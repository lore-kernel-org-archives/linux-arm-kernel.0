From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:15 +0100
Subject: [PATCH v2 01/12] ARM: mm: remove redundant dsb() prior to range TLB
 invalidation
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel TLB range invalidation functions already contain dsb
instructions before and after the maintenance, so there is no need to
introduce additional barriers.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dma-mapping.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ef3e0f3..5baabf7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -455,7 +455,6 @@ static void __dma_remap(struct page *page, size_t size, pgprot_t prot)
 	unsigned end = start + size;
 
 	apply_to_page_range(&init_mm, start, size, __dma_update_pte, &prot);
-	dsb();
 	flush_tlb_kernel_range(start, end);
 }
 
-- 
1.8.2.2
