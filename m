From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:12 +0100
Subject: [PATCH RFC 04/15] drm/armada: move IRQ handling into CRTC
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMC-00009w-Gd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/armada_crtc.c | 36 +++++++++++++++++--
 drivers/gpu/drm/armada/armada_crtc.h |  4 +--
 drivers/gpu/drm/armada/armada_drv.c  | 68 +++++-------------------------------
 3 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 81c34f949dfc..9341a94cc906 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -349,7 +349,7 @@ static bool armada_drm_crtc_mode_fixup(struct drm_crtc *crtc,
 	return true;
 }
 
-void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
+static void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
 {
 	struct armada_vbl_event *e, *n;
 	void __iomem *base = dcrtc->base;
@@ -410,6 +410,27 @@ void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
 	}
 }
 
+static irqreturn_t armada_drm_irq(int irq, void *arg)
+{
+	struct armada_crtc *dcrtc = arg;
+	u32 v, stat = readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR);
+
+	/*
+	 * This is rediculous - rather than writing bits to clear, we
+	 * have to set the actual status register value.  This is racy.
+	 */
+	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
+
+	/* Mask out those interrupts we haven't enabled */
+	v = stat & dcrtc->irq_ena;
+
+	if (v & (VSYNC_IRQ|GRA_FRAME_IRQ|DUMB_FRAMEDONE)) {
+		armada_drm_crtc_irq(dcrtc, stat);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
 /* These are locked by dev->vbl_lock */
 void armada_drm_crtc_disable_irq(struct armada_crtc *dcrtc, u32 mask)
 {
@@ -888,6 +909,8 @@ static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
 	if (!IS_ERR(dcrtc->clk))
 		clk_disable_unprepare(dcrtc->clk);
 
+	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ENA);
+
 	kfree(dcrtc);
 }
 
@@ -1028,7 +1051,7 @@ static int armada_drm_crtc_create_properties(struct drm_device *dev)
 }
 
 int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
-	struct resource *res)
+	struct resource *res, int irq)
 {
 	struct armada_private *priv = dev->dev_private;
 	struct armada_crtc *dcrtc;
@@ -1074,6 +1097,15 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 		       CFG_PDWN64x66, dcrtc->base + LCD_SPU_SRAM_PARA1);
 	writel_relaxed(0x2032ff81, dcrtc->base + LCD_SPU_DMA_CTRL1);
 	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_GRA_OVSA_HPXL_VLN);
+	writel_relaxed(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
+	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
+
+	ret = devm_request_irq(dev, irq, armada_drm_irq, 0, "armada_drm_crtc",
+			       dcrtc);
+	if (ret < 0) {
+		kfree(dcrtc);
+		return ret;
+	}
 
 	if (priv->variant->crtc_init) {
 		ret = priv->variant->crtc_init(dcrtc);
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 9c10a07e7492..0e952b271212 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -72,10 +72,10 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
-int armada_drm_crtc_create(struct drm_device *, unsigned, struct resource *);
+int armada_drm_crtc_create(struct drm_device *, unsigned, struct resource *,
+	int);
 void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
 void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
-void armada_drm_crtc_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_enable_irq(struct armada_crtc *, u32);
 void armada_drm_crtc_update_regs(struct armada_crtc *, struct armada_regs *);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8ab3cd1a8cdb..58884d807e6c 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -155,10 +155,16 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 
 	/* Create all LCD controllers */
 	for (n = 0; n < ARRAY_SIZE(priv->dcrtc); n++) {
+		int irq;
+
 		if (!res[n])
 			break;
 
-		ret = armada_drm_crtc_create(dev, n, res[n]);
+		irq = platform_get_irq(dev->platformdev, n);
+		if (irq < 0)
+			goto err_kms;
+
+		ret = armada_drm_crtc_create(dev, n, res[n], irq);
 		if (ret)
 			goto err_kms;
 	}
@@ -173,22 +179,16 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err_kms;
 
-	ret = drm_irq_install(dev, platform_get_irq(dev->platformdev, 0));
-	if (ret)
-		goto err_kms;
-
 	dev->vblank_disable_allowed = 1;
 
 	ret = armada_fbdev_init(dev);
 	if (ret)
-		goto err_irq;
+		goto err_kms;
 
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
 
- err_irq:
-	drm_irq_uninstall(dev);
  err_kms:
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
@@ -203,7 +203,6 @@ static int armada_drm_unload(struct drm_device *dev)
 
 	drm_kms_helper_poll_fini(dev);
 	armada_fbdev_fini(dev);
-	drm_irq_uninstall(dev);
 	drm_mode_config_cleanup(dev);
 	drm_mm_takedown(&priv->linear);
 	flush_work(&priv->fb_unref_work);
@@ -259,52 +258,6 @@ static void armada_drm_disable_vblank(struct drm_device *dev, int crtc)
 	armada_drm_crtc_disable_irq(priv->dcrtc[crtc], VSYNC_IRQ_ENA);
 }
 
-static irqreturn_t armada_drm_irq_handler(int irq, void *arg)
-{
-	struct drm_device *dev = arg;
-	struct armada_private *priv = dev->dev_private;
-	struct armada_crtc *dcrtc = priv->dcrtc[0];
-	uint32_t v, stat = readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR);
-	irqreturn_t handled = IRQ_NONE;
-
-	/*
-	 * This is rediculous - rather than writing bits to clear, we
-	 * have to set the actual status register value.  This is racy.
-	 */
-	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
-
-	/* Mask out those interrupts we haven't enabled */
-	v = stat & dcrtc->irq_ena;
-
-	if (v & (VSYNC_IRQ|GRA_FRAME_IRQ|DUMB_FRAMEDONE)) {
-		armada_drm_crtc_irq(dcrtc, stat);
-		handled = IRQ_HANDLED;
-	}
-
-	return handled;
-}
-
-static int armada_drm_irq_postinstall(struct drm_device *dev)
-{
-	struct armada_private *priv = dev->dev_private;
-	struct armada_crtc *dcrtc = priv->dcrtc[0];
-
-	spin_lock_irq(&dev->vbl_lock);
-	writel_relaxed(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
-	writel(0, dcrtc->base + LCD_SPU_IRQ_ISR);
-	spin_unlock_irq(&dev->vbl_lock);
-
-	return 0;
-}
-
-static void armada_drm_irq_uninstall(struct drm_device *dev)
-{
-	struct armada_private *priv = dev->dev_private;
-	struct armada_crtc *dcrtc = priv->dcrtc[0];
-
-	writel(0, dcrtc->base + LCD_SPU_IRQ_ENA);
-}
-
 static struct drm_ioctl_desc armada_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE, armada_gem_create_ioctl,
 		DRM_UNLOCKED),
@@ -340,9 +293,6 @@ static struct drm_driver armada_drm_driver = {
 	.get_vblank_counter	= drm_vblank_count,
 	.enable_vblank		= armada_drm_enable_vblank,
 	.disable_vblank		= armada_drm_disable_vblank,
-	.irq_handler		= armada_drm_irq_handler,
-	.irq_postinstall	= armada_drm_irq_postinstall,
-	.irq_uninstall		= armada_drm_irq_uninstall,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init		= armada_drm_debugfs_init,
 	.debugfs_cleanup	= armada_drm_debugfs_cleanup,
@@ -362,7 +312,7 @@ static struct drm_driver armada_drm_driver = {
 	.desc			= "Armada SoC DRM",
 	.date			= "20120730",
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
-				  DRIVER_HAVE_IRQ | DRIVER_PRIME,
+				  DRIVER_PRIME,
 	.ioctls			= armada_ioctls,
 	.fops			= &armada_drm_fops,
 };
-- 
1.8.3.1
