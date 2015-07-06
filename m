From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon,  6 Jul 2015 21:10:43 +0200
Subject: [PATCH v10] crypto: Add Allwinner Security System crypto accelerator
Message-ID: <1436209848-16530-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This is the driver for the Security System included in Allwinner SoC A20.
The Security System (SS for short) is a hardware cryptographic accelerator that
support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
It could be found on others Allwinner SoC: 
- A10, A10s, A13, A31 and A33 manual give the same datasheet for SS than A20
- A23 speak about a security system but without precisions
- A80 and A83T datasheet speak about a security system with more functions
  (SHA224/SHA256/RSA/CRC), they will be supported in a separate driver.

This driver currently supports:
- MD5 and SHA1 hash algorithms
- AES block cipher in CBC/ECB mode with 128/196/256bits keys.
- DES and 3DES block cipher in CBC/ECB mode
The driver exposes all those algorithms through the kernel cryptographic API.

The driver support only CPU driven (aka poll mode) transfer mode,
since the DMA engine of the A20 does not have a mainline driver yet.

For the moment the driver is fully synchronous.
A patch exists for making the driver asynchronous at the costs of badly decreasing performance.
It will be re-introduced later when DMA will be supported.

Changes since v9
- use spin_lock_bh instead of spin_lock_irqx
- use sg_miter always with SG_MITER_ATOMIC flag
- rework the hash update functions
- the DES/3DES/AES now uses two functions one for all case and one for SG with
 size not multiple of 4 and so remove the fallback for DES/3DES
- add A10 support, tested by Matthieu CERDA
- fix export/import functions
- do not use any _relaxed read/write
- write IV at end of cipher functions

Changes since v8
- use sg_miter in cipher functions, this clean all kmap stuff (thanks to bbrezillon)
- use GIC in dt interupts
- rename all references (files/dtcompatible) from sunxi to sun4i in prevision of futur A80/A83 driver

Changes since v7
- Add ECB block mode
- split the sunxi_ss_cipher_init in two
- remove sunxi_ss_cipher_encrypt/sunxi_ss_cipher_decrypt
- use now sunxi_ss_block_method_encrypt and sunxi_ss_block_method_decrypt
- Add weak DES key test needed by ECB tests

Changes since v6:
- Use alphabetic ordering for new sections in MAINTAINERS
- Clean remaining PRNG driver header

Changes since v5:
- Hash functions now keep partial hash states in sunxi_ss structures
- Use of spinlock instead of mutex
- Remove the static sunxi_ss structures by using container of
- Add export/import functions
- replace lots of writel by writesl
- replace lots of readl by readsl

Changes since v4:
- Rework all mutex path
- Use ahash_request_ctx() in hash functions
- Major rework of hash functions for solving mutex problems
- Split sunxi_req_ctx in two since ciphers now use struct sunxi_tfm_ctx
- Hash functions now test FIFO space register

Changes since v3:
- Remove all algorithms options from Kconfig, so now only one module is used
- Add the sunxi_ss_cipher function to unify mode calculation
- Remove the sunxi_cipher_exit empty function
- Add some missing mutex_unlock()
- Drop PRNG support, I wait for more comment on its results before re-enabling it.

Changes since v2:
- Fix Makefile and Kconfig for static kernel.

Changes since v1:
- annotate ss->base as __iomem
- regroup all mutex in the ss_ctx structure
- splited driver in 7 modules (core md5 sha1 aes des 3des prng) in sunxi-ss directory
- use dev_exit_p() for .remove
- added missing CRYPTO_BLKCIPHER dep in Kconfig
- use ahash instead of shash
- use ablkcipher instead of blkcipher
- use crypto_rng_ctx instead of crypto_tfm_ctx
- set seed as an u32
- drop useless comment decoration
- drop useless debug
- ss_ctx is now a static pointer and whole structure being allocated
- fix the platform_get_resource/devm_ioremap_resource pattern
- invert getting die id and configuring clock
- set clock value as a const unsigned long
- add MODULE_ALIAS
- use define names more consistency (SS_xxx)
- fix PRNG errors
- respell SS to Security System in DT documentation
