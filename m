From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jan 2013 14:27:43 +0000
Subject: [PATCH 0/6] Fix 740t support and remove more unused ARMv3 code
Message-ID: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When looking at the remaining ARMv3 code that we still have kicking
around, I noticed that the only user of the cache-flushing routines is
the 740t, an ARMv4 chip. Having read the datasheet, we can actually use
our ARMv4 cache-flushing code and remove cache-v3.S.

After making that change, I thought I'd better do some testing, which is
where the fun began...

Even after getting hold of a 740t Integrator/AP core-tile, I ran into
many problems with the CPU support, which I don't believe has *ever*
worked. Anyway, having fixed those, the board runs like a charm.

Next stop is the 940t, which looks to be broken in similar ways.

Will


Will Deacon (6):
  ARM: tlbflush: remove ARMv3 support
  ARM: cache: remove ARMv3 support code
  ARM: mm: fix numerous hideous errors in proc-arm740.S
  ARM: mm: remove broken condition check for v4 flushing
  ARM: modules: don't export cpu_set_pte_ext when !MMU
  ARM: integrator: ensure ap_syscon_base is initialised when
    !CONFIG_MMU

 arch/arm/include/asm/glue-cache.h        |   8 --
 arch/arm/include/asm/tlbflush.h          |  11 +--
 arch/arm/mach-integrator/integrator_ap.c |   2 +-
 arch/arm/mm/Kconfig                      |   5 +-
 arch/arm/mm/Makefile                     |   1 -
 arch/arm/mm/cache-v3.S                   | 137 -------------------------------
 arch/arm/mm/cache-v4.S                   |   2 +-
 arch/arm/mm/proc-arm740.S                |  30 ++++---
 arch/arm/mm/proc-syms.c                  |   2 +
 9 files changed, 24 insertions(+), 174 deletions(-)
 delete mode 100644 arch/arm/mm/cache-v3.S

-- 
1.8.0
