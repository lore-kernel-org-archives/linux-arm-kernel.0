From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:58:01 +0000
Subject: [RFC 5/9] arm64: don't open code page table entry creation
In-Reply-To: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1511265485-27163-6-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of open coding the generation of page table entries, use the
macros/functions that exist for this - pfn_p*d and p*d_populate. Most
code in the kernel already uses these macros, this patch tries to fix
up the few places that don't. This is useful for the next patch in this
series, which needs to change the page table entry logic, and it's
better to have that logic in one place.

The KVM extended ID map is special, since we're creating a level above
CONFIG_PGTABLE_LEVELS and the required function isn't available. (The
normal kernel ID map code doesn't need this change because its page
tables are created in assembly (__create_page_tables)).

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 11 +++++++++--
 arch/arm64/kernel/hibernate.c    |  3 +--
 arch/arm64/mm/mmu.c              | 14 +++++++++-----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 747bfff92948..5a11af32d1ff 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -276,6 +276,13 @@ static inline bool __kvm_cpu_uses_extended_idmap(void)
 	return __cpu_uses_extended_idmap();
 }
 
+/*
+ * Can't use pgd_populate here, because the extended idmap adds an extra level
+ * above CONFIG_PGTABLE_LEVELS (which is 2 or 3 if we're using the extended
+ * idmap), and pgd_populate is only available if CONFIG_PGTABLE_LEVELS = 4.
+ */
+#define kvm_extended_idmap_pgd(phys)	__pgd((phys) | PMD_TYPE_TABLE)
+
 static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 				       pgd_t *hyp_pgd,
 				       pgd_t *merged_hyp_pgd,
@@ -289,7 +296,7 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 	 * extended idmap.
 	 */
 	VM_BUG_ON(pgd_val(merged_hyp_pgd[0]));
-	merged_hyp_pgd[0] = __pgd(__pa(hyp_pgd) | PMD_TYPE_TABLE);
+	merged_hyp_pgd[0] = kvm_extended_idmap_pgd(__pa(hyp_pgd));
 
 	/*
 	 * Create another extended level entry that points to the boot HYP map,
@@ -299,7 +306,7 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 	 */
 	idmap_idx = hyp_idmap_start >> VA_BITS;
 	VM_BUG_ON(pgd_val(merged_hyp_pgd[idmap_idx]));
-	merged_hyp_pgd[idmap_idx] = __pgd(__pa(boot_hyp_pgd) | PMD_TYPE_TABLE);
+	merged_hyp_pgd[idmap_idx] = kvm_extended_idmap_pgd(__pa(boot_hyp_pgd));
 }
 
 static inline unsigned int kvm_get_vmid_bits(void)
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 1ef660ebf049..18b9695d93f9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -246,8 +246,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	}
 
 	pte = pte_offset_kernel(pmd, dst_addr);
-	set_pte(pte, __pte(virt_to_phys((void *)dst) |
-			 pgprot_val(PAGE_KERNEL_EXEC)));
+	set_pte(pte, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
 
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f1eb15e0e864..4152b36033a2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -570,8 +570,8 @@ static void __init map_kernel(pgd_t *pgd)
 		 * entry instead.
 		 */
 		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
-		set_pud(pud_set_fixmap_offset(pgd, FIXADDR_START),
-			__pud(__pa_symbol(bm_pmd) | PUD_TYPE_TABLE));
+		pud_populate(&init_mm, pud_set_fixmap_offset(pgd, FIXADDR_START),
+			     lm_alias(bm_pmd));
 		pud_clear_fixmap();
 	} else {
 		BUG();
@@ -686,7 +686,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 			if (!p)
 				return -ENOMEM;
 
-			set_pmd(pmd, __pmd(__pa(p) | PROT_SECT_NORMAL));
+			pmd_set_huge(pmd, __pa(p), __pgprot(PROT_SECT_NORMAL));
 		} else
 			vmemmap_verify((pte_t *)pmd, node, addr, next);
 	} while (addr = next, addr != end);
@@ -875,15 +875,19 @@ int __init arch_ioremap_pmd_supported(void)
 
 int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
 {
+	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
+					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pud, __pud(phys | PUD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+	set_pud(pud, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
 int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
 {
+	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
+					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmd, __pmd(phys | PMD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+	set_pmd(pmd, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-- 
2.1.4
