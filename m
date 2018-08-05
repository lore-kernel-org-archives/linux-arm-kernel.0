From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun,  5 Aug 2018 13:48:07 +0100
Subject: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20180805124807.18169-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leaving the DRM driver enabled on reboot or kexec has the annoying
effect of leaving the display generating transactions whilst the
IOMMU has been shut down.

In turn, the IOMMU driver (which shares its interrupt line with
the VOP) starts warning either on shutdown or when entering the
secondary kernel in the kexec case (nothing is expected on that
front).

A cheap way of ensuring that things are nicely shut down is to
register a shutdown callback in the platform driver.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f814d37b1db2..05368fa4f956 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -442,6 +442,11 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
+{
+	rockchip_drm_platform_remove(pdev);
+}
+
 static const struct of_device_id rockchip_drm_dt_ids[] = {
 	{ .compatible = "rockchip,display-subsystem", },
 	{ /* sentinel */ },
@@ -451,6 +456,7 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
+	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,
-- 
2.14.2
