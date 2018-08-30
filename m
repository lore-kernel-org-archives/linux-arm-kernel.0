From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 30 Aug 2018 19:28:32 -0300
Subject: [PATCH] iommu: rockchip: Drop verbose prints in the interrupt handler
Message-ID: <20180830222832.16766-1-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing verbosely via WARN macros and friends in interrupt handlers
is strongly discouraged. Drop them and use proper ratelimited
prints.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..21bb9a30bc64 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -523,11 +523,13 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	int i;
 
-	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
-		return 0;
+	if (!pm_runtime_get_if_in_use(iommu->dev))
+		return ret;
 
-	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+	if (clk_bulk_enable(iommu->num_clocks, iommu->clocks)) {
+		dev_err_ratelimited(iommu->dev, "couldn't enable clocks\n");
 		goto out;
+	}
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
@@ -544,7 +546,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 			flags = (status & RK_MMU_STATUS_PAGE_FAULT_IS_WRITE) ?
 					IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
 
-			dev_err(iommu->dev, "Page fault at %pad of type %s\n",
+			dev_err_ratelimited(iommu->dev, "Page fault at %pad of type %s\n",
 				&iova,
 				(flags == IOMMU_FAULT_WRITE) ? "write" : "read");
 
-- 
2.18.0
