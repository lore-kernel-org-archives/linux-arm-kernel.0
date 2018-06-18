From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 18 Jun 2018 12:27:54 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Fix pgtable allocation in selftest
Message-ID: <20180618112754.24942-1-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4b123757eeaa ("iommu/io-pgtable-arm: Make allocations
NUMA-aware") added a NUMA hint to page table allocation, but the pgtable
selftest doesn't provide an SMMU device parameter. Since dev_to_node
doesn't accept a NULL argument, add a special case for selftest.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 010a254305dd..88641b4560bc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -237,7 +237,8 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
+			     gfp | __GFP_ZERO, order);
 	if (!p)
 		return NULL;
 
-- 
2.17.0
