From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Apr 2012 14:08:28 +0100
Subject: [RFC PATCH 0/3] ARM: add cache level maintenance operations
Message-ID: <1334236111-28144-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v7 ARM architecture introduced the concept of cache levels and relative
control registers to manage them. Cache operations that operate on set/way
require to define the cache level at which maintenance operations are carried
out by using coprocessor registers.

Processors like A7/A15 integrated a unified L2 that is part of the cache
level hierarchy; this implies that cache operations operating on all levels
also end up cleaning the L2 unified cache which is a very time consuming
operation and it is not needed for some power-down operations like single CPU
shutdown.

For v7, flush_kern_all() cleans all the cache levels up to the Level of
Coherency which includes L2 in it. This is suboptimal for code paths that ends
up shutting-down a single processor like CPU hotplug and CPU idle, where only
per-CPU cache state (ie L1 integrated cache) has to be cleaned and invalidated.

To fix this performance issue this patchset introduces cache level maintenance
operations in the kernel.

A new cache operations pointer is added to cpu_cache_fns

void (*flush_kern_dcache_level)(int);

that takes an input parameter corresponding to the upper dcache level that has
to be cleaned/invalidated.

A preferred default level hook is introduced that corresponds to flushing all
cache levels leaving the current behaviour unchanged.

A v7 specific patch adds a preferred cache level hook that corresponds to
Level of Unification Inner Shareable; it represents data cache levels that
are per-CPU (ie integrated L1) in most of the current v7 based systems.

Code is in the making to define the preferred cache level through a DT
binding since it is SoC specific.

The patchset updates cpu_suspend code accordingly, in order to flush only cache
levels that are lost when a single CPU is shutdown.

For A9/A5 processors Level of Unification Inner Shareable and Level of
Coherency are equivalent hence this patch should not affect cpu_suspend
behaviour in any way when run on A9/A5 based systems.

Tested on an A15 dual cluster system through CPU soft-reboot.

TO BE DONE:

- Test it with CPUs going through power shutdown
- Test it on all existing A9/A5 implementations using cpu_suspend

Lorenzo Pieralisi (3):
  ARM: mm: define cache levels for cache maintenance ops
  ARM: mm: v7 cache level operations
  ARM: kernel: update cpu_suspend code to use dcache level operations

 arch/arm/include/asm/cacheflush.h |   38 ++++++++++++++++++++++++++++++++
 arch/arm/kernel/suspend.c         |   13 ++++++++++-
 arch/arm/mm/cache-v7.S            |   43 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/proc-macros.S         |    7 +++++-
 4 files changed, 98 insertions(+), 3 deletions(-)

-- 
1.7.9.5
