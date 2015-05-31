From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 31 May 2015 11:15:05 +0200
Subject: [PATCH v3 1/4] drivers: soc: sunxi: Introduce SoC driver to map SRAMs
In-Reply-To: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1433063708-11726-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs have a handful of SRAM that can be either mapped to be
accessible by devices or the CPU.

That mapping is controlled by an SRAM controller, and that mapping might
not be set by the bootloader, for example if the device wasn't used at all,
or if we're using solutions like the U-Boot's Falcon Boot.

We could also imagine changing this at runtime for example to change the
mapping of these SRAMs to use them for suspend/resume or runtime memory
rate change, if that ever happens.

These use cases require some API in the kernel to control that mapping,
exported through a drivers/soc driver.

This driver also implement a debugfs file that shows the SRAM found in the
system, the current mapping and the SRAM that have been claimed by some
drivers in the kernel.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[hdegoede at redhat.com: Changed compat string to sun4i-a10-sram-controller, as
 the sram controller is identical on sun4i, sun5i & sun7i, added devicetree
 binding documentation, fixed some checkpatch warnings]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/soc/sunxi/sram.txt         |  72 ++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/sunxi/Kconfig                          |  10 +
 drivers/soc/sunxi/Makefile                         |   1 +
 drivers/soc/sunxi/sunxi_sram.c                     | 284 +++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_sram.h               |  19 ++
 7 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h

diff --git a/Documentation/devicetree/bindings/soc/sunxi/sram.txt b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
new file mode 100644
index 000000000000..067698112f5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
@@ -0,0 +1,72 @@
+Allwinnner SoC SRAM controllers
+-----------------------------------------------------
+
+The SRAM controller found on most Allwinner devices is represented by
+a regular node for the SRAM controller itself, with sub-nodes
+reprensenting the SRAM handled by the SRAM controller.
+
+Controller Node
+---------------
+
+Required properties:
+- compatible : "allwinner,sun4i-a10-sram-controller"
+- reg : sram controller register offset + length
+
+SRAM nodes
+----------
+
+Each SRAM is described using the mmio-sram bindings documented in
+Documentation/devicetree/bindings/misc/sram.txt
+
+Each SRAM will have SRAM sections that are going to be handled by the
+SRAM controller as subnodes. These sections are represented following
+once again the representation described in the mmio-sram binding.
+
+The valid sections compatible are:
+    - allwinner,sun4i-a10-sram-a3-a4
+    - allwinner,sun4i-a10-sram-d
+
+Devices using SRAM sections
+---------------------------
+
+Some devices need to request to the SRAM controller to map an SRAM for
+their exclusive use.
+
+The relationship between such a device and an SRAM section is
+expressed through the allwinner,sram property, that will take a
+phandle and an argument.
+
+This valid values for this argument are:
+  - 0: CPU
+  - 1: Device
+
+Example
+-------
+sram-controller at 01c00000 {
+	compatible = "allwinner,sun4i-a10-sram-controller";
+	reg = <0x01c00000 0x30>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	sram_a: sram at 00000000 {
+		compatible = "mmio-sram";
+		reg = <0x00000000 0xc000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00000000 0xc000>;
+
+		emac_sram: sram-section at 8000 {
+			compatible = "allwinner,sun4i-a10-sram-a3-a4";
+			reg = <0x8000 0x4000>;
+			status = "disabled";
+		};
+	};
+};
+
+emac: ethernet at 01c0b000 {
+	compatible = "allwinner,sun4i-a10-emac";
+	...
+
+	allwinner,sram = <&emac_sram 1>;
+};
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index d8bde82f0370..96ddecb92254 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 70042b259744..7dc7c0d8a2c1 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
new file mode 100644
index 000000000000..353b07e40176
--- /dev/null
+++ b/drivers/soc/sunxi/Kconfig
@@ -0,0 +1,10 @@
+#
+# Allwinner sunXi SoC drivers
+#
+config SUNXI_SRAM
+	bool
+	default ARCH_SUNXI
+	help
+	  Say y here to enable the SRAM controller support. This
+	  device is responsible on mapping the SRAM in the sunXi SoCs
+	  whether to the CPU/DMA, or to the devices.
diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
new file mode 100644
index 000000000000..4cf9dbdf346e
--- /dev/null
+++ b/drivers/soc/sunxi/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
new file mode 100644
index 000000000000..fd528ec31fb6
--- /dev/null
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -0,0 +1,284 @@
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
+#include <linux/of_address.h>
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
+struct sunxi_sram_data {
+	char			*name;
+	u8			reg;
+	u8			offset;
+	u8			width;
+	struct sunxi_sram_func	*func;
+	struct list_head	list;
+};
+
+struct sunxi_sram_desc {
+	struct sunxi_sram_data	data;
+	bool			claimed;
+};
+
+#define SUNXI_SRAM_MAP(_val, _func)				\
+	{							\
+		.func = _func,					\
+		.val = _val,					\
+	}
+
+#define SUNXI_SRAM_DATA(_name, _reg, _off, _width, ...)		\
+	{							\
+		.name = _name,					\
+		.reg = _reg,					\
+		.offset = _off,					\
+		.width = _width,				\
+		.func = (struct sunxi_sram_func[]){		\
+			__VA_ARGS__, { } },			\
+	}
+
+static struct sunxi_sram_desc sun4i_a10_sram_a3_a4 = {
+	.data	= SUNXI_SRAM_DATA("A3-A4", 0x4, 0x4, 1,
+				  SUNXI_SRAM_MAP(0, "cpu"),
+				  SUNXI_SRAM_MAP(1, "emac")),
+};
+
+static struct sunxi_sram_desc sun4i_a10_sram_d = {
+	.data	= SUNXI_SRAM_DATA("D", 0x4, 0x0, 1,
+				  SUNXI_SRAM_MAP(0, "cpu"),
+				  SUNXI_SRAM_MAP(1, "usb-otg")),
+};
+
+static const struct of_device_id sunxi_sram_dt_ids[] = {
+	{
+		.compatible	= "allwinner,sun4i-a10-sram-a3-a4",
+		.data		= &sun4i_a10_sram_a3_a4.data,
+	},
+	{
+		.compatible	= "allwinner,sun4i-a10-sram-d",
+		.data		= &sun4i_a10_sram_d.data,
+	},
+	{}
+};
+
+static struct device *sram_dev;
+static LIST_HEAD(claimed_sram);
+static DEFINE_SPINLOCK(sram_lock);
+static void __iomem *base;
+
+static int sunxi_sram_show(struct seq_file *s, void *data)
+{
+	struct device_node *sram_node, *section_node;
+	const struct sunxi_sram_data *sram_data;
+	const struct of_device_id *match;
+	struct sunxi_sram_func *func;
+	const __be32 *sram_addr_p, *section_addr_p;
+	u32 val;
+
+	seq_puts(s, "Allwinner sunXi SRAM\n");
+	seq_puts(s, "--------------------\n\n");
+
+	for_each_child_of_node(sram_dev->of_node, sram_node) {
+		sram_addr_p = of_get_address(sram_node, 0, NULL, NULL);
+
+		seq_printf(s, "sram@%08x\n",
+			   be32_to_cpu(*sram_addr_p));
+
+		for_each_child_of_node(sram_node, section_node) {
+			match = of_match_node(sunxi_sram_dt_ids, section_node);
+			if (!match)
+				continue;
+			sram_data = match->data;
+
+			section_addr_p = of_get_address(section_node, 0,
+							NULL, NULL);
+
+			seq_printf(s, "\tsection@%04x\t(%s)\n",
+				   be32_to_cpu(*section_addr_p),
+				   sram_data->name);
+
+			val = readl(base + sram_data->reg);
+			val >>= sram_data->offset;
+			val &= sram_data->width;
+
+			for (func = sram_data->func; func->func; func++) {
+				seq_printf(s, "\t\t%s%c\n", func->func,
+					   func->val == val ? '*' : ' ');
+			}
+		}
+
+		seq_puts(s, "\n");
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
+static inline struct sunxi_sram_desc *to_sram_desc(const struct sunxi_sram_data *data)
+{
+	return container_of(data, struct sunxi_sram_desc, data);
+}
+
+static const struct sunxi_sram_data *sunxi_sram_of_parse(struct device_node *node,
+							 unsigned int *value)
+{
+	const struct of_device_id *match;
+	struct of_phandle_args args;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node, "allwinner,sram", 1, 0,
+					       &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!of_device_is_available(args.np)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	if (value)
+		*value = args.args[0];
+
+	match = of_match_node(sunxi_sram_dt_ids, args.np);
+	if (!match) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	of_node_put(args.np);
+	return match->data;
+
+err:
+	of_node_put(args.np);
+	return ERR_PTR(ret);
+}
+
+int sunxi_sram_claim(struct device *dev)
+{
+	const struct sunxi_sram_data *sram_data;
+	struct sunxi_sram_desc *sram_desc;
+	unsigned int device;
+	u32 val, mask;
+
+	if (IS_ERR(base))
+		return -EPROBE_DEFER;
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	sram_data = sunxi_sram_of_parse(dev->of_node, &device);
+	if (IS_ERR(sram_data))
+		return PTR_ERR(sram_data);
+
+	sram_desc = to_sram_desc(sram_data);
+
+	spin_lock(&sram_lock);
+
+	if (sram_desc->claimed) {
+		spin_unlock(&sram_lock);
+		return -EBUSY;
+	}
+
+	mask = GENMASK(sram_data->offset + sram_data->width, sram_data->offset);
+	val = readl(base + sram_data->reg);
+	val &= ~mask;
+	writel(val | ((device << sram_data->offset) & mask),
+	       base + sram_data->reg);
+
+	spin_unlock(&sram_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sunxi_sram_claim);
+
+int sunxi_sram_release(struct device *dev)
+{
+	const struct sunxi_sram_data *sram_data;
+	struct sunxi_sram_desc *sram_desc;
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	sram_data = sunxi_sram_of_parse(dev->of_node, NULL);
+	if (IS_ERR(sram_data))
+		return -EINVAL;
+
+	sram_desc = to_sram_desc(sram_data);
+
+	spin_lock(&sram_lock);
+	sram_desc->claimed = false;
+	spin_unlock(&sram_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sunxi_sram_release);
+
+static int sunxi_sram_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct dentry *d;
+
+	sram_dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+
+	d = debugfs_create_file("sram", S_IRUGO, NULL, NULL,
+				&sunxi_sram_fops);
+	if (!d)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_sram_dt_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
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
index 000000000000..c5f663bba9c2
--- /dev/null
+++ b/include/linux/soc/sunxi/sunxi_sram.h
@@ -0,0 +1,19 @@
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
+int sunxi_sram_claim(struct device *dev);
+int sunxi_sram_release(struct device *dev);
+
+#endif /* _SUNXI_SRAM_H_ */
-- 
2.4.1
