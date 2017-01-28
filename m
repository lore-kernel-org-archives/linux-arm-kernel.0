From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 28 Jan 2017 23:33:29 +0000
Subject: [PATCH v2 0/4] crypto: time invariant AES for CCM (and GCM/CTR)
Message-ID: <1485646413-17491-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is primarily directed at improving the performance and security
of CCM on the Rasperry Pi 3. This involves splitting the MAC handling of
CCM into a separate driver so that we can efficiently replace it by something
else using the ordinary algo resolution machinery.

Patch #1 adds some testcases for cbcmac(aes), which will be introduced later.

Patch #2 replaces the open coded CBC MAC hashing routines in the CCM driver
with calls to a cbcmac() hash, and implements a template for producing such
transforms. This eliminates all the fuzzy scatterwalk code as well.

Patch #3 implements cbcmac(aes) using NEON on arm64

Patch #4 is an RFC patch that implements ctr(aes) and cbcmac(aes) in a way
that is intended to eliminate observeable data dependent latencies in AES
processing, by replacing the usual 16 KB of lookup tables with a single
Sbox that is prefetched before processing each block. It is 50% slower than
generic AES, but this may be acceptable in many cases.

Changes since v1:
- remove ilen, and add missing flags assignment (#2)
- deal with zero cryptlen (#2)
- use correctly sized dg[] array in desc ctx (#3, #4)
- fix bug in update routine (#3)
- various other tweaks

Ard Biesheuvel (4):
  crypto: testmgr - add test cases for cbcmac(aes)
  crypto: ccm - switch to separate cbcmac driver
  crypto: arm64/aes - add NEON and Crypto Extension CBC-MAC driver
  crypto: aes - add generic time invariant AES for CTR/CCM/GCM

 arch/arm64/crypto/aes-glue.c  | 107 ++++++
 arch/arm64/crypto/aes-modes.S |  22 ++
 crypto/Kconfig                |  18 +
 crypto/Makefile               |   1 +
 crypto/aes_ti.c               | 320 +++++++++++++++++
 crypto/ccm.c                  | 376 +++++++++++++-------
 crypto/testmgr.c              |   7 +
 crypto/testmgr.h              |  58 +++
 8 files changed, 772 insertions(+), 137 deletions(-)
 create mode 100644 crypto/aes_ti.c

-- 
2.7.4
