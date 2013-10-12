From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Oct 2013 17:58:43 -0400
Subject: [RFC 00/23] mm: Use memblock interface instead of bootmem
Message-ID: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun, Yinghai and others, 

Here is an attempt to convert the core kernel code to memblock allocator
APIs when used with NO_BOOTMEM. Based on discussion thread [1] and my
limited understanding of the topic, I tried to cook up this RFC with
help from Grygorii. I am counting on reviews, guidance and testing help
to move forward with the approach. This is one of the blocking item for
the ARM LPAE architecture on the physical memory starts after 4BG boundary
and hence needs the early memory allocators 

As outlined by Tejun, we would like to remove the use of nobootmem.c and
then eventually bootmem allocator once all arch switch to NO_BOOTMEM.
Not to break the existing architectures using bootmem, all the new
memblock interfaces fall back to bootmem layer with !NO_BOOTMEM

Testing is done on ARM architecture with 32 bit and ARM LAPE machines
with normal as well sparse(famed) memory model. To convert ARM to
NO_BOOTMEM, I have used Russell's work [2] and couple of patches
on top of that.

Comments/suggestions are welcome !!

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Olof Johansson <olof@lixom.net>

Grygorii Strashko (9):
  mm/bootmem: remove duplicated declaration of __free_pages_bootmem()
  mm/block: remove unnecessary inclusion of bootmem.h
  mm/memory_hotplug: remove unnecessary inclusion of bootmem.h
  mm/staging: remove unnecessary inclusion of bootmem.h
  mm/char: remove unnecessary inclusion of bootmem.h
  mm/memblock: debug: correct displaying of upper memory boundary
  mm/memblock: debug: don't free reserved array if
    !ARCH_DISCARD_MEMBLOCK
  mm/hugetlb: Use memblock apis for early memory allocations
  mm/page_cgroup: Use memblock apis for early memory allocations

Santosh Shilimkar (14):
  mm/memblock: Add memblock early memory allocation apis
  mm/init: Use memblock apis for early memory allocations
  mm/printk: Use memblock apis for early memory allocations
  mm/page_alloc: Use memblock apis for early memory allocations
  mm/power: Use memblock apis for early memory allocations
  mm/lib: Use memblock apis for early memory allocations
  mm/lib: Use memblock apis for early memory allocations
  mm/sparse: Use memblock apis for early memory allocations
  mm/percpu: Use memblock apis for early memory allocations
  mm/memory_hotplug: Use memblock apis for early memory allocations
  mm/firmware: Use memblock apis for early memory allocations
  mm/ARM: kernel: Use memblock apis for early memory allocations
  mm/ARM: mm: Use memblock apis for early memory allocations
  mm/ARM: OMAP: Use memblock apis for early memory allocations

 arch/arm/kernel/devtree.c        |    2 +-
 arch/arm/kernel/setup.c          |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |    8 +--
 arch/arm/mm/init.c               |    2 +-
 block/blk-ioc.c                  |    1 -
 drivers/char/mem.c               |    1 -
 drivers/firmware/memmap.c        |    2 +-
 drivers/staging/speakup/main.c   |    2 -
 include/linux/bootmem.h          |   73 ++++++++++++++++++++++-
 init/main.c                      |    4 +-
 kernel/power/snapshot.c          |    2 +-
 kernel/printk/printk.c           |   10 +---
 lib/cpumask.c                    |    4 +-
 lib/swiotlb.c                    |   30 +++++-----
 mm/hugetlb.c                     |   10 ++--
 mm/memblock.c                    |  122 +++++++++++++++++++++++++++++++++++++-
 mm/memory_hotplug.c              |    3 +-
 mm/page_alloc.c                  |   26 ++++----
 mm/page_cgroup.c                 |    5 +-
 mm/percpu.c                      |   39 +++++++-----
 mm/sparse-vmemmap.c              |    5 +-
 mm/sparse.c                      |   24 ++++----
 22 files changed, 284 insertions(+), 93 deletions(-)

Regards,
Santosh

[1] https://lkml.org/lkml/2013/6/29/77
[2] http://lwn.net/Articles/561854/
-- 
1.7.9.5
