From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Jan 2018 12:11:35 +0000
Subject: [PATCH 0/7] arm64: move literal data into .rodata section
Message-ID: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent inadvertently creating speculative gadgets by moving literal data
into the .rodata section.

Patch #1 enables this for C code, by reverting a change that disables the
GCC feature implementing this. Note that this conflicts with the mitigation
of erratum #843419 for Cortex-A53.

Patch #2 - #7 update the crypto asm code to move sboxes and round constant
tables (which may or may not be hiding 'interesting' opcodes) from .text
to .rodata

Ard Biesheuvel (7):
  arm64: kernel: avoid executable literal pools
  arm64/crypto: aes-cipher: move S-box to .rodata section
  arm64/crypto: aes-neon: move literal data to .rodata section
  arm64/crypto: crc32: move literal data to .rodata section
  arm64/crypto: crct10dif: move literal data to .rodata section
  arm64/crypto: sha2-ce: move the round constant table to .rodata
    section
  arm64/crypto: sha1-ce: get rid of literal pool

 arch/arm64/Makefile                   |  4 ++--
 arch/arm64/crypto/aes-cipher-core.S   | 19 ++++++++++---------
 arch/arm64/crypto/aes-neon.S          |  8 ++++----
 arch/arm64/crypto/crc32-ce-core.S     |  7 ++++---
 arch/arm64/crypto/crct10dif-ce-core.S | 17 +++++++++--------
 arch/arm64/crypto/sha1-ce-core.S      | 20 +++++++++-----------
 arch/arm64/crypto/sha2-ce-core.S      |  4 +++-
 7 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.11.0
