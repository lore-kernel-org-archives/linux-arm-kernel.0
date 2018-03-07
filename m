From: toshi.kani@hpe.com (Toshi Kani)
Date: Wed,  7 Mar 2018 11:32:25 -0700
Subject: [PATCH 0/2] fix memory leak / panic in ioremap huge pages
Message-ID: <20180307183227.17983-1-toshi.kani@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
may create pud/pmd mappings.  Kernel panic was observed on arm64
systems with Cortex-A75 in the following steps as described by
Hanjun Guo. [1]

1. ioremap a 4K size, valid page table will build,
2. iounmap it, pte0 will set to 0;
3. ioremap the same address with 2M size, pgd/pmd is unchanged,
   then set the a new value for pmd;
4. pte0 is leaked;
5. CPU may meet exception because the old pmd is still in TLB,
   which will lead to kernel panic.

This panic is not reproducible on x86.  INVLPG, called from iounmap,
purges all levels of entries associated with purged address on x86.
x86 still has memory leak.

Patch 01 adds new interfaces as stubs, which work as workaround of
this issue.  This patch 01 was leveraged from Hanjun's patch. [1]
Patch 02 fixes the issue on x86 by implementing the interfaces.

[1] https://patchwork.kernel.org/patch/10134581/

---
Toshi Kani (2):
 1/2 mm/vmalloc: Add interfaces to free unused page table
 2/2 x86/mm: implement free pmd/pte page interfaces

---
 arch/arm64/mm/mmu.c           | 10 ++++++++++
 arch/x86/mm/pgtable.c         | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/pgtable.h | 10 ++++++++++
 lib/ioremap.c                 |  6 ++++--
 4 files changed, 68 insertions(+), 2 deletions(-)
