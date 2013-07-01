From: dsd@laptop.org (Daniel Drake)
Date: Mon,  1 Jul 2013 16:30:09 -0400 (EDT)
Subject: armada_drm clock selection - try 2
Message-ID: <20130701203009.633A8FAAD5@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Here is a new patch which should incorporate all your previous feedback.
Now each variant passes clock info to the main driver via a new
armada_clk_info structure.

A helper function in the core lets each variant find the best clock.
As you suggested we first try external ("dedicated") clocks, where we can
change the rate to find an exact match. We fall back on looking at the rates
of the other clocks and we return the clock that provides us with the closest
match after integer division (rejecting those that don't bring us within 1%).

There is still the possibility that two CRTCs on the same device end up using
the same clock, so I added a usage counter to each clock to prevent the rate
from being changed by another CRTC.

This is compile-tested only - but after your feedback I will add the
remaining required hacks and test it on XO.

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index a016888..7dff2dc 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -17,12 +17,29 @@
 
 static int armada510_init(struct armada_private *priv, struct device *dev)
 {
-	priv->extclk[0] = devm_clk_get(dev, "ext_ref_clk_1");
+	struct armada_clk_info *clk_info = devm_kzalloc(dev,
+		sizeof(struct armada_clk_info) * 4, GFP_KERNEL);
 
-	if (IS_ERR(priv->extclk[0]) && PTR_ERR(priv->extclk[0]) == -ENOENT)
-		priv->extclk[0] = ERR_PTR(-EPROBE_DEFER);
+	if (!clk_info)
+		return -ENOMEM;
 
-	return PTR_RET(priv->extclk[0]);
+	/* External clocks */
+	clk_info[0].clk = devm_clk_get(dev, "ext_ref_clk_0");
+	clk_info[0].is_dedicated = true;
+	clk_info[0].sclk = SCLK_510_EXTCLK0;
+	clk_info[1].clk = devm_clk_get(dev, "ext_ref_clk_1");
+	clk_info[1].is_dedicated = true;
+	clk_info[1].sclk = SCLK_510_EXTCLK1;
+
+	/* Internal/shared clocks */
+	clk_info[2].clk = devm_clk_get(dev, "axi");
+	clk_info[2].sclk = SCLK_510_AXI;
+	clk_info[3].clk = devm_clk_get(dev, "pll");
+	clk_info[3].sclk = SCLK_510_PLL;
+
+	priv->num_clks = 4;
+	priv->clk_info = clk_info;
+	return 0;
 }
 
 static int armada510_crtc_init(struct armada_crtc *dcrtc)
@@ -38,42 +55,25 @@ static int armada510_crtc_init(struct armada_crtc *dcrtc)
  * supportable, and again with sclk != NULL to set the clocks up for
  * that.  The former can return an error, but the latter is expected
  * not to.
- *
- * We currently are pretty rudimentary here, always selecting
- * EXT_REF_CLK_1 for LCD0 and erroring LCD1.  This needs improvement!
  */
 static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 	const struct drm_display_mode *mode, uint32_t *sclk)
 {
 	struct armada_private *priv = dcrtc->crtc.dev->dev_private;
-	struct clk *clk = priv->extclk[0];
-	int ret;
-
-	if (dcrtc->num == 1)
-		return -EINVAL;
-
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	if (dcrtc->clk != clk) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-		dcrtc->clk = clk;
-	}
+	struct armada_clk_info *clk_info;
+	int err;
+	int divider;
 
-	if (sclk) {
-		uint32_t rate, ref, div;
+	clk_info = armada_drm_find_best_clock(priv, mode->clock * 1000, &divider);
+	if (!clk_info)
+		return -ENOENT;
 
-		rate = mode->clock * 1000;
-		ref = clk_round_rate(clk, rate);
-		div = DIV_ROUND_UP(ref, rate);
-		if (div < 1)
-			div = 1;
+	err = armada_drm_crtc_switch_clock(dcrtc, clk_info);
+	if (err)
+		return err;
 
-		clk_set_rate(clk, ref);
-		*sclk = div | SCLK_510_EXTCLK1;
-	}
+	if (sclk)
+		*sclk = divider | clk_info->sclk;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index f489157..8202be2 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -83,6 +83,34 @@ enum csc_mode {
  * porch, which we're reprogramming.)
  */
 
+/* Switch to a new clock source after disabling and unpreparing the current
+ * one. If non-NULL, the new clock source is expected to be prepared before
+ * this function is called. */
+int armada_drm_crtc_switch_clock(struct armada_crtc *dcrtc,
+	struct armada_clk_info *clk_info)
+{
+	int err;
+
+	if (dcrtc->active_clk == clk_info)
+		return 0;
+
+	if (dcrtc->active_clk) {
+		clk_disable_unprepare(dcrtc->active_clk->clk);
+		dcrtc->active_clk->usage_count--;
+		dcrtc->active_clk = NULL;
+	}
+
+	if (clk_info) {
+		err = clk_enable(clk_info->clk);
+		if (err)
+			return err;
+		dcrtc->active_clk = clk_info;
+		clk_info->usage_count++;
+	}
+
+	return 0;
+}
+
 void
 armada_drm_crtc_update_regs(struct armada_crtc *dcrtc, struct armada_regs *regs)
 {
@@ -647,10 +675,7 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	priv->dcrtc[dcrtc->num] = NULL;
 	drm_crtc_cleanup(&dcrtc->crtc);
-
-	if (!IS_ERR(dcrtc->clk))
-		clk_disable_unprepare(dcrtc->clk);
-
+	armada_drm_crtc_switch_clock(dcrtc, NULL);
 	kfree(dcrtc);
 }
 
@@ -814,7 +839,6 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 
 	dcrtc->base = base;
 	dcrtc->num = num;
-	dcrtc->clk = ERR_PTR(-EINVAL);
 	dcrtc->csc_yuv_mode = CSC_AUTO;
 	dcrtc->csc_rgb_mode = CSC_AUTO;
 	dcrtc->cfg_dumb_ctrl = DUMB24_RGB888_0;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 972da53..f260676 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -37,7 +37,7 @@ struct armada_crtc {
 	struct drm_crtc		crtc;
 	unsigned		num;
 	void __iomem		*base;
-	struct clk		*clk;
+	struct armada_clk_info	*active_clk;
 	struct {
 		uint32_t	spu_v_h_total;
 		uint32_t	spu_v_porch;
@@ -70,5 +70,7 @@ void armada_drm_crtc_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_enable_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_update_regs(struct armada_crtc *, struct armada_regs *);
+int armada_drm_crtc_switch_clock(struct armada_crtc *dcrtc,
+	struct armada_clk_info *clk_info);
 
 #endif
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index e8c4f80..4fe8ec5 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -55,6 +55,20 @@ void armada_drm_vbl_event_remove_unlocked(struct armada_crtc *,
 	__e->fn = _f;					\
 } while (0)
 
+struct armada_clk_info {
+	struct clk *clk;
+
+	/* If this clock is dedicated to us, we can change its rate without
+	 * worrying about any other users in other parts of the system. */
+	bool is_dedicated;
+
+	/* However, we cannot share the same dedicated clock between two CRTCs
+	 * if each CRTC wants a different rate. Track the number of users. */
+	int usage_count;
+
+	/* The bits in the SCLK register that select this clock */
+	uint32_t sclk;
+};
 
 struct armada_private;
 
@@ -77,7 +91,8 @@ struct armada_private {
 	struct drm_fb_helper	*fbdev;
 	struct armada_crtc	*dcrtc[2];
 	struct drm_mm		linear;
-	struct clk		*extclk[2];
+	int			num_clks;
+	struct armada_clk_info	*clk_info;
 	struct drm_property	*csc_yuv_prop;
 	struct drm_property	*csc_rgb_prop;
 	struct drm_property	*colorkey_prop;
@@ -99,6 +114,9 @@ void __armada_drm_queue_unref_work(struct drm_device *,
 void armada_drm_queue_unref_work(struct drm_device *,
 	struct drm_framebuffer *);
 
+struct armada_clk_info *armada_drm_find_best_clock(struct armada_private *priv,
+	long rate, int *divider);
+
 extern const struct drm_mode_config_funcs armada_drm_mode_config_funcs;
 
 int armada_fbdev_init(struct drm_device *);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index e0a08e9..411d56f 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -16,6 +16,97 @@
 #include "armada_ioctl.h"
 #include "armada_ioctlP.h"
 
+/* Find the best clock and integer divisor for a given rate.
+ * NULL is returned when no clock can be found.
+ * When the return value is non-NULL, the divider output variable is set
+ * appropriately, and the clock is returned in prepared state. */
+struct armada_clk_info *armada_drm_find_best_clock(struct armada_private *priv, 
+	long rate, int *divider)
+{
+	int i;
+	int div;
+	long residue;
+	long res_max;
+	long ref;
+	struct armada_clk_info *ret = NULL;
+
+	/* Look for an unused dedicated clock (e.g. an external clock with
+	 * no other users) which can provide the desired rate exactly. In this
+	 * case we can change the clock rate to meet our needs. */
+	for (i = 0; i < priv->num_clks; i++) {
+		struct armada_clk_info *clkinfo = &priv->clk_info[i];
+		struct clk *candidate = clkinfo->clk;
+		if (IS_ERR(candidate))
+			continue;
+
+		if (!clkinfo->is_dedicated || clkinfo->usage_count > 0)
+			continue;
+
+		if (clk_prepare(candidate))
+			continue;
+
+		ref = clk_round_rate(candidate, rate);
+		if (ref == rate) {
+			*divider = 1;
+			clk_set_rate(candidate, ref);
+			return clkinfo;
+
+		}
+		clk_unprepare(candidate);
+	}
+
+	/* Fallback: look for a clock that can bring us within 1% of the
+	 * desired rate when an integer divider is applied. In this case we
+	 * do not change the clock's rate because the clock may be shared with
+	 * other elements. */
+	res_max = rate / 100;
+	for (i = 0; i < priv->num_clks; i++) {
+		struct armada_clk_info *clkinfo = &priv->clk_info[i];
+		struct clk *candidate = clkinfo->clk;
+		long ref_residue;
+
+		if (IS_ERR(candidate) || clk_prepare(candidate))
+			continue;
+
+		ref = clk_get_rate(candidate);
+		ref_residue = ref % rate;
+
+		/* Normalize the residue value: if its at the high end of
+		 * the range, calculate its offset from the next possible
+		 * divisor. */
+		if (ref_residue > res_max)
+			ref_residue = rate - ref_residue;
+
+		/* Ignore rates worse than 1% */
+		if (ref_residue > res_max) {
+			clk_unprepare(candidate);
+			continue;
+		}
+
+		/* Do we have a better previous match? */
+		if (ret && residue < ref_residue) {
+			clk_unprepare(candidate);
+			continue;
+		}
+
+		/* We have the best match, store it for later. */
+		if (ret)
+			clk_unprepare(ret->clk);
+
+		ret = clkinfo;
+		residue = ref_residue;
+	}
+
+	if (ret) {
+		div = DIV_ROUND_UP(ref, rate);
+		if (div < 1)
+			div = 1;
+		*divider = div;
+	}
+
+	return ret;
+}
+
 static void armada_drm_unref_work(struct work_struct *work)
 {
 	struct armada_private *priv =
-- 
1.8.1.4
