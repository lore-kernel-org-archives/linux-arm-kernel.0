From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:15 +0000
Subject: [PATCH 21/29] ARM: KVM: allow HYP mappings to be at an offset from
 kernel mappings
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-22-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 cannot represent the kernel VAs in HYP mode, because of the lack
of TTBR1 at EL2. A way to cope with this situation is to have HYP VAs
to be an offset from the kernel VAs.

Introduce macros to convert a kernel VA to a HYP VA, make the HYP
mapping functions use these conversion macros. Also change the
documentation to reflect the existence of the offset.

On ARM, where we can have an identity mapping between kernel and HYP,
the macros are without any effect.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h |  8 ++++++++
 arch/arm/kvm/mmu.c             | 43 ++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index ac78493..3c71a1d 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -22,6 +22,14 @@
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
 
+/*
+ * We directly use the kernel VA for the HYP, as we can directly share
+ * the mapping (HTTBR "covers" TTBR1).
+ */
+#define HYP_PAGE_OFFSET_MASK	(~0UL)
+#define HYP_PAGE_OFFSET		PAGE_OFFSET
+#define KERN_TO_HYP(kva)	(kva)
+
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_hyp_pmds(void);
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 6b4ea18..ead6b16 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -101,14 +101,15 @@ void free_hyp_pmds(void)
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	for (addr = PAGE_OFFSET; addr != 0; addr += PGDIR_SIZE) {
-		pgd = hyp_pgd + pgd_index(addr);
-		pud = pud_offset(pgd, addr);
+		unsigned long hyp_addr = KERN_TO_HYP(addr);
+		pgd = hyp_pgd + pgd_index(hyp_addr);
+		pud = pud_offset(pgd, hyp_addr);
 
 		if (pud_none(*pud))
 			continue;
 		BUG_ON(pud_bad(*pud));
 
-		pmd = pmd_offset(pud, addr);
+		pmd = pmd_offset(pud, hyp_addr);
 		free_ptes(pmd, addr);
 		pmd_free(NULL, pmd);
 		pud_clear(pud);
@@ -124,7 +125,9 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 	struct page *page;
 
 	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
-		pte = pte_offset_kernel(pmd, addr);
+		unsigned long hyp_addr = KERN_TO_HYP(addr);
+
+		pte = pte_offset_kernel(pmd, hyp_addr);
 		BUG_ON(!virt_addr_valid(addr));
 		page = virt_to_page(addr);
 		kvm_set_pte(pte, mk_pte(page, PAGE_HYP));
@@ -139,7 +142,9 @@ static void create_hyp_io_pte_mappings(pmd_t *pmd, unsigned long start,
 	unsigned long addr;
 
 	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
-		pte = pte_offset_kernel(pmd, addr);
+		unsigned long hyp_addr = KERN_TO_HYP(addr);
+
+		pte = pte_offset_kernel(pmd, hyp_addr);
 		BUG_ON(pfn_valid(*pfn_base));
 		kvm_set_pte(pte, pfn_pte(*pfn_base, PAGE_HYP_DEVICE));
 		(*pfn_base)++;
@@ -154,12 +159,13 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 	unsigned long addr, next;
 
 	for (addr = start; addr < end; addr = next) {
-		pmd = pmd_offset(pud, addr);
+		unsigned long hyp_addr = KERN_TO_HYP(addr);
+		pmd = pmd_offset(pud, hyp_addr);
 
 		BUG_ON(pmd_sect(*pmd));
 
 		if (pmd_none(*pmd)) {
-			pte = pte_alloc_one_kernel(NULL, addr);
+			pte = pte_alloc_one_kernel(NULL, hyp_addr);
 			if (!pte) {
 				kvm_err("Cannot allocate Hyp pte\n");
 				return -ENOMEM;
@@ -200,11 +206,12 @@ static int __create_hyp_mappings(void *from, void *to, unsigned long *pfn_base)
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	for (addr = start; addr < end; addr = next) {
-		pgd = hyp_pgd + pgd_index(addr);
-		pud = pud_offset(pgd, addr);
+		unsigned long hyp_addr = KERN_TO_HYP(addr);
+		pgd = hyp_pgd + pgd_index(hyp_addr);
+		pud = pud_offset(pgd, hyp_addr);
 
 		if (pud_none_or_clear_bad(pud)) {
-			pmd = pmd_alloc_one(NULL, addr);
+			pmd = pmd_alloc_one(NULL, hyp_addr);
 			if (!pmd) {
 				kvm_err("Cannot allocate Hyp pmd\n");
 				err = -ENOMEM;
@@ -224,12 +231,13 @@ out:
 }
 
 /**
- * create_hyp_mappings - map a kernel virtual address range in Hyp mode
+ * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
  * @to:		The virtual kernel end address of the range (exclusive)
  *
- * The same virtual address as the kernel virtual address is also used in
- * Hyp-mode mapping to the same underlying physical pages.
+ * The same virtual address as the kernel virtual address is also used
+ * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
+ * physical pages.
  *
  * Note: Wrapping around zero in the "to" address is not supported.
  */
@@ -239,10 +247,13 @@ int create_hyp_mappings(void *from, void *to)
 }
 
 /**
- * create_hyp_io_mappings - map a physical IO range in Hyp mode
- * @from:	The virtual HYP start address of the range
- * @to:		The virtual HYP end address of the range (exclusive)
+ * create_hyp_io_mappings - duplicate a kernel IO mapping into Hyp mode
+ * @from:	The kernel start VA of the range
+ * @to:		The kernel end VA of the range (exclusive)
  * @addr:	The physical start address which gets mapped
+ *
+ * The resulting HYP VA is the same as the kernel VA, modulo
+ * HYP_PAGE_OFFSET.
  */
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t addr)
 {
-- 
1.7.12.4
