From: khilman@ti.com (Kevin Hilman)
Date: Fri, 10 Aug 2012 11:39:13 -0700
Subject: [PATCH v2 3/3] ARM: OMAP: omap_device: idle devices with no driver
 bound
In-Reply-To: <1344623953-26434-1-git-send-email-khilman@ti.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
Message-ID: <1344623953-26434-4-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under some circumstances, drivers may leave an omap_device enabled due
to driver programming errors, or due to a failure in the drivers
probe method.

Using the recently added omap_device driver_status field, we can
detect conditions where an omap_device is enabled but has no driver
bound and then ensure that the device is properly idled until it can
be probed again.

The goal of this feature is not only to detect and warn on these error
conditions, but also to ensure that devices are properly put in
low-power states so they do not prevent SoC-wide low-power states.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 150112e..0693260 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1133,3 +1133,41 @@ static int __init omap_device_init(void)
 	return 0;
 }
 core_initcall(omap_device_init);
+
+/**
+ * omap_device_late_idle - idle devices without drivers
+ * @dev: struct device * associated with omap_device
+ * @data: unused
+ *
+ * Check the driver bound status of this device, and idle it
+ * if there is no driver attached.
+ */
+static int __init omap_device_late_idle(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od = to_omap_device(pdev);
+
+	if (!od)
+		return 0;
+
+	/*
+	 * If omap_device state is enabled, but has no driver bound,
+	 * idle it.
+	 */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
+		if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
+			dev_warn(dev, "%s: enabled but no driver.  Idling\n",
+				__func__);
+			omap_device_idle(pdev);
+		}
+	}
+
+	return 0;
+}
+
+static int __init omap_device_late_init(void)
+{
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
+	return 0;
+}
+late_initcall(omap_device_late_init);
-- 
1.7.9.2
