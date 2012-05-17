From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:11 +0100
Subject: [PATCH 06/18] mfd: ab8500: Remove confusing ab8500-i2c file and merge
 into ab8500-core
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ab8500-i2c is used as core code to register the ab8500 device.
After allocating ab8500 memory, it immediately calls into
ab8500-core where the real initialisation takes place. This
patch moves all core registration and memory allocation into
the true ab8500-core file and removes ab8500-i2c completely.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 drivers/mfd/Makefile               |    5 +-
 drivers/mfd/ab8500-core.c          |  105 +++++++++++++++++++++--
 drivers/mfd/ab8500-i2c.c           |  160 ------------------------------------
 4 files changed, 103 insertions(+), 169 deletions(-)
 delete mode 100644 drivers/mfd/ab8500-i2c.c

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 433045d..46df945 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -205,7 +205,7 @@ static struct resource ab8500_resources[] = {
 };
 
 struct platform_device ab8500_device = {
-	.name = "ab8500-i2c",
+	.name = "ab8500-core",
 	.id = 0,
 	.dev = {
 		.platform_data = &ab8500_platdata,
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index acc888d..15b0ba6 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -90,12 +90,11 @@ obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
 obj-$(CONFIG_ABX500_CORE)	+= abx500-core.o
 obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
 obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
-obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_AB8500_DEBUG)	+= ab8500-debugfs.o
 obj-$(CONFIG_AB8500_GPADC)	+= ab8500-gpadc.o
 obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
-# ab8500-i2c need to come after db8500-prcmu (which provides the channel)
-obj-$(CONFIG_AB8500_I2C_CORE)	+= ab8500-i2c.o
+# ab8500-core needs to come after db8500-prcmu (which provides the channel)
+obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
 obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 08850f0..0e2df71 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
+#include <linux/mfd/dbx500-prcmu.h>
 #include <linux/regulator/ab8500.h>
 
 /*
@@ -128,6 +129,41 @@ static const char ab8500_version_str[][7] = {
 	[AB8500_VERSION_AB8540] = "AB8540",
 };
 
+static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
+{
+	int ret;
+
+	ret = prcmu_abb_write((u8)(addr >> 8), (u8)(addr & 0xFF), &data, 1);
+	if (ret < 0)
+		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
+	return ret;
+}
+
+static int ab8500_i2c_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
+	u8 data)
+{
+	int ret;
+
+	ret = prcmu_abb_write_masked((u8)(addr >> 8), (u8)(addr & 0xFF), &data,
+		&mask, 1);
+	if (ret < 0)
+		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
+	return ret;
+}
+
+static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
+{
+	int ret;
+	u8 data;
+
+	ret = prcmu_abb_read((u8)(addr >> 8), (u8)(addr & 0xFF), &data, 1);
+	if (ret < 0) {
+		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
+		return ret;
+	}
+	return (int)data;
+}
+
 static int ab8500_get_chip_id(struct device *dev)
 {
 	struct ab8500 *ab8500;
@@ -1076,27 +1112,51 @@ static struct attribute_group ab9540_attr_group = {
 	.attrs	= ab9540_sysfs_entries,
 };
 
-int __devinit ab8500_init(struct ab8500 *ab8500, enum ab8500_version version)
+static int __devinit ab8500_probe(struct platform_device *pdev)
 {
-	struct ab8500_platform_data *plat = dev_get_platdata(ab8500->dev);
+	struct ab8500_platform_data *plat = dev_get_platdata(&pdev->dev);
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	enum ab8500_version version = platid->driver_data;
+	struct ab8500 *ab8500;
+	struct resource *resource;
 	int ret;
 	int i;
 	u8 value;
 
+	ab8500 = kzalloc(sizeof *ab8500, GFP_KERNEL);
+	if (!ab8500)
+		return -ENOMEM;
+
 	if (plat)
 		ab8500->irq_base = plat->irq_base;
 
+	ab8500->dev = &pdev->dev;
+
+	resource = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!resource) {
+		ret = -ENODEV;
+		goto out_free_ab8500;
+	}
+
+	ab8500->irq = resource->start;
+
+	ab8500->read = ab8500_i2c_read;
+	ab8500->write = ab8500_i2c_write;
+	ab8500->write_masked = ab8500_i2c_write_masked;
+
 	mutex_init(&ab8500->lock);
 	mutex_init(&ab8500->irq_lock);
 	atomic_set(&ab8500->transfer_ongoing, 0);
 
+	platform_set_drvdata(pdev, ab8500);
+
 	if (version != AB8500_VERSION_UNDEFINED)
 		ab8500->version = version;
 	else {
 		ret = get_register_interruptible(ab8500, AB8500_MISC,
 			AB8500_IC_NAME_REG, &value);
 		if (ret < 0)
-			return ret;
+			goto out_free_ab8500;
 
 		ab8500->version = value;
 	}
@@ -1104,7 +1164,7 @@ int __devinit ab8500_init(struct ab8500 *ab8500, enum ab8500_version version)
 	ret = get_register_interruptible(ab8500, AB8500_MISC,
 		AB8500_REV_REG, &value);
 	if (ret < 0)
-		return ret;
+		goto out_free_ab8500;
 
 	ab8500->chip_id = value;
 
@@ -1240,12 +1300,16 @@ out_freeoldmask:
 	kfree(ab8500->oldmask);
 out_freemask:
 	kfree(ab8500->mask);
+out_free_ab8500:
+	kfree(ab8500);
 
 	return ret;
 }
 
-int __devexit ab8500_exit(struct ab8500 *ab8500)
+static int __devexit ab8500_remove(struct platform_device *pdev)
 {
+	struct ab8500 *ab8500 = platform_get_drvdata(pdev);
+
 	if (is_ab9540(ab8500))
 		sysfs_remove_group(&ab8500->dev->kobj, &ab9540_attr_group);
 	else
@@ -1257,10 +1321,41 @@ int __devexit ab8500_exit(struct ab8500 *ab8500)
 	}
 	kfree(ab8500->oldmask);
 	kfree(ab8500->mask);
+	kfree(ab8500);
 
 	return 0;
 }
 
+static const struct platform_device_id ab8500_id[] = {
+	{ "ab8500-core", AB8500_VERSION_AB8500 },
+	{ "ab8505-i2c", AB8500_VERSION_AB8505 },
+	{ "ab9540-i2c", AB8500_VERSION_AB9540 },
+	{ "ab8540-i2c", AB8500_VERSION_AB8540 },
+	{ }
+};
+
+static struct platform_driver ab8500_core_driver = {
+	.driver = {
+		.name = "ab8500-core",
+		.owner = THIS_MODULE,
+	},
+	.probe	= ab8500_probe,
+	.remove	= __devexit_p(ab8500_remove),
+	.id_table = ab8500_id,
+};
+
+static int __init ab8500_core_init(void)
+{
+	return platform_driver_register(&ab8500_core_driver);
+}
+
+static void __exit ab8500_core_exit(void)
+{
+	platform_driver_unregister(&ab8500_core_driver);
+}
+arch_initcall(ab8500_core_init);
+module_exit(ab8500_core_exit);
+
 MODULE_AUTHOR("Mattias Wallin, Srinidhi Kasagar, Rabin Vincent");
 MODULE_DESCRIPTION("AB8500 MFD core");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/ab8500-i2c.c b/drivers/mfd/ab8500-i2c.c
deleted file mode 100644
index 89b31a3..0000000
--- a/drivers/mfd/ab8500-i2c.c
+++ /dev/null
@@ -1,160 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson.
- * License Terms: GNU General Public License v2
- * This file was based on drivers/mfd/ab8500-spi.c
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/dbx500-prcmu.h>
-
-static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
-{
-	int ret;
-
-	ret = prcmu_abb_write((u8)(addr >> 8), (u8)(addr & 0xFF), &data, 1);
-	if (ret < 0)
-		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
-	return ret;
-}
-
-static int ab8500_i2c_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
-	u8 data)
-{
-	int ret;
-
-	ret = prcmu_abb_write_masked((u8)(addr >> 8), (u8)(addr & 0xFF), &data,
-		&mask, 1);
-	if (ret < 0)
-		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
-	return ret;
-}
-
-static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
-{
-	int ret;
-	u8 data;
-
-	ret = prcmu_abb_read((u8)(addr >> 8), (u8)(addr & 0xFF), &data, 1);
-	if (ret < 0) {
-		dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
-		return ret;
-	}
-	return (int)data;
-}
-
-static int __devinit ab8500_i2c_probe(struct platform_device *plf)
-{
-	const struct platform_device_id *platid = platform_get_device_id(plf);
-	struct ab8500 *ab8500;
-	struct resource *resource;
-	int ret;
-
-	ab8500 = kzalloc(sizeof *ab8500, GFP_KERNEL);
-	if (!ab8500)
-		return -ENOMEM;
-
-	ab8500->dev = &plf->dev;
-
-	resource = platform_get_resource(plf, IORESOURCE_IRQ, 0);
-	if (!resource) {
-		kfree(ab8500);
-		return -ENODEV;
-	}
-
-	ab8500->irq = resource->start;
-
-	ab8500->read = ab8500_i2c_read;
-	ab8500->write = ab8500_i2c_write;
-	ab8500->write_masked = ab8500_i2c_write_masked;
-
-	platform_set_drvdata(plf, ab8500);
-
-	ret = ab8500_init(ab8500, platid->driver_data);
-	if (ret)
-		kfree(ab8500);
-
-
-	return ret;
-}
-
-static int __devexit ab8500_i2c_remove(struct platform_device *plf)
-{
-	struct ab8500 *ab8500 = platform_get_drvdata(plf);
-
-	ab8500_exit(ab8500);
-	kfree(ab8500);
-
-	return 0;
-}
-
-static const struct platform_device_id ab8500_id[] = {
-	{ "ab8500-i2c", AB8500_VERSION_AB8500 },
-	{ "ab8505-i2c", AB8500_VERSION_AB8505 },
-	{ "ab9540-i2c", AB8500_VERSION_AB9540 },
-	{ "ab8540-i2c", AB8500_VERSION_AB8540 },
-	{ }
-};
-
-#ifdef CONFIG_PM
-static int ab8500_i2c_suspend(struct device *dev)
-{
-	struct ab8500 *ab = dev_get_drvdata(dev);
-
-	disable_irq(ab->irq);
-	enable_irq_wake(ab->irq);
-
-	return 0;
-}
-
-static int ab8500_i2c_resume(struct device *dev)
-{
-	struct ab8500 *ab = dev_get_drvdata(dev);
-
-	disable_irq_wake(ab->irq);
-	enable_irq(ab->irq);
-
-	return 0;
-}
-
-static const struct dev_pm_ops ab8500_i2c_pm_ops = {
-	.suspend	= ab8500_i2c_suspend,
-	.resume		= ab8500_i2c_resume,
-};
-
-#define AB8500_I2C_PM_OPS	(&ab8500_i2c_pm_ops)
-#else
-#define AB8500_I2C_PM_OPS	NULL
-#endif
-
-static struct platform_driver ab8500_i2c_driver = {
-	.driver = {
-		.name = "ab8500-i2c",
-		.owner = THIS_MODULE,
-		.pm	= AB8500_I2C_PM_OPS,
-	},
-	.probe	= ab8500_i2c_probe,
-	.remove	= __devexit_p(ab8500_i2c_remove),
-	.id_table = ab8500_id,
-};
-
-static int __init ab8500_i2c_init(void)
-{
-	return platform_driver_register(&ab8500_i2c_driver);
-}
-
-static void __exit ab8500_i2c_exit(void)
-{
-	platform_driver_unregister(&ab8500_i2c_driver);
-}
-arch_initcall(ab8500_i2c_init);
-module_exit(ab8500_i2c_exit);
-
-MODULE_AUTHOR("Mattias WALLIN <mattias.wallin@stericsson.com");
-MODULE_DESCRIPTION("AB8500 Core access via PRCMU I2C");
-MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
