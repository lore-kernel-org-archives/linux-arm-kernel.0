From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  1 Aug 2017 14:53:43 +0530
Subject: [PATCH V3 2/8] drivers: boot_constraint: Add boot_constraints_disable
 kernel parameter
In-Reply-To: <cover.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <4bec0c3e58f76e06e5305c5ddbab859e2a87935e.1501578037.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Users must be given an option to discard any constraints set by
bootloaders. For example, consider that a constraint is set for the LCD
controller's supply and the LCD driver isn't loaded by the kernel. If
the user doesn't need to use the LCD device, then he shouldn't be forced
to honour the constraint.

We can also think about finer control of such constraints with help of
some sysfs files, but a kernel parameter is fine to begin with.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/base/boot_constraints/core.c            | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9c171ce4190..0706d1b6004d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -426,6 +426,9 @@
 			embedded devices based on command line input.
 			See Documentation/block/cmdline-partition.txt
 
+	boot_constraints_disable
+			Do not set any boot constraints for devices.
+
 	boot_delay=	Milliseconds to delay each printk during boot.
 			Values larger than 10 seconds (10000) are changed to
 			no delay (0).
diff --git a/drivers/base/boot_constraints/core.c b/drivers/base/boot_constraints/core.c
index 366a05d6d9ba..e0c33b2b216f 100644
--- a/drivers/base/boot_constraints/core.c
+++ b/drivers/base/boot_constraints/core.c
@@ -24,6 +24,17 @@
 static LIST_HEAD(constraint_devices);
 static DEFINE_MUTEX(constraint_devices_mutex);
 
+static bool boot_constraints_disabled;
+
+static int __init constraints_disable(char *str)
+{
+	boot_constraints_disabled = true;
+	pr_debug("disabled\n");
+
+	return 0;
+}
+early_param("boot_constraints_disable", constraints_disable);
+
 /* Boot constraints core */
 
 static struct constraint_dev *constraint_device_find(struct device *dev)
@@ -126,6 +137,9 @@ int dev_boot_constraint_add(struct device *dev,
 	struct constraint *constraint;
 	int ret;
 
+	if (boot_constraints_disabled)
+		return -ENODEV;
+
 	mutex_lock(&constraint_devices_mutex);
 
 	/* Find or add the cdev type first */
@@ -184,6 +198,9 @@ void dev_boot_constraints_remove(struct device *dev)
 	struct constraint_dev *cdev;
 	struct constraint *constraint, *temp;
 
+	if (boot_constraints_disabled)
+		return;
+
 	mutex_lock(&constraint_devices_mutex);
 
 	cdev = constraint_device_find(dev);
-- 
2.13.0.71.gd7076ec9c9cb
