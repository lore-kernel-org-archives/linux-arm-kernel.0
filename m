From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:14 -0400
Subject: [PATCH 0/8] ARM: mm: Extend the runtime patch stub for PAE systems
Message-ID: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on discussion/debate on Cyril's generic code patching framework,
we cooked up this series which basically trying to extend the existing
v2p runtime patching for LPAE machines which can have physical memory
beyond 4 GB. Keystone is one such ARM machine.

We think the 64 bit patching can be still made better than the proposed
patch in the series and hence seeking expert comments from RMK, Nico and
others. Last patch in the series added to just give perspective on how
machine code will make use of the available bits from the series.

Santosh Shilimkar (6):
  ARM: mm: LPAE: use phys_addr_t appropriately in p2v and v2p
    conversions
  ARM: mm: Introduce virt_to_idmap() with an arch hook
  ARM: mm: Move the idmap print to appropriate place in the code
  ARM: mm: Pass the constant as an argument to fixup_pv_table()
  ARM: mm: Recreate kernel mappings in early_paging_init()
  ARM: keystone: Switch over to high physical address range

Sricharan R (2):
  ARM: mm: Add __pv_stub_mov to patch MOV instruction
  ARM: mm: LPAE: Correct virt_to_phys patching for 64 bit physical
    addresses

 arch/arm/include/asm/mach/arch.h  |    1 +
 arch/arm/include/asm/memory.h     |   72 ++++++++++++++++++++++++---
 arch/arm/kernel/armksyms.c        |    2 +
 arch/arm/kernel/head.S            |   39 +++++++++++++--
 arch/arm/kernel/module.c          |   11 ++++-
 arch/arm/kernel/setup.c           |    3 ++
 arch/arm/kernel/smp.c             |    2 +-
 arch/arm/kernel/vmlinux.lds.S     |    5 ++
 arch/arm/mach-keystone/keystone.c |   49 ++++++++++++++++++
 arch/arm/mach-keystone/memory.h   |   24 +++++++++
 arch/arm/mach-keystone/platsmp.c  |   16 +++++-
 arch/arm/mm/idmap.c               |    8 +--
 arch/arm/mm/mmu.c                 |   99 +++++++++++++++++++++++++++++++++++++
 13 files changed, 311 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-keystone/memory.h

-- 
1.7.9.5
