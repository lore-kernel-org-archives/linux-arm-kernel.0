From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Mar 2014 12:44:21 +0100
Subject: [PATCH RFT 0/2] arm64: AES in ECB/CBC/CTR/XTS modes
Message-ID: <1395143063-28897-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code has been sitting in my personal git repo for about 6 months, waiting
for a piece of hardware to do some performance testing on. I am losing my
patience so I am posting it now so others may have a go if they are interested.
Please post back your results in that case.

(Note that an early version containing just the Crypto Extensions code was
posted a while ago.)

These are asynchronous versions of AES in ECB, CBC, CTR and XTS modes. They use
ablk_helper, hence the inclusion of patch #1.

Patch #2 contains both a Crypto Extensions and a plain NEON implementation. As
much as possible of the glue and chaining mode code was shared, and the diff
between crypto extensions and NEON split out into aes-ce.S and aes-neon.S

The Makefile allows some tweaking with INTERLEAVE and INTERLEAVE_INLINE. I don't
expect the overhead of inline expansion to be justified, but I do expect there
to be a difference between non-interleaved and interleaved instantiations. Note
that the NEON code only supports INTERLEAVE=4 for lack of registers. Please
refer to aes-modes.S for more details.

Happy to answer to questions and/or comments.

Ard Biesheuvel (2):
  ARM64: pull in <asm/simd.h> from asm-generic
  ARM64: add support for NEON and Crypto Extensions accelerated AES

 arch/arm64/Makefile           |   2 +
 arch/arm64/crypto/Makefile    |  23 ++
 arch/arm64/crypto/aes-ce.S    | 147 +++++++++++
 arch/arm64/crypto/aes-glue.c  | 447 ++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aes-modes.S | 555 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aes-neon.S  | 382 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/Kbuild |   1 +
 crypto/Kconfig                |  14 ++
 8 files changed, 1571 insertions(+)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-ce.S
 create mode 100644 arch/arm64/crypto/aes-glue.c
 create mode 100644 arch/arm64/crypto/aes-modes.S
 create mode 100644 arch/arm64/crypto/aes-neon.S

-- 
1.8.3.2
