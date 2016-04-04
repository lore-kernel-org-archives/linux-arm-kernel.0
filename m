From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 10:31:20 +0200
Subject: [PATCH v5 0/4] fix memremap on ARM
Message-ID: <1459758684-16191-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is something I ran into while working on support for the UEFI
memory attributes and ESRT tables. In both cases, these tables are
passed to the kernel in memory which is guaranteed to be below 4 GB,
but may be outside of the kernel direct mapping. (UEFI typically
attempts to allocate from the top down, which means such tables are
highly likely to be in highmem for any system with more than 760 MB
of system RAM)

The recently introduced memremap() is a very useful abstraction for
accessing such tables, because it is generic, and already attempts to
do the right thing with respect to regions that may already have been
mapped directly. However, it falls back to ioremap_cache() for mapping
high memory, which is not allowed on ARM for system RAM, and also results
in the region to be mapped with different attributes depending on whether
it is covered by lowmem or not.

So instead, create an arch specific hook 'arch_memremap_wb(), and
implement it for ARM using the same memory attributes used for the
linear mapping. Note that memremap will only call this hook for regions
that are not already mapped permanently.

Since this change results in memremap() to use attributes different from
the ones used by ioremap_cache(), revert the change to pxa2xx-flash that
moved it to memremap.

Changes since v4:
- fix !MMU problems spotted by the kbuild test robot (patches #1 and #4)
- rebased onto v4.6-rc2 (no conflicts)

Changes since v3:
- fix inadvertent logic change, where invoking arch_memremap_wb() would only be
  attempted on a region that intersects System RAM

Changes since v2:
- add patch to bring back ioremap_cached() on ARM
- switch pxa2xx-flash back to ioremap_cached() not ioremap_cache()
- use arch_ioremap_caller not __arm_ioremap_caller() in patch #4
- deal with __iomem annotation of arch_ioremap_caller (patch #4)

Changes since v1/rfc:
- new patch #1 that reverts the ioremap_cache->memremap conversion for the
  pxa2xx-flash driver
- added Dan's ack to patch #2

Ard Biesheuvel (4):
  ARM: reintroduce ioremap_cached() for creating cached I/O mappings
  mtd: pxa2xx-flash: switch back from memremap to ioremap_cached
  memremap: add arch specific hook for MEMREMAP_WB mappings
  ARM: memremap: implement arch_memremap_wb()

 arch/arm/include/asm/io.h       | 12 ++++++++++++
 arch/arm/mm/ioremap.c           | 16 ++++++++++++++--
 arch/arm/mm/nommu.c             |  9 +++++++++
 drivers/mtd/maps/pxa2xx-flash.c |  6 +++---
 kernel/memremap.c               | 11 +++++++++--
 5 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.5.0
