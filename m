From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu, 21 Sep 2017 14:29:20 +0530
Subject: [PATCH 2/4] numa,
 iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
 translation tables
In-Reply-To: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170921085922.11659-3-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function __arm_lpae_alloc_pages is used to allcoated memory for smmu
translation tables. updating function to allocate memory/pages
from the proximity domain of SMMU device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/iommu/io-pgtable-arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a3..f6d01f6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -215,8 +215,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 {
 	struct device *dev = cfg->iommu_dev;
 	dma_addr_t dma;
-	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
+	void *pages;
 
+	pages = alloc_pages_exact_nid(dev_to_node(dev), size,
+			gfp | __GFP_ZERO);
 	if (!pages)
 		return NULL;
 
-- 
2.9.4
