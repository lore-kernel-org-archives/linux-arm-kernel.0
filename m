From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Oct 2014 10:32:51 +0000
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1413628372-2809-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch brings readonly support for the On Chip OTP cells in the i.MX23
and i.MX28 processor. The driver uses files (one for each cell) in sysfs
as interface.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/misc/Kconfig     |   13 ++
 drivers/misc/Makefile    |    1 +
 drivers/misc/fsl_ocotp.c |  332 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/misc/fsl_ocotp.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b841180..7455efa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,6 +515,19 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config FSL_OCOTP
+        tristate "Freescale MXS On-Chip OTP Memory Support"
+        depends on ARCH_MXS && SYSFS
+        help
+          If you say Y here, you will get support for a readonly
+	  SysFS interface for the One Time Programmable memory pages that
+	  are stored on the Freescale i.MX23/i.MX28 processor.
+
+          To compile this driver as a module, choose M here: the module
+          will be called fsl_ocotp.
+
+          If unsure, it is safe to say N.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5497d02..301cd15 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,3 +55,4 @@ obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
+obj-$(CONFIG_FSL_OCOTP)           += fsl_ocotp.o
diff --git a/drivers/misc/fsl_ocotp.c b/drivers/misc/fsl_ocotp.c
new file mode 100644
index 0000000..ddb4e9b
--- /dev/null
+++ b/drivers/misc/fsl_ocotp.c
@@ -0,0 +1,332 @@
+/*
+ * Freescale On-Chip OTP driver
+ *
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Huang Shijie <b32955@freescale.com>
+ *
+ * Christoph G. Baumann <cgb@debian.org>
+ * Stefan Wahren <stefan.wahren@i2se.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/fcntl.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+/* OCOTP registers and bits */
+#define HW_OCOTP_CTRL_SET	(0x00000004)
+#define HW_OCOTP_CTRL_CLR	(0x00000008)
+
+#define BM_OCOTP_CTRL_RD_BANK_OPEN	0x00001000
+#define BM_OCOTP_CTRL_ERROR		0x00000200
+#define BM_OCOTP_CTRL_BUSY		0x00000100
+
+struct fsl_ocotp {
+	struct attribute_group group;
+	struct mutex lock;
+	void __iomem *base_addr;
+	u32 data_offset;
+};
+
+static ssize_t fsl_ocotp_attr_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsl_ocotp *otp = platform_get_drvdata(pdev);
+	int timeout = 0x400;
+	int index = 0;
+	u32 value = 0;
+	u32 offset;
+
+	if (otp == NULL) {
+		dev_err(dev, "%s: no drvdata\n", __func__);
+		return 0;
+	}
+
+	while (otp->group.attrs[index]) {
+		if (strcmp(attr->attr.name, otp->group.attrs[index]->name) == 0)
+			break;
+
+		index++;
+	}
+
+	if (otp->group.attrs[index] == NULL) {
+		dev_err(dev, "%s: attr not found\n", __func__);
+		return 0;
+	}
+
+	mutex_lock(&otp->lock);
+
+	/* try to clear ERROR bit */
+	writel(BM_OCOTP_CTRL_ERROR, otp->base_addr + HW_OCOTP_CTRL_CLR);
+
+	/* check both BUSY and ERROR cleared */
+	while ((readl(otp->base_addr) &
+	       (BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
+		cpu_relax();
+
+	if (unlikely(!timeout)) {
+		dev_err(dev, "%s: OCTOP busy or error\n", __func__);
+		goto error_unlock;
+	}
+
+	/* open OCOTP banks for read */
+	writel(BM_OCOTP_CTRL_RD_BANK_OPEN, otp->base_addr + HW_OCOTP_CTRL_SET);
+
+	/* approximately wait 32 hclk cycles */
+	udelay(1);
+
+	/* poll BUSY bit becoming cleared */
+	timeout = 0x400;
+	while ((readl(otp->base_addr) & BM_OCOTP_CTRL_BUSY) && --timeout)
+		cpu_relax();
+
+	if (timeout) {
+		offset = otp->data_offset + index * 0x10;
+		value = readl(otp->base_addr + offset);
+	}
+
+	/* close banks for power saving */
+	writel(BM_OCOTP_CTRL_RD_BANK_OPEN, otp->base_addr + HW_OCOTP_CTRL_CLR);
+
+	if (unlikely(!timeout)) {
+		dev_err(dev, "%s: OCTOP timeout\n", __func__);
+		goto error_unlock;
+	}
+
+	mutex_unlock(&otp->lock);
+	return sprintf(buf, "0x%x\n", value);
+
+error_unlock:
+	mutex_unlock(&otp->lock);
+	return 0;
+}
+
+static DEVICE_ATTR(HW_OCOTP_CUST0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CUST1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CUST2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CUST3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CRYPTO0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CRYPTO1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CRYPTO2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CRYPTO3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+
+static DEVICE_ATTR(HW_OCOTP_HWCAP0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_HWCAP1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_HWCAP2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_HWCAP3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_HWCAP4, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_HWCAP5, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SWCAP, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_CUSTCAP, S_IRUSR, fsl_ocotp_attr_show, NULL);
+
+static DEVICE_ATTR(HW_OCOTP_LOCK, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_OPS0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_OPS1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_OPS2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_OPS3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_UN0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_UN1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_UN2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+
+static DEVICE_ATTR(HW_OCOTP_ROM0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM4, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM5, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM6, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_ROM7, S_IRUSR, fsl_ocotp_attr_show, NULL);
+
+static DEVICE_ATTR(HW_OCOTP_SRK0, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK1, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK2, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK3, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK4, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK5, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK6, S_IRUSR, fsl_ocotp_attr_show, NULL);
+static DEVICE_ATTR(HW_OCOTP_SRK7, S_IRUSR, fsl_ocotp_attr_show, NULL);
+
+static struct attribute *imx23_ocotp_attributes[] = {
+	&dev_attr_HW_OCOTP_CUST0.attr,
+	&dev_attr_HW_OCOTP_CUST1.attr,
+	&dev_attr_HW_OCOTP_CUST2.attr,
+	&dev_attr_HW_OCOTP_CUST3.attr,
+	&dev_attr_HW_OCOTP_CRYPTO0.attr,
+	&dev_attr_HW_OCOTP_CRYPTO1.attr,
+	&dev_attr_HW_OCOTP_CRYPTO2.attr,
+	&dev_attr_HW_OCOTP_CRYPTO3.attr,
+	&dev_attr_HW_OCOTP_HWCAP0.attr,
+	&dev_attr_HW_OCOTP_HWCAP1.attr,
+	&dev_attr_HW_OCOTP_HWCAP2.attr,
+	&dev_attr_HW_OCOTP_HWCAP3.attr,
+	&dev_attr_HW_OCOTP_HWCAP4.attr,
+	&dev_attr_HW_OCOTP_HWCAP5.attr,
+	&dev_attr_HW_OCOTP_SWCAP.attr,
+	&dev_attr_HW_OCOTP_CUSTCAP.attr,
+	&dev_attr_HW_OCOTP_LOCK.attr,
+	&dev_attr_HW_OCOTP_OPS0.attr,
+	&dev_attr_HW_OCOTP_OPS1.attr,
+	&dev_attr_HW_OCOTP_OPS2.attr,
+	&dev_attr_HW_OCOTP_OPS3.attr,
+	&dev_attr_HW_OCOTP_UN0.attr,
+	&dev_attr_HW_OCOTP_UN1.attr,
+	&dev_attr_HW_OCOTP_UN2.attr,
+	&dev_attr_HW_OCOTP_ROM0.attr,
+	&dev_attr_HW_OCOTP_ROM1.attr,
+	&dev_attr_HW_OCOTP_ROM2.attr,
+	&dev_attr_HW_OCOTP_ROM3.attr,
+	&dev_attr_HW_OCOTP_ROM4.attr,
+	&dev_attr_HW_OCOTP_ROM5.attr,
+	&dev_attr_HW_OCOTP_ROM6.attr,
+	&dev_attr_HW_OCOTP_ROM7.attr,
+	NULL
+};
+
+static struct attribute *imx28_ocotp_attributes[] = {
+	&dev_attr_HW_OCOTP_CUST0.attr,
+	&dev_attr_HW_OCOTP_CUST1.attr,
+	&dev_attr_HW_OCOTP_CUST2.attr,
+	&dev_attr_HW_OCOTP_CUST3.attr,
+	&dev_attr_HW_OCOTP_CRYPTO0.attr,
+	&dev_attr_HW_OCOTP_CRYPTO1.attr,
+	&dev_attr_HW_OCOTP_CRYPTO2.attr,
+	&dev_attr_HW_OCOTP_CRYPTO3.attr,
+	&dev_attr_HW_OCOTP_HWCAP0.attr,
+	&dev_attr_HW_OCOTP_HWCAP1.attr,
+	&dev_attr_HW_OCOTP_HWCAP2.attr,
+	&dev_attr_HW_OCOTP_HWCAP3.attr,
+	&dev_attr_HW_OCOTP_HWCAP4.attr,
+	&dev_attr_HW_OCOTP_HWCAP5.attr,
+	&dev_attr_HW_OCOTP_SWCAP.attr,
+	&dev_attr_HW_OCOTP_CUSTCAP.attr,
+	&dev_attr_HW_OCOTP_LOCK.attr,
+	&dev_attr_HW_OCOTP_OPS0.attr,
+	&dev_attr_HW_OCOTP_OPS1.attr,
+	&dev_attr_HW_OCOTP_OPS2.attr,
+	&dev_attr_HW_OCOTP_OPS3.attr,
+	&dev_attr_HW_OCOTP_UN0.attr,
+	&dev_attr_HW_OCOTP_UN1.attr,
+	&dev_attr_HW_OCOTP_UN2.attr,
+	&dev_attr_HW_OCOTP_ROM0.attr,
+	&dev_attr_HW_OCOTP_ROM1.attr,
+	&dev_attr_HW_OCOTP_ROM2.attr,
+	&dev_attr_HW_OCOTP_ROM3.attr,
+	&dev_attr_HW_OCOTP_ROM4.attr,
+	&dev_attr_HW_OCOTP_ROM5.attr,
+	&dev_attr_HW_OCOTP_ROM6.attr,
+	&dev_attr_HW_OCOTP_ROM7.attr,
+	&dev_attr_HW_OCOTP_SRK0.attr,
+	&dev_attr_HW_OCOTP_SRK1.attr,
+	&dev_attr_HW_OCOTP_SRK2.attr,
+	&dev_attr_HW_OCOTP_SRK3.attr,
+	&dev_attr_HW_OCOTP_SRK4.attr,
+	&dev_attr_HW_OCOTP_SRK5.attr,
+	&dev_attr_HW_OCOTP_SRK6.attr,
+	&dev_attr_HW_OCOTP_SRK7.attr,
+	NULL
+};
+
+static const struct fsl_ocotp imx23_ocotp = {
+	.group = { .name = "fuses", .attrs = imx23_ocotp_attributes },
+	.data_offset	= 0x20,
+};
+
+static const struct fsl_ocotp imx28_ocotp = {
+	.group = { .name = "fuses", .attrs = imx28_ocotp_attributes },
+	.data_offset	= 0x20,
+};
+
+static const struct of_device_id fsl_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx23-ocotp", .data = &imx23_ocotp },
+	{ .compatible = "fsl,imx28-ocotp", .data = &imx28_ocotp },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_ocotp_dt_ids);
+
+static int fsl_ocotp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fsl_ocotp *otp;
+	const struct of_device_id *match;
+	struct resource *res;
+	int ret;
+
+	match = of_match_device(fsl_ocotp_dt_ids, dev);
+	if (!match) {
+		dev_err(dev, "%s: Unable to match device\n", __func__);
+		return -ENODEV;
+	}
+
+	if (!dev->of_node) {
+		dev_err(dev, "missing device tree\n");
+		return -EINVAL;
+	}
+
+	otp = devm_kmemdup(dev, match->data, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	otp->base_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base_addr))
+		return PTR_ERR(otp->base_addr);
+
+	mutex_init(&otp->lock);
+
+	ret = sysfs_create_group(&dev->kobj, &otp->group);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, otp);
+
+	dev_info(dev, "initialized\n");
+
+	return 0;
+}
+
+static int fsl_ocotp_remove(struct platform_device *pdev)
+{
+	struct fsl_ocotp *otp = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &otp->group);
+
+	return 0;
+}
+
+static struct platform_driver fsl_ocotp_driver = {
+	.probe		= fsl_ocotp_probe,
+	.remove		= fsl_ocotp_remove,
+	.driver		= {
+		.name   = "fsl_ocotp",
+		.owner	= THIS_MODULE,
+		.of_match_table = fsl_ocotp_dt_ids,
+	},
+};
+
+module_platform_driver(fsl_ocotp_driver);
+MODULE_AUTHOR("Christoph G. Baumann <cgb@debian.org>");
+MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_DESCRIPTION("driver for OCOTP in i.MX23/i.MX28");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
