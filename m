From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Tue, 22 Jul 2014 19:36:35 +0400
Subject: [PATCH 2/2] ARM: LPAE: reduce damage caused by idmap to virtual memory
 layout
In-Reply-To: <20140722153623.25088.37742.stgit@buzz>
References: <20140722153623.25088.37742.stgit@buzz>
Message-ID: <20140722153635.25088.14197.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

idmap layout combines both phisical and virtual addresses.
Everything works fine if ram physically lays below PAGE_OFFSET.
Otherwise idmap starts punching huge holes in virtual memory layout.
It maps ram by 2MiB sections, but when it allocates new pmd page it
cuts 1GiB at once.

This patch makes a copy of all affected pmds from init_mm.
Only few (usually one) 2MiB sections will be lost.
This is not eliminates problem but makes it 512 times less likely.

Usually idmap is used only for a short period. For examle for booting
secondary cpu __turn_mmu_on (executed in physical addresses) jumps to
virtual address of __secondary_switched which calls secondary_start_kernel
which in turn calls cpu_switch_mm and switches to normal pgd from init_mm.
So everything will be fine if these functions aren't intersect with idmap.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm/mm/idmap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 8e0e52e..dcd023c 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -25,6 +25,9 @@ static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 			pr_warning("Failed to allocate identity pmd.\n");
 			return;
 		}
+		if (!pud_none(*pud))
+			memcpy(pmd, pmd_offset(pud, 0),
+			       PTRS_PER_PMD * sizeof(pmd_t));
 		pud_populate(&init_mm, pud, pmd);
 		pmd += pmd_index(addr);
 	} else
