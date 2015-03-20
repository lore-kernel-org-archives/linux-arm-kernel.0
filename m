From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 19:52:45 +0100
Subject: [PATCH 1/5] drivers: soc: sunxi: Introduce SoC driver to map SRAMs
In-Reply-To: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426877569-11493-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The Allwinner SoCs have a handful of SRAM that can be either mapped to be
accessible by devices or the CPU.

That mapping is controlled by an SRAM controller, and that mapping might not be
set by the bootloader, for example if the device wasn't used at all, or if
we're using solutions like the U-Boot's Falcon Boot.

We could also imagine changing this at runtime for example to change the
mapping of these SRAMs to use them for suspend/resume or runtime memory rate
change, if that ever happens.

These use cases require some API in the kernel to control that mapping,
exported through a drivers/soc driver.

This driver also implement a debugfs file that shows the SRAM found in the
system, the current mapping and the SRAM that have been claimed by some drivers
in the kernel.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[hdegoede at redhat.com: Changed compat string to sun4i-a10-sram-controller, as
 the sram controller is identical on sun4i, sun5i & sun7i, added devicetree
 binding documentation, fixed some checkpatch warnings]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/soc/sunxi/sram.txt         |  64 ++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/sunxi/Kconfig                          |  12 ++
 drivers/soc/sunxi/Makefile                         |   1 +
 drivers/soc/sunxi/sunxi_sram.c                     | 235 +++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_sram.h               |  24 +++
 7 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h

diff --git a/Documentation/devicetree/bindings/soc/sunxi/sram.txt b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
new file mode 100644
index 0000000..6e1bc80
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
@@ -0,0 +1,64 @@
+Allwinnner sun4i / sun5i / sun7i SoC SRAM controllers
+-----------------------------------------------------
+
+Required properties:
+- compatible : "allwinner,sun4i-a10-sram-controller"
+- reg : sram controller register offset + length
+
+SRAM nodes
+----------
+
+Besides a node for the SRAM controller the devicetree must also contain a
+node for each SRAM block controlled by the controller.
+
+Required sram node properties:
+- compatible : "allwinner,sun4i-a10-sram"
+- allwinner,sram-name : should be one of
+  * "A1"
+  * "A2"
+  * "A3-A4"
+  * "D"
+
+Example
+-------
+
+/*
+ * Note we use the address were mmio register start, not where
+ * the SRAM blocks starts, this cannot be changed because doing
+ * doing so would be a devicetree ABI change.
+ */
+soc at 01c00000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	sram at 00000000 {
+		compatible = "allwinner,sun4i-a10-sram";
+		reg = <0x00000000 0x4000>;
+		allwinner,sram-name = "A1";
+	};
+
+	sram at 00004000 {
+		compatible = "allwinner,sun4i-a10-sram";
+		reg = <0x00004000 0x4000>;
+		allwinner,sram-name = "A2";
+	};
+
+	sram at 00008000 {
+		compatible = "allwinner,sun4i-a10-sram";
+		reg = <0x00008000 0x4000>;
+		allwinner,sram-name = "A3-A4";
+	};
+
+	sram at 00010000 {
+		compatible = "allwinner,sun4i-a10-sram";
+		reg = <0x00010000 0x1000>;
+		allwinner,sram-name = "D";
+	};
+
+	sram-controller at 01c00000 {
+		compatible = "allwinner,sun4i-a10-sram-controller";
+		reg = <0x01c00000 0x30>;
+	};
+};
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 76d6bd4..5d0f55d 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,6 +1,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 063113d..170bba3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
new file mode 100644
index 0000000..212c634
--- /dev/null
+++ b/drivers/soc/sunxi/Kconfig
@@ -0,0 +1,12 @@
+#
+# Allwinner sunXi SoC drivers
+#
+config SUNXI_SRAM
+        tristate "Allwinner sunXi SRAM Controller"
+        depends on ARCH_SUNXI
+	default y
+        help
+          Say y here to enable the SRAM controller support. This
+          device is responsible on mapping the SRAM in the sunXi SoCs
+          wether to the CPU/DMA, or to the devices.
+
diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
new file mode 100644
index 0000000..4cf9dbd
--- /dev/null
+++ b/drivers/soc/sunxi/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
new file mode 100644
index 0000000..5b76fd1
--- /dev/null
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -0,0 +1,235 @@
+/*
+ * Allwinner SoCs SRAM Controller Driver
+ *
+ * Copyright (C) 2015 Maxime Ripard
+ *
+ * Author: Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <linux/soc/sunxi/sunxi_sram.h>
+
+struct sunxi_sram_func {
+	char	*func;
+	u8	val;
+};
+
+struct sunxi_sram_desc {
+	enum sunxi_sram_type	type;
+	char			*name;
+	u8			reg;
+	u8			offset;
+	u8			width;
+	struct sunxi_sram_func	*func;
+	bool			claimed;
+	bool			enabled;
+};
+
+#define SUNXI_SRAM_MAP(_val, _func)				\
+	{							\
+		.func = _func,					\
+		.val = _val,					\
+	}
+
+#define SUNXI_SRAM_DESC(_type, _name, _reg, _off, _width, ...)	\
+	{							\
+		.type = _type,					\
+		.name = _name,					\
+		.reg = _reg,					\
+		.offset = _off,					\
+		.width = _width,				\
+		.func = (struct sunxi_sram_func[]){		\
+			__VA_ARGS__, { } },			\
+	}
+
+struct sunxi_sram_desc sun4i_sram_desc[] = {
+	SUNXI_SRAM_DESC(SUNXI_SRAM_EMAC, "A3-A4", 0x4, 0x4, 1,
+			SUNXI_SRAM_MAP(0, "cpu"),
+			SUNXI_SRAM_MAP(1, "emac")),
+	SUNXI_SRAM_DESC(SUNXI_SRAM_USB_OTG, "D", 0x4, 0x0, 1,
+			SUNXI_SRAM_MAP(0, "cpu"),
+			SUNXI_SRAM_MAP(1, "usb-otg")),
+	{ /* Sentinel */ },
+};
+
+static struct sunxi_sram_desc *sram_list;
+static DEFINE_SPINLOCK(sram_lock);
+static void __iomem *base;
+
+static int sunxi_sram_show(struct seq_file *s, void *data)
+{
+	struct sunxi_sram_desc *sram;
+	struct sunxi_sram_func *func;
+	u32 val;
+
+	seq_puts(s, "Allwinner sunXi SRAM\n");
+	seq_puts(s, "--------------------\n");
+
+
+	for (sram = sram_list; sram->name; sram++) {
+		if (!sram->enabled)
+			continue;
+
+		seq_printf(s, "\n%s\n", sram->name);
+
+		val = readl(base + sram->reg);
+		val >>= sram->offset;
+		val &= sram->width;
+
+		for (func = sram->func; func->func; func++) {
+			seq_printf(s, "\t\t%s%c\n", func->func,
+				   func->val == val ? '*' : ' ');
+		}
+	}
+
+	return 0;
+}
+
+static int sunxi_sram_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sunxi_sram_show, inode->i_private);
+}
+
+static const struct file_operations sunxi_sram_fops = {
+	.open = sunxi_sram_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+int sunxi_sram_claim(enum sunxi_sram_type type, const char *function)
+{
+	struct sunxi_sram_desc *sram;
+	struct sunxi_sram_func *func;
+	u32 val;
+
+	if (IS_ERR(base))
+		return -EPROBE_DEFER;
+
+	for (sram = sram_list; sram->name; sram++) {
+		if (sram->type != type)
+			continue;
+
+		if (!sram->enabled)
+			return -ENODEV;
+
+		spin_lock(&sram_lock);
+
+		if (sram->claimed) {
+			spin_unlock(&sram_lock);
+			return -EBUSY;
+		}
+
+		sram->claimed = true;
+		spin_unlock(&sram_lock);
+
+		for (func = sram->func; func->func; func++) {
+			if (strcmp(function, func->func))
+				continue;
+
+			val = readl(base + sram->reg);
+			val &= ~GENMASK(sram->offset + sram->width,
+					sram->offset);
+			writel(val | func->val, base + sram->reg);
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(sunxi_sram_claim);
+
+int sunxi_sram_release(enum sunxi_sram_type type)
+{
+	struct sunxi_sram_desc *sram;
+
+	for (sram = sram_list; sram->type; sram++) {
+		if (sram->type != type)
+			continue;
+
+		if (!sram->enabled)
+			return -ENODEV;
+
+		spin_lock(&sram_lock);
+		sram->claimed = false;
+		spin_unlock(&sram_lock);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(sunxi_sram_release);
+
+static const struct of_device_id sunxi_sram_dt_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-sram-controller",
+	  .data = &sun4i_sram_desc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
+
+static int sunxi_sram_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct sunxi_sram_desc *sram;
+	struct device_node *node;
+	struct resource *res;
+	struct dentry *d;
+	const char *name;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	match = of_match_device(sunxi_sram_dt_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	sram_list = (struct sunxi_sram_desc *)match->data;
+
+	for_each_compatible_node(node, NULL, "allwinner,sun4i-a10-sram") {
+		if (of_property_read_string(node, "allwinner,sram-name", &name))
+			continue;
+
+		for (sram = sram_list; sram->name; sram++)
+			if (!strcmp(name, sram->name))
+				break;
+
+		if (!sram->name)
+			continue;
+
+		sram->enabled = true;
+	}
+
+	d = debugfs_create_file("sram", S_IRUGO, NULL, NULL,
+				&sunxi_sram_fops);
+	if (!d)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct platform_driver sunxi_sram_driver = {
+	.driver = {
+		.name		= "sunxi-sram",
+		.of_match_table	= sunxi_sram_dt_match,
+	},
+	.probe	= sunxi_sram_probe,
+};
+module_platform_driver(sunxi_sram_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/sunxi/sunxi_sram.h b/include/linux/soc/sunxi/sunxi_sram.h
new file mode 100644
index 0000000..351c31a
--- /dev/null
+++ b/include/linux/soc/sunxi/sunxi_sram.h
@@ -0,0 +1,24 @@
+/*
+ * Allwinner SoCs SRAM Controller Driver
+ *
+ * Copyright (C) 2015 Maxime Ripard
+ *
+ * Author: Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _SUNXI_SRAM_H_
+#define _SUNXI_SRAM_H_
+
+enum sunxi_sram_type {
+	SUNXI_SRAM_USB_OTG,
+	SUNXI_SRAM_EMAC,
+};
+
+int sunxi_sram_claim(enum sunxi_sram_type type, const char *function);
+int sunxi_sram_release(enum sunxi_sram_type type);
+
+#endif /* _SUNXI_SRAM_H_ */
-- 
2.3.3
