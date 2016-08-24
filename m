From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 22:07:17 +0900
Subject: [PATCH v3 3/5] gpu: drm: exynos_hdmi: Move DDC logic into single
 function
In-Reply-To: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
References: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
Message-ID: <1472044039-16536-4-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paring DT properties and getting the I2C adapter in one function.

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
 drivers/gpu/drm/exynos/exynos_hdmi.c | 46 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 2275efe..8d99b5d 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1760,16 +1760,34 @@ static const struct component_ops hdmi_component_ops = {
 	.unbind = hdmi_unbind,
 };
 
-static struct device_node *hdmi_legacy_ddc_dt_binding(struct device *dev)
+static int hdmi_get_ddc_adapter(struct hdmi_context *hdata)
 {
 	const char *compatible_str = "samsung,exynos4210-hdmiddc";
 	struct device_node *np;
+	struct i2c_adapter *adpt;
 
 	np = of_find_compatible_node(NULL, NULL, compatible_str);
 	if (np)
-		return of_get_next_parent(np);
+		np = of_get_next_parent(np);
+	else
+		np = of_parse_phandle(hdata->dev->of_node, "ddc", 0);
+
+	if (!np) {
+		DRM_ERROR("Failed to find ddc node in device tree\n");
+		return -ENODEV;
+	}
 
-	return NULL;
+	adpt = of_find_i2c_adapter_by_node(np);
+	if (!adpt) {
+		DRM_ERROR("Failed to get ddc i2c adapter by node\n");
+		of_node_put(np);
+		return -EPROBE_DEFER;
+	}
+
+	hdata->ddc_adpt = adpt;
+	of_node_put(np);
+
+	return 0;
 }
 
 static struct device_node *hdmi_legacy_phy_dt_binding(struct device *dev)
@@ -1781,7 +1799,7 @@ static struct device_node *hdmi_legacy_phy_dt_binding(struct device *dev)
 
 static int hdmi_probe(struct platform_device *pdev)
 {
-	struct device_node *ddc_node, *phy_node;
+	struct device_node *phy_node;
 	struct device *dev = &pdev->dev;
 	struct hdmi_context *hdata;
 	struct resource *res;
@@ -1811,23 +1829,9 @@ static int hdmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ddc_node = hdmi_legacy_ddc_dt_binding(dev);
-	if (ddc_node)
-		goto out_get_ddc_adpt;
-
-	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
-	if (!ddc_node) {
-		DRM_ERROR("Failed to find ddc node in device tree\n");
-		return -ENODEV;
-	}
-	of_node_put(dev->of_node);
-
-out_get_ddc_adpt:
-	hdata->ddc_adpt = of_find_i2c_adapter_by_node(ddc_node);
-	if (!hdata->ddc_adpt) {
-		DRM_ERROR("Failed to get ddc i2c adapter by node\n");
-		return -EPROBE_DEFER;
-	}
+	ret = hdmi_get_ddc_adapter(hdata);
+	if (ret)
+		return ret;
 
 	phy_node = hdmi_legacy_phy_dt_binding(dev);
 	if (phy_node)
-- 
1.9.1
