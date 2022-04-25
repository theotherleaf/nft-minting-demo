// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  event NewEpicNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("LeafyNFT", "LEAFY") {
    console.log("This is my NFT contract.");
  }

  function makeAnEpicNFT(string memory metadata) public {
    // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

    // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    _setTokenURI(newItemId, metadata);
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
    emit NewEpicNFTMinted(msg.sender, newItemId);
  }

  function getCurrentTokenId() public view returns (uint256) {
    return _tokenIds.current();
  }
}
