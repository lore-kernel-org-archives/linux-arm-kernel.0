From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:00:58 +0000
Subject: [PATCH v2 03/30] arm64: KVM: HYP mode idmap support
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary infrastructure for identity-mapped HYP page
tables. Idmap-ed code must be in the ".hyp.idmap.text" linker
section.

The rest of the HYP ends up in ".hyp.text".

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S |  10 +++
 arch/arm64/kvm/idmap.c          | 141 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/idmap.h          |   8 +++
 3 files changed, 159 insertions(+)
 create mode 100644 arch/arm64/kvm/idmap.c
 create mode 100644 arch/arm64/kvm/idmap.h

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3fae2be..51b87c3 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -17,6 +17,15 @@ ENTRY(stext)
 
 jiffies = jiffies_64;
 
+#define HYPERVISOR_TEXT					\
+	ALIGN_FUNCTION();				\
+	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
+	*(.hyp.idmap.text)				\
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
+	VMLINUX_SYMBOL(__hyp_text_start) = .;		\
+	*(.hyp.text)					\
+	VMLINUX_SYMBOL(__hyp_text_end) = .;
+
 SECTIONS
 {
 	/*
@@ -49,6 +58,7 @@ SECTIONS
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
+			HYPERVISOR_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
diff --git a/arch/arm64/kvm/idmap.c b/arch/arm64/kvm/idmap.c
new file mode 100644
index 0000000..68a55d4
--- /dev/null
+++ b/arch/arm64/kvm/idmap.c
@@ -0,0 +1,141 @@
+/*
+ * Copyright (C) 2012 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <asm/cputype.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/virt.h>
+
+#include "idmap.h"
+
+pgd_t *hyp_pgd;
+
+/*
+ * We always use a 2-level mapping for hyp-idmap:
+ * - Section mapped for 4kB pages
+ * - Page mapped for 64kB pages
+ */
+#ifdef CONFIG_ARM64_64K_PAGES
+static void idmap_add_pte(pmd_t *pmd, unsigned long addr, unsigned long end)
+{
+	struct page *page;
+	pte_t *pte;
+	unsigned long next;
+
+	if (pmd_none(*pmd)) {
+		pte = pte_alloc_one_kernel(NULL, addr);
+		if (!pte) {
+			pr_warning("Failed to allocate identity pte.\n");
+			return;
+		}
+		pmd_populate_kernel(NULL, pmd, pte);
+	}
+
+	pte = pte_offset_kernel(pmd, addr);
+
+	do {
+		page = phys_to_page(addr);
+		next = (addr & PAGE_MASK) + PAGE_SIZE;
+		set_pte(pte, mk_pte(page, PAGE_HYP));
+	} while (pte++, addr = next, addr < end);
+}
+#else
+#define HYP_SECT_PROT	(PMD_TYPE_SECT | PMD_SECT_AF | \
+			 PMD_ATTRINDX(MT_NORMAL) | PMD_HYP)
+
+/*
+ * For 4kB pages, we use a section to perform the identity mapping,
+ * hence the direct call to __pmd_populate().
+ */
+static void idmap_add_pte(pmd_t *pmd, unsigned long addr, unsigned long end)
+{
+	__pmd_populate(pmd, addr & PMD_MASK, HYP_SECT_PROT);
+}
+#endif
+
+static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	if (pud_none_or_clear_bad(pud)) {
+		pmd = pmd_alloc_one(NULL, addr);
+		if (!pmd) {
+			pr_warning("Failed to allocate identity pmd.\n");
+			return;
+		}
+		pud_populate(NULL, pud, pmd);
+	}
+
+	pmd = pmd_offset(pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+		idmap_add_pte(pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end)
+{
+	pud_t *pud = pud_offset(pgd, addr);
+	unsigned long next;
+
+	do {
+		next = pud_addr_end(addr, end);
+		idmap_add_pmd(pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+
+static int __init hyp_idmap_setup(void)
+{
+	unsigned long addr, end;
+	unsigned long next;
+	pgd_t *pgd;
+
+	if (!is_hyp_mode_available()) {
+		hyp_pgd = NULL;
+		return 0;
+	}
+
+	hyp_pgd = pgd_alloc(NULL);
+	if (!hyp_pgd)
+		return -ENOMEM;
+
+	addr = virt_to_phys(__hyp_idmap_text_start);
+	end = virt_to_phys(__hyp_idmap_text_end);
+
+	pr_info("Setting up static HYP identity map for 0x%lx - 0x%lx\n",
+		addr, end);
+
+	pgd = hyp_pgd + pgd_index(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		idmap_add_pud(pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+
+	dsb();
+
+	return 0;
+}
+early_initcall(hyp_idmap_setup);
diff --git a/arch/arm64/kvm/idmap.h b/arch/arm64/kvm/idmap.h
new file mode 100644
index 0000000..fcb130f
--- /dev/null
+++ b/arch/arm64/kvm/idmap.h
@@ -0,0 +1,8 @@
+#ifndef __KVM_IDMAP_H
+#define __KVM_IDMAP_H
+
+#include <asm/pgtable.h>
+
+extern pgd_t *hyp_pgd;
+
+#endif	/* __KVM_IDMAP_H */
-- 
1.8.1.4
