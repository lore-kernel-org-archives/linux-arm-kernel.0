From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 16 Oct 2015 16:33:42 +0100
Subject: [PATCH 2/2] arm64: Use gfpflags_allow_blocking()
In-Reply-To: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
Message-ID: <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__GFP_WAIT is going away to live its life under a new identity; convert
__iommu_alloc_attrs() to the new helper function instead.

CC: Mel Gorman <mgorman@techsingularity.net>
CC: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 66444df..40cd4af 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -566,7 +566,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (gfp & __GFP_WAIT) {
+	if (gfpflags_allow_blocking(gfp)) {
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 
-- 
1.9.1
