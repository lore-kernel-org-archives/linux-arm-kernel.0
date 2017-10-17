From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 17 Oct 2017 16:09:23 +0800
Subject: [RFC PATCH v3 3/5] drm/bridge/analogix: Do not use device's drvdata
In-Reply-To: <20171017080925.23763-1-jeffy.chen@rock-chips.com>
References: <20171017080925.23763-1-jeffy.chen@rock-chips.com>
Message-ID: <20171017080925.23763-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

The driver that instantiates the bridge should own the drvdata, as all
driver model callbacks (probe, remove, shutdown, PM ops, etc.) are also
owned by its driver struct. Moreover, storing two different pointer
types in driver data depending on driver initialization status is barely
a good practice and in fact has led to many bugs in this driver.

Let's clean up this mess and change Analogix entry points to simply
accept some opaque struct pointer, adjusting their users at the same
time to avoid breaking the compilation.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 +++++++++-------------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 ++++++-----
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 47 +++++++++++---------
 include/drm/bridge/analogix_dp.h                   | 19 ++++----
 4 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5dd3f1cd074a..74d274b6d31d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -98,17 +98,15 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 	return 0;
 }
 
-int analogix_dp_psr_supported(struct device *dev)
+int analogix_dp_psr_supported(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 
 	return dp->psr_support;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
 
-int analogix_dp_enable_psr(struct device *dev)
+int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 	struct edp_vsc_psr psr_vsc;
 
 	if (!dp->psr_support)
@@ -129,9 +127,8 @@ int analogix_dp_enable_psr(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
 
-int analogix_dp_disable_psr(struct device *dev)
+int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 	struct edp_vsc_psr psr_vsc;
 	int ret;
 
@@ -1281,8 +1278,9 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 	return analogix_dp_transfer(dp, msg);
 }
 
-int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
-		     struct analogix_dp_plat_data *plat_data)
+struct analogix_dp_device *
+analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
+		 struct analogix_dp_plat_data *plat_data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct analogix_dp_device *dp;
@@ -1292,14 +1290,12 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	if (!plat_data) {
 		dev_err(dev, "Invalided input plat_data\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	dp = devm_kzalloc(dev, sizeof(struct analogix_dp_device), GFP_KERNEL);
 	if (!dp)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, dp);
+		return ERR_PTR(-ENOMEM);
 
 	dp->dev = &pdev->dev;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
@@ -1316,7 +1312,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	ret = analogix_dp_dt_parse_pdata(dp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	dp->phy = devm_phy_get(dp->dev, "dp");
 	if (IS_ERR(dp->phy)) {
@@ -1330,14 +1326,14 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 			if (ret == -ENOSYS || ret == -ENODEV)
 				dp->phy = NULL;
 			else
-				return ret;
+				return ERR_PTR(ret);
 		}
 	}
 
 	dp->clock = devm_clk_get(&pdev->dev, "dp");
 	if (IS_ERR(dp->clock)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		return PTR_ERR(dp->clock);
+		return ERR_CAST(dp->clock);
 	}
 
 	clk_prepare_enable(dp->clock);
@@ -1346,7 +1342,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dp->reg_base))
-		return PTR_ERR(dp->reg_base);
+		return ERR_CAST(dp->reg_base);
 
 	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
 
@@ -1367,7 +1363,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 					    "hpd_gpio");
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get hpd gpio\n");
-			return ret;
+			return ERR_PTR(ret);
 		}
 		dp->irq = gpio_to_irq(dp->hpd_gpio);
 		irq_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
@@ -1379,7 +1375,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	if (dp->irq == -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	pm_runtime_enable(dev);
@@ -1420,7 +1416,7 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	phy_power_off(dp->phy);
 	pm_runtime_put(dev);
 
-	return 0;
+	return dp;
 
 err_disable_pm_runtime:
 
@@ -1428,15 +1424,12 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_bind);
 
-void analogix_dp_unbind(struct device *dev, struct device *master,
-			void *data)
+void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
-
 	analogix_dp_bridge_disable(dp->bridge);
 	dp->connector.funcs->destroy(&dp->connector);
 	dp->encoder->funcs->destroy(dp->encoder);
@@ -1449,16 +1442,14 @@ void analogix_dp_unbind(struct device *dev, struct device *master,
 	}
 
 	drm_dp_aux_unregister(&dp->aux);
-	pm_runtime_disable(dev);
+	pm_runtime_disable(dp->dev);
 	clk_disable_unprepare(dp->clock);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
 
 #ifdef CONFIG_PM
-int analogix_dp_suspend(struct device *dev)
+int analogix_dp_suspend(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
-
 	clk_disable_unprepare(dp->clock);
 
 	if (dp->plat_data->panel) {
@@ -1470,9 +1461,8 @@ int analogix_dp_suspend(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(analogix_dp_suspend);
 
-int analogix_dp_resume(struct device *dev)
+int analogix_dp_resume(struct analogix_dp_device *dp)
 {
-	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(dp->clock);
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 39629e7a80b9..f7e5b2c405ed 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -41,6 +41,7 @@ struct exynos_dp_device {
 	struct device              *dev;
 
 	struct videomode           vm;
+	struct analogix_dp_device *adp;
 	struct analogix_dp_plat_data plat_data;
 };
 
@@ -157,13 +158,6 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	int ret;
 
-	/*
-	 * Just like the probe function said, we don't need the
-	 * device drvrate anymore, we should leave the charge to
-	 * analogix dp driver, set the device drvdata to NULL.
-	 */
-	dev_set_drvdata(dev, NULL);
-
 	dp->dev = dev;
 	dp->drm_dev = drm_dev;
 
@@ -190,13 +184,19 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 
 	dp->plat_data.encoder = encoder;
 
-	return analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
+	dp->adp = analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
+	if (IS_ERR(dp->adp))
+		return PTR_ERR(dp->adp);
+
+	return 0;
 }
 
 static void exynos_dp_unbind(struct device *dev, struct device *master,
 			     void *data)
 {
-	return analogix_dp_unbind(dev, master, data);
+	struct exynos_dp_device *dp = dev_get_drvdata(dev);
+
+	return analogix_dp_unbind(dp->adp);
 }
 
 static const struct component_ops exynos_dp_ops = {
@@ -257,12 +257,16 @@ static int exynos_dp_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int exynos_dp_suspend(struct device *dev)
 {
-	return analogix_dp_suspend(dev);
+	struct exynos_dp_device *dp = dev_get_drvdata(dev);
+
+	return analogix_dp_suspend(dp->adp);
 }
 
 static int exynos_dp_resume(struct device *dev)
 {
-	return analogix_dp_resume(dev);
+	struct exynos_dp_device *dp = dev_get_drvdata(dev);
+
+	return analogix_dp_resume(dp->adp);
 }
 #endif
 
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index cb8941e8bcdd..e8be6cbc5f3f 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -77,6 +77,7 @@ struct rockchip_dp_device {
 
 	const struct rockchip_dp_chip_data *data;
 
+	struct analogix_dp_device *adp;
 	struct analogix_dp_plat_data plat_data;
 };
 
@@ -85,7 +86,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	unsigned long flags;
 
-	if (!analogix_dp_psr_supported(dp->dev))
+	if (!analogix_dp_psr_supported(dp->adp))
 		return;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
@@ -116,9 +117,9 @@ static void analogix_dp_psr_work(struct work_struct *work)
 
 	spin_lock_irqsave(&dp->psr_lock, flags);
 	if (dp->psr_state == EDP_VSC_PSR_STATE_ACTIVE)
-		analogix_dp_enable_psr(dp->dev);
+		analogix_dp_enable_psr(dp->adp);
 	else
-		analogix_dp_disable_psr(dp->dev);
+		analogix_dp_disable_psr(dp->adp);
 	spin_unlock_irqrestore(&dp->psr_lock, flags);
 }
 
@@ -350,13 +351,6 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	struct drm_device *drm_dev = data;
 	int ret;
 
-	/*
-	 * Just like the probe function said, we don't need the
-	 * device drvrate anymore, we should leave the charge to
-	 * analogix dp driver, set the device drvdata to NULL.
-	 */
-	dev_set_drvdata(dev, NULL);
-
 	dp_data = of_device_get_match_data(dev);
 	if (!dp_data)
 		return -ENODEV;
@@ -387,9 +381,11 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 
 	rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
 
-	ret = analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
-	if (ret < 0)
+	dp->adp = analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
+	if (IS_ERR(dp->adp)) {
+		ret = PTR_ERR(dp->adp);
 		goto err_unreg_psr;
+	}
 	return 0;
 
 err_unreg_psr:
@@ -407,7 +403,7 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 
 	rockchip_drm_psr_unregister(&dp->encoder);
 
-	analogix_dp_unbind(dev, master, data);
+	analogix_dp_unbind(dp->adp);
 	clk_disable_unprepare(dp->pclk);
 }
 
@@ -435,11 +431,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 
 	dp->plat_data.panel = panel;
 
-	/*
-	 * We just use the drvdata until driver run into component
-	 * add function, and then we would set drvdata to null, so
-	 * that analogix dp driver could take charge of the drvdata.
-	 */
 	platform_set_drvdata(pdev, dp);
 
 	return component_add(dev, &rockchip_dp_component_ops);
@@ -452,10 +443,26 @@ static int rockchip_dp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_dp_suspend(struct device *dev)
+{
+	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
+
+	return analogix_dp_suspend(dp->adp);
+}
+
+static int rockchip_dp_resume(struct device *dev)
+{
+	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
+
+	return analogix_dp_resume(dp->adp);
+}
+#endif
+
 static const struct dev_pm_ops rockchip_dp_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
-	.suspend = analogix_dp_suspend,
-	.resume_early = analogix_dp_resume,
+	.suspend = rockchip_dp_suspend,
+	.resume_early = rockchip_dp_resume,
 #endif
 };
 
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index c99d6eaef1ac..5518fc75dd6e 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -13,6 +13,8 @@
 
 #include <drm/drm_crtc.h>
 
+struct analogix_dp_device;
+
 enum analogix_dp_devtype {
 	EXYNOS_DP,
 	RK3288_DP,
@@ -38,16 +40,17 @@ struct analogix_dp_plat_data {
 			 struct drm_connector *);
 };
 
-int analogix_dp_psr_supported(struct device *dev);
-int analogix_dp_enable_psr(struct device *dev);
-int analogix_dp_disable_psr(struct device *dev);
+int analogix_dp_psr_supported(struct analogix_dp_device *dp);
+int analogix_dp_enable_psr(struct analogix_dp_device *dp);
+int analogix_dp_disable_psr(struct analogix_dp_device *dp);
 
-int analogix_dp_resume(struct device *dev);
-int analogix_dp_suspend(struct device *dev);
+int analogix_dp_resume(struct analogix_dp_device *dp);
+int analogix_dp_suspend(struct analogix_dp_device *dp);
 
-int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
-		     struct analogix_dp_plat_data *plat_data);
-void analogix_dp_unbind(struct device *dev, struct device *master, void *data);
+struct analogix_dp_device *
+analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
+		 struct analogix_dp_plat_data *plat_data);
+void analogix_dp_unbind(struct analogix_dp_device *dp);
 
 int analogix_dp_start_crc(struct drm_connector *connector);
 int analogix_dp_stop_crc(struct drm_connector *connector);
-- 
2.11.0
