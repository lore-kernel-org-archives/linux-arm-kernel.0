From: dsd@laptop.org (Daniel Drake)
Date: Fri, 28 Jun 2013 16:11:32 -0400 (EDT)
Subject: armada_drm clock selection
Message-ID: <20130628201133.1D6D2FAAD5@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for pointing me to the most recent version of your driver.
Can you comment on the below patch for improved clock handling?
It is based on the approach in Jean-Francois Moine's driver, and would
serve for the basis of having clock info come from the DT. If you have
something else in mind, maybe you can explain quickly, and I'll try to
implement it.

armada_priv now has a clk array, the indice of each member of the array
corresponds to the id in the SCLK register (so extclk1 goes at clk[3]).
When we need to set up SCLK for a CRTC, we try to find a clock that can
meet the requested rate exactly. If we don't find one, we fall back on the
first clock in the array.

armada510_compute_crtc_clock had a fair amount of stuff that is in danger
of being repeated in a MMP2-equivalent function, and then again for MMP3.
So I took out the clock-hunting code and made that into a function that
would be shared by the 3 platforms.

devm can't be used for clocks as for DT we will use of_clk_get() with an index
and there is no devm equivalent.

Comments appreciated. Compile tested only.
---
 drivers/gpu/drm/armada/armada_crtc.c |  31 ++++++++---
 drivers/gpu/drm/armada/armada_drm.h  |  15 +++--
 drivers/gpu/drm/armada/armada_drv.c  | 104 ++++++++++++++++++++---------------
 drivers/gpu/drm/armada/armada_hw.h   |   9 +--
 4 files changed, 100 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index dadaf63..9705466 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -413,16 +413,31 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	struct armada_private *priv = crtc->dev->dev_private;
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 	struct armada_regs regs[16];
+	struct clk *clk;
 	uint32_t lm, rm, tm, bm, val, sclk;
 	unsigned long flags;
 	unsigned i;
 	bool interlaced;
+	int clk_idx;
 	int ret;
 
-	/* First, check that this will succeed. */
-	ret = priv->ops->compute_crtc_clock(dcrtc, adj, NULL);
-	if (ret)
-		return ret;
+	/* First, check that a suitable clock is available. */
+	clk_idx = armada_drm_find_best_clock(priv, adj->clock * 1000);
+	if (clk_idx < 0)
+		return clk_idx;
+
+	clk = priv->clk[clk_idx];
+	if (dcrtc->clk != clk) {
+		if (dcrtc->clk) {
+			clk_disable_unprepare(clk);
+			dcrtc->clk = NULL;
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		dcrtc->clk = clk;
+	}
 
 	drm_framebuffer_reference(crtc->fb);
 
@@ -459,8 +474,8 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 		writel_relaxed(val, dcrtc->base + LCD_SPU_DUMB_CTRL);
 	}
 
-	/* Now compute the divider for real */
-	priv->ops->compute_crtc_clock(dcrtc, adj, &sclk);
+	/* Now compute the divider */
+	sclk = priv->ops->compute_crtc_clock(dcrtc, adj->clock * 1000, clk_idx);
 
 	armada_reg_queue_set(regs, i, sclk, LCD_CFG_SCLK_DIV);
 
@@ -634,7 +649,7 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 	priv->dcrtc[dcrtc->num] = NULL;
 	drm_crtc_cleanup(&dcrtc->crtc);
 
-	if (!IS_ERR(dcrtc->clk))
+	if (dcrtc->clk)
 		clk_disable_unprepare(dcrtc->clk);
 
 	kfree(dcrtc);
@@ -734,7 +749,7 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 
 	dcrtc->base = base;
 	dcrtc->num = num;
-	dcrtc->clk = ERR_PTR(-EINVAL);
+	dcrtc->clk = NULL;
 	dcrtc->cfg_dma_ctrl0 = CFG_GRA_ENA | CFG_GRA_HSMOOTH;
 	dcrtc->cfg_dumb_ctrl = DUMB24_RGB888_0;
 	spin_lock_init(&dcrtc->irq_lock);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index c2dcde5..b41d77c 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -41,18 +41,23 @@ struct armada_private;
 
 struct armada_ops {
 	int (*init)(struct armada_private *, struct device *);
-	int (*compute_crtc_clock)(struct armada_crtc *,
-				  const struct drm_display_mode *,
-				  uint32_t *);
+	uint32_t (*compute_crtc_clock)(struct armada_crtc *,
+				       long rate, int clk_idx);
 };
 
+#define ARMADA_MAX_CLOCK 4
+
 struct armada_private {
 	const struct armada_ops	*ops;
 	struct drm_fb_helper	*fbdev;
 	struct armada_crtc	*dcrtc[2];
 	struct armada_overlay	*overlay;
 	struct drm_mm		linear;
-	struct clk		*extclk[2];
+
+	/* The index of clocks in this array line up with their ID
+	 * into the SCLK clock selection register. */
+	struct clk		*clk[ARMADA_MAX_CLOCK];
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*de;
 #endif
@@ -70,4 +75,6 @@ void armada_drm_overlay_off(struct drm_device *, struct armada_overlay *);
 int armada_drm_debugfs_init(struct drm_minor *);
 void armada_drm_debugfs_cleanup(struct drm_minor *);
 
+int armada_drm_find_best_clock(struct armada_private *priv, long needed_rate);
+
 #endif
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 807fd35..a6fc3f1 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -16,68 +16,71 @@
 #include "armada_ioctl.h"
 #include "armada_ioctlP.h"
 
+int armada_drm_find_best_clock(struct armada_private *priv, long needed_rate)
+{
+	int i;
+
+	/* check if any clock can meet this rate directly */
+	for (i = 0; i < ARMADA_MAX_CLOCK; i++) {
+		struct clk *clk = priv->clk[i];
+		long ref;
+
+		if (!clk)
+			continue;
+
+		clk_set_rate(clk, needed_rate);
+		ref = clk_get_rate(clk);
+
+		if (ref % needed_rate == 0)
+			return i;
+	}
+
+	/* fallback: return first available clock */
+	for (i = 0; i < ARMADA_MAX_CLOCK; i++) {
+		struct clk *clk = priv->clk[i];
+		if (clk)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 /*
  * Armada510 specific initialization.  There _may_ be two external
  * clocks - look them up now but don't fail if they're not present.
  * We may be able to use the internal clocks instead.
+ *
+ * We currently are pretty rudimentary here, always selecting EXT_REF_CLK_1
  */
 static int armada510_init(struct armada_private *priv, struct device *dev)
 {
-	priv->extclk[0] = devm_clk_get(dev, "ext_ref_clk_1");
+	struct clk *clk = clk_get(dev, "ext_ref_clk_1");
 
-	if (IS_ERR(priv->extclk[0])) {
-		int ret = PTR_ERR(priv->extclk[0]);
+	if (IS_ERR(clk)) {
+		int ret = PTR_ERR(clk);
 		if (ret == -ENOENT)
 			ret = -EPROBE_DEFER;
 		return ret;
 	}
 
+	priv->clk[SCLK_510_EXTCLK1] = clk;
 	return 0;
 }
 
-/*
- * Armada510 specific SCLK register selection: this gets called with
- * sclk = NULL to test whether the mode is supportable, and again with
- * sclk != NULL to set the clocks up for that.  The former can return
- * an error, but the latter is expected not to.
- *
- * We currently are pretty rudimentary here, always selecting
- * EXT_REF_CLK_1 for LCD0 and erroring LCD1.  This needs improvement!
- */
-static int armada510_compute_crtc_clock(struct armada_crtc *dcrtc,
-	const struct drm_display_mode *mode, uint32_t *sclk)
+static uint32_t armada510_compute_crtc_clock(struct armada_crtc *dcrtc,
+	long rate, int clk_idx)
 {
 	struct armada_private *priv = dcrtc->crtc.dev->dev_private;
-	struct clk *clk = priv->extclk[0];
-	int ret;
+	struct clk *clk = priv->clk[clk_idx];
+	uint32_t ref, div;
 
-	if (dcrtc->num == 1)
-		return -EINVAL;
+	ref = clk_round_rate(clk, rate);
+	div = DIV_ROUND_UP(ref, rate);
+	if (div < 1)
+		div = 1;
 
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	if (dcrtc->clk != clk) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-		dcrtc->clk = clk;
-	}
-
-	if (sclk) {
-		uint32_t rate, ref, div;
-
-		rate = mode->clock * 1000;
-		ref = clk_round_rate(clk, rate);
-		div = DIV_ROUND_UP(ref, rate);
-		if (div < 1)
-			div = 1;
-
-		clk_set_rate(clk, ref);
-		*sclk = div | SCLK_510_EXTCLK1;
-	}
-
-	return 0;
+	clk_set_rate(clk, ref);
+	return div | clk_idx << SCLK_510_SHIFT;
 }
 
 static const struct armada_ops armada510_ops = {
@@ -85,6 +88,19 @@ static const struct armada_ops armada510_ops = {
 	.compute_crtc_clock = armada510_compute_crtc_clock,
 };
 
+static void release_clocks(struct armada_private *priv)
+{
+	int i;
+	for (i = 0; i < ARMADA_MAX_CLOCK; i++) {
+		struct clk *clk = priv->clk[i];
+		if (!clk)
+			continue;
+
+		clk_put(clk);
+		priv->clk[i] = NULL;
+	}
+}
+
 static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 {
 	struct armada_private *priv;
@@ -129,7 +145,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 
 	ret = priv->ops->init(priv, dev->dev);
 	if (ret)
-		return ret;
+		goto err_buf;
 
 	/* Mode setting support */
 	drm_mode_config_init(dev);
@@ -176,6 +192,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
  err_irq:
 	drm_irq_uninstall(dev);
  err_kms:
+	release_clocks(priv);
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
  err_buf:
@@ -193,6 +210,7 @@ static int armada_drm_unload(struct drm_device *dev)
 	drm_irq_uninstall(dev);
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
+	release_clocks(priv);
 	dev->dev_private = NULL;
 
 	return 0;
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/armada_hw.h
index 58d2a20..df59b5a 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -193,11 +193,12 @@ enum {
 };
 
 /* For LCD_CFG_SCLK_DIV */
+#define SCLK_510_SHIFT 30
 enum {
-	SCLK_510_AXI		= 0x0 << 30,	/* Armada 510 */
-	SCLK_510_EXTCLK0	= 0x1 << 30,	/* Armada 510 */
-	SCLK_510_PLL		= 0x2 << 30,	/* Armada 510 */
-	SCLK_510_EXTCLK1	= 0x3 << 30,	/* Armada 510 */
+	SCLK_510_AXI		= 0x0 << SCLK_510_SHIFT,	/* Armada 510 */
+	SCLK_510_EXTCLK0	= 0x1 << SCLK_510_SHIFT,	/* Armada 510 */
+	SCLK_510_PLL		= 0x2 << SCLK_510_SHIFT,	/* Armada 510 */
+	SCLK_510_EXTCLK1	= 0x3 << SCLK_510_SHIFT,	/* Armada 510 */
 	SCLK_DIV_CHANGE		= 1 << 29,
 	SCLK_16X_AHB		= 0x0 << 28,	/* Armada 16x */
 	SCLK_16X_PCLK		= 0x1 << 28,	/* Armada 16x */
-- 
1.8.1.4
