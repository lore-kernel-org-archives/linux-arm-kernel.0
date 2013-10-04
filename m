From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  4 Oct 2013 21:03:36 +0200
Subject: [PATCH v3 0/3] ARM: NEON based fast(er) AES in CBC/CTR/XTS modes
Message-ID: <1380913419-13296-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of a series implementing a faster and more secure AES implementation
based on bit slicing using NEON instructions.

Changes since v2:
- included the Perl script that generates the .S file, and added some make
  rules so that modifications to the Perl script will carry over to the .S file
  automatically without imposing Perl for all users;

Changes since v1:
- implemented a suggestion by Jussi Kivilinna which substantially improves
  decryption performance, decryption speedup is now 25% on Cortex-A15 (up from
  5 - 10%), encryption speedup is still at 45%;
- fixed a potential issue with tail blocks in CTR mode;
- copied some comments about the origin of this code and the expected power
  efficiency from the cover letter to the commit log of patch 3;
- some cosmetic changes.

This code passes the builtin test 'modprobe tcrypt.ko mode=10' in both ARM and
Thumb-2 modes.

The core code has been adopted from the OpenSSL project (in collaboration
with the original author, on cc). For ease of maintenance, this version is
identical to the upstream OpenSSL code, i.e., all modifications that were
required to make it suitable for inclusion into the kernel have been made
upstream.

This series still depends on commit a62b01cd (crypto: create generic version of
ablk_helper) which I omitted this time but which can be found in the cryptodev
tree or in linux-next.

Ard Biesheuvel (3):
  ARM: pull in <asm/simd.h> from asm-generic
  ARM: move AES typedefs and function prototypes to separate header
  ARM: add support for bit sliced AES using NEON instructions

 arch/arm/crypto/Makefile             |   14 +-
 arch/arm/crypto/aes_glue.c           |   22 +-
 arch/arm/crypto/aes_glue.h           |   19 +
 arch/arm/crypto/aesbs-core.S_shipped | 2544 ++++++++++++++++++++++++++++++++++
 arch/arm/crypto/aesbs-glue.c         |  434 ++++++
 arch/arm/crypto/bsaes-armv7.pl       | 2467 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/Kbuild          |    1 +
 crypto/Kconfig                       |   16 +
 8 files changed, 5499 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/crypto/aes_glue.h
 create mode 100644 arch/arm/crypto/aesbs-core.S_shipped
 create mode 100644 arch/arm/crypto/aesbs-glue.c
 create mode 100644 arch/arm/crypto/bsaes-armv7.pl

-- 
1.8.1.2
