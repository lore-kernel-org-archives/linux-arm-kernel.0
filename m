From: Alexey.Brodkin@synopsys.com (Alexey Brodkin)
Date: Fri, 19 Feb 2016 11:15:01 +0300
Subject: [PATCH] drm: ARM HDLCD - get rid of devm_clk_put()
Message-ID: <1455869701-23437-1-git-send-email-abrodkin@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock is acquired with devm_clk_get() which already manages
corresponding resource.

I.e. in case of driver removal or failure on installaiton
clock resources will be automatically released and explicit
call of devm_clk_put() is not required.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 56b829f..734849f 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -55,16 +55,14 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 	hdlcd->mmio = devm_ioremap_resource(drm->dev, res);
 	if (IS_ERR(hdlcd->mmio)) {
 		DRM_ERROR("failed to map control registers area\n");
-		ret = PTR_ERR(hdlcd->mmio);
 		hdlcd->mmio = NULL;
-		goto fail;
+		return PTR_ERR(hdlcd->mmio);
 	}
 
 	version = hdlcd_read(hdlcd, HDLCD_REG_VERSION);
 	if ((version & HDLCD_PRODUCT_MASK) != HDLCD_PRODUCT_ID) {
 		DRM_ERROR("unknown product id: 0x%x\n", version);
-		ret = -EINVAL;
-		goto fail;
+		return -EINVAL;
 	}
 	DRM_INFO("found ARM HDLCD version r%dp%d\n",
 		(version & HDLCD_VERSION_MAJOR_MASK) >> 8,
@@ -73,7 +71,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 	/* Get the optional framebuffer memory resource */
 	ret = of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
-		goto fail;
+		return ret;
 
 	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -101,8 +99,6 @@ irq_fail:
 	drm_crtc_cleanup(&hdlcd->crtc);
 setup_fail:
 	of_reserved_mem_device_release(drm->dev);
-fail:
-	devm_clk_put(drm->dev, hdlcd->clk);
 
 	return ret;
 }
@@ -412,7 +408,6 @@ err_unload:
 	pm_runtime_put_sync(drm->dev);
 	pm_runtime_disable(drm->dev);
 	of_reserved_mem_device_release(drm->dev);
-	devm_clk_put(dev, hdlcd->clk);
 err_free:
 	drm_dev_unref(drm);
 
@@ -436,10 +431,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	pm_runtime_put_sync(drm->dev);
 	pm_runtime_disable(drm->dev);
 	of_reserved_mem_device_release(drm->dev);
-	if (!IS_ERR(hdlcd->clk)) {
-		devm_clk_put(drm->dev, hdlcd->clk);
-		hdlcd->clk = NULL;
-	}
 	drm_mode_config_cleanup(drm);
 	drm_dev_unregister(drm);
 	drm_dev_unref(drm);
-- 
2.5.0
