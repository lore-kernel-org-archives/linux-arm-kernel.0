From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Dec 2017 13:10:47 +0100
Subject: [PATCH 4/4 v5] drm/pl111: Support handling bridge timings
In-Reply-To: <20171215121047.3650-1-linus.walleij@linaro.org>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
Message-ID: <20171215121047.3650-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bridge has a too strict setup time for the incoming
signals, we may not be fast enough and then we need to
compensate by outputting the signal on the inverse clock
edge so it is for sure stable when the bridge samples it.

Since bridges in difference to panels does not expose their
connectors, make the connector optional in the display
setup code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- Use the new bridge timings setup method.
---
 drivers/gpu/drm/pl111/Kconfig         |  1 +
 drivers/gpu/drm/pl111/pl111_display.c | 35 +++++++++++++++++++++++++++++++----
 drivers/gpu/drm/pl111/pl111_drv.c     | 20 +++++++++++---------
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index e5e2abd66491..82cb3e60ddc8 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -8,6 +8,7 @@ config DRM_PL111
 	select DRM_GEM_CMA_HELPER
 	select DRM_BRIDGE
 	select DRM_PANEL_BRIDGE
+	select DRM_DUMB_VGA_DAC
 	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	help
 	  Choose this option for DRM support for the PL111 CLCD controller.
diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 06c4bf756b69..7fe4040aea46 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -94,6 +94,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	const struct drm_display_mode *mode = &cstate->mode;
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct drm_connector *connector = priv->connector;
+	struct drm_bridge *bridge = priv->bridge;
 	u32 cntl;
 	u32 ppl, hsw, hfp, hbp;
 	u32 lpp, vsw, vfp, vbp;
@@ -143,11 +144,37 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		tim2 |= TIM2_IVS;
 
-	if (connector->display_info.bus_flags & DRM_BUS_FLAG_DE_LOW)
-		tim2 |= TIM2_IOE;
+	if (connector) {
+		if (connector->display_info.bus_flags & DRM_BUS_FLAG_DE_LOW)
+			tim2 |= TIM2_IOE;
 
-	if (connector->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
-		tim2 |= TIM2_IPC;
+		if (connector->display_info.bus_flags &
+		    DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+			tim2 |= TIM2_IPC;
+	}
+
+	if (bridge) {
+		const struct drm_bridge_timings *btimings = bridge->timings;
+
+		/*
+		 * Here is when things get really fun. Sometimes the bridge
+		 * timings are such that the signal out from PL11x is not
+		 * stable before the receiving bridge (such as a dumb VGA DAC
+		 * or similar) samples it. If that happens, we compensate by
+		 * the only method we have: output the data on the opposite
+		 * edge of the clock so it is for sure stable when it gets
+		 * sampled.
+		 *
+		 * The PL111 manual does not contain proper timining diagrams
+		 * or data for these details, but we know from experiments
+		 * that the setup time is more than 3000 picoseconds (3 ns).
+		 * If we have a bridge that requires the signal to be stable
+		 * earlier than 3000 ps before the clock pulse, we have to
+		 * output the data on the opposite edge to avoid flicker.
+		 */
+		if (btimings && btimings->setup_time_ps >= 3000)
+			tim2 ^= TIM2_IPC;
+	}
 
 	tim2 |= cpl << 16;
 	writel(tim2, priv->regs + CLCD_TIM2);
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 201d57d5cb54..101a9c7db6ff 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -107,11 +107,17 @@ static int pl111_modeset_init(struct drm_device *dev)
 			ret = PTR_ERR(bridge);
 			goto out_config;
 		}
-		/*
-		 * TODO: when we are using a different bridge than a panel
-		 * (such as a dumb VGA connector) we need to devise a different
-		 * method to get the connector out of the bridge.
-		 */
+	} else if (bridge) {
+		dev_info(dev->dev, "Using non-panel bridge\n");
+	} else {
+		dev_err(dev->dev, "No bridge, exiting\n");
+		return -ENODEV;
+	}
+
+	priv->bridge = bridge;
+	if (panel) {
+		priv->panel = panel;
+		priv->connector = panel->connector;
 	}
 
 	ret = pl111_display_init(dev);
@@ -125,10 +131,6 @@ static int pl111_modeset_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	priv->bridge = bridge;
-	priv->panel = panel;
-	priv->connector = panel->connector;
-
 	ret = drm_vblank_init(dev, 1);
 	if (ret != 0) {
 		dev_err(dev->dev, "Failed to init vblank\n");
-- 
2.14.3
