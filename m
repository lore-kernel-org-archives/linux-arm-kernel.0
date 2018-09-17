From: minchan@kernel.org (Minchan Kim)
Date: Mon, 17 Sep 2018 09:44:51 +0900
Subject: [PATCH v1 3/3] arm: mm: support get_user_pages_fast
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
Message-ID: <20180917004451.174527-4-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, there was a report get_user_pages_fast helps app launching
speed due to reducing uninterruptible sleep time because we don't
need to contend for mmap_sem, I believe.

With get_user_pages_fast, that uniterruptible sleep time is reduced
about 5~10% by testing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/mm/Makefile |   6 ++
 arch/arm/mm/gup.c    | 221 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/arm/mm/gup.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699fbfc4..f55f96d56843 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -13,6 +13,12 @@ obj-y				+= nommu.o
 obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o pmsa-v8.o
 endif
 
+ifneq ($(CONFIG_ARM_LPAE),y)
+ifeq ($(CONFIG_ARCH_HAS_PTE_SPECIAL),y)
+obj-$(CONFIG_MMU)		+= gup.o
+endif
+endif
+
 obj-$(CONFIG_ARM_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
diff --git a/arch/arm/mm/gup.c b/arch/arm/mm/gup.c
new file mode 100644
index 000000000000..4b9ce1f2d998
--- /dev/null
+++ b/arch/arm/mm/gup.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/pagemap.h>
+#include <asm/pgtable.h>
+
+static inline pte_t gup_get_pte(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
+static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	int ret = 0;
+	pte_t *ptep, *ptem;
+
+	ptem = ptep = pte_offset_map(&pmd, addr);
+	do {
+		pte_t pte = gup_get_pte(ptep);
+		struct page *page;
+
+		if (!pte_access_permitted(pte, write))
+			goto pte_unmap;
+
+		if (pte_special(pte))
+			goto pte_unmap;
+
+		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+		page = pte_page(pte);
+
+		if (!page_cache_get_speculative(page))
+			goto pte_unmap;
+
+		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+			put_page(page);
+			goto pte_unmap;
+		}
+
+		SetPageReferenced(page);
+		pages[*nr] = page;
+		(*nr)++;
+
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	ret = 1;
+
+pte_unmap:
+	pte_unmap(ptem);
+	return ret;
+}
+
+static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pmd_t *pmdp;
+
+	pmdp = pmd_offset(&pud, addr);
+	do {
+		pmd_t pmd = READ_ONCE(*pmdp);
+
+		next = pmd_addr_end(addr, end);
+		if (!pmd_present(pmd))
+			return 0;
+		else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
+			return 0;
+	} while (pmdp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_pud_range(p4d_t *p4dp, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pud_t *pudp;
+
+	pudp = pud_offset(p4dp, addr);
+	do {
+		pud_t pud = READ_ONCE(*pudp);
+
+		next = pud_addr_end(addr, end);
+		if (pud_none(pud))
+			return 0;
+		else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+			return 0;
+	} while (pudp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_p4d_range(pgd_t *pgdp, unsigned long addr, unsigned long end,
+			 int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	p4d_t *p4dp;
+
+	p4dp = p4d_offset(pgdp, addr);
+	do {
+		next = p4d_addr_end(addr, end);
+		if (p4d_none(*p4dp))
+			return 0;
+		else if (!gup_pud_range(p4dp, addr, next, write, pages, nr))
+			return 0;
+	} while (p4dp++, addr = next, addr != end);
+
+	return 1;
+}
+
+
+static void gup_pgd_range(unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pgd_t *pgdp;
+
+	pgdp = pgd_offset(current->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgdp))
+			return;
+		else if (!gup_p4d_range(pgdp, addr, next, write, pages, nr))
+			break;
+	} while (pgdp++, addr = next, addr != end);
+}
+
+bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+{
+	unsigned long len, end;
+
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+	return end >= start;
+}
+
+/*
+ * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
+ * back to the regular GUP.
+ */
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
+{
+	unsigned long addr, len, end;
+	unsigned long flags;
+	int nr = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return 0;
+
+	/*
+	 * Disable interrupts.  We use the nested form as we can already have
+	 * interrupts disabled by get_futex_key.
+	 *
+	 * With interrupts disabled, we block page table pages from being
+	 * freed from under us. See mmu_gather_tlb in asm-generic/tlb.h
+	 * for more details.
+	 *
+	 * We do not adopt an rcu_read_lock(.) here as we also want to
+	 * block IPIs that come from THPs splitting.
+	 */
+
+	if (gup_fast_permitted(start, nr_pages, write)) {
+		local_irq_save(flags);
+		gup_pgd_range(addr, end, write, pages, &nr);
+		local_irq_restore(flags);
+	}
+
+	return nr;
+}
+
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			struct page **pages)
+{
+	unsigned long addr, len, end;
+	int nr = 0, ret = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+
+	if (nr_pages <= 0)
+		return 0;
+
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return -EFAULT;
+
+	if (gup_fast_permitted(start, nr_pages, write)) {
+		local_irq_disable();
+		gup_pgd_range(addr, end, write, pages, &nr);
+		local_irq_enable();
+		ret = nr;
+	}
+
+	if (nr < nr_pages) {
+		/* Try to get the remaining pages with get_user_pages */
+		start += nr << PAGE_SHIFT;
+		pages += nr;
+
+		ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
+				write ? FOLL_WRITE : 0);
+
+		/* Have to be a bit careful with return values */
+		if (nr > 0) {
+			if (ret < 0)
+				ret = nr;
+			else
+				ret += nr;
+		}
+	}
+
+	return ret;
+}
-- 
2.19.0.397.gdd90340f6a-goog
