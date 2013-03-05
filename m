From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:17 +0000
Subject: [PATCH 23/29] ARM: KVM: sanitize freeing of HYP page tables
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-24-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of trying to free everything from PAGE_OFFSET to the
top of memory, use the virt_addr_valid macro to check the
upper limit.

Also do the same for the vmalloc region where the IO mappings
are allocated.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ec14269..71d15bc 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -86,34 +86,42 @@ static void free_ptes(pmd_t *pmd, unsigned long addr)
 	}
 }
 
+static void free_hyp_pgd_entry(unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned long hyp_addr = KERN_TO_HYP(addr);
+
+	pgd = hyp_pgd + pgd_index(hyp_addr);
+	pud = pud_offset(pgd, hyp_addr);
+
+	if (pud_none(*pud))
+		return;
+	BUG_ON(pud_bad(*pud));
+
+	pmd = pmd_offset(pud, hyp_addr);
+	free_ptes(pmd, addr);
+	pmd_free(NULL, pmd);
+	pud_clear(pud);
+}
+
 /**
  * free_hyp_pmds - free a Hyp-mode level-2 tables and child level-3 tables
  *
  * Assumes this is a page table used strictly in Hyp-mode and therefore contains
- * only mappings in the kernel memory area, which is above PAGE_OFFSET.
+ * either mappings in the kernel memory area (above PAGE_OFFSET), or
+ * device mappings in the vmalloc range (from VMALLOC_START to VMALLOC_END).
  */
 void free_hyp_pmds(void)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
 	unsigned long addr;
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
-	for (addr = PAGE_OFFSET; addr != 0; addr += PGDIR_SIZE) {
-		unsigned long hyp_addr = KERN_TO_HYP(addr);
-		pgd = hyp_pgd + pgd_index(hyp_addr);
-		pud = pud_offset(pgd, hyp_addr);
-
-		if (pud_none(*pud))
-			continue;
-		BUG_ON(pud_bad(*pud));
-
-		pmd = pmd_offset(pud, hyp_addr);
-		free_ptes(pmd, addr);
-		pmd_free(NULL, pmd);
-		pud_clear(pud);
-	}
+	for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
+		free_hyp_pgd_entry(addr);
+	for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
+		free_hyp_pgd_entry(addr);
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
-- 
1.7.12.4
