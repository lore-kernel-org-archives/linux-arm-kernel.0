From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:27 +0100
Subject: [RFC PATCH 14/17] ARM: kernel: save/restore 1:1 page tables
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-15-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the code required to allocate and populate page tables
that are needed by save/restore code to deal with MMU off/on
transactions.

MMU is enabled early in the resume path which allows to call into
Linux subsystems with init_mm virtual mappings (cloned at boot).

Current thread page table pointer and context id is saved on power
down from active_mm and restored on warm boot.
Currently the translation tables contains 1:1 mappings of the Linux
kernel code and data, and 1:1 UNCACHED mapping of control code required when MMU
is turned off in the restore code path.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sr_mapping.c |   78 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/sr_mapping.c

diff --git a/arch/arm/kernel/sr_mapping.c b/arch/arm/kernel/sr_mapping.c
new file mode 100644
index 0000000..32640dc
--- /dev/null
+++ b/arch/arm/kernel/sr_mapping.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/mm_types.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/sections.h>
+#include <asm/cputype.h>
+#include <asm/cacheflush.h>
+#include "sr_helpers.h"
+#include "sr.h"
+
+#define PROT_PTE_DEVICE		(L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN)
+
+static pgd_t *pgd;
+
+static void *linux_sr_map_page(void *addr, unsigned int size,
+				 pgprot_t prot)
+{
+	pmd_t *pmd;
+	pte_t *pte;
+	u64 pfn;
+	unsigned long end = (unsigned long) (addr) + size;
+	unsigned long vaddr = (unsigned long) (addr);
+
+	pmd = pmd_offset(pgd + pgd_index(vaddr), vaddr);
+	pfn = vaddr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel(pmd, vaddr);
+
+	do {
+		if (!pte)
+			return NULL;
+		set_pte_ext(pte, pfn_pte(pfn, prot), 0);
+		outer_clean_range(__pa(pte), __pa(pte + 1));
+		pfn++;
+	} while (pte++, vaddr += PAGE_SIZE, vaddr != end);
+
+	return addr;
+}
+
+int linux_sr_setup_translation_tables(void)
+{
+	pgd = pgd_alloc(&init_mm);
+
+	if (!pgd)
+		return -ENOMEM;
+	/*
+	 * These kernel identity mappings are not strictly necessary
+	 * since resume code creates them on the fly.
+	 * They are left for completeness in case the suspend
+	 * code had to turn MMU off for a power down failure and
+	 * the call to (*sr_sleep) returns.
+	 */
+	identity_mapping_add(pgd, __pa(_stext), __pa(_etext));
+	identity_mapping_add(pgd, __pa(_sdata), __pa(_edata));
+
+	linux_sr_map_page(context_memory_uncached,
+				CONTEXT_SPACE_UNCACHED,
+				__pgprot(PROT_PTE_DEVICE |
+				L_PTE_MT_UNCACHED | L_PTE_SHARED));
+
+	/* save pgd of translation tables for cpu_switch_mm */
+	main_table.fw_mmu_context = pgd;
+
+	__cpuc_flush_dcache_area(pgd, sizeof(pgd));
+	outer_clean_range(__pa(pgd), __pa(pgd + 1));
+	return 0;
+}
-- 
1.7.4.4
