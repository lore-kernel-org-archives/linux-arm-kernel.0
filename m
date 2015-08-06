From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  6 Aug 2015 09:24:18 -0500
Subject: [RFC PATCH 7/8] drm: bridge: analogix_dp: try force hpd after plug in
 lookup failed
In-Reply-To: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438871058-24005-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some edp screen do not have hpd signal, so we can't just return
failed when hpd plug in detect failed.

Besides TRM indicate that if HPD_STATUS(RO) is 0, AUX CH will not
work, so we need to give a force hpd action to set HPD_STATUS manually.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix_dp_core.c | 28 +++++++++++++++++++++++-----
 drivers/gpu/drm/bridge/analogix_dp_core.h |  1 +
 drivers/gpu/drm/bridge/analogix_dp_reg.c  |  9 +++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
index 28724d4..7e67f19 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
@@ -68,15 +68,33 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
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
+	 * return failed when hpd plug in detect failed.
+	 *
+	 * Besides TRM indicate that if HPD_STATUS(RO) is 0, AUX CH
+	 * will not work, so we need to give a force hpd action to
+	 * set HPD_STATUS manually.
+	 */
+	dev_dbg(dp->dev, "failed to get hpd plug status, try to force hpd\n");
+
+	analogix_dp_force_hpd(dp);
+
+	if (analogix_dp_get_plug_in_status(dp) != 0) {
+		dev_err(dp->dev, "failed to get hpd plug in status\n");
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dp->dev, "success to get plug in status after force hpd\n");
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix_dp_core.h
index fe72695..43cec77 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.h
@@ -183,6 +183,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 				       bool enable);
 void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
+void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
 void analogix_dp_reset_aux(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix_dp_reg.c
index 4d6e08a..3fb215b 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_reg.c
@@ -366,6 +366,15 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
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
2.1.2
