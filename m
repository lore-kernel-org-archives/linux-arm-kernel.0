From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Oct 2012 15:39:53 -0000
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and
 _od_resume_noirq
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Message-ID: <1350488043-5053-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

current implementation doesn't take care about
drivers which don't provide *_noirq methods and we
could fall into a situation where we would suspend/resume
devices even though they haven't asked for it.

One such case happened with the I2C driver which
was getting suspended during suspend_noirq() just
to be resume right after by any other device doing
an I2C transfer on its suspend method.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/omap_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7a7d1f2..935f416 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int ret;
 
+	if (!pm || !pm->suspend_noirq)
+		return 0;
+
 	/* Don't attempt late suspend on a driver that is not bound */
 	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
 		return 0;
@@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->resume_noirq)
+		return 0;
 
 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
 	    !pm_runtime_status_suspended(dev)) {
-- 
1.8.0.rc0
