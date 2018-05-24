From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 12:50:18 -0500
Subject: [PATCH v2 2/8] driver core: add a deferred probe timeout
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Message-ID: <20180524175024.19874-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deferring probe can wait forever on dependencies that may never appear
for a variety of reasons. This can be difficult to debug especially if
the console has dependencies or userspace fails to boot to a shell. Add
a timeout to retry probing without possibly optional dependencies and to
dump out the deferred probe pending list after retrying.

This mechanism is intended for debug purposes. It won't work for the
console which needs to be enabled before userspace starts. However, if
the console's dependencies are resolved, then the kernel log will be
printed (as opposed to no output).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++
 drivers/base/dd.c                             | 28 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..dd3f40b34a24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -809,6 +809,13 @@
 			Defaults to the default architecture's huge page size
 			if not specified.
 
+	deferred_probe_timeout=
+			[KNL] Set a timeout in seconds for deferred probe to
+			give up waiting on dependencies to probe. Only specific
+			dependencies (subsystems or drivers) that have opted in
+			will be ignored. This option also dumps out devices
+			still on the deferred probe list after retrying.
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d6034718da6f..4133b240c7e4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -226,9 +226,17 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+static int deferred_probe_timeout = -1;
+static int __init deferred_probe_timeout_setup(char *str)
+{
+	deferred_probe_timeout = simple_strtol(str, NULL, 0);
+	return 1;
+}
+__setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
+
 int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
 {
-	if (optional && initcalls_done) {
+	if ((optional || !deferred_probe_timeout) && initcalls_done) {
 		dev_WARN(dev, "ignoring dependency for device, assuming no driver");
 		return -ENODEV;
 	}
@@ -236,6 +244,19 @@ int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
 	return -EPROBE_DEFER;
 }
 
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
@@ -257,6 +278,11 @@ static int deferred_probe_initcall(void)
 	 */
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
+
+	if (deferred_probe_timeout > 0) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+			deferred_probe_timeout * HZ);
+	}
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
-- 
2.17.0
