From: davidm@egauge.net (David Mosberger-Tang)
Date: Wed, 20 Jan 2016 20:57:35 -0700
Subject: [PATCH] misc: atmel-secumod: Driver for Atmel "security module".
Message-ID: <1453348655-31182-1-git-send-email-davidm@egauge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Mosberger <davidm@egauge.net>

SAMA5D2 (and perhaps other SOCs) implements a secure module which
hosts a battery-backed SRAM with is sectioned into three different
areas with different properties: a 4KiB auto-erasable secure RAM, a
1KiB non-auto-eraseable secure RAM, and 32 bytes of (non-secure) RAM.

This driver provides (minimal) access to these RAM areas through
sysfs.  For example, adding this to the DTS:

	secumod at fc040000 {
		compatible = "atmel,sama5d2-secumod";
		reg = <0xfc040000 0x4000>;
		status = "okay";

		#address-cells = <1>;
		#size-cells = <1>;

		secram_auto_erasable at f8044000 {
			reg = <0xf8044000 0x1000>;
		};
		secram at f8045000 {
			reg = <0xf8045000 0x400>;
		};
		ram at f8045400 {
			reg = <0xf8045400 0x20>;
		};
	};

would provide binary files "ram", "secram", and "secram_auto_erasable"
in directory /sys/bus/platform/devices/fc040000.secumod.
This files can then be read or written with any user-level tool.

The driver is minimal in the sense that it doesn't provide (yet)
a way to manage scrambling keys etc.

Signed-off-by: David Mosberger <davidm@egauge.net>
---
 arch/arm/boot/dts/sama5d2.dtsi |  19 ++++
 drivers/misc/Kconfig           |   7 ++
 drivers/misc/Makefile          |   1 +
 drivers/misc/atmel-secumod.c   | 224 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 drivers/misc/atmel-secumod.c

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 89d4de8..d4bd3b6 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1239,6 +1239,25 @@
 				clocks = <&pioA_clk>;
 			};
 
+			secumod at fc040000 {
+				compatible = "atmel,sama5d2-secumod";
+				reg = <0xfc040000 0x4000>;
+				status = "okay";
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				secram_auto_erasable at f8044000 {
+					reg = <0xf8044000 0x1000>;
+				};
+				secram at f8045000 {
+					reg = <0xf8045000 0x400>;
+				};
+				ram at f8045400 {
+					reg = <0xf8045400 0x20>;
+				};
+			};
+
 			tdes at fc044000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc044000 0x100>;
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 006242c..74a8ee5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -84,6 +84,13 @@ config ATMEL_TCB_CLKSRC_BLOCK
 	  TC can be used for other purposes, such as PWM generation and
 	  interval timing.
 
+config ATMEL_SECUMOD
+       tristate "Atmel Secure Module driver"
+       depends on ARCH_AT91
+       help
+         Select this to get support for the secure module (SECUMOD) built
+	 into the SAMA5D2 chips.
+
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7d5c4cd..e1f661d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
+obj-$(CONFIG_ATMEL_SECUMOD)	+= atmel-secumod.o
 obj-$(CONFIG_BMP085)		+= bmp085.o
 obj-$(CONFIG_BMP085_I2C)	+= bmp085-i2c.o
 obj-$(CONFIG_BMP085_SPI)	+= bmp085-spi.o
diff --git a/drivers/misc/atmel-secumod.c b/drivers/misc/atmel-secumod.c
new file mode 100644
index 0000000..5ac1a18
--- /dev/null
+++ b/drivers/misc/atmel-secumod.c
@@ -0,0 +1,224 @@
+/*
+ * Driver for SAMA5D2 secure module (SECUMOD).
+ *
+ * Copyright (C) 2016 eGauge Systems LLC
+ *
+ * David Mosberger <davidm@egauge.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+
+/*
+ * Security-module register definitions:
+ */
+#define SECUMOD_RAMRDY	0x0014
+
+struct ram_area {
+	struct list_head next;
+	void *regs;	/* ioremapped RAM area */
+	size_t size;	/* size in bytes */
+	struct bin_attribute attr;
+};
+
+struct secumod_device {
+	struct spinlock lock;
+	void __iomem *regs;		/* ioremapped SECUMOD registers */
+	struct platform_device *pdev;
+	struct list_head ram_areas;
+};
+
+static ssize_t
+secumod_ram_write(struct file *filp, struct kobject *kobj,
+		  struct bin_attribute *attr,
+		  char *buf, loff_t off, size_t count)
+{
+	struct ram_area *ram = attr->private;
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct secumod_device *secumod = platform_get_drvdata(pdev);
+
+	if (off < 0 || off >= ram->size)
+		return -EINVAL;
+	if (off + count > ram->size)
+		count = ram->size = off;
+
+	if (count > 0) {
+		spin_lock(&secumod->lock);
+		memcpy_toio(ram->regs + off, buf, count);
+		spin_unlock(&secumod->lock);
+	}
+	return count;
+}
+
+static ssize_t
+secumod_ram_read(struct file *filp, struct kobject *kobj,
+		 struct bin_attribute *attr,
+		 char *buf, loff_t off, size_t count)
+{
+	struct ram_area *ram = attr->private;
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct secumod_device *secumod = platform_get_drvdata(pdev);
+
+	if (off < 0 || off >= ram->size)
+		return -EINVAL;
+	if (off + count > ram->size)
+		count = ram->size = off;
+
+	if (count > 0) {
+		spin_lock(&secumod->lock);
+		memcpy_fromio(buf, ram->regs + off, count);
+		spin_unlock(&secumod->lock);
+	}
+	return count;
+}
+
+static void
+secumod_register_ram(struct secumod_device *secumod,
+		     const char *name, unsigned long addr, size_t size)
+{
+	struct device *dev = &secumod->pdev->dev;
+	struct ram_area *ram;
+	int ret;
+
+	ram = devm_kzalloc(dev, sizeof(*ram), GFP_KERNEL);
+	if (!ram) {
+		dev_err(dev, "Out of memory for RAM area %s\n", name);
+		return;
+	}
+	INIT_LIST_HEAD(&ram->next);
+	ram->size = size;
+	ram->regs = ioremap_nocache(addr, size);
+	ram->attr.attr.name = name;
+	ram->attr.attr.mode = S_IRUGO | S_IWUSR;
+	ram->attr.private = ram;
+	ram->attr.size = size;
+	ram->attr.read = secumod_ram_read;
+	ram->attr.write = secumod_ram_write;
+	ret = device_create_bin_file(dev, &ram->attr);
+	if (ret) {
+		dev_err(dev, "Failed to register RAM area %s (%d)", name, ret);
+		return;
+	}
+	spin_lock(&secumod->lock);
+	list_add_tail(&ram->next, &secumod->ram_areas);
+	spin_unlock(&secumod->lock);
+	pr_info("atmel-secumod: RAM 0x%08lx-0x%08lx (%s)\n",
+		addr, addr + size - 1, name);
+}
+
+/*
+ * Since the secure module may need to automatically erase some of the
+ * RAM, it may take a while for it to be ready.  As far as I know,
+ * it's not documented how long this might take in the worst-case.
+ */
+static void
+secumod_wait_ready (struct secumod_device *secumod)
+{
+	unsigned long start, stop;
+
+	start = jiffies;
+	while (!(readl(secumod->regs + SECUMOD_RAMRDY) & 1))
+		msleep_interruptible(1);
+	stop = jiffies;
+	if (stop != start)
+		pr_info("atmel-secumod: it took %u msec for SECUMOD "
+			"to become ready...\n", jiffies_to_msecs(stop - start));
+}
+
+static int
+secumod_probe(struct platform_device *pdev)
+{
+	struct secumod_device *secumod;
+	struct device_node *child;
+	struct resource *regs;
+	u32 addr, size;
+	const void *pv;
+	int len;
+
+	secumod = devm_kzalloc(&pdev->dev, sizeof(*secumod), GFP_KERNEL);
+	if (!secumod) {
+		dev_err(&pdev->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+	spin_lock_init(&secumod->lock);
+	INIT_LIST_HEAD(&secumod->ram_areas);
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Missing of_node attribute\n");
+		return -ENODEV;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "Missing secumod resources.\n");
+		return -ENODEV;
+	}
+	secumod->pdev = pdev;
+	secumod->regs = devm_ioremap_resource(&pdev->dev, regs);
+
+	platform_set_drvdata(pdev, secumod);
+
+	for_each_child_of_node(pdev->dev.of_node, child) {
+		pv = of_get_property(child, "reg", &len);
+		if (!pv ||
+		    of_n_addr_cells(child) != 1 ||
+		    of_n_size_cells(child) != 1) {
+			dev_err(&pdev->dev, "Node %s missing \"reg\" property "
+				"or incorrect address/size count.",
+				child->name);
+			return -ENODEV;
+		}
+		addr = be32_to_cpup(pv);
+		size = be32_to_cpup(pv + 4);
+		secumod_register_ram(secumod, child->name, addr, size);
+	}
+	secumod_wait_ready(secumod);
+	return 0;
+}
+
+static int
+secumod_remove(struct platform_device *pdev)
+{
+	struct secumod_device *secumod = platform_get_drvdata(pdev);
+	struct ram_area *ram;
+
+	spin_lock(&secumod->lock);
+	list_for_each_entry(ram, &secumod->ram_areas, next)
+		device_remove_bin_file(&pdev->dev, &ram->attr);
+	spin_unlock(&secumod->lock);
+	return 0;
+}
+
+static const struct of_device_id secumod_dt_ids[] = {
+	{
+		.compatible = "atmel,sama5d2-secumod"
+	},
+	{
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, secumod_dt_ids);
+
+static struct platform_driver secumod_driver = {
+	.driver = {
+		.name = "atmel-secumod",
+		.of_match_table = of_match_ptr(secumod_dt_ids),
+	},
+	.probe		= secumod_probe,
+	.remove		= secumod_remove
+};
+module_platform_driver(secumod_driver);
+
+MODULE_AUTHOR("David Mosberger <davidm@egauge.net>");
+MODULE_DESCRIPTION("Atmel SAMA5D2 secure module driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
