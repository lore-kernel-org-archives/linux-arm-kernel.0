From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 12:19:54 +0100
Subject: [PATCH 0/5] ARMv6 and ARMv7 mm fixes
Message-ID: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

There are a few issues with ASID handling and cache flushing on v6/v7
CPUs that have been identified when running Linux on the Cortex-A15.

These patches solve the problems for the classic page tables. Additional
LPAE changes will be posted separately.

Tested on a Realview-PBX platform with a dual-core Cortex-A9.

Thanks,

Will


Catalin Marinas (1):
  ARM: mm: make TTBR1 always point to swapper_pg_dir on ARMv6/7

Will Deacon (4):
  ARM: cache: ensure MVA is cacheline aligned in flush_kern_dcache_area
  ARM: mm: use TTBR1 instead of reserved context ID
  ARM: mm: fix racy ASID rollover broadcast on SMP platforms
  ARM: mm: allow ASID 0 to be allocated to tasks

 arch/arm/include/asm/proc-fns.h |   14 ++++++++++++++
 arch/arm/include/asm/smp.h      |    1 +
 arch/arm/kernel/head.S          |    7 +++++--
 arch/arm/kernel/smp.c           |    1 +
 arch/arm/mm/cache-v6.S          |    1 +
 arch/arm/mm/cache-v7.S          |    2 ++
 arch/arm/mm/context.c           |   20 ++++++++++----------
 arch/arm/mm/proc-v6.S           |    4 +++-
 arch/arm/mm/proc-v7.S           |   14 +++++++-------
 9 files changed, 44 insertions(+), 20 deletions(-)
