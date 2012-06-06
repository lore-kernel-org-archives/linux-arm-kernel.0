From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Jun 2012 12:35:22 +0200
Subject: [PATCHv2] ARM: mm: fix type of the arm_dma_limit global variable
In-Reply-To: <20120606092946.GL8262@n2100.arm.linux.org.uk>
References: <20120606092946.GL8262@n2100.arm.linux.org.uk>
Message-ID: <1338978922-30452-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_dma_limit stores physical address of maximal address accessible by DMA,
so the phys_addr_t type makes much more sense for it instead of u32. This
patch fixes the following build warning:

arch/arm/mm/init.c:380: warning: comparison of distinct pointer types lacks a cast

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/init.c |    2 +-
 arch/arm/mm/mm.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c21d06c..f54d592 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL(arm_dma_zone_size);
  * allocations.  This must be the smallest DMA mask in the system,
  * so a successful GFP_DMA allocation will always satisfy this.
  */
-u32 arm_dma_limit;
+phys_addr_t arm_dma_limit;
 
 static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 	unsigned long dma_size)
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 93dc0c1..c471436 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -62,7 +62,7 @@ extern void __flush_dcache_page(struct address_space *mapping, struct page *page
 #endif
 
 #ifdef CONFIG_ZONE_DMA
-extern u32 arm_dma_limit;
+extern phys_addr_t arm_dma_limit;
 #else
 #define arm_dma_limit ((u32)~0)
 #endif
-- 
1.7.1.569.g6f426
