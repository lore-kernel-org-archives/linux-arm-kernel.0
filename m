From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 28 Apr 2014 18:06:41 -0700
Subject: [PATCH v4 5/5] change update_range to handle > 4GB 2nd stage range for
 ARMv7
In-Reply-To: <535EF871.9090604@samsung.com>
References: <535EF871.9090604@samsung.com>
Message-ID: <535EFB21.9040308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds support for unmapping 2nd stage page tables for addresses >4GB
on ARMv7.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 88f5503..afbf8ba 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -176,21 +176,25 @@ static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
 	}
 }
 
+/* Function shared between identity and 2nd stage mappings. For 2nd stage
+ * the IPA may be > 4GB on ARMv7, and page table range functions
+ * will fail. kvm_xxx_addr_end() is used to handle both cases.
+ */
 static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
-			unsigned long long start, u64 size)
+			phys_addr_t start, u64 size)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long long addr = start, end = start + size;
-	u64 next;
+	phys_addr_t addr = start, end = start + size;
+	phys_addr_t next;
 
 	while (addr < end) {
 		pgd = pgdp + pgd_index(addr);
 		pud = pud_offset(pgd, addr);
 		if (pud_none(*pud)) {
-			addr = pud_addr_end(addr, end);
+			addr = kvm_pud_addr_end(addr, end);
 			continue;
 		}
 
@@ -200,13 +204,13 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 			 * move on.
 			 */
 			clear_pud_entry(kvm, pud, addr);
-			addr = pud_addr_end(addr, end);
+			addr = kvm_pud_addr_end(addr, end);
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-			addr = pmd_addr_end(addr, end);
+			addr = kvm_pmd_addr_end(addr, end);
 			continue;
 		}
 
@@ -221,10 +225,10 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 		 */
 		if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
 			clear_pmd_entry(kvm, pmd, addr);
-			next = pmd_addr_end(addr, end);
+			next = kvm_pmd_addr_end(addr, end);
 			if (page_empty(pmd) && !page_empty(pud)) {
 				clear_pud_entry(kvm, pud, addr);
-				next = pud_addr_end(addr, end);
+				next = kvm_pud_addr_end(addr, end);
 			}
 		}
 
-- 
1.7.9.5
