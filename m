From: andrew_gabbasov@mentor.com (Andrew Gabbasov)
Date: Fri, 17 Feb 2017 06:09:36 -0700
Subject: [PATCH 0/3] ARM: mm: Fix ARMv7+ aliasing instuction cache invalidation
Message-ID: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7+ instruction cache supports memory location aliases
(when different virtual memory locations, mapped to the same
physical location, are stored in different cache lines).
But, unlike ARMv6, there is no page coloring restrictions,
and virtual address based instruction cache maintenance
operations does not affect all the aliases.

ARMv7-A and ARMv7-R Architecture Reference Manual, section B3.11.2:

"If instruction cache invalidation by address is performed on a memory
location, the effect of that invalidation is visible only to the virtual
address supplied with the operation. The effect of the invalidation might
not be visible to any other aliases of that physical memory location.

The only architecturally-guaranteed way to invalidate all aliases
of a physical address from a VIPT instruction cache is to invalidate
the entire instruction cache."

So, instruction cache invalidation after modification of instructions
in memory should be done differently from ARMv6. The correct way
is similar to what is now done for arm64 architecture.

This patch series implements necessary changes.
The third patch actually is not directly related to ARMv7 instruction
cache invalidation, but is a fix rather for ARMv6, but in related area.

Andrew Gabbasov (3):
  ARM: mm: Add a separate API function for DCCMVAU cache operation
  ARM: mm: Support VIPT aliasing but not coloring instruction cache
  ARM: mm: Fix checks for supporting caches for mapping color alignment

 arch/arm/include/asm/cacheflush.h |  3 +++
 arch/arm/include/asm/cachetype.h  |  4 +++-
 arch/arm/include/asm/glue-cache.h |  3 +++
 arch/arm/kernel/setup.c           | 17 ++++++++---------
 arch/arm/mm/cache-fa.S            |  3 +++
 arch/arm/mm/cache-nop.S           |  3 +++
 arch/arm/mm/cache-v4.S            |  3 +++
 arch/arm/mm/cache-v4wb.S          |  3 +++
 arch/arm/mm/cache-v4wt.S          |  3 +++
 arch/arm/mm/cache-v6.S            |  3 +++
 arch/arm/mm/cache-v7.S            | 27 +++++++++++++++++++++++++++
 arch/arm/mm/cache-v7m.S           | 23 +++++++++++++++++++++++
 arch/arm/mm/flush.c               | 11 ++++++++++-
 arch/arm/mm/mmap.c                |  6 ++++--
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
 arch/arm/mm/proc-feroceon.S       |  6 ++++++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  4 ++++
 29 files changed, 146 insertions(+), 13 deletions(-)

-- 
2.1.0
