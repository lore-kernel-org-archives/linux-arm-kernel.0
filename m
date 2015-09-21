From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:03:00 +0200
Subject: [PATCH v6 20/22] driver core: Allow deferring probes until late init
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-21-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a field to struct device that instructs the device-driver core to
defer the probe of this device until the late_initcall level.

By letting all built-in drivers to register before starting to probe, we
can avoid any deferred probes by probing dependencies on demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

Changes in v4:
- Add Kconfig DELAY_DEVICE_PROBES to allow disabling delayed probing in
  machines with initcalls that depend on devices probing at a given time.

 drivers/base/Kconfig   | 18 ++++++++++++++++++
 drivers/base/dd.c      |  7 +++++++
 include/linux/device.h |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 98504ec99c7d..44b5d33b1f49 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -324,4 +324,22 @@ config CMA_ALIGNMENT
 
 endif
 
+config DELAY_DEVICE_PROBES
+	bool "Allow delaying the probe of some devices"
+	default y
+	help
+	  Devices can be matched to a driver and probed from the moment they
+	  are registered, but early during boot their probes are likely to be
+	  deferred because some dependency isn't available yet because most
+	  drivers haven't been registered yet.
+
+	  Enabling this option allows the device registration code to delay the
+	  probing of a specific device until device_initcall_sync, when all
+	  built-in drivers have been registered already.
+
+	  In some platforms there may be implicit assumptions about when some
+	  devices are probed, so enabling this option could cause problems there.
+
+	  If unsure, say Y here.
+
 endmenu
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 7dc04ee81c8b..269ea76c1a4f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -417,6 +417,13 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENODEV;
 
+#if IS_ENABLED(CONFIG_DELAY_DEVICE_PROBES)
+	if (!driver_deferred_probe_enable && dev->probe_late) {
+		driver_deferred_probe_add(dev);
+		return 0;
+	}
+#endif
+
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 8e7b806f0744..e64f4c7e243d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -744,6 +744,7 @@ struct device_dma_parameters {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
+ * @probe_late:	If set, device will be probed in the late initcall level.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -828,6 +829,7 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
+	bool			probe_late:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
-- 
2.4.3
