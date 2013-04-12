From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:18:50 +0100
Subject: [PATCH v3 5/7] ARM: KVM: rework HYP page table freeing
In-Reply-To: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365779932-20322-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in freeing HYP page tables differently from Stage-2.
They now have the same requirements, and should be dealt with the same way.

Promote unmap_stage2_range to be The One True Way, and get rid of a number
of nasty bugs in the process (goo thing we never actually called free_hyp_pmds
before...).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h |   2 +-
 arch/arm/kvm/arm.c             |   2 +-
 arch/arm/kvm/mmu.c             | 181 ++++++++++++++++++-----------------------
 3 files changed, 82 insertions(+), 103 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3c71a1d..92eb20d 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -32,7 +32,7 @@
 
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
-void free_hyp_pmds(void);
+void free_hyp_pgds(void);
 
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 23538ed..8992f05 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -937,7 +937,7 @@ static int init_hyp_mode(void)
 out_free_context:
 	free_percpu(kvm_host_cpu_state);
 out_free_mappings:
-	free_hyp_pmds();
+	free_hyp_pgds();
 out_free_stack_pages:
 	for_each_possible_cpu(cpu)
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index bfc5927..7464824 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -72,56 +72,104 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 	return p;
 }
 
-static void free_ptes(pmd_t *pmd, unsigned long addr)
+static void clear_pud_entry(pud_t *pud)
 {
-	pte_t *pte;
-	unsigned int i;
+	pmd_t *pmd_table = pmd_offset(pud, 0);
+	pud_clear(pud);
+	pmd_free(NULL, pmd_table);
+	put_page(virt_to_page(pud));
+}
 
-	for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE) {
-		if (!pmd_none(*pmd) && pmd_table(*pmd)) {
-			pte = pte_offset_kernel(pmd, addr);
-			pte_free_kernel(NULL, pte);
-		}
-		pmd++;
+static void clear_pmd_entry(pmd_t *pmd)
+{
+	pte_t *pte_table = pte_offset_kernel(pmd, 0);
+	pmd_clear(pmd);
+	pte_free_kernel(NULL, pte_table);
+	put_page(virt_to_page(pmd));
+}
+
+static bool pmd_empty(pmd_t *pmd)
+{
+	struct page *pmd_page = virt_to_page(pmd);
+	return page_count(pmd_page) == 1;
+}
+
+static void clear_pte_entry(pte_t *pte)
+{
+	if (pte_present(*pte)) {
+		kvm_set_pte(pte, __pte(0));
+		put_page(virt_to_page(pte));
 	}
 }
 
-static void free_hyp_pgd_entry(unsigned long addr)
+static bool pte_empty(pte_t *pte)
+{
+	struct page *pte_page = virt_to_page(pte);
+	return page_count(pte_page) == 1;
+}
+
+static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	unsigned long hyp_addr = KERN_TO_HYP(addr);
+	pte_t *pte;
+	unsigned long long addr = start, end = start + size;
+	u64 range;
 
-	pgd = hyp_pgd + pgd_index(hyp_addr);
-	pud = pud_offset(pgd, hyp_addr);
+	while (addr < end) {
+		pgd = pgdp + pgd_index(addr);
+		pud = pud_offset(pgd, addr);
+		if (pud_none(*pud)) {
+			addr += PUD_SIZE;
+			continue;
+		}
 
-	if (pud_none(*pud))
-		return;
-	BUG_ON(pud_bad(*pud));
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			addr += PMD_SIZE;
+			continue;
+		}
 
-	pmd = pmd_offset(pud, hyp_addr);
-	free_ptes(pmd, addr);
-	pmd_free(NULL, pmd);
-	pud_clear(pud);
+		pte = pte_offset_kernel(pmd, addr);
+		clear_pte_entry(pte);
+		range = PAGE_SIZE;
+
+		/* If we emptied the pte, walk back up the ladder */
+		if (pte_empty(pte)) {
+			clear_pmd_entry(pmd);
+			range = PMD_SIZE;
+			if (pmd_empty(pmd)) {
+				clear_pud_entry(pud);
+				range = PUD_SIZE;
+			}
+		}
+
+		addr += range;
+	}
 }
 
 /**
- * free_hyp_pmds - free a Hyp-mode level-2 tables and child level-3 tables
+ * free_hyp_pgds - free Hyp-mode page tables
  *
- * Assumes this is a page table used strictly in Hyp-mode and therefore contains
+ * Assumes hyp_pgd is a page table used strictly in Hyp-mode and therefore contains
  * either mappings in the kernel memory area (above PAGE_OFFSET), or
  * device mappings in the vmalloc range (from VMALLOC_START to VMALLOC_END).
  */
-void free_hyp_pmds(void)
+void free_hyp_pgds(void)
 {
 	unsigned long addr;
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
-	for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
-		free_hyp_pgd_entry(addr);
-	for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
-		free_hyp_pgd_entry(addr);
+
+	if (hyp_pgd) {
+		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
+			unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
+			unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+		kfree(hyp_pgd);
+	}
+
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
@@ -136,6 +184,7 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 	do {
 		pte = pte_offset_kernel(pmd, addr);
 		kvm_set_pte(pte, pfn_pte(pfn, prot));
+		get_page(virt_to_page(pte));
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 }
@@ -161,6 +210,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 				return -ENOMEM;
 			}
 			pmd_populate_kernel(NULL, pmd, pte);
+			get_page(virt_to_page(pmd));
 		}
 
 		next = pmd_addr_end(addr, end);
@@ -197,6 +247,7 @@ static int __create_hyp_mappings(pgd_t *pgdp,
 				goto out;
 			}
 			pud_populate(NULL, pud, pmd);
+			get_page(virt_to_page(pud));
 		}
 
 		next = pgd_addr_end(addr, end);
@@ -289,42 +340,6 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 	return 0;
 }
 
-static void clear_pud_entry(pud_t *pud)
-{
-	pmd_t *pmd_table = pmd_offset(pud, 0);
-	pud_clear(pud);
-	pmd_free(NULL, pmd_table);
-	put_page(virt_to_page(pud));
-}
-
-static void clear_pmd_entry(pmd_t *pmd)
-{
-	pte_t *pte_table = pte_offset_kernel(pmd, 0);
-	pmd_clear(pmd);
-	pte_free_kernel(NULL, pte_table);
-	put_page(virt_to_page(pmd));
-}
-
-static bool pmd_empty(pmd_t *pmd)
-{
-	struct page *pmd_page = virt_to_page(pmd);
-	return page_count(pmd_page) == 1;
-}
-
-static void clear_pte_entry(pte_t *pte)
-{
-	if (pte_present(*pte)) {
-		kvm_set_pte(pte, __pte(0));
-		put_page(virt_to_page(pte));
-	}
-}
-
-static bool pte_empty(pte_t *pte)
-{
-	struct page *pte_page = virt_to_page(pte);
-	return page_count(pte_page) == 1;
-}
-
 /**
  * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
  * @kvm:   The VM pointer
@@ -338,43 +353,7 @@ static bool pte_empty(pte_t *pte)
  */
 static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	phys_addr_t addr = start, end = start + size;
-	u64 range;
-
-	while (addr < end) {
-		pgd = kvm->arch.pgd + pgd_index(addr);
-		pud = pud_offset(pgd, addr);
-		if (pud_none(*pud)) {
-			addr += PUD_SIZE;
-			continue;
-		}
-
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
-			addr += PMD_SIZE;
-			continue;
-		}
-
-		pte = pte_offset_kernel(pmd, addr);
-		clear_pte_entry(pte);
-		range = PAGE_SIZE;
-
-		/* If we emptied the pte, walk back up the ladder */
-		if (pte_empty(pte)) {
-			clear_pmd_entry(pmd);
-			range = PMD_SIZE;
-			if (pmd_empty(pmd)) {
-				clear_pud_entry(pud);
-				range = PUD_SIZE;
-			}
-		}
-
-		addr += range;
-	}
+	unmap_range(kvm->arch.pgd, start, size);
 }
 
 /**
@@ -741,7 +720,7 @@ int kvm_mmu_init(void)
 
 	return 0;
 out:
-	kfree(hyp_pgd);
+	free_hyp_pgds();
 	return err;
 }
 
-- 
1.8.1.4
