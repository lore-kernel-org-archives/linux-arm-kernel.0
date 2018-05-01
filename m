From: robh@kernel.org (Rob Herring)
Date: Tue,  1 May 2018 16:31:14 -0500
Subject: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180501213114.20183-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deferred probe will currently wait forever on dependent devices to probe,
but sometimes a driver will never exist. It's also not always critical for
a driver to exist. Platforms can rely on default configuration from the
bootloader or reset defaults for things such as pinctrl and power domains.
This is often the case with initial platform support until various drivers
get enabled. There's at least 2 scenarios where deferred probe can render
a platform broken. Both involve using a DT which has more devices and
dependencies than the kernel supports. The 1st case is a driver may be
disabled in the kernel config. The 2nd case is the kernel version may
simply not have the dependent driver. This can happen if using a newer DT
(provided by firmware perhaps) with a stable kernel version.

Unfortunately, this change breaks with modules as we have no way of
knowing when modules are done loading. One possibility is to make this
opt in or out based on compatible strings rather than at a subsystem level.
Ideally this information could be extracted automatically somehow. OTOH,
maybe the lists are pretty small. There's only a handful of subsystems
that can be optional, and then only so many drivers in those that can be
modules (at least for pinctrl, many drivers are built-in only).

Cc: Alexander Graf <agraf@suse.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
This patch came out of a discussion on the ARM boot-architecture 
list[1] about DT forwards and backwards compatibility issues. There are 
issues with newer DTs breaking on older, stable kernels. Some of these 
are difficult to solve, but cases of optional devices not having 
kernel support should be solvable.

I tested this on a RPi3 B with the pinctrl driver forced off. With this 
change, the MMC/SD and UART drivers can function without the pinctrl 
driver.

Rob

[1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html

 drivers/base/dd.c            | 16 ++++++++++++++++
 drivers/pinctrl/devicetree.c |  2 +-
 include/linux/device.h       |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c9f54089429b..5848808b9d7a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -226,6 +226,15 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+
+int driver_deferred_probe_optional(void)
+{
+	if (initcalls_done)
+		return -ENODEV;
+
+	return -EPROBE_DEFER;
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -240,6 +249,13 @@ static int deferred_probe_initcall(void)
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
 	initcalls_done = true;
+
+	/*
+	 * Trigger deferred probe again, this time we won't defer anything
+	 * that is optional
+	 */
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index b601039d6c69..096e52a5c506 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -120,7 +120,7 @@ static int dt_to_map_one_config(struct pinctrl *p,
 				np_config);
 			of_node_put(np_pctldev);
 			/* OK let's just assume this will appear later then */
-			return -EPROBE_DEFER;
+			return driver_deferred_probe_optional();
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (pctldev && (np_pctldev == p->dev->of_node))
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99e1f25..8de920442bc1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -332,6 +332,8 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
 				  int (*match)(struct device *dev, void *data));
 
+int driver_deferred_probe_optional(void);
+
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
-- 
2.17.0
