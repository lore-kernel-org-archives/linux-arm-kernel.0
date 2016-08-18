From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:52 +0100
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
Message-ID: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set allows M-class cpus benefit of optional cache support.
It originally was written by Jonny, I've been keeping it locally mainly
rebasing over Linux versions.

The original idea behind patches was to reuse existing cache handling
code from v7A/R with help of extra macros to factor out cache handling
logic (v7M cache operations are provided via memory mapped interface
rather than co-processor instructions).
However, that idea was rejected and starting form this (v2) version
V7M cache logic lives into file and macros to indirect memory-mapped
operations stay there locally since they make it easier to follow the
code.

Along with the v7M cache support the first user (Cortex-M7) is
introduced.

Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
one showed significant boot speed-up.

Based on 4.8-rc2.

Thanks!
Vladimir

Changelog:

    v1 -> v2
        - dropped generalisation of read_cpuid() (per Russell)
	- M-class cache operations moved under it's own file and do not
	  interfere with A/R code (per Russell)

    RFC -> v1
        - use linux/io.h instead of asm/io.h (per Russell)
        - droped cast to void pointer in set_csselr; BASEADDR_V7M_SCB
          is already defined with a help of IOMEM macro (per Russell)
        - open-coded implantation of dccmvau and icimvau instead of
          macros, since the latter would mark the wring instruction as
          user-accessible (per Russell)
        - dccimvac is updated  per Russell preference
        - M_CLASS() macro is used instead of THUMB() where appropriate

Jonathan Austin (6):
  ARM: factor out CSSELR/CCSIDR operations that use cp15 directly
  ARM: V7M: Add addresses for mem-mapped V7M cache operations
  ARM: V7M: Add support for reading the CTR with read_cpuid_cachetype()
  ARM: V7M: Wire up caches for V7M processors with cache support.
  ARM: V7M: Indirect proc_info construction for V7M CPUs
  ARM: V7M: Add support for the Cortex-M7 processor

Vladimir Murzin (2):
  ARM: V7M: fix notrace variant of save_and_disable_irqs
  ARM: V7M: introduce cache operations

 arch/arm/include/asm/assembler.h  |    4 +
 arch/arm/include/asm/cachetype.h  |   39 ++++
 arch/arm/include/asm/cputype.h    |   15 +-
 arch/arm/include/asm/glue-cache.h |    4 -
 arch/arm/include/asm/v7m.h        |   22 ++
 arch/arm/kernel/head-nommu.S      |   16 +-
 arch/arm/kernel/setup.c           |   16 +-
 arch/arm/mm/Kconfig               |   10 +-
 arch/arm/mm/Makefile              |    2 +
 arch/arm/mm/cache-v7m.S           |  453 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-macros.S         |   16 ++
 arch/arm/mm/proc-v7m.S            |  107 +++++++--
 12 files changed, 668 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mm/cache-v7m.S

-- 
1.7.9.5
