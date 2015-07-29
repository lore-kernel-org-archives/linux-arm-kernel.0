From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Jul 2015 19:46:12 +0100
Subject: [PATCH v2 9/9] iommu/io-pgtable: Remove flush_pgtable callback
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <7c5584d3efa61ee6b0b87efb72f24f32852aafb7.1438195011.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the users fully converted to DMA API operations, it's dead, Jim.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 6 ------
 drivers/iommu/io-pgtable.h     | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0617687..e4bc2b2 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -884,16 +884,10 @@ static void dummy_tlb_sync(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_flush_pgtable(void *ptr, size_t size, void *cookie)
-{
-	WARN_ON(cookie != cfg_cookie);
-}
-
 static struct iommu_gather_ops dummy_tlb_ops __initdata = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
-	.flush_pgtable	= dummy_flush_pgtable,
 };
 
 static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 8f61286..68c63d9 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -19,7 +19,6 @@ enum io_pgtable_fmt {
  * @tlb_add_flush: Queue up a TLB invalidation for a virtual address range.
  * @tlb_sync:      Ensure any queued TLB invalidation has taken effect, and
  *                 any corresponding page table updates are visible.
- * @flush_pgtable: Ensure page table updates are visible to the IOMMU.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
@@ -29,7 +28,6 @@ struct iommu_gather_ops {
 	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
 			      void *cookie);
 	void (*tlb_sync)(void *cookie);
-	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
 };
 
 /**
-- 
1.9.1
