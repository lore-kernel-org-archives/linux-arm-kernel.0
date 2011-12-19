From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 19 Dec 2011 14:12:20 -0700 (MST)
Subject: [PATCH 3/6] OMAP: PM: register to the per-device PM QoS framework
In-Reply-To: <1323874304-5001-4-git-send-email-j-pihet@ti.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
 <1323874304-5001-4-git-send-email-j-pihet@ti.com>
Message-ID: <alpine.DEB.2.00.1112191405310.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 14 Dec 2011, jean.pihet at newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> Implement the devices wake-up latency constraints using the global
> device PM QoS notification handler which applies the constraints to the
> underlying layer by calling the corresponding function at hwmod level.
> 
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

I've modified this patch to work with omap_devices that contain multiple 
hwmods, and to move the code to the mach-omap2/omap_device.c code, which 
seems to make more sense.  Since the hwmod set-constraint and 
remove-constraint functions are now split, this code also must determine 
which one to call.

- Paul

From: Jean Pihet <j-pihet@ti.com>
Date: Sun, 18 Dec 2011 16:42:07 -0700
Subject: [PATCH] ARM: OMAP: omap_device: register to the per-device PM QoS
 framework

Implement the devices wake-up latency constraints using the global
device PM QoS notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul at pwsan.com: modified to work with omap_devices with large numbers of
 hwmods; moved code to mach-omap2/omap_device.c; added documentation; use
 notifier return codes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   74 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index e8d9869..b2c18b7 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -2,6 +2,7 @@
  * omap_device implementation
  *
  * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -88,6 +89,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -409,6 +411,67 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+/**
+ * _omap_device_pm_qos_handler - interface to the per-device PM QoS framework
+ * @nb: pointer to omap_device_pm_qos_nb (not used)
+ * @new_value: new maximum wakeup latency constraint for @req->dev (in ?s)
+ * @req: struct dev_pm_qos_request * passed by the Linux PM QoS code
+ *
+ * Called by the Linux core device PM QoS code to alter the maximum
+ * wakeup latency constraint on a device.  If the underlying device is
+ * an omap_device, then this code will pass the constraint on to the
+ * underlying hwmods.  Returns -EINVAL if this code can't handle the
+ * constraint for some reason, or passes along the return code from the
+ * hwmod wakeup latency constraint functions.
+ */
+static int _omap_device_pm_qos_handler(struct notifier_block *nb,
+				       unsigned long new_value,
+				       void *req)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct dev_pm_qos_request *dev_pm_qos_req = req;
+	int ret = NOTIFY_OK;
+	int r, i;
+
+	pr_debug("OMAP PM constraints: req at 0x%p, new_value=%lu\n",
+		 req, new_value);
+
+	/* Look for the platform device for the constraint target device */
+	pdev = to_platform_device(dev_pm_qos_req->dev);
+
+	/* Try to catch non platform devices */
+	if (pdev->name == NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	/* Find the associated omap_device for dev */
+	od = to_omap_device(pdev);
+	if (od == NULL) {
+		pr_err("%s: Error: no omap_device for device %s\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	pr_debug("OMAP PM constraints: req at 0x%p, dev=0x%p, new_value=%lu\n",
+		 req, dev_pm_qos_req->dev, new_value);
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		oh = od->hwmods[i];
+		if (new_value == PM_QOS_DEV_LAT_DEFAULT_VALUE)
+			r = omap_hwmod_remove_wakeuplat_constraint(oh, dev_pm_qos_req);
+		else
+			r = omap_hwmod_set_wakeuplat_constraint(oh, dev_pm_qos_req, new_value);
+
+		if (!r)
+			ret = NOTIFY_BAD;
+	}
+
+	return ret;
+}
 
 /* Public functions for use by core code */
 
@@ -1135,13 +1198,24 @@ struct device omap_device_parent = {
 	.parent         = &platform_bus,
 };
 
+static struct notifier_block omap_device_pm_qos_nb = {
+	.notifier_call	= _omap_device_pm_qos_handler,
+};
+
 static struct notifier_block platform_nb = {
 	.notifier_call = _omap_device_notifier_call,
 };
 
 static int __init omap_device_init(void)
 {
+	int ret;
+
 	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	ret = dev_pm_qos_add_global_notifier(&omap_device_pm_qos_nb);
+	if (!ret)
+		pr_err("omap_device: cannot add global notifier for dev PM QoS\n");
+
 	return device_register(&omap_device_parent);
 }
 core_initcall(omap_device_init);
-- 
1.7.7.3
