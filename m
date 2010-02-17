From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Wed, 17 Feb 2010 16:05:55 +0200
Subject: [PATCH] ARM: oprofile: convert from sysdev to platform device
Message-ID: <1266415555-16711-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oprofile does not work with PM, because sysdev_suspend() is done with
interrupts disabled and oprofile needs a mutex. Implementing oprofile
as a platform device solves this problem.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/oprofile/common.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 3fcd752..af0ffda 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -11,7 +11,8 @@
 #include <linux/oprofile.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/sysdev.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/mutex.h>
 
 #include "op_counter.h"
@@ -77,7 +78,7 @@ static void op_arm_stop(void)
 }
 
 #ifdef CONFIG_PM
-static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
+static int op_arm_suspend(struct platform_device *dev, pm_message_t state)
 {
 	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled)
@@ -86,7 +87,7 @@ static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int op_arm_resume(struct sys_device *dev)
+static int op_arm_resume(struct platform_device *dev)
 {
 	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled && op_arm_model->start())
@@ -95,34 +96,41 @@ static int op_arm_resume(struct sys_device *dev)
 	return 0;
 }
 
-static struct sysdev_class oprofile_sysclass = {
-	.name		= "oprofile",
+static struct platform_driver oprofile_driver = {
+	.driver         = {
+		.name   = "arm-oprofile",
+	},
 	.resume		= op_arm_resume,
 	.suspend	= op_arm_suspend,
 };
 
-static struct sys_device device_oprofile = {
-	.id		= 0,
-	.cls		= &oprofile_sysclass,
-};
+static struct platform_device *oprofile_pdev;
 
 static int __init init_driverfs(void)
 {
 	int ret;
 
-	if (!(ret = sysdev_class_register(&oprofile_sysclass)))
-		ret = sysdev_register(&device_oprofile);
+	ret = platform_driver_register(&oprofile_driver);
+	if (ret)
+		return ret;
+
+	oprofile_pdev =
+		platform_device_register_simple("arm-oprofile", 0, NULL, 0);
+	if (IS_ERR(oprofile_pdev)) {
+		ret = PTR_ERR(oprofile_pdev);
+		platform_driver_unregister(&oprofile_driver);
+	}
 
 	return ret;
 }
 
 static void  exit_driverfs(void)
 {
-	sysdev_unregister(&device_oprofile);
-	sysdev_class_unregister(&oprofile_sysclass);
+	platform_device_unregister(oprofile_pdev);
+	platform_driver_unregister(&oprofile_driver);
 }
 #else
-#define init_driverfs()	do { } while (0)
+static int __init init_driverfs(void) { return 0; }
 #define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
@@ -159,8 +167,12 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 		if (!counter_config)
 			return -ENOMEM;
 
+		ret = init_driverfs();
+		if (ret) {
+			kfree(counter_config);
+			return ret;
+		}
 		op_arm_model = spec;
-		init_driverfs();
 		ops->create_files = op_arm_create_files;
 		ops->setup = op_arm_setup;
 		ops->shutdown = op_arm_stop;
@@ -178,6 +190,6 @@ void oprofile_arch_exit(void)
 	if (op_arm_model) {
 		exit_driverfs();
 		op_arm_model = NULL;
+		kfree(counter_config);
 	}
-	kfree(counter_config);
 }
-- 
1.5.6.5
