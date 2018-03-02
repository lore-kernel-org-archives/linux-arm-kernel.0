From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2018 10:09:46 +0100
Subject: [PATCH 2/4] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <20180302090948.6399-1-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
Message-ID: <20180302090948.6399-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were previously selecting 1024x768 and 32BPP as the default
set-up for the PL111 consumers.

This does not work on elder systems: the device tree bindings
support a property "max-memory-bandwidth" in bytes/second that
states that if you exceed this the memory bus will saturate.
The result is flickering and unstable images.

Parse the "max-memory-bandwidth" and respect it when
intializing the driver. On the RealView PB11MP, Versatile and
Integrator/CP we get a nice console as default with this code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Account for the case where there is no bandwidth limitation
  so priv->memory_bw is zero. Then just accept any modes.
ChangeLog v1->v2:
- Exploit the new .mode_valid() callback we added to the
  simple KMS helper.
- Use the hardcoded bits per pixel per variant instead of
  trying to be heuristic about this setting for now.
---
 drivers/gpu/drm/pl111/pl111_display.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm.h     |  1 +
 drivers/gpu/drm/pl111/pl111_drv.c     |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index d75923896609..577e61950e16 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -50,6 +50,41 @@ irqreturn_t pl111_irq(int irq, void *data)
 	return status;
 }
 
+static enum drm_mode_status
+pl111_mode_valid(struct drm_crtc *crtc,
+		 const struct drm_display_mode *mode)
+{
+	struct drm_device *drm = crtc->dev;
+	struct pl111_drm_dev_private *priv = drm->dev_private;
+	u32 cpp = priv->variant->fb_bpp / 8;
+	u64 bw;
+
+	/*
+	 * We use the pixelclock to also account for interlaced modes, the
+	 * resulting bandwidth is in bytes per second.
+	 */
+	bw = mode->clock * 1000; /* In Hz */
+	bw = bw * mode->hdisplay * mode->vdisplay * cpp;
+	bw = div_u64(bw, mode->htotal * mode->vtotal);
+
+	/*
+	 * If no bandwidth constraints, anything goes, else
+	 * check if we are too fast.
+	 */
+	if (priv->memory_bw && (bw > priv->memory_bw)) {
+		DRM_INFO("%d x %d @ %d Hz, %d cpp, bw %llu too fast\n",
+			 mode->hdisplay, mode->vdisplay,
+			 mode->clock * 1000, cpp, bw);
+
+		return MODE_BAD;
+	}
+	DRM_INFO("%d x %d @ %d Hz, %d cpp, bw %llu bytes/s OK\n",
+		 mode->hdisplay, mode->vdisplay,
+		 mode->clock * 1000, cpp, bw);
+
+	return MODE_OK;
+}
+
 static int pl111_display_check(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *pstate,
 			       struct drm_crtc_state *cstate)
@@ -344,6 +379,7 @@ static int pl111_display_prepare_fb(struct drm_simple_display_pipe *pipe,
 }
 
 static const struct drm_simple_display_pipe_funcs pl111_display_funcs = {
+	.mode_valid = pl111_mode_valid,
 	.check = pl111_display_check,
 	.enable = pl111_display_enable,
 	.disable = pl111_display_disable,
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 360fbdd2203c..70b092670c04 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -65,6 +65,7 @@ struct pl111_drm_dev_private {
 	struct drm_simple_display_pipe pipe;
 
 	void *regs;
+	u32 memory_bw;
 	u32 ienb;
 	u32 ctrl;
 	/* The pixel clock (a reference to our clock divider off of CLCDCLK). */
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 73d252351438..b469aa317d9d 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -262,6 +262,12 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
+	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
+				 &priv->memory_bw)) {
+		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
+		priv->memory_bw = 0;
+	}
+
 	/* The two variants swap this register */
 	if (variant->is_pl110) {
 		priv->ienb = CLCD_PL110_IENB;
-- 
2.14.3
