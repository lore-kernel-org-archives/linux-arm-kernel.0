From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  8 May 2011 13:51:19 +0100
Subject: [PATCH v5 00/19] ARM: Add support for the Large Physical Address
	Extensions
Message-ID: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches adds support for the Large Physical Extensions on
the ARM architecture (available with the Cortex-A15 processor). LPAE
comes with a 3-level page table format (compared to 2-level for the
classic one), allowing up to 40-bit physical address space.

The ARM LPAE documentation is available from (free registration needed):

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0406b_virtualization_extns/index.html

The full set of patches on top of linux-next (LPAE, support for an
emulated Versatile Express with Cortex-A15 tile and generic timers) is
available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-2.6-cm.git arm-lpae-next

Changelog:

- Rebased on top of linux-next 20110503.
- Using pgtable-nopud.h (following Russell's patch for the classic page
  table format).
- Other fixes related to the nopud and v2p changes (mainly idmap).
- The SMP support patch was dropped and a more generic variant added that
  makes TTBR1 always point to swapper_pg_dir on ARMv7.
- Some of the previous patches already merged into mainline.


Catalin Marinas (15):
  ARM: LPAE: Use long long printk format for displaying the pud
  ARM: LPAE: Use unsigned long for __phys_to_virt and __virt_to_phys
  ARM: LPAE: Make TTBR1 always point to swapper_pg_dir on ARMv7
  ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead of PGDIR_*
  ARM: LPAE: Factor out 2-level page table definitions into separate
    files
  ARM: LPAE: Add (pte|pmd|pgd|pgprot)val_t type definitions as u32
  ARM: LPAE: Use a mask for physical addresses in page table entries
  ARM: LPAE: Introduce the 3-level page table format definitions
  ARM: LPAE: Page table maintenance for the 3-level format
  ARM: LPAE: MMU setup for the 3-level page table format
  ARM: LPAE: Add fault handling support
  ARM: LPAE: Add context switching support
  ARM: LPAE: Add identity mapping support for the 3-level page table
    format
  ARM: LPAE: Add support for cpu_v7_do_(suspend|resume)
  ARM: LPAE: Add the Kconfig entries

Will Deacon (4):
  ARM: LPAE: add ISBs around MMU enabling code
  ARM: LPAE: Use generic dma_addr_t type definition
  ARM: LPAE: mark memory banks with start > ULONG_MAX as highmem
  ARM: LPAE: add support for ATAG_MEM64

 arch/arm/Kconfig                            |    2 +-
 arch/arm/include/asm/assembler.h            |   11 ++
 arch/arm/include/asm/memory.h               |    4 +-
 arch/arm/include/asm/page.h                 |   44 +-----
 arch/arm/include/asm/pgalloc.h              |   28 ++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |   93 ++++++++++++
 arch/arm/include/asm/pgtable-2level-types.h |   67 +++++++++
 arch/arm/include/asm/pgtable-2level.h       |  143 ++++++++++++++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |   81 ++++++++++
 arch/arm/include/asm/pgtable-3level-types.h |   68 +++++++++
 arch/arm/include/asm/pgtable-3level.h       |  106 ++++++++++++++
 arch/arm/include/asm/pgtable-hwdef.h        |   81 +----------
 arch/arm/include/asm/pgtable.h              |  211 +++++++++------------------
 arch/arm/include/asm/proc-fns.h             |   25 +++
 arch/arm/include/asm/setup.h                |   10 +-
 arch/arm/include/asm/smp.h                  |    1 +
 arch/arm/include/asm/tlbflush.h             |    4 +-
 arch/arm/include/asm/types.h                |   11 +--
 arch/arm/kernel/compat.c                    |    4 +-
 arch/arm/kernel/head.S                      |  126 +++++++++++-----
 arch/arm/kernel/module.c                    |    2 +-
 arch/arm/kernel/setup.c                     |   12 ++-
 arch/arm/kernel/smp.c                       |    1 +
 arch/arm/mm/Kconfig                         |   13 ++
 arch/arm/mm/alignment.c                     |    8 +-
 arch/arm/mm/context.c                       |   19 ++-
 arch/arm/mm/dma-mapping.c                   |    6 +-
 arch/arm/mm/fault.c                         |   82 ++++++++++-
 arch/arm/mm/idmap.c                         |   36 +++++-
 arch/arm/mm/ioremap.c                       |    8 +-
 arch/arm/mm/mm.h                            |    4 +-
 arch/arm/mm/mmu.c                           |   51 +++++--
 arch/arm/mm/pgd.c                           |   51 ++++++-
 arch/arm/mm/proc-macros.S                   |    5 +-
 arch/arm/mm/proc-v7.S                       |  152 +++++++++++++++++--
 35 files changed, 1207 insertions(+), 363 deletions(-)
 create mode 100644 arch/arm/include/asm/pgtable-2level-hwdef.h
 create mode 100644 arch/arm/include/asm/pgtable-2level-types.h
 create mode 100644 arch/arm/include/asm/pgtable-2level.h
 create mode 100644 arch/arm/include/asm/pgtable-3level-hwdef.h
 create mode 100644 arch/arm/include/asm/pgtable-3level-types.h
 create mode 100644 arch/arm/include/asm/pgtable-3level.h
