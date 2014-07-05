From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:27 +0100
Subject: [PATCH RFC 07/15] drm/armada: make variant a CRTC thing
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMR-0000A9-Qd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the variant pointer into the armada_crtc structure, and update for
the resulting changes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_510.c  |  4 ++--
 drivers/gpu/drm/armada/armada_crtc.c | 27 ++++++++++++---------------
 drivers/gpu/drm/armada/armada_crtc.h |  5 ++++-
 drivers/gpu/drm/armada/armada_drm.h  |  9 ++++-----
 drivers/gpu/drm/armada/armada_drv.c  |  5 +++--
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index a9dabcaef92e..1bcf1a8c1915 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -79,6 +79,6 @@ static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 const struct armada_variant armada510_ops = {
 	.has_spu_adv_reg = true,
 	.spu_adv_reg = ADV_HWC32ENABLE | ADV_HWC32ARGB | ADV_HWC32BLEND,
-	.crtc_init = armada510_crtc_init,
-	.crtc_compute_clock = armada510_crtc_compute_clock,
+	.init = armada510_crtc_init,
+	.compute_clock = armada510_crtc_compute_clock,
 };
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 3adddabc3626..afa497489000 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -332,17 +332,16 @@ static void armada_drm_crtc_commit(struct drm_crtc *crtc)
 static bool armada_drm_crtc_mode_fixup(struct drm_crtc *crtc,
 	const struct drm_display_mode *mode, struct drm_display_mode *adj)
 {
-	struct armada_private *priv = crtc->dev->dev_private;
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 	int ret;
 
 	/* We can't do interlaced modes if we don't have the SPU_ADV_REG */
-	if (!priv->variant->has_spu_adv_reg &&
+	if (!dcrtc->variant->has_spu_adv_reg &&
 	    adj->flags & DRM_MODE_FLAG_INTERLACE)
 		return false;
 
 	/* Check whether the display mode is possible */
-	ret = priv->variant->crtc_compute_clock(dcrtc, adj, NULL);
+	ret = dcrtc->variant->compute_clock(dcrtc, adj, NULL);
 	if (ret)
 		return false;
 
@@ -491,7 +490,6 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	struct drm_display_mode *mode, struct drm_display_mode *adj,
 	int x, int y, struct drm_framebuffer *old_fb)
 {
-	struct armada_private *priv = crtc->dev->dev_private;
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
 	struct armada_regs regs[17];
 	uint32_t lm, rm, tm, bm, val, sclk;
@@ -536,7 +534,7 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	}
 
 	/* Now compute the divider for real */
-	priv->variant->crtc_compute_clock(dcrtc, adj, &sclk);
+	dcrtc->variant->compute_clock(dcrtc, adj, &sclk);
 
 	/* Ensure graphic fifo is enabled */
 	armada_reg_queue_mod(regs, i, 0, CFG_PDWN64x66, LCD_SPU_SRAM_PARA1);
@@ -558,7 +556,7 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	dcrtc->v[1].spu_v_porch = tm << 16 | bm;
 	val = adj->crtc_hsync_start;
 	dcrtc->v[1].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN |
-		priv->variant->spu_adv_reg;
+		dcrtc->variant->spu_adv_reg;
 
 	if (interlaced) {
 		/* Odd interlaced frame */
@@ -567,7 +565,7 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 		dcrtc->v[0].spu_v_porch = dcrtc->v[1].spu_v_porch + 1;
 		val = adj->crtc_hsync_start - adj->crtc_htotal / 2;
 		dcrtc->v[0].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN |
-			priv->variant->spu_adv_reg;
+			dcrtc->variant->spu_adv_reg;
 	} else {
 		dcrtc->v[0] = dcrtc->v[1];
 	}
@@ -582,7 +580,7 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_h_total,
 			   LCD_SPUT_V_H_TOTAL);
 
-	if (priv->variant->has_spu_adv_reg) {
+	if (dcrtc->variant->has_spu_adv_reg) {
 		armada_reg_queue_mod(regs, i, dcrtc->v[0].spu_adv_reg,
 				     ADV_VSYNC_L_OFF | ADV_VSYNC_H_OFF |
 				     ADV_VSYNCOFFEN, LCD_SPU_ADV_REG);
@@ -826,12 +824,11 @@ static int armada_drm_crtc_cursor_set(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
-	struct armada_private *priv = crtc->dev->dev_private;
 	struct armada_gem_object *obj = NULL;
 	int ret;
 
 	/* If no cursor support, replicate drm's return value */
-	if (!priv->variant->has_spu_adv_reg)
+	if (!dcrtc->variant->has_spu_adv_reg)
 		return -ENXIO;
 
 	if (handle && w > 0 && h > 0) {
@@ -879,11 +876,10 @@ static int armada_drm_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 {
 	struct drm_device *dev = crtc->dev;
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
-	struct armada_private *priv = crtc->dev->dev_private;
 	int ret;
 
 	/* If no cursor support, replicate drm's return value */
-	if (!priv->variant->has_spu_adv_reg)
+	if (!dcrtc->variant->has_spu_adv_reg)
 		return -EFAULT;
 
 	mutex_lock(&dev->struct_mutex);
@@ -1051,7 +1047,7 @@ static int armada_drm_crtc_create_properties(struct drm_device *dev)
 }
 
 int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
-	int irq)
+	int irq, const struct armada_variant *variant)
 {
 	struct armada_private *priv = dev->dev_private;
 	struct armada_crtc *dcrtc;
@@ -1074,6 +1070,7 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 		return -ENOMEM;
 	}
 
+	dcrtc->variant = variant;
 	dcrtc->base = base;
 	dcrtc->num = dev->mode_config.num_crtc;
 	dcrtc->clk = ERR_PTR(-EINVAL);
@@ -1107,8 +1104,8 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 		return ret;
 	}
 
-	if (priv->variant->crtc_init) {
-		ret = priv->variant->crtc_init(dcrtc, dev->dev);
+	if (dcrtc->variant->init) {
+		ret = dcrtc->variant->init(dcrtc, dev->dev);
 		if (ret) {
 			kfree(dcrtc);
 			return ret;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 3f0e70bb2e9c..73efcfcdf814 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -32,9 +32,11 @@ struct armada_regs {
 	armada_reg_queue_mod(_r, _i, 0, 0, ~0)
 
 struct armada_frame_work;
+struct armada_variant;
 
 struct armada_crtc {
 	struct drm_crtc		crtc;
+	const struct armada_variant *variant;
 	unsigned		num;
 	void __iomem		*base;
 	struct clk		*clk;
@@ -73,7 +75,8 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
-int armada_drm_crtc_create(struct drm_device *, struct resource *, int);
+int armada_drm_crtc_create(struct drm_device *, struct resource *, int,
+	const struct armada_variant *);
 void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
 void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index a5452ae883d1..ea63c6c7c66f 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -61,17 +61,16 @@ struct armada_private;
 struct armada_variant {
 	bool has_spu_adv_reg;
 	uint32_t spu_adv_reg;
-	int (*crtc_init)(struct armada_crtc *, struct device *);
-	int (*crtc_compute_clock)(struct armada_crtc *,
-				  const struct drm_display_mode *,
-				  uint32_t *);
+	int (*init)(struct armada_crtc *, struct device *);
+	int (*compute_clock)(struct armada_crtc *,
+			     const struct drm_display_mode *,
+			     uint32_t *);
 };
 
 /* Variant ops */
 extern const struct armada_variant armada510_ops;
 
 struct armada_private {
-	const struct armada_variant *variant;
 	struct work_struct	fb_unref_work;
 	DECLARE_KFIFO(fb_unref, struct drm_framebuffer *, 8);
 	struct drm_fb_helper	*fbdev;
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 4939a86a2afc..3995be3c686b 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -85,6 +85,7 @@ void armada_drm_queue_unref_work(struct drm_device *dev,
 static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 {
 	const struct platform_device_id *id;
+	const struct armada_variant *variant;
 	struct armada_private *priv;
 	struct resource *res[ARRAY_SIZE(priv->dcrtc)];
 	struct resource *mem = NULL;
@@ -128,7 +129,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 	if (!id)
 		return -ENXIO;
 
-	priv->variant = (struct armada_variant *)id->driver_data;
+	variant = (const struct armada_variant *)id->driver_data;
 
 	INIT_WORK(&priv->fb_unref_work, armada_drm_unref_work);
 	INIT_KFIFO(priv->fb_unref);
@@ -160,7 +161,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		if (irq < 0)
 			goto err_kms;
 
-		ret = armada_drm_crtc_create(dev, res[n], irq);
+		ret = armada_drm_crtc_create(dev, res[n], irq, variant);
 		if (ret)
 			goto err_kms;
 	}
-- 
1.8.3.1
