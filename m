From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 15:39:17 +0100
Subject: [PATCH 3/3] drm: arm-hdlcd: fix build warnings for !CONFIG_PM
In-Reply-To: <4194408.X82ccDjh5X@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
Message-ID: <2621741.YulfsnvZOh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hdlcd_pm_suspend and hdlcd_pm_resume are intentionally unused
when CONFIG_PM is not set in this driver, and we get a compiler warning
for this:

drivers/gpu/drm/arm/hdlcd_drv.c:521:12: warning: 'hdlcd_pm_suspend' defined but not used [-Wunused-function]
drivers/gpu/drm/arm/hdlcd_drv.c:536:12: warning: 'hdlcd_pm_resume' defined but not used [-Wunused-function]

This adds a __maybe_unused annotation for the two functions, to let
the compiler know this is the intended behavior. This is better than
an #ifdef as it improves the compile time coverage of the code and it
looks nicer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 31969efe97d4..6173bb835223 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -518,7 +518,7 @@ static const struct of_device_id  hdlcd_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hdlcd_of_match);
 
-static int hdlcd_pm_suspend(struct device *dev)
+static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
@@ -533,7 +533,7 @@ static int hdlcd_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int hdlcd_pm_resume(struct device *dev)
+static int __maybe_unused hdlcd_pm_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
