From: khilman@ti.com (Kevin Hilman)
Date: Fri, 10 Aug 2012 11:39:12 -0700
Subject: [PATCH v2 2/3] ARM: OMAP: omap_device: don't attempt late suspend if
 no driver bound
In-Reply-To: <1344623953-26434-1-git-send-email-khilman@ti.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
Message-ID: <1344623953-26434-3-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the omap_device PM domain layer uses the late suspend and
early resume callbacks to ensure devices are in their low power
states.

However, this is attempted even in cases where a driver probe has
failed.  If a driver's ->probe() method fails, the driver is likely in
a state where it is not expecting its runtime PM callbacks to be
called, yet currently the omap_device PM domain code attempts to call
the drivers callbacks.

To fix, use the omap_device driver_status field to check whether a
driver is bound to the omap_device before attempting to trigger driver
callbacks.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 1d1b5ff..150112e 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -756,6 +756,10 @@ static int _od_suspend_noirq(struct device *dev)
 	struct omap_device *od = to_omap_device(pdev);
 	int ret;
 
+	/* Don't attempt late suspend on a driver that is not bound */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
+		return 0;
+
 	ret = pm_generic_suspend_noirq(dev);
 
 	if (!ret && !pm_runtime_status_suspended(dev)) {
-- 
1.7.9.2
