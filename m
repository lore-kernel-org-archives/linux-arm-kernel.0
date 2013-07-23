From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Jul 2013 12:09:13 +0100
Subject: [PATCH v3 01/12] ARM: mm: remove redundant dsb() prior to range TLB
 invalidation
In-Reply-To: <1374577764-32480-1-git-send-email-will.deacon@arm.com>
References: <1374577764-32480-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374577764-32480-2-git-send-email-will.deacon@arm.com>
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
index 7f9b179..0c17f69 100644
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
