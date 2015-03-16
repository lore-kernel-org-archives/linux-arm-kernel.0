From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon, 16 Mar 2015 20:01:18 +0100
Subject: [PATCH v6] crypto: Add Allwinner Security System crypto accelerator
Message-ID: <1426532482-28830-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This is the driver for the Security System included in Allwinner SoC A20.
The Security System (SS for short) is a hardware cryptographic accelerator that
support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
It could be found on others Allwinner SoC: 
- A10s, A33 and A31 diagram speak about it with precisions (AES/DES/3DES/Md5/SHA1/PRNG)
- A10 and A13 manual give the same datasheet for SS than A20
- A23 speak about a security system but without precisions
- A80 datasheet speak about a security system with more functions
  (SHA224/SHA256/RSA/CRC) but without precisions
  But I do not have access on any of those hardware, tests are welcome.

  This driver currently supports:
  - MD5 and SHA1 hash algorithms
  - AES block cipher in CBC mode with 128/196/256bits keys.
  - DES and 3DES block cipher in CBC mode
  The driver exposes all those algorithms through the kernel cryptographic API.

  The driver support only CPU driven (aka poll mode) transfer mode,
  since the DMA engine of the A20 does not have a mainline driver yet.

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
