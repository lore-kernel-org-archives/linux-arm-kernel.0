From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  9 Dec 2016 14:33:50 +0000
Subject: [PATCH v2 0/3] crypto: arm64/ARM: NEON accelerated ChaCha20 *skcipher*
Message-ID: <1481294033-23508-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another port of existing x86 SSE code to NEON, again both for arm64 and ARM.

ChaCha20 is a stream cipher described in RFC 7539, and is intended to be
an efficient software implementable 'standby cipher', in case AES cannot
be used.

This NEON implementation is almost 2x as fast as the generic C code
(measured on Cortex-A57 using the arm64 version)

Changes in v2:
- add patch to convert the generic and x86 to skciphers first
- tweaked the arm64 version for some additional performance
- use chunksize == 4x blocksize for optimal speed

Ard Biesheuvel (3):
  crypto: chacha20 - convert generic and x86 versions to skcipher
  crypto: arm64/chacha20 - implement NEON version based on SSE3 code
  crypto: arm/chacha20 - implement NEON version based on SSE3 code

 arch/arm/crypto/Kconfig                |   6 +
 arch/arm/crypto/Makefile               |   2 +
 arch/arm/crypto/chacha20-neon-core.S   | 524 ++++++++++++++++++++
 arch/arm/crypto/chacha20-neon-glue.c   | 127 +++++
 arch/arm64/crypto/Kconfig              |   6 +
 arch/arm64/crypto/Makefile             |   3 +
 arch/arm64/crypto/chacha20-neon-core.S | 450 +++++++++++++++++
 arch/arm64/crypto/chacha20-neon-glue.c | 122 +++++
 arch/x86/crypto/chacha20_glue.c        |  69 ++-
 crypto/chacha20_generic.c              |  73 ++-
 include/crypto/chacha20.h              |   6 +-
 11 files changed, 1304 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/crypto/chacha20-neon-core.S
 create mode 100644 arch/arm/crypto/chacha20-neon-glue.c
 create mode 100644 arch/arm64/crypto/chacha20-neon-core.S
 create mode 100644 arch/arm64/crypto/chacha20-neon-glue.c

-- 
2.7.4
