From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jul 2014 20:09:41 +0100
Subject: [PATCH v7 00/11] arm64: Support 4 levels of translation tables
Message-ID: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've taken over Jungseok's 4-level page table series here:

https://lkml.kernel.org/g/000001cf6dc6$03ded0c0$0b9c7240$@samsung.com

I kept the same series numbering, so this is normally version 7. Changes
since v6:

- Additional fixes for duplicate (SWAPPER|IDMAP)_DIR_SIZE definitions
- Removed the fixmap pmd from swapper_pg_dir populated in head.S
- Several clean-ups in Jungseok's patches (annotated above my
  signed-off-by line)
- Removal of the pgtable-*level-hwdef.h files
- Converting levels config options to int ARM64_PGTABLE_LEVELS

Important change: I dropped the KVM support for 4 levels temporarily. I
plan to revive them but didn't have for v7.

You can also access the branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64 pgtable-4levels

The branch is on top of the arm64 for-next/core branch.

Thanks.


Catalin Marinas (6):
  arm64: Remove duplicate (SWAPPER|IDMAP)_DIR_SIZE definitions
  arm64: Do not initialise the fixmap page tables in head.S
  arm64: Convert bool ARM64_x_LEVELS to int ARM64_PGTABLE_LEVELS
  arm64: Remove asm/pgtable-*level-hwdef.h files
  arm64: Clean up the initial page table creation in head.S
  arm64: Determine the vmalloc/vmemmap space at build time based on
    VA_BITS

Jungseok Lee (5):
  arm64: Use pr_* instead of printk
  arm64: Introduce VA_BITS and translation level options
  arm64: Add a description on 48-bit address space with 4KB pages
  arm64: Add 4 levels of page tables definition with 4KB pages
  arm64: mm: Implement 4 levels of translation tables

 Documentation/arm64/memory.txt                | 67 ++++++++-----------------
 arch/arm64/Kconfig                            | 51 ++++++++++++++++++-
 arch/arm64/include/asm/memory.h               |  6 +--
 arch/arm64/include/asm/page.h                 | 17 +++++--
 arch/arm64/include/asm/pgalloc.h              | 24 ++++++++-
 arch/arm64/include/asm/pgtable-2level-hwdef.h | 43 ----------------
 arch/arm64/include/asm/pgtable-3level-hwdef.h | 50 -------------------
 arch/arm64/include/asm/pgtable-4level-types.h | 71 +++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        | 42 ++++++++++++++--
 arch/arm64/include/asm/pgtable.h              | 56 ++++++++++++++++++---
 arch/arm64/include/asm/tlb.h                  | 11 ++++-
 arch/arm64/kernel/head.S                      | 52 +++++++++++++-------
 arch/arm64/kernel/traps.c                     | 13 +++--
 arch/arm64/mm/fault.c                         |  1 +
 arch/arm64/mm/init.c                          | 22 ++++++---
 arch/arm64/mm/ioremap.c                       | 30 ++++++++---
 arch/arm64/mm/mmu.c                           | 14 ++++--
 17 files changed, 363 insertions(+), 207 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pgtable-2level-hwdef.h
 delete mode 100644 arch/arm64/include/asm/pgtable-3level-hwdef.h
 create mode 100644 arch/arm64/include/asm/pgtable-4level-types.h
