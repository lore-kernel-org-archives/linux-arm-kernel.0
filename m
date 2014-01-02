From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:10 +0000
Subject: [PATCH RFC 40/46] imx-drm: imx-drm-core: move allocation of imxdrm
 device to driver load function
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VyppG-0007GB-9Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now no longer necessary to keep this structure around; we can
allocate it upon DRM driver load and destroy it thereafter without
affecting the other components now.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   47 ++++---------------------------
 1 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 0172739a00fe..8e257c5fb041 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -38,7 +38,6 @@ struct imx_drm_crtc;
 
 struct imx_drm_device {
 	struct drm_device			*drm;
-	struct device				*dev;
 	struct imx_drm_crtc			*crtc[MAX_CRTC];
 	int					pipes;
 	struct drm_fbdev_cma			*fbhelper;
@@ -206,13 +205,6 @@ int imx_drm_connector_mode_valid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(imx_drm_connector_mode_valid);
 
-static struct imx_drm_device *imx_drm_device;
-
-static struct imx_drm_device *__imx_drm_device(void)
-{
-	return imx_drm_device;
-}
-
 void imx_drm_connector_destroy(struct drm_connector *connector)
 {
 	drm_sysfs_connector_remove(connector);
@@ -236,10 +228,14 @@ static struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
  */
 static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 {
-	struct imx_drm_device *imxdrm = __imx_drm_device();
+	struct imx_drm_device *imxdrm;
 	struct drm_connector *connector;
 	int ret;
 
+	imxdrm = devm_kzalloc(drm->dev, sizeof(*imxdrm), GFP_KERNEL);
+	if (!imxdrm)
+		return -ENOMEM;
+
 	imxdrm->drm = drm;
 
 	drm->dev_private = imxdrm;
@@ -602,8 +598,6 @@ static int imx_drm_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	imx_drm_device->dev = &pdev->dev;
-
 	return component_master_add(&pdev->dev, &imx_drm_ops);
 }
 
@@ -628,36 +622,7 @@ static struct platform_driver imx_drm_pdrv = {
 		.of_match_table = imx_drm_dt_ids,
 	},
 };
-
-static int __init imx_drm_init(void)
-{
-	int ret;
-
-	imx_drm_device = kzalloc(sizeof(*imx_drm_device), GFP_KERNEL);
-	if (!imx_drm_device)
-		return -ENOMEM;
-
-	ret = platform_driver_register(&imx_drm_pdrv);
-	if (ret)
-		goto err_pdrv;
-
-	return 0;
-
-err_pdrv:
-	kfree(imx_drm_device);
-
-	return ret;
-}
-
-static void __exit imx_drm_exit(void)
-{
-	platform_driver_unregister(&imx_drm_pdrv);
-
-	kfree(imx_drm_device);
-}
-
-module_init(imx_drm_init);
-module_exit(imx_drm_exit);
+module_platform_driver(imx_drm_pdrv);
 
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("i.MX drm driver core");
-- 
1.7.4.4
