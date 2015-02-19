From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Fri, 20 Feb 2015 00:41:41 +0100
Subject: [PATCH] ARM: OMAP2+: Return correct error values from device and hwmod
Message-ID: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch function pm_runtime_get_sync() returns 0 even when some
omap subfunction fails. This patch properly propagate error codes from omap
functions back to caller.

This patch fix problem, when loading omap-aes driver in qemu cause kernel oops.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/omap_device.c |   30 +++++++++++++++++-------------
 arch/arm/mach-omap2/omap_hwmod.c  |   20 ++++++++++++--------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index be9541e..9fd47a9 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -224,13 +224,13 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
  */
 static int _omap_device_enable_hwmods(struct omap_device *od)
 {
+	int ret = 0;
 	int i;
 
 	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_enable(od->hwmods[i]);
+		ret |= omap_hwmod_enable(od->hwmods[i]);
 
-	/* XXX pass along return value here? */
-	return 0;
+	return ret;
 }
 
 /**
@@ -241,13 +241,13 @@ static int _omap_device_enable_hwmods(struct omap_device *od)
  */
 static int _omap_device_idle_hwmods(struct omap_device *od)
 {
+	int ret = 0;
 	int i;
 
 	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_idle(od->hwmods[i]);
+		ret |= omap_hwmod_idle(od->hwmods[i]);
 
-	/* XXX pass along return value here? */
-	return 0;
+	return ret;
 }
 
 /* Public functions for use by core code */
@@ -595,18 +595,20 @@ static int _od_runtime_suspend(struct device *dev)
 	int ret;
 
 	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		return ret;
 
-	if (!ret)
-		omap_device_idle(pdev);
-
-	return ret;
+	return omap_device_idle(pdev);
 }
 
 static int _od_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
-	omap_device_enable(pdev);
+	ret = omap_device_enable(pdev);
+	if (ret)
+		return ret;
 
 	return pm_generic_runtime_resume(dev);
 }
@@ -740,7 +742,8 @@ int omap_device_enable(struct platform_device *pdev)
 
 	ret = _omap_device_enable_hwmods(od);
 
-	od->_state = OMAP_DEVICE_STATE_ENABLED;
+	if (ret == 0)
+		od->_state = OMAP_DEVICE_STATE_ENABLED;
 
 	return ret;
 }
@@ -770,7 +773,8 @@ int omap_device_idle(struct platform_device *pdev)
 
 	ret = _omap_device_idle_hwmods(od);
 
-	od->_state = OMAP_DEVICE_STATE_IDLE;
+	if (ret == 0)
+		od->_state = OMAP_DEVICE_STATE_IDLE;
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..2ce4f39 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3350,16 +3350,17 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
  */
 int omap_hwmod_idle(struct omap_hwmod *oh)
 {
+	int r;
 	unsigned long flags;
 
 	if (!oh)
 		return -EINVAL;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_idle(oh);
+	r = _idle(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-	return 0;
+	return r;
 }
 
 /**
@@ -3372,16 +3373,17 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
  */
 int omap_hwmod_shutdown(struct omap_hwmod *oh)
 {
+	int r;
 	unsigned long flags;
 
 	if (!oh)
 		return -EINVAL;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_shutdown(oh);
+	r = _shutdown(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-	return 0;
+	return r;
 }
 
 /**
@@ -3392,13 +3394,14 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
  */
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh)
 {
+	int r;
 	unsigned long flags;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_enable_clocks(oh);
+	r = _enable_clocks(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-	return 0;
+	return r;
 }
 
 /**
@@ -3409,13 +3412,14 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh)
  */
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh)
 {
+	int r;
 	unsigned long flags;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_disable_clocks(oh);
+	r = _disable_clocks(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-	return 0;
+	return r;
 }
 
 /**
-- 
1.7.9.5
