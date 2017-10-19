From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 19 Oct 2017 11:48:04 +0800
Subject: [PATCH v6 02/10] drm/rockchip: analogix_dp: Remove unnecessary init
 code
In-Reply-To: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
Message-ID: <20171019034812.13768-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary init code, since we would do it in the power_on()
callback.

Also move of parse code to probe().

Fixes: 9e32e16e9e98 ("drm: rockchip: dp: add rockchip platform dp driver")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5: None

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 27 ++++++-------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 4d3f6ad0abdd..8cae5ad926cd 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -269,7 +269,7 @@ static struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
 	.destroy = rockchip_dp_drm_encoder_destroy,
 };
 
-static int rockchip_dp_init(struct rockchip_dp_device *dp)
+static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 {
 	struct device *dev = dp->dev;
 	struct device_node *np = dev->of_node;
@@ -303,19 +303,6 @@ static int rockchip_dp_init(struct rockchip_dp_device *dp)
 		return PTR_ERR(dp->rst);
 	}
 
-	ret = clk_prepare_enable(dp->pclk);
-	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "failed to enable pclk %d\n", ret);
-		return ret;
-	}
-
-	ret = rockchip_dp_pre_init(dp);
-	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "failed to pre init %d\n", ret);
-		clk_disable_unprepare(dp->pclk);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -361,10 +348,6 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	if (!dp_data)
 		return -ENODEV;
 
-	ret = rockchip_dp_init(dp);
-	if (ret < 0)
-		return ret;
-
 	dp->data = dp_data;
 	dp->drm_dev = drm_dev;
 
@@ -398,7 +381,6 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 	rockchip_drm_psr_unregister(&dp->encoder);
 
 	analogix_dp_unbind(dev, master, data);
-	clk_disable_unprepare(dp->pclk);
 }
 
 static const struct component_ops rockchip_dp_component_ops = {
@@ -414,7 +396,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	int ret;
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
@@ -422,9 +404,12 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dp->dev = dev;
-
 	dp->plat_data.panel = panel;
 
+	ret = rockchip_dp_of_probe(dp);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * We just use the drvdata until driver run into component
 	 * add function, and then we would set drvdata to null, so
-- 
2.11.0
