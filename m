From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:12 +0100
Subject: [PATCH RFC 00/10] ARM: V7M: Support caches
Message-ID: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set allows M-class cpus benefit of optional cache support.
It originaly was written by Jonny, I've been keeping it localy mainly
rebasing over Linux versions.

The main idea behind patches is to reuse existing cache handling code
from v7A/R. In case v7M cache operations are provided via memory
mapped interface rather than co-processor instructions, so extra
macros have been introduced to factor out cache handling logic and
low-level operations.

Along with the v7M cache support the first user (Cortex-M7) is
introduced.

Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
one showed significant boot speed-up.

Based on 4.6-rc3.

Thanks!
Vladimir

Jonathan Austin (9):
  ARM: factor out CSSELR/CCSIDR operations that use cp15 directly
  ARM: V7M: Make read_cpuid() generally available on V7M.
  ARM: V7M: Add addresses for mem-mapped V7M cache operations
  ARM: V7M: Add support for reading the CTR with CPUID_CACHETYPE
  ARM: Extract cp15 operations from cache flush code
  ARM: V7M: Implement cache macros for V7M
  ARM: V7M: Wire up caches for V7M processors with cache support.
  ARM: V7M: Indirect proc_info construction for V7M CPUs
  ARM: V7M: Add support for the Cortex-M7 processor

Vladimir Murzin (1):
  ARM: V7M: fix notrace variant of save_and_disable_irqs

 arch/arm/include/asm/assembler.h  |    4 ++
 arch/arm/include/asm/cachetype.h  |   39 +++++++++++
 arch/arm/include/asm/cputype.h    |   51 ++++++++------
 arch/arm/include/asm/glue-cache.h |    4 --
 arch/arm/include/asm/v7m.h        |   22 ++++++
 arch/arm/kernel/head-nommu.S      |   16 ++++-
 arch/arm/kernel/setup.c           |   16 ++---
 arch/arm/mm/Kconfig               |    7 +-
 arch/arm/mm/Makefile              |    4 ++
 arch/arm/mm/cache-v7.S            |   66 ++++++++---------
 arch/arm/mm/proc-macros.S         |   23 ------
 arch/arm/mm/proc-v7.S             |    1 +
 arch/arm/mm/proc-v7m.S            |   93 ++++++++++++++++++++----
 arch/arm/mm/v7-cache-macros.S     |  129 ++++++++++++++++++++++++++++++++++
 arch/arm/mm/v7m-cache-macros.S    |  140 +++++++++++++++++++++++++++++++++++++
 15 files changed, 507 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/mm/v7-cache-macros.S
 create mode 100644 arch/arm/mm/v7m-cache-macros.S

-- 
1.7.9.5
