From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:23 +0800
Subject: [PATCH v4 8/9] drm/hisilicon/hibmc: Add vblank interruput
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-9-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vblank interrupt.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 47 ++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 2ade5a8..5ae0e1d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -40,16 +40,46 @@
 
 static int hibmc_enable_vblank(struct drm_device *dev, unsigned int pipe)
 {
+	struct hibmc_drm_device *hidev =
+		(struct hibmc_drm_device *)dev->dev_private;
+
+	writel(HIBMC_RAW_INTERRUPT_EN_VBLANK(1),
+	       hidev->mmio + HIBMC_RAW_INTERRUPT_EN);
+
 	return 0;
 }
 
 static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
 {
+	struct hibmc_drm_device *hidev =
+		(struct hibmc_drm_device *)dev->dev_private;
+
+	writel(HIBMC_RAW_INTERRUPT_EN_VBLANK(0),
+	       hidev->mmio + HIBMC_RAW_INTERRUPT_EN);
+}
+
+irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
+{
+	struct drm_device *dev = (struct drm_device *)arg;
+	struct hibmc_drm_device *hidev =
+		(struct hibmc_drm_device *)dev->dev_private;
+	struct drm_crtc *crtc = &hidev->crtc;
+	u32 status;
+
+	status = readl(hidev->mmio + HIBMC_RAW_INTERRUPT);
+
+	if (status & HIBMC_RAW_INTERRUPT_VBLANK(1)) {
+		writel(HIBMC_RAW_INTERRUPT_VBLANK(1),
+		       hidev->mmio + HIBMC_RAW_INTERRUPT);
+		drm_crtc_handle_vblank(crtc);
+	}
+
+	return IRQ_HANDLED;
 }
 
 static struct drm_driver hibmc_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
-				  DRIVER_ATOMIC,
+				  DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
 	.fops			= &hibmc_fops,
 	.name			= "hibmc",
 	.date			= "20160828",
@@ -63,6 +93,7 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
 	.dumb_create            = hibmc_dumb_create,
 	.dumb_map_offset        = hibmc_dumb_mmap_offset,
 	.dumb_destroy           = drm_gem_dumb_destroy,
+	.irq_handler		= hibmc_drm_interrupt,
 };
 
 static int hibmc_pm_suspend(struct device *dev)
@@ -282,6 +313,20 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err;
 
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
+	if (ret) {
+		DRM_ERROR("failed to initialize vblank.\n");
+		return ret;
+	}
+
+	if (pci_enable_msi(dev->pdev)) {
+		DRM_ERROR("Enabling MSI failed!\n");
+	} else {
+		ret = drm_irq_install(dev, dev->pdev->irq);
+		if (ret)
+			DRM_ERROR("install irq failed , ret = %d\n", ret);
+	}
+
 	/* reset all the states of crtc/plane/encoder/connector */
 	drm_mode_config_reset(dev);
 
-- 
1.9.1
