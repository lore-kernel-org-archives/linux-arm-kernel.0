From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat,  6 Feb 2016 11:24:52 +0800
Subject: [PATCH v4 05/11] drm/hisilicon: Add vblank driver for ADE
In-Reply-To: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
References: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1454729098-79807-6-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vblank irq handle.

v4: None.
v3:
- Remove hisi_get_crtc_from_index func.
- A few cleanup.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 62 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 14 +++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ff70f1c3dd78..2a12e14ea6ab 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -295,6 +295,59 @@ static void ade_set_medianoc_qos(struct ade_crtc *acrtc)
 	writel(val, reg);
 }
 
+static int ade_enable_vblank(struct drm_device *dev, unsigned int pipe)
+{
+	struct kirin_drm_private *priv = dev->dev_private;
+	struct ade_crtc *acrtc = to_ade_crtc(priv->crtc[pipe]);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	if (!ctx->power_on)
+		(void)ade_power_up(ctx);
+
+	ade_update_bits(base + LDI_INT_EN, FRAME_END_INT_EN_OFST,
+			MASK(1), 1);
+
+	return 0;
+}
+
+static void ade_disable_vblank(struct drm_device *dev, unsigned int pipe)
+{
+	struct kirin_drm_private *priv = dev->dev_private;
+	struct ade_crtc *acrtc = to_ade_crtc(priv->crtc[pipe]);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	if (!ctx->power_on) {
+		DRM_ERROR("power is down! vblank disable fail\n");
+		return;
+	}
+
+	ade_update_bits(base + LDI_INT_EN, FRAME_END_INT_EN_OFST,
+			MASK(1), 0);
+}
+
+static irqreturn_t ade_irq_handler(int irq, void *data)
+{
+	struct ade_crtc *acrtc = data;
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct drm_crtc *crtc = &acrtc->base;
+	void __iomem *base = ctx->base;
+	u32 status;
+
+	status = readl(base + LDI_MSK_INT);
+	DRM_DEBUG_VBL("LDI IRQ: status=0x%X\n", status);
+
+	/* vblank irq */
+	if (status & BIT(FRAME_END_INT_EN_OFST)) {
+		ade_update_bits(base + LDI_INT_CLR, FRAME_END_INT_EN_OFST,
+				MASK(1), 1);
+		drm_crtc_handle_vblank(crtc);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void ade_display_enable(struct ade_crtc *acrtc)
 {
 	struct ade_hw_ctx *ctx = acrtc->ctx;
@@ -973,6 +1026,15 @@ int ade_drm_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
+	/* vblank irq init */
+	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
+			       DRIVER_IRQ_SHARED, dev->driver->name, acrtc);
+	if (ret)
+		return ret;
+	dev->driver->get_vblank_counter = drm_vblank_no_hw_counter;
+	dev->driver->enable_vblank = ade_enable_vblank;
+	dev->driver->disable_vblank = ade_disable_vblank;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 055729c1889c..723888feb760 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -32,6 +32,7 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
 	struct kirin_drm_private *priv = dev->dev_private;
 
+	drm_vblank_cleanup(dev);
 	dc_ops->cleanup(dev);
 	drm_mode_config_cleanup(dev);
 	devm_kfree(dev->dev, priv);
@@ -85,11 +86,22 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 		goto err_dc_cleanup;
 	}
 
+	/* vblank init */
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
+	if (ret) {
+		DRM_ERROR("failed to initialize vblank.\n");
+		goto err_unbind_all;
+	}
+	/* with irq_enabled = true, we can use the vblank feature. */
+	dev->irq_enabled = true;
+
 	/* reset all the states of crtc/plane/encoder/connector */
 	drm_mode_config_reset(dev);
 
 	return 0;
 
+err_unbind_all:
+	component_unbind_all(dev->dev, dev);
 err_dc_cleanup:
 	dc_ops->cleanup(dev);
 err_mode_config_cleanup:
@@ -123,7 +135,7 @@ static int kirin_gem_cma_dumb_create(struct drm_file *file,
 
 static struct drm_driver kirin_drm_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
-				  DRIVER_ATOMIC,
+				  DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
 	.fops			= &kirin_drm_fops,
 	.set_busid		= drm_platform_set_busid,
 
-- 
1.9.1
