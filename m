From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Aug 2013 21:12:59 -0700
Subject: [PATCH 2/4] ARM: KVM: Fix unaligned unmap_range leak
In-Reply-To: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
References: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376280781-6539-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unmap_range function did not properly cover the case when the start
address was not aligned to PMD_SIZE or PUD_SIZE and an entire pte table
or pmd table was cleared, causing us to leak memory when incrementing
the addr.

The fix is to always move onto the next page table entry boundary
instead of adding the full size of the VA range covered by the
corresponding table level entry.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ca6bea4..80a83ec 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -132,37 +132,37 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long long addr = start, end = start + size;
-	u64 range;
+	u64 next;
 
 	while (addr < end) {
 		pgd = pgdp + pgd_index(addr);
 		pud = pud_offset(pgd, addr);
 		if (pud_none(*pud)) {
-			addr += PUD_SIZE;
+			addr = pud_addr_end(addr, end);
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-			addr += PMD_SIZE;
+			addr = pmd_addr_end(addr, end);
 			continue;
 		}
 
 		pte = pte_offset_kernel(pmd, addr);
 		clear_pte_entry(kvm, pte, addr);
-		range = PAGE_SIZE;
+		next = addr + PAGE_SIZE;
 
 		/* If we emptied the pte, walk back up the ladder */
 		if (pte_empty(pte)) {
 			clear_pmd_entry(kvm, pmd, addr);
-			range = PMD_SIZE;
+			next = pmd_addr_end(addr, end);
 			if (pmd_empty(pmd)) {
 				clear_pud_entry(kvm, pud, addr);
-				range = PUD_SIZE;
+				next = pud_addr_end(addr, end);
 			}
 		}
 
-		addr += range;
+		addr = next;
 	}
 }
 
-- 
1.7.10.4
