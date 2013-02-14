From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 13:15:52 +0200
Subject: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation if !od
Message-ID: <1360840554-26901-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eventually, we need to be able to remove
ti,hwmods DT attribute (or at a minimum
ignore it).

For new platforms, this patch could enable
the transition by not relying on ti,hwmods
to have functioning PM and Idle implementation.

Notice that this poses no differences for
platforms which are already supported, it
just gives us means of dropping the relyance
on hwmod for new platforms.

NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_device.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e065daa..305eeb4 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -796,13 +796,18 @@ static int __init omap_early_device_register(struct platform_device *pdev)
 static int _od_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
 	int ret;
 
 	ret = pm_generic_runtime_suspend(dev);
 
+	if (!od)
+		goto out;
+
 	if (!ret)
 		omap_device_idle(pdev);
 
+out:
 	return ret;
 }
 
@@ -814,9 +819,14 @@ static int _od_runtime_idle(struct device *dev)
 static int _od_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+
+	if (!od)
+		goto out;
 
 	omap_device_enable(pdev);
 
+out:
 	return pm_generic_runtime_resume(dev);
 }
 #endif
@@ -828,6 +838,9 @@ static int _od_suspend_noirq(struct device *dev)
 	struct omap_device *od = to_omap_device(pdev);
 	int ret;
 
+	if (!od)
+		return pm_generic_suspend_noirq(dev);
+
 	/* Don't attempt late suspend on a driver that is not bound */
 	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
 		return 0;
@@ -850,6 +863,9 @@ static int _od_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
 
+	if (!od)
+		goto out;
+
 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
 	    !pm_runtime_status_suspended(dev)) {
 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
@@ -858,6 +874,7 @@ static int _od_resume_noirq(struct device *dev)
 		pm_generic_runtime_resume(dev);
 	}
 
+out:
 	return pm_generic_resume_noirq(dev);
 }
 #else
-- 
1.8.1.rc1.5.g7e0651a
