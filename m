From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 10 Aug 2012 16:59:31 -0600 (MDT)
Subject: [PATCH v2 3/3] ARM: OMAP: omap_device: idle devices with no
 driver bound
In-Reply-To: <1344623953-26434-4-git-send-email-khilman@ti.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
 <1344623953-26434-4-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1208101658130.29149@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2012, Kevin Hilman wrote:

> Under some circumstances, drivers may leave an omap_device enabled due
> to driver programming errors, or due to a failure in the drivers
> probe method.
> 
> Using the recently added omap_device driver_status field, we can
> detect conditions where an omap_device is enabled but has no driver
> bound and then ensure that the device is properly idled until it can
> be probed again.
> 
> The goal of this feature is not only to detect and warn on these error
> conditions, but also to ensure that devices are properly put in
> low-power states so they do not prevent SoC-wide low-power states.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Here's the queued version of this one.


- Paul

From: Kevin Hilman <khilman@ti.com>
Date: Fri, 10 Aug 2012 11:39:13 -0700
Subject: [PATCH] ARM: OMAP: omap_device: idle devices with no driver bound

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
[paul at pwsan.com: fixed checkpatch issue; removed blank line at top of 
 file]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 150112e..1f8d9c9 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1,4 +1,3 @@
-
 /*
  * omap_device implementation
  *
@@ -1133,3 +1132,41 @@ static int __init omap_device_init(void)
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
+				 __func__);
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
1.7.10.4
