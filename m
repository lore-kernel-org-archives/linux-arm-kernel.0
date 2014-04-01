From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  1 Apr 2014 15:47:32 +0200
Subject: [PATCH v3 0/7] arm64: NEON crypto under CONFIG_PREEMPT
Message-ID: <1396360059-31949-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt to reduce latency under CONFIG_PREEMPT while
maintaining optimal throughput otherwise, i.e., under !CONFIG_PREEMPT or
while running outside of process context.

In the in_interrupt() case, the calls to kernel_neon_begin and kernel_neon_end
incur a fixed penalty (i.e., each call needs to stack/unstack a fixed number of
registers), and preemption is not possible anyway, so the call into the crypto
algorithm should just complete as fast as possible, ideally by processing all
of the input in the core loop without having to spill state to memory or reload
round keys (e.g., SHA-256 uses 64 32-bit round keys to process each input block
of 64 bytes)

In contrast, when running in process context, we should avoid hogging the CPU by
spending unreasonable amounts of time inside a kernel_neon_begin/kernel_neon_end
section. However, reloading those 64 32-byte round keys to process each 64-byte
block one by one is far from optimal.

The solution proposed here is to allow the inner loops of the crypto algorithms
to test the TIF_NEED_RESCHED flag, and terminate early if it is set. This is
essentially CONFIG_PREEMPT_VOLUNTARY, even under CONFIG_PREEMPT, but it is the
best we can do when running with preemption disabled.

Patch #1 - #3 are the Crypto Extensions based implementations of SHA-1,
SHA-224/SHA-256 and GHASH that I have posted before. Patch #4 introduces the
shared asm macro that tests TIF_NEED_RESCHED, patches #5 - #7 rework the code
introduced in patches #1 - #3 to perform the need_resched test in the core loop.

Note that this series depends on my kernel mode NEON optimization patches posted
a while ago.

Ard Biesheuvel (7):
  arm64/crypto: SHA-1 using ARMv8 Crypto Extensions
  arm64/crypto: SHA-224/SHA-256 using ARMv8 Crypto Extensions
  arm64/crypto: GHASH secure hash using ARMv8 Crypto Extensions
  arm64/crypto: add shared macro to test for NEED_RESCHED
  arm64/crypto: add voluntary preemption to Crypto Extensions SHA1
  arm64/crypto: add voluntary preemption to Crypto Extensions SHA2
  arm64/crypto: add voluntary preemption to Crypto Extensions GHASH

 arch/arm64/Kconfig                 |   3 +
 arch/arm64/Makefile                |   1 +
 arch/arm64/crypto/Kconfig          |  27 ++++
 arch/arm64/crypto/Makefile         |  18 +++
 arch/arm64/crypto/ghash-ce-core.S  |  98 +++++++++++++
 arch/arm64/crypto/ghash-ce-glue.c  | 172 +++++++++++++++++++++++
 arch/arm64/crypto/sha1-ce-core.S   | 154 ++++++++++++++++++++
 arch/arm64/crypto/sha1-ce-glue.c   | 201 ++++++++++++++++++++++++++
 arch/arm64/crypto/sha2-ce-core.S   | 159 +++++++++++++++++++++
 arch/arm64/crypto/sha2-ce-glue.c   | 281 +++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/assembler.h |  21 +++
 11 files changed, 1135 insertions(+)
 create mode 100644 arch/arm64/crypto/Kconfig
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/ghash-ce-core.S
 create mode 100644 arch/arm64/crypto/ghash-ce-glue.c
 create mode 100644 arch/arm64/crypto/sha1-ce-core.S
 create mode 100644 arch/arm64/crypto/sha1-ce-glue.c
 create mode 100644 arch/arm64/crypto/sha2-ce-core.S
 create mode 100644 arch/arm64/crypto/sha2-ce-glue.c

-- 
1.8.3.2
