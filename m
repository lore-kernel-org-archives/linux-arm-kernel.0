From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2011 16:23:36 +0000
Subject: [PATCH v9 00/15] ARM: Add support for the Large Physical Address
 Extensions
Message-ID: <1321287831-24560-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 9 of the set of patches adding support for the Large
Physical Address Extensions on the ARM architecture (available with the
Cortex-A15 and Cortex-A7 processors).

This patch set against 3.2-rc1 is available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux.git for-next

The patch set also includes Russell's nopud patch with an additional
fix-up to be reviewed (they are not in mainline yet but LPAE depends on
them).


Changelog (from v8, updates following review):

- Removed the ATAG_MEM64 patch.
- Removed the different PMD_SECT_XN definition for asm.
- proc-v7.S fixes for SMP/UP instructions pairing.
- Removed references to PHYS_OFFSET in proc-v7.S and added comment about
  VMSPLIT_1G.
- pr_fmt() definition removed from idmap.c.
- ARCH_DMA_ADDR_T_64BIT now defaults to false without any dependencies.
  Platforms should select this explicitly.
- Reordered the nopud fixup with Russell's nopud patch.

Known issues:

- idmap_add_pmd() still cannot be called in an atomic context but the
  kexec patches re-implement the setup_mm_for_reboot() function and it
  no longer calls identity_mapping_add().


Catalin Marinas (12):
  ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud
  ARM: LPAE: Move page table maintenance macros to pgtable-2level.h
  ARM: LPAE: Move the FSR definitions to separate files
  ARM: LPAE: Factor out classic-MMU specific code into proc-v7-2level.S
  ARM: LPAE: Introduce the 3-level page table format definitions
  ARM: LPAE: Page table maintenance for the 3-level format
  ARM: LPAE: MMU setup for the 3-level page table format
  ARM: LPAE: Invalidate the TLB before freeing the PMD
  ARM: LPAE: Add fault handling support
  ARM: LPAE: Add context switching support
  ARM: LPAE: Add identity mapping support for the 3-level page table
    format
  ARM: LPAE: Add the Kconfig entries

Russell King (1):
  ARM: pgtable: switch to use pgtable-nopud.h

Will Deacon (2):
  ARM: LPAE: add ISBs around MMU enabling code
  ARM: LPAE: mark memory banks with start > ULONG_MAX as highmem

 arch/arm/Kconfig                            |    2 +-
 arch/arm/boot/compressed/head.S             |    1 +
 arch/arm/include/asm/assembler.h            |   11 ++
 arch/arm/include/asm/page.h                 |    4 +
 arch/arm/include/asm/pgalloc.h              |   26 ++++-
 arch/arm/include/asm/pgtable-2level.h       |   41 ++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |   77 ++++++++++++
 arch/arm/include/asm/pgtable-3level-types.h |   70 +++++++++++
 arch/arm/include/asm/pgtable-3level.h       |  155 +++++++++++++++++++++++
 arch/arm/include/asm/pgtable-hwdef.h        |    4 +
 arch/arm/include/asm/pgtable.h              |   43 +------
 arch/arm/include/asm/proc-fns.h             |   21 +++
 arch/arm/include/asm/system.h               |    8 ++
 arch/arm/include/asm/tlb.h                  |   12 ++-
 arch/arm/kernel/head.S                      |   47 +++++++-
 arch/arm/kernel/hw_breakpoint.c             |    8 +-
 arch/arm/kernel/sleep.S                     |    2 +
 arch/arm/mm/Kconfig                         |   17 +++
 arch/arm/mm/alignment.c                     |    2 +-
 arch/arm/mm/context.c                       |   19 +++-
 arch/arm/mm/fault.c                         |  111 +++--------------
 arch/arm/mm/fault.h                         |   27 ++++-
 arch/arm/mm/fsr-2level.c                    |   78 ++++++++++++
 arch/arm/mm/fsr-3level.c                    |   68 ++++++++++
 arch/arm/mm/idmap.c                         |   34 +++++-
 arch/arm/mm/ioremap.c                       |   39 ++++---
 arch/arm/mm/mmu.c                           |   46 +++++++-
 arch/arm/mm/pgd.c                           |   51 +++++++-
 arch/arm/mm/proc-macros.S                   |    5 +-
 arch/arm/mm/proc-v7-2level.S                |  171 ++++++++++++++++++++++++++
 arch/arm/mm/proc-v7-3level.S                |  151 +++++++++++++++++++++++
 arch/arm/mm/proc-v7.S                       |  177 +++------------------------
 32 files changed, 1205 insertions(+), 323 deletions(-)
 create mode 100644 arch/arm/include/asm/pgtable-3level-hwdef.h
 create mode 100644 arch/arm/include/asm/pgtable-3level-types.h
 create mode 100644 arch/arm/include/asm/pgtable-3level.h
 create mode 100644 arch/arm/mm/fsr-2level.c
 create mode 100644 arch/arm/mm/fsr-3level.c
 create mode 100644 arch/arm/mm/proc-v7-2level.S
 create mode 100644 arch/arm/mm/proc-v7-3level.S
