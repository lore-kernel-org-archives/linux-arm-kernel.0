From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 28 Jun 2017 15:56:36 +0530
Subject: [RFC 3/5] drivers: boot_constraint: Add boot_constraints_disable
 kernel parameter
In-Reply-To: <cover.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <f2fff03550bd14e1334de3faa1a79c0f8651b09d.1498642745.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Users must be given an option to discard any constraints set by
bootloaders. For example, consider that a constraint is set for the LCD
controller's supply and the LCD driver isn't loaded by the kernel. If
the user doesn't need to use the LCD device, then he shouldn't be forced
to honour the constraint.

We can also think about finer control of such constraints with help of
some sysfs files, but a kernel parameter is fine to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 drivers/base/boot_constraint.c                  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7737ab5d04b2..35e8a298bfc1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -426,6 +426,8 @@
 			embedded devices based on command line input.
 			See Documentation/block/cmdline-partition.txt
 
+	boot_constraints_disable = Do not set any boot constraints for devices.
+
 	boot_delay=	Milliseconds to delay each printk during boot.
 			Values larger than 10 seconds (10000) are changed to
 			no delay (0).
diff --git a/drivers/base/boot_constraint.c b/drivers/base/boot_constraint.c
index 495344e6405b..ab766d60191a 100644
--- a/drivers/base/boot_constraint.c
+++ b/drivers/base/boot_constraint.c
@@ -45,6 +45,17 @@ static DEFINE_MUTEX(constraint_devices_mutex);
 static int constraint_supply_add(struct constraint *constraint, void *data);
 static void constraint_supply_remove(struct constraint *constraint);
 
+static bool constraints_disabled;
+
+static int __init constraints_disable(char *str)
+{
+	constraints_disabled = true;
+	pr_debug("disabled\n");
+
+	return 0;
+}
+early_param("boot_constraints_disable", constraints_disable);
+
 
 /* Boot constraints core */
 
@@ -152,6 +163,9 @@ int boot_constraint_add(struct device *dev, enum boot_constraint_type type,
 	struct constraint *constraint;
 	int ret;
 
+	if (constraints_disabled)
+		return -ENODEV;
+
 	mutex_lock(&constraint_devices_mutex);
 
 	/* Find or add the cdev type first */
@@ -202,6 +216,9 @@ void boot_constraints_remove(struct device *dev)
 	struct constraint_dev *cdev;
 	struct constraint *constraint, *temp;
 
+	if (constraints_disabled)
+		return;
+
 	mutex_lock(&constraint_devices_mutex);
 
 	cdev = constraint_device_find(dev);
-- 
2.13.0.71.gd7076ec9c9cb
