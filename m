From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Sep 2012 17:35:30 +0100
Subject: [RFC PATCH v2 0/5] ARM: augment cache flushing API
Message-ID: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides an update of a previous posting:

http://www.spinics.net/lists/arm-kernel/msg194946.html

v2 updates:
 - Dropped v7 dcache level patch
 - Refactor the set to make it work on all processors with MULTI_CACHE
   and !MULTI_CACHE
 - Factor out label redefinition in v7_flush_dcache_all
 - Updated some comments

v7 ARM architecture introduced the concept of cache levels and relative
control registers to manage them. Cache operations that operate on set/way
require to define the cache level at which maintenance operations are carried
out by using coprocessor registers.

Processors like A7/A15 integrates a unified L2 that is part of the cache
level hierarchy; this implies that cache operations operating on all levels
also end up cleaning the L2 unified cache which is a very time consuming
operation and it is not needed for some power-down operations like single CPU
shutdown.

For v7, flush_kern_all() cleans all the cache levels up to the Level of
Coherency which includes L2 in it. This is suboptimal for code paths that end
up shutting-down a single processor like CPU hotplug and CPU idle, where only
per-CPU cache state (ie L1 integrated cache) has to be cleaned and invalidated.

To fix this performance issue this patchset introduces cache LoUIS (Level of
Unification Inner Shareable) maintenance operations in the kernel.

A new cache operations pointer is added to cpu_cache_fns

void (*flush_kern_cache_louis)(void);

that allows to clean and invalidate all data cache levels up to the LoUIS and
invalidate the instruction cache. This new API should provide a sufficiently
optimized API to be used in generic C code in the kernel for power management
operations on most v7 systems.

For architecture versions previous to v7, flush_kern_cache_louis() falls back
to flush_kern_all() leaving the current behaviour unchanged.

For A9/A5 processors Level of Unification Inner Shareable and Level of
Coherency are equivalent hence this patch should not affect current kernel
behaviour in any way when run on A9/A5 based systems, but should nonetheless
be thoroughly tested on them.

Tested on:
  - OMAP4 (S2R, cpuidle and hotplug)
  - OMAP5 (out of tree code) (S2R, cpuidle and hotplug)
  - TC2 big.LITTLE testchip (out of tree code) (cpuidle, on both A7 and A15
    clusters)

Lorenzo Pieralisi (4):
  ARM: mm: implement LoUIS API for cache maintenance ops
  ARM: mm: rename jump labels in v7_flush_dcache_all function
  ARM: kernel: update cpu_suspend code to use cache LoUIS operations
  ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API

Santosh Shilimkar (1):
  ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API

 arch/arm/include/asm/cacheflush.h | 15 ++++++++++++
 arch/arm/include/asm/glue-cache.h |  1 +
 arch/arm/kernel/smp.c             |  5 +++-
 arch/arm/kernel/suspend.c         | 17 +++++++++++++-
 arch/arm/mm/cache-fa.S            |  3 +++
 arch/arm/mm/cache-v3.S            |  3 +++
 arch/arm/mm/cache-v4.S            |  3 +++
 arch/arm/mm/cache-v4wb.S          |  3 +++
 arch/arm/mm/cache-v4wt.S          |  3 +++
 arch/arm/mm/cache-v6.S            |  3 +++
 arch/arm/mm/cache-v7.S            | 48 ++++++++++++++++++++++++++++++++++-----
 arch/arm/mm/proc-arm1020.S        |  3 +++
 arch/arm/mm/proc-arm1020e.S       |  3 +++
 arch/arm/mm/proc-arm1022.S        |  3 +++
 arch/arm/mm/proc-arm1026.S        |  3 +++
 arch/arm/mm/proc-arm920.S         |  3 +++
 arch/arm/mm/proc-arm922.S         |  3 +++
 arch/arm/mm/proc-arm925.S         |  3 +++
 arch/arm/mm/proc-arm926.S         |  3 +++
 arch/arm/mm/proc-arm940.S         |  3 +++
 arch/arm/mm/proc-arm946.S         |  3 +++
 arch/arm/mm/proc-feroceon.S       |  3 +++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-v7.S             |  2 +-
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  3 +++
 27 files changed, 140 insertions(+), 9 deletions(-)

-- 
1.7.12
