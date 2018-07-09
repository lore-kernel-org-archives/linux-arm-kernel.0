From: robh@kernel.org (Rob Herring)
Date: Mon,  9 Jul 2018 09:41:48 -0600
Subject: [PATCH v4 1/6] driver core: allow stopping deferred probe after init
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Message-ID: <20180709154153.15742-2-robh@kernel.org>
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
(provided by firmware perhaps) with a stable kernel version. Deferred
probe issues can be difficult to debug especially if the console has
dependencies or userspace fails to boot to a shell.

There are also cases like IOMMUs where only built-in drivers are
supported, so deferring probe after initcalls is not needed. The IOMMU
subsystem implemented its own mechanism to handle this using OF_DECLARE
linker sections.

This commit adds makes ending deferred probe conditional on initcalls
being completed or a debug timeout. Subsystems or drivers may opt-in by
calling driver_deferred_probe_check_init_done() instead of
unconditionally returning -EPROBE_DEFER. They may use additional
information from DT or kernel's config to decide whether to continue to
defer probe or not.

The timeout mechanism is intended for debug purposes and WARNs loudly.
The remaining deferred probe pending list will also be dumped after the
timeout. Not that this timeout won't work for the console which needs
to be enabled before userspace starts. However, if the console's
dependencies are resolved, then the kernel log will be printed (as
opposed to no output).

Cc: Alexander Graf <agraf@suse.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
- Rebase on driver-core-next
- Only allow base 10 for timeout

v3:
- Merged with timeout patch.
- Clarify that deferred_probe_timeout is a debug option.
- Drop the 'optional' param. The only user was pinctrl, so it has to handle
  that functionality.
- Rename function to driver_deferred_probe_check_state
- Added kerneldoc for driver_deferred_probe_check_state
- Print a 1 line warning if stopping deferred probe after initcalls and a
  WARN on timeout.

 .../admin-guide/kernel-parameters.txt         |  9 +++
 drivers/base/dd.c                             | 59 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..e83ef4648ea4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -804,6 +804,15 @@
 			Defaults to the default architecture's huge page size
 			if not specified.

+	deferred_probe_timeout=
+			[KNL] Debugging option to set a timeout in seconds for
+			deferred probe to give up waiting on dependencies to
+			probe. Only specific dependencies (subsystems or
+			drivers) that have opted in will be ignored. A timeout of 0
+			will timeout at the end of initcalls. This option will also
+			dump out devices still on the deferred probe list after
+			retrying.
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e85705e84407..fb62f1be40d3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -55,6 +55,7 @@ static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 static struct dentry *deferred_devices;
+static bool initcalls_done;

 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -219,6 +220,51 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);

+static int deferred_probe_timeout = -1;
+static int __init deferred_probe_timeout_setup(char *str)
+{
+	deferred_probe_timeout = simple_strtol(str, NULL, 10);
+	return 1;
+}
+__setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
+
+/**
+ * driver_deferred_probe_check_state() - Check deferred probe state
+ * @dev: device to check
+ *
+ * Returns -ENODEV if init is done and all built-in drivers have had a chance
+ * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
+ * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ *
+ * Drivers or subsystems can opt-in to calling this function instead of directly
+ * returning -EPROBE_DEFER.
+ */
+int driver_deferred_probe_check_state(struct device *dev)
+{
+	if (initcalls_done) {
+		if (!deferred_probe_timeout) {
+			dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+			return -ETIMEDOUT;
+		}
+		dev_warn(dev, "ignoring dependency for device, assuming no driver");
+		return -ENODEV;
+	}
+	return -EPROBE_DEFER;
+}
+
+static void deferred_probe_timeout_work_func(struct work_struct *work)
+{
+	struct device_private *private, *p;
+
+	deferred_probe_timeout = 0;
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+
+	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
+		dev_info(private->device, "deferred probe pending");
+}
+static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -235,6 +281,19 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
+	initcalls_done = true;
+
+	/*
+	 * Trigger deferred probe again, this time we won't defer anything
+	 * that is optional
+	 */
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+
+	if (deferred_probe_timeout > 0) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+			deferred_probe_timeout * HZ);
+	}
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
diff --git a/include/linux/device.h b/include/linux/device.h
index 575c5a35ece5..d2acc78d279b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -339,6 +339,8 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
 				  int (*match)(struct device *dev, void *data));

+int driver_deferred_probe_check_state(struct device *dev);
+
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
--
2.17.1
