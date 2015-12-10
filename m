From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 10 Dec 2015 16:55:25 +0800
Subject: [PATCH v10 19/19] drm: bridge: analogix/dp: Fix the possible dead
 lock in bridge disable time
In-Reply-To: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1449737725-13642-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It may caused a dead lock if we flush the hpd work in bridge disable time.

The normal flow would like:
  IN --> DRM IOCTL
        1. Acquire crtc_ww_class_mutex (DRM IOCTL)
  IN --> analogix_dp_bridge
        2. Acquire hpd work lock (Flush hpd work)
        3. HPD work already in idle, no need to run the work function.
  OUT <-- analogix_dp_bridge
  OUT <-- DRM IOCTL

The dead lock flow would like:
  IN --> DRM IOCTL
        1. Acquire crtc_ww_class_mutex (DRM IOCTL)
  IN --> analogix_dp_bridge
        2. Acquire hpd work lock (Flush hpd work)
  IN --> analogix_dp_hotplug
  IN --> drm_helper_hpd_irq_event
        3. Acquire mode_config lock (This lock already have been acquired in previous step 1)
** Dead Lock Now **

It's wrong to flush the hpd work in bridge->disable time, I guess the
original code just want to ensure the delay work must be finish before
encoder disabled.

The flush work in bridge disable time is try to ensure the HPD event
won't be missed before display card disabled, actually we can take a
fast respond way(interrupt thread) to update DRM HPD event to fix the
delay update and possible dead lock.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
This patch was introduced in v10.1, suggested by Heiko

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 62 ++++++++++------------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  3 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 26 +++++++++
 3 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 79ba88e..5977e06 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -848,47 +848,40 @@ static void analogix_dp_enable_scramble(struct analogix_dp_device *dp,
 	}
 }
 
-static irqreturn_t analogix_dp_irq_handler(int irq, void *arg)
+static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
 {
 	struct analogix_dp_device *dp = arg;
-
+	irqreturn_t ret = IRQ_NONE;
 	enum dp_irq_type irq_type;
 
 	irq_type = analogix_dp_get_irq_type(dp);
-	switch (irq_type) {
-	case DP_IRQ_TYPE_HP_CABLE_IN:
-		dev_dbg(dp->dev, "Received irq - cable in\n");
-		schedule_work(&dp->hotplug_work);
-		analogix_dp_clear_hotplug_interrupts(dp);
-		break;
-	case DP_IRQ_TYPE_HP_CABLE_OUT:
-		dev_dbg(dp->dev, "Received irq - cable out\n");
-		analogix_dp_clear_hotplug_interrupts(dp);
-		break;
-	case DP_IRQ_TYPE_HP_CHANGE:
-		/*
-		 * We get these change notifications once in a while, but there
-		 * is nothing we can do with them. Just ignore it for now and
-		 * only handle cable changes.
-		 */
-		dev_dbg(dp->dev, "Received irq - hotplug change; ignoring.\n");
-		analogix_dp_clear_hotplug_interrupts(dp);
-		break;
-	default:
-		dev_err(dp->dev, "Received irq - unknown type!\n");
-		break;
+	if (irq_type != DP_IRQ_TYPE_UNKNOWN) {
+		analogix_dp_mute_hpd_interrupt(dp);
+		ret = IRQ_WAKE_THREAD;
 	}
-	return IRQ_HANDLED;
+
+	return ret;
 }
 
-static void analogix_dp_hotplug(struct work_struct *work)
+static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 {
-	struct analogix_dp_device *dp;
+	struct analogix_dp_device *dp = arg;
+	enum dp_irq_type irq_type;
+
+	irq_type = analogix_dp_get_irq_type(dp);
+	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
+	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
+		dev_dbg(dp->dev, "Detected cable status changed!\n");
+		if (dp->drm_dev)
+			drm_helper_hpd_irq_event(dp->drm_dev);
+	}
 
-	dp = container_of(work, struct analogix_dp_device, hotplug_work);
+	if (irq_type != DP_IRQ_TYPE_UNKNOWN) {
+		analogix_dp_clear_hotplug_interrupts(dp);
+		analogix_dp_unmute_hpd_interrupt(dp);
+	}
 
-	if (dp->drm_dev)
-		drm_helper_hpd_irq_event(dp->drm_dev);
+	return IRQ_HANDLED;
 }
 
 static void analogix_dp_commit(struct analogix_dp_device *dp)
@@ -1041,7 +1034,6 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	}
 
 	disable_irq(dp->irq);
-	flush_work(&dp->hotplug_work);
 	phy_power_off(dp->phy);
 
 	if (dp->plat_data->power_off)
@@ -1300,8 +1292,6 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 		return -ENODEV;
 	}
 
-	INIT_WORK(&dp->hotplug_work, analogix_dp_hotplug);
-
 	pm_runtime_enable(dev);
 
 	phy_power_on(dp->phy);
@@ -1315,8 +1305,10 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	analogix_dp_init_dp(dp);
 
-	ret = devm_request_irq(&pdev->dev, dp->irq, analogix_dp_irq_handler,
-			       irq_flags, "analogix-dp", dp);
+	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
+					analogix_dp_hardirq,
+					analogix_dp_irq_thread,
+					irq_flags, "analogix-dp", dp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		goto err_disable_pm_runtime;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 628c486..ecc467d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -178,7 +178,6 @@ struct analogix_dp_device {
 
 	struct video_info	video_info;
 	struct link_train	link_train;
-	struct work_struct	hotplug_work;
 	struct phy		*phy;
 	int			dpms_mode;
 	int			hpd_gpio;
@@ -197,6 +196,8 @@ void analogix_dp_init_interrupt(struct analogix_dp_device *dp);
 void analogix_dp_reset(struct analogix_dp_device *dp);
 void analogix_dp_swreset(struct analogix_dp_device *dp);
 void analogix_dp_config_interrupt(struct analogix_dp_device *dp);
+void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp);
+void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp);
 enum pll_status analogix_dp_get_pll_lock_status(struct analogix_dp_device *dp);
 void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index dc376bd..00ac13c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -185,6 +185,32 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
 }
 
+void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp)
+{
+	u32 reg;
+
+	/* 0: mask, 1: unmask */
+	reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	reg &= ~COMMON_INT_MASK_4;
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+
+	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	reg &= ~INT_STA_MASK;
+	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+}
+
+void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp)
+{
+	u32 reg;
+
+	/* 0: mask, 1: unmask */
+	reg = COMMON_INT_MASK_4;
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+
+	reg = INT_STA_MASK;
+	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+}
+
 enum pll_status analogix_dp_get_pll_lock_status(struct analogix_dp_device *dp)
 {
 	u32 reg;
-- 
1.9.1
