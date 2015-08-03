From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Aug 2015 14:25:54 +0100
Subject: [PATCH 12/13] iommu/io-pgtable: Remove flush_pgtable callback
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Message-ID: <1438608355-7335-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

With the users fully converted to DMA API operations, it's dead, Jim.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 6 ------
 drivers/iommu/io-pgtable.h     | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 06176872fb78..e4bc2b23ab96 100644
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
index e8fadb012ed2..48538a35d078 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -20,7 +20,6 @@ enum io_pgtable_fmt {
  * @tlb_sync:      Ensure any queued TLB invalidation has taken effect, and
  *                 any corresponding page table updates are visible to the
  *                 IOMMU.
- * @flush_pgtable: Ensure page table updates are visible to the IOMMU.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
@@ -30,7 +29,6 @@ struct iommu_gather_ops {
 	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
 			      void *cookie);
 	void (*tlb_sync)(void *cookie);
-	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
 };
 
 /**
-- 
2.1.4
