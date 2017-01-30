From: shailendra.v@samsung.com (Shailendra Verma)
Date: Mon, 30 Jan 2017 10:32:03 +0530
Subject: [PATCH] Gpu: drm: exynos - Fix possible NULL derefrence.
References: <CGME20170130050228epcas4p1b880b1ae599b7f7d6c60a4b0554a2162@epcas4p1.samsung.com>
Message-ID: <1485752523-30029-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_get_match_data could return NULL, and so can cause
a NULL pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  |    4 ++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c |    4 ++++
 drivers/gpu/drm/exynos/exynos_hdmi.c     |    4 ++++
 drivers/gpu/drm/exynos/exynos_mixer.c    |    4 ++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e07cb1f..fba0ffc 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1765,6 +1765,10 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 	dsi->dev = dev;
 	dsi->driver_data = of_device_get_match_data(dev);
+	if (!dsi->driver_data) {
+		dev_err(dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	ret = exynos_dsi_parse_dt(dsi);
 	if (ret)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index e2e4051..f568234 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -1076,6 +1076,10 @@ static int fimd_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 	ctx->suspended = true;
 	ctx->driver_data = of_device_get_match_data(dev);
+	if (!ctx->driver_data) {
+		dev_err(dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	if (of_property_read_bool(dev->of_node, "samsung,invert-vden"))
 		ctx->vidcon1 |= VIDCON1_INV_VDEN;
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 38eaa63..27aeb74 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1837,6 +1837,10 @@ static int hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdata->drv_data = of_device_get_match_data(dev);
+	if (!hdata->drv_data) {
+		dev_err(dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	platform_set_drvdata(pdev, hdata);
 
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index edb20a3..b3c6bbb 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1205,6 +1205,10 @@ static int mixer_probe(struct platform_device *pdev)
 	}
 
 	drv = of_device_get_match_data(dev);
+	if (!drv) {
+		dev_err(dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	ctx->pdev = pdev;
 	ctx->dev = dev;
-- 
1.7.9.5
