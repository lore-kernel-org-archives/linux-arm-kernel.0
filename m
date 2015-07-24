From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 11:41:51 +0100
Subject: [PATCH v2 00/20] arm64: support for 8.1 LSE atomic instructions
Message-ID: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version two of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355980.html

Changes since v1 include:

  * Fixed WFE usage in rwlock code
  * Fixed rwlock trylock retry semantics
  * Added documentation update for failed cmpxchg semantics
  * Replaced explicit save/restore of LR with a clobber

Tested on Juno and Fastmodel.

Peter -- do you want to pick up the documentation update, or shall I
         keep it with the rest of this series?

Will

--->8

Will Deacon (20):
  arm64: rwlocks: don't fail trylock purely due to contention
  documentation: Clarify failed cmpxchg memory ordering semantics
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

 Documentation/atomic_ops.txt          |   4 +-
 Documentation/memory-barriers.txt     |   6 +-
 arch/arm64/Kconfig                    |  13 ++
 arch/arm64/Makefile                   |  13 +-
 arch/arm64/include/asm/atomic.h       | 262 ++++++-------------------------
 arch/arm64/include/asm/atomic_ll_sc.h | 237 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   | 285 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cmpxchg.h      | 192 +++++++++--------------
 arch/arm64/include/asm/cpufeature.h   |   5 +-
 arch/arm64/include/asm/futex.h        |   2 +
 arch/arm64/include/asm/lse.h          |  53 +++++++
 arch/arm64/include/asm/spinlock.h     | 147 ++++++++++++++----
 arch/arm64/include/uapi/asm/hwcap.h   |   1 +
 arch/arm64/kernel/setup.c             |  18 +++
 arch/arm64/lib/Makefile               |  13 ++
 arch/arm64/lib/atomic_ll_sc.c         |   3 +
 arch/arm64/lib/bitops.S               |  45 +++---
 17 files changed, 911 insertions(+), 388 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic_ll_sc.h
 create mode 100644 arch/arm64/include/asm/atomic_lse.h
 create mode 100644 arch/arm64/include/asm/lse.h
 create mode 100644 arch/arm64/lib/atomic_ll_sc.c

-- 
2.1.4
