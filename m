From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 22 Mar 2016 16:04:33 +0100
Subject: [PATCH] iommu/rockchip: Only log stall errors when attaching
Message-ID: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the logging of timeouts when stalling the MMU to
rk_iommu_attach_device, as it's expected that sometimes the MMU won't
get stalled when detaching a device, and it's not a real problem that
would need to be communicated to the user.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0253ab35c33b..65325b6742e6 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -346,13 +346,7 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
 
-	ret = rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
-	if (ret)
-		for (i = 0; i < iommu->num_mmu; i++)
-			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
-				rk_iommu_read(iommu->bases[i], RK_MMU_STATUS));
-
-	return ret;
+	return rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
 }
 
 static int rk_iommu_disable_stall(struct rk_iommu *iommu)
@@ -798,8 +792,12 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	ret = rk_iommu_enable_stall(iommu);
-	if (ret)
+	if (ret) {
+		for (i = 0; i < iommu->num_mmu; i++)
+			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
+				rk_iommu_read(iommu->bases[i], RK_MMU_STATUS));
 		return ret;
+	}
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-- 
2.5.0
