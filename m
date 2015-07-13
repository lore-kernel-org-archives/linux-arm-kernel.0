From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:01 +0100
Subject: [PATCH 00/18] arm64: support for 8.1 LSE atomic instructions
Message-ID: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for the new atomic instructions,
introduced as part of the Large System Extension in ARMv8.1, to the
Linux kernel.

Whilst the new instructions can be configured out at compile time via
the CONFIG_ARM64_LSE_ATOMICS option, we make heavy use of alternative
patching to ensure that we can continue to boot a kernel Image anywhere,
regardless of the CPU support.

I've tested this on Juno, Seattle and Hikey (none of which have the new
instructions) and also on the FastModel with 8.1 enabled.

Feedback welcome,

Will

--->8

Will Deacon (18):
  arm64: cpufeature.h: add missing #include of kernel.h
  arm64: atomics: move ll/sc atomics into separate header file
  arm64: elf: advertise 8.1 atomic instructions as new hwcap
  arm64: alternatives: add cpu feature for lse atomics
  arm64: introduce CONFIG_ARM64_LSE_ATOMICS as fallback to ll/sc atomics
  arm64: atomics: patch in lse instructions when supported by the CPU
  arm64: locks: patch in lse instructions when supported by the CPU
  arm64: bitops: patch in lse instructions when supported by the CPU
  arm64: xchg: patch in lse instructions when supported by the CPU
  arm64: cmpxchg: patch in lse instructions when supported by the CPU
  arm64: cmpxchg_dbl: patch in lse instructions when supported by the
    CPU
  arm64: cmpxchg: avoid "cc" clobber in ll/sc routines
  arm64: cmpxchg: avoid memory barrier on comparison failure
  arm64: atomics: tidy up common atomic{,64}_* macros
  arm64: atomics: prefetch the destination word for write prior to stxr
  arm64: atomics: implement atomic{,64}_cmpxchg using cmpxchg
  arm64: atomic64_dec_if_positive: fix incorrect branch condition
  arm64: kconfig: select HAVE_CMPXCHG_LOCAL

 arch/arm64/Kconfig                    |  13 ++
 arch/arm64/Makefile                   |  13 +-
 arch/arm64/include/asm/atomic.h       | 262 ++++++-------------------------
 arch/arm64/include/asm/atomic_ll_sc.h | 237 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   | 279 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cmpxchg.h      | 192 +++++++++--------------
 arch/arm64/include/asm/cpufeature.h   |   5 +-
 arch/arm64/include/asm/futex.h        |   2 +
 arch/arm64/include/asm/lse.h          |  58 +++++++
 arch/arm64/include/asm/spinlock.h     | 132 ++++++++++++----
 arch/arm64/include/uapi/asm/hwcap.h   |   1 +
 arch/arm64/kernel/setup.c             |  18 +++
 arch/arm64/lib/Makefile               |  13 ++
 arch/arm64/lib/atomic_ll_sc.c         |   3 +
 arch/arm64/lib/bitops.S               |  45 +++---
 15 files changed, 893 insertions(+), 380 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic_ll_sc.h
 create mode 100644 arch/arm64/include/asm/atomic_lse.h
 create mode 100644 arch/arm64/include/asm/lse.h
 create mode 100644 arch/arm64/lib/atomic_ll_sc.c

-- 
2.1.4
