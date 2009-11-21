From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:39:14 +0000
Subject: [PATCH 09/10] ARM: dma-mapping: get rid of setting/clearing the
	reserved page bit
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvne-0007r7-AW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's unnecessary; x86 doesn't do it, and ALSA doesn't require it
anymore.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f3c0fc8..9807035 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -209,10 +209,6 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 		do {
 			BUG_ON(!pte_none(*pte));
 
-			/*
-			 * x86 does not mark the pages reserved...
-			 */
-			SetPageReserved(page);
 			set_pte_ext(pte, mk_pte(page, prot), 0);
 			page++;
 			pte++;
@@ -267,21 +263,9 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 			ptep = consistent_pte[++idx];
 		}
 
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
-				/*
-				 * x86 does not mark the pages reserved...
-				 */
-				ClearPageReserved(page);
-				continue;
-			}
-		}
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
+		if (pte_none(pte) || !pte_present(pte))
+			printk(KERN_CRIT "%s: bad page in kernel page table\n",
+			       __func__);
 	} while (size -= PAGE_SIZE);
 
 	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-- 
1.6.2.5
