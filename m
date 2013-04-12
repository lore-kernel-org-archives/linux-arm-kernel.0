From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 19:12:02 +0100
Subject: [PATCH v4 2/7] ARM: KVM: fix HYP mapping limitations around zero
In-Reply-To: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365790327-2138-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code for creating HYP mapping doesn't like to wrap
around zero, which prevents from mapping anything into the last
page of the virtual address space.

It doesn't take much effort to remove this limitation, making
the code more consistent with the rest of the kernel in the process.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3003321..96d61da 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -131,11 +131,12 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 	pte_t *pte;
 	unsigned long addr;
 
-	for (addr = start; addr < end; addr += PAGE_SIZE) {
+	addr = start;
+	do {
 		pte = pte_offset_kernel(pmd, addr);
 		kvm_set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
-	}
+	} while (addr += PAGE_SIZE, addr != end);
 }
 
 static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
@@ -146,7 +147,8 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 	pte_t *pte;
 	unsigned long addr, next;
 
-	for (addr = start; addr < end; addr = next) {
+	addr = start;
+	do {
 		pmd = pmd_offset(pud, addr);
 
 		BUG_ON(pmd_sect(*pmd));
@@ -164,7 +166,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 
 		create_hyp_pte_mappings(pmd, addr, next, pfn, prot);
 		pfn += (next - addr) >> PAGE_SHIFT;
-	}
+	} while (addr = next, addr != end);
 
 	return 0;
 }
@@ -179,11 +181,10 @@ static int __create_hyp_mappings(pgd_t *pgdp,
 	unsigned long addr, next;
 	int err = 0;
 
-	if (start >= end)
-		return -EINVAL;
-
 	mutex_lock(&kvm_hyp_pgd_mutex);
-	for (addr = start & PAGE_MASK; addr < end; addr = next) {
+	addr = start & PAGE_MASK;
+	end = PAGE_ALIGN(end);
+	do {
 		pgd = pgdp + pgd_index(addr);
 		pud = pud_offset(pgd, addr);
 
@@ -202,7 +203,7 @@ static int __create_hyp_mappings(pgd_t *pgdp,
 		if (err)
 			goto out;
 		pfn += (next - addr) >> PAGE_SHIFT;
-	}
+	} while (addr = next, addr != end);
 out:
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 	return err;
@@ -216,8 +217,6 @@ out:
  * The same virtual address as the kernel virtual address is also used
  * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
  * physical pages.
- *
- * Note: Wrapping around zero in the "to" address is not supported.
  */
 int create_hyp_mappings(void *from, void *to)
 {
-- 
1.8.1.4
