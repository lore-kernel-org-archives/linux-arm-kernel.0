From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun,  5 Aug 2018 13:46:16 +0100
Subject: [PATCH] iommu/rockchip: Handle errors returned from PM framework
Message-ID: <20180805124616.18020-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pm_runtime_get_if_in_use can fail: either PM has been disabled
altogether (-EINVAL), or the device hasn't been enabled yet (0).
Sadly, we ignore the first case at the moment, and end up treating
it as if we had received a valid interrupt.

The first case could happen because the interrupt line is shared
(with the VOP for example), and although that device hasn't been
programmed yet, an interrupt may be pending (think kexec/kdump).

The second case means that we've enabled the IOMMU, but it is
not powered-on just yet. This could be another instance of the
above, but as it deserves investigation, let's output a single
warning (instead of flodding the console).

In both cases, bail with an IRQ_NONE.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..9d21495a8433 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	u32 int_status;
 	dma_addr_t iova;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
+	int i, err;
 
-	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
-		return 0;
+	err = pm_runtime_get_if_in_use(iommu->dev);
+	if ((err < 0) || WARN_ON_ONCE(!err))
+		return ret;
 
 	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
 		goto out;
-- 
2.14.2
