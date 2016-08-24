From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 22:07:18 +0900
Subject: [PATCH v3 4/5] gpu: drm: exynos_hdmi: Move PHY logic into single
 function
In-Reply-To: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
References: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <1472044039-16536-5-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paring DT properties and getting PHY IO (memory mapped or I2C) in one function.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 63 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 8d99b5d..249cb23 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1790,16 +1790,44 @@ static int hdmi_get_ddc_adapter(struct hdmi_context *hdata)
 	return 0;
 }
 
-static struct device_node *hdmi_legacy_phy_dt_binding(struct device *dev)
+static int hdmi_get_phy_io(struct hdmi_context *hdata)
 {
 	const char *compatible_str = "samsung,exynos4212-hdmiphy";
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, compatible_str);
+	if (!np) {
+		np = of_parse_phandle(hdata->dev->of_node, "phy", 0);
+		if (!np) {
+			DRM_ERROR("Failed to find hdmiphy node in device tree\n");
+			return -ENODEV;
+		}
+	}
+
+	if (hdata->drv_data->is_apb_phy) {
+		hdata->regs_hdmiphy = of_iomap(np, 0);
+		if (!hdata->regs_hdmiphy) {
+			DRM_ERROR("failed to ioremap hdmi phy\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		hdata->hdmiphy_port = of_find_i2c_device_by_node(np);
+		if (!hdata->hdmiphy_port) {
+			DRM_ERROR("Failed to get hdmi phy i2c client\n");
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
+	}
 
-	return of_find_compatible_node(NULL, NULL, compatible_str);
+out:
+	of_node_put(np);
+	return ret;
 }
 
 static int hdmi_probe(struct platform_device *pdev)
 {
-	struct device_node *phy_node;
 	struct device *dev = &pdev->dev;
 	struct hdmi_context *hdata;
 	struct resource *res;
@@ -1833,34 +1861,9 @@ static int hdmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	phy_node = hdmi_legacy_phy_dt_binding(dev);
-	if (phy_node)
-		goto out_get_phy_port;
-
-	phy_node = of_parse_phandle(dev->of_node, "phy", 0);
-	if (!phy_node) {
-		DRM_ERROR("Failed to find hdmiphy node in device tree\n");
-		ret = -ENODEV;
+	ret = hdmi_get_phy_io(hdata);
+	if (ret)
 		goto err_ddc;
-	}
-	of_node_put(dev->of_node);
-
-out_get_phy_port:
-	if (hdata->drv_data->is_apb_phy) {
-		hdata->regs_hdmiphy = of_iomap(phy_node, 0);
-		if (!hdata->regs_hdmiphy) {
-			DRM_ERROR("failed to ioremap hdmi phy\n");
-			ret = -ENOMEM;
-			goto err_ddc;
-		}
-	} else {
-		hdata->hdmiphy_port = of_find_i2c_device_by_node(phy_node);
-		if (!hdata->hdmiphy_port) {
-			DRM_ERROR("Failed to get hdmi phy i2c client\n");
-			ret = -EPROBE_DEFER;
-			goto err_ddc;
-		}
-	}
 
 	INIT_DELAYED_WORK(&hdata->hotplug_work, hdmi_hotplug_work_func);
 
-- 
1.9.1
