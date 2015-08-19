From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 19 Aug 2015 09:51:59 -0500
Subject: [PATCH v3 11/14] drm: bridge: analogix_dp: try force hpd after plug
 in lookup failed
In-Reply-To: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1439995919-18668-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some edp screen do not have hpd signal, so we can't just return
failed when hpd plug in detect failed.

This is an hardware property, so we need add a devicetree property
"analogix,need-force-hpd" to indicate this sutiation.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Add "analogix,need-force-hpd" to indicate whether driver need foce
  hpd when hpd detect failed.

Changes in v2: None

 .../devicetree/bindings/drm/bridge/analogix_dp.txt |  3 ++
 .../bindings/video/analogix_dp-rockchip.txt        |  1 +
 .../devicetree/bindings/video/exynos_dp.txt        |  1 +
 drivers/gpu/drm/bridge/analogix_dp_core.c          | 36 +++++++++++++++++++---
 drivers/gpu/drm/bridge/analogix_dp_core.h          |  2 ++
 drivers/gpu/drm/bridge/analogix_dp_reg.c           |  9 ++++++
 6 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
index 6127018..b043200 100644
--- a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
+++ b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
@@ -40,6 +40,9 @@ Required properties for dp-controller:
 		* Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
 
 Optional properties for dp-controller:
+	-analogix,need-force-hpd:
+		Indicate driver need force hpd when hpd detect failed, this
+		is used for some eDP screen which don't have hpd signal.
 	-analogix,hpd-gpio:
 		Hotplug detect GPIO.
 			Indicates which GPIO should be used for hotplug
diff --git a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
index 99fd421..752005e 100644
--- a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
+++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
@@ -27,6 +27,7 @@ For the below properties, please refer to Analogix DP binding document:
 - analogix,color-depth (required)
 - analogix,link-rate (required)
 - analogix,lane-count (required)
+- analogix,need-force-hpd (optional)
 - analogix,hpd-gpio (optional)
 - video interfaces (optional)
 -------------------------------------------------------------------------------
diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
index 177506f..ba20416 100644
--- a/Documentation/devicetree/bindings/video/exynos_dp.txt
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -53,6 +53,7 @@ For the below properties, please refer to Analogix DP binding document:
 	-analogix,color-depth (required)
 	-analogix,link-rate (required)
 	-analogix,lane-count (required)
+	-analogix,need-force-hpd (optional)
 	-analogix,hpd-gpio (optional)
 	-video interfaces (optional)
 -------------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
index 1778e0a..99870f7 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
@@ -63,15 +63,38 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 {
 	int timeout_loop = 0;
 
-	while (analogix_dp_get_plug_in_status(dp) != 0) {
+	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
+		if (analogix_dp_get_plug_in_status(dp) == 0)
+			return 0;
+
 		timeout_loop++;
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
-			dev_err(dp->dev, "failed to get hpd plug status\n");
-			return -ETIMEDOUT;
-		}
 		usleep_range(10, 11);
 	}
 
+	/*
+	 * Some edp screen do not have hpd signal, so we can't just
+	 * return failed when hpd plug in detect failed, DT property
+	 * "need-force-hpd" would indicate whether driver need this.
+	 */
+	if (!dp->need_force_hpd)
+		return -ETIMEDOUT;
+
+	/*
+	 * The eDP TRM indicate that if HPD_STATUS(RO) is 0, AUX CH
+	 * will not work, so we need to give a force hpd action to
+	 * set HPD_STATUS manually.
+	 */
+	dev_dbg(dp->dev, "failed to get hpd plug status, try to force hpd\n");
+
+	analogix_dp_force_hpd(dp);
+
+	if (analogix_dp_get_plug_in_status(dp) != 0) {
+		dev_err(dp->dev, "failed to get hpd plug in status\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dp->dev, "success to get plug in status after force hpd\n");
+
 	return 0;
 }
 
@@ -1272,6 +1295,9 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	if (IS_ERR(dp->reg_base))
 		return PTR_ERR(dp->reg_base);
 
+	dp->need_force_hpd =
+		of_property_read_bool(dev->of_node, "analogix,need-force-hpd");
+
 	dp->hpd_gpio = of_get_named_gpio(dev->of_node, "analogix,hpd-gpio", 0);
 
 	if (gpio_is_valid(dp->hpd_gpio)) {
diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix_dp_core.h
index 941b34f..2405155 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.h
@@ -160,6 +160,7 @@ struct analogix_dp_device {
 	struct phy		*phy;
 	int			dpms_mode;
 	int			hpd_gpio;
+	bool                    need_force_hpd;
 
 	struct analogix_dp_plat_data *plat_data;
 };
@@ -180,6 +181,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 				       bool enable);
 void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
+void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
 void analogix_dp_reset_aux(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix_dp_reg.c
index a0fc1fb..bf7cee1 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_reg.c
@@ -365,6 +365,15 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 }
 
+void analogix_dp_force_hpd(struct analogix_dp_device *dp)
+{
+	u32 reg;
+
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
+	reg = (F_HPD | HPD_CTRL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
+}
+
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
 {
 	u32 reg;
-- 
1.9.1
