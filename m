From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:22 +0100
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to CRTC init
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the variant initialisation entirely to the CRTC init function -
the variant support is really about the CRTC properties than the whole
system, and we want to treat each CRTC individually when we support DT.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_510.c  | 19 ++++++++-----------
 drivers/gpu/drm/armada/armada_crtc.c |  2 +-
 drivers/gpu/drm/armada/armada_crtc.h |  1 +
 drivers/gpu/drm/armada/armada_drm.h  |  6 ++----
 drivers/gpu/drm/armada/armada_drv.c  |  4 ----
 5 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index 59948eff6095..a9dabcaef92e 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -15,20 +15,19 @@
 #include "armada_drm.h"
 #include "armada_hw.h"
 
-static int armada510_init(struct armada_private *priv, struct device *dev)
+static int armada510_crtc_init(struct armada_crtc *dcrtc, struct device *dev)
 {
-	priv->extclk[0] = devm_clk_get(dev, "ext_ref_clk_1");
+	struct clk *clk;
 
-	if (IS_ERR(priv->extclk[0]) && PTR_ERR(priv->extclk[0]) == -ENOENT)
-		priv->extclk[0] = ERR_PTR(-EPROBE_DEFER);
+	clk = devm_clk_get(dev, "ext_ref_clk_1");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk) == -ENOENT ? -EPROBE_DEFER : PTR_ERR(clk);
 
-	return PTR_RET(priv->extclk[0]);
-}
+	dcrtc->extclk[0] = clk;
 
-static int armada510_crtc_init(struct armada_crtc *dcrtc)
-{
 	/* Lower the watermark so to eliminate jitter at higher bandwidths */
 	armada_updatel(0x20, (1 << 11) | 0xff, dcrtc->base + LCD_CFG_RDREG4F);
+
 	return 0;
 }
 
@@ -45,8 +44,7 @@ static int armada510_crtc_init(struct armada_crtc *dcrtc)
 static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 	const struct drm_display_mode *mode, uint32_t *sclk)
 {
-	struct armada_private *priv = dcrtc->crtc.dev->dev_private;
-	struct clk *clk = priv->extclk[0];
+	struct clk *clk = dcrtc->extclk[0];
 	int ret;
 
 	if (dcrtc->num == 1)
@@ -81,7 +79,6 @@ static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 const struct armada_variant armada510_ops = {
 	.has_spu_adv_reg = true,
 	.spu_adv_reg = ADV_HWC32ENABLE | ADV_HWC32ARGB | ADV_HWC32BLEND,
-	.init = armada510_init,
 	.crtc_init = armada510_crtc_init,
 	.crtc_compute_clock = armada510_crtc_compute_clock,
 };
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 4336dfd3585d..3adddabc3626 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1108,7 +1108,7 @@ int armada_drm_crtc_create(struct drm_device *dev, struct resource *res,
 	}
 
 	if (priv->variant->crtc_init) {
-		ret = priv->variant->crtc_init(dcrtc);
+		ret = priv->variant->crtc_init(dcrtc, dev->dev);
 		if (ret) {
 			kfree(dcrtc);
 			return ret;
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 531a9b0bdcfb..3f0e70bb2e9c 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -38,6 +38,7 @@ struct armada_crtc {
 	unsigned		num;
 	void __iomem		*base;
 	struct clk		*clk;
+	struct clk		*extclk[2];
 	struct {
 		uint32_t	spu_v_h_total;
 		uint32_t	spu_v_porch;
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index a72cae03b99b..a5452ae883d1 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -59,10 +59,9 @@ void armada_drm_vbl_event_remove_unlocked(struct armada_crtc *,
 struct armada_private;
 
 struct armada_variant {
-	bool	has_spu_adv_reg;
+	bool has_spu_adv_reg;
 	uint32_t spu_adv_reg;
-	int (*init)(struct armada_private *, struct device *);
-	int (*crtc_init)(struct armada_crtc *);
+	int (*crtc_init)(struct armada_crtc *, struct device *);
 	int (*crtc_compute_clock)(struct armada_crtc *,
 				  const struct drm_display_mode *,
 				  uint32_t *);
@@ -78,7 +77,6 @@ struct armada_private {
 	struct drm_fb_helper	*fbdev;
 	struct armada_crtc	*dcrtc[2];
 	struct drm_mm		linear;
-	struct clk		*extclk[2];
 	struct drm_property	*csc_yuv_prop;
 	struct drm_property	*csc_rgb_prop;
 	struct drm_property	*colorkey_prop;
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index add8b101fa9e..4939a86a2afc 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -130,10 +130,6 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 
 	priv->variant = (struct armada_variant *)id->driver_data;
 
-	ret = priv->variant->init(priv, dev->dev);
-	if (ret)
-		return ret;
-
 	INIT_WORK(&priv->fb_unref_work, armada_drm_unref_work);
 	INIT_KFIFO(priv->fb_unref);
 
-- 
1.8.3.1
