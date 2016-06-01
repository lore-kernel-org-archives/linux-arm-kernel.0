From: john@metanate.com (John Keeping)
Date: Wed,  1 Jun 2016 16:46:10 +0100
Subject: [RESEND PATCH] iommu/rockchip: fix zap cache during device attach
Message-ID: <20160601154610.22899-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk_iommu_command() takes a struct rk_iommu and iterates over the slave
MMUs, so this is doubly wrong in that we're passing in the wrong pointer
and talking to MMUs that we shouldn't be.

Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")
Cc: stable at vger.kernel.org
Signed-off-by: John Keeping <john@metanate.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
The original was sent just before the merge window [0].  The only
changes are to the commit message:

* add Cc: stable
* add Heiko's {Tested,Reviewed}-by

[0] http://article.gmane.org/gmane.linux.kernel.iommu/13556

 drivers/iommu/rockchip-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c7d6156ff536..25b4627cb57f 100644
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
