From: john@metanate.com (John Keeping)
Date: Tue, 10 May 2016 16:50:46 +0100
Subject: [PATCH] iommu/rockchip: fix zap cache during device attach
Message-ID: <20160510155046.24515-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk_iommu_command() takes a struct rk_iommu and iterates over the slave
MMUs, so this is doubly wrong in that we're passing in the wrong pointer
and talking to MMUs that we shouldn't be.

Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/iommu/rockchip-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5710a06c3049..0ea8d9a24de0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -815,7 +815,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	dte_addr = virt_to_phys(rk_domain->dt);
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
-		rk_iommu_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
+		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
 
-- 
2.8.2.565.gdb84f68.dirty
