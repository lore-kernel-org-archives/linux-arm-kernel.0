From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 20 May 2016 15:32:05 +0530
Subject: [PATCH v3 4/4] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <cover.1463737502.git.maitysanchayan@gmail.com>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
Message-ID: <ffef165d05f71a1b19437171d8fdb4bc78f6b1e3.1463737502.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a SoC driver to be used by Freescale Vybrid SoC's.
Driver utilises syscon and nvmem consumer API's to get the
various register values needed and expose the SoC specific
properties via sysfs.

A sample output from Colibri Vybrid VF61 is below:

root at colibri-vf:~# cd /sys/bus/soc/devices/soc0
root at colibri-vf:/sys/bus/soc/devices/soc0# ls
family     machine    power      revision   soc_id     subsystem  uevent
root at colibri-vf:/sys/bus/soc/devices/soc0# cat family
Freescale Vybrid VF610
root at colibri-vf:/sys/bus/soc/devices/soc0# cat machine
Freescale Vybrid
root at colibri-vf:/sys/bus/soc/devices/soc0# cat revision
00000013
root at colibri-vf:/sys/bus/soc/devices/soc0# cat soc_id
df6472a6130f29d4

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 .../bindings/arm/freescale/fsl,vf610-soc.txt       |  20 +++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/fsl/Kconfig                            |  10 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/soc-vf610.c                        | 198 +++++++++++++++++++++
 5 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/soc-vf610.c

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
new file mode 100644
index 0000000..338905d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
@@ -0,0 +1,20 @@
+Vybrid System-on-Chip
+---------------------
+
+Required properties:
+
+- compatible: "fsl,vf610-soc"
+- rom-revision: phandle to the on-chip ROM node
+- mscm: phandle to the MSCM CPU configuration node
+- nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
+- nvmem-cell-names: should contain string names "cfg0" and "cfg1"
+
+Example:
+
+	vf610-soc {
+		compatible = "fsl,vf610-soc";
+		rom-revision = <&ocrom>;
+		mscm = <&mscm_cpucfg>;
+		nvmem-cells = <&ocotp_cfg0>, <&ocotp_cfg1>;
+		nvmem-cell-names = "cfg0", "cfg1";
+	};
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0..4410eb7 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/brcmstb/Kconfig"
+source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
new file mode 100644
index 0000000..029ea17
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig
@@ -0,0 +1,10 @@
+#
+# Freescale SoC drivers
+
+config SOC_BUS_VF610
+	bool "SoC bus device for the Freescale Vybrid platform"
+	depends on NVMEM && NVMEM_VF610_OCOTP
+	select SOC_BUS
+	help
+	 Include support for the SoC bus on the Freescale Vybrid platform
+	 providing sysfs information about the module variant.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 203307f..afaf092 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -2,5 +2,6 @@
 # Makefile for the Linux Kernel SOC fsl specific device drivers
 #
 
+obj-$(CONFIG_SOC_VF610)			+= soc-vf610.o
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
diff --git a/drivers/soc/fsl/soc-vf610.c b/drivers/soc/fsl/soc-vf610.c
new file mode 100644
index 0000000..571ba69
--- /dev/null
+++ b/drivers/soc/fsl/soc-vf610.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (C) 2016 Toradex AG.
+ *
+ * Author: Sanchayan Maity <sanchayan.maity@toradex.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define MSCM_CPxCOUNT_OFFSET	0x2C
+#define MSCM_CPxCFG1_OFFSET	0x14
+#define ROM_REVISION_OFFSET	0x80
+
+struct vf610_soc {
+	struct device *dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct nvmem_cell *ocotp_cfg0;
+	struct nvmem_cell *ocotp_cfg1;
+};
+
+static int vf610_soc_probe(struct platform_device *pdev)
+{
+	struct vf610_soc *info;
+	struct device *dev = &pdev->dev;
+	struct device_node *rom_node, *mscm_node;
+	struct regmap *rom_regmap, *mscm_regmap;
+	char soc_type[] = "xx0";
+	size_t id1_len, id2_len;
+	u32 cpucount, l2size, rom_rev;
+	u8 *socid1, *socid2;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(struct vf610_soc), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->dev = dev;
+
+	info->ocotp_cfg0 = devm_nvmem_cell_get(dev, "cfg0");
+	if (IS_ERR(info->ocotp_cfg0))
+		return -EPROBE_DEFER;
+
+	info->ocotp_cfg1 = devm_nvmem_cell_get(dev, "cfg1");
+	if (IS_ERR(info->ocotp_cfg1))
+		return -EPROBE_DEFER;
+
+	socid1 = nvmem_cell_read(info->ocotp_cfg0, &id1_len);
+	if (IS_ERR(socid1)) {
+		dev_err(dev, "Could not read nvmem cell %ld\n",
+			PTR_ERR(socid1));
+		return PTR_ERR(socid1);
+	}
+
+	socid2 = nvmem_cell_read(info->ocotp_cfg1, &id2_len);
+	if (IS_ERR(socid2)) {
+		dev_err(dev, "Could not read nvmem cell %ld\n",
+			PTR_ERR(socid2));
+		ret = PTR_ERR(socid2);
+		goto out_socid2;
+	}
+	add_device_randomness(socid1, id1_len);
+	add_device_randomness(socid2, id2_len);
+
+	rom_node = of_parse_phandle(pdev->dev.of_node, "rom-revision", 0);
+	if (!rom_node) {
+		dev_err(dev, "Lookup failed for rom-revision node\n");
+		ret = -ENODEV;
+		goto out_rom_node;
+	}
+
+	mscm_node = of_parse_phandle(pdev->dev.of_node, "mscm", 0);
+	if (!mscm_node) {
+		dev_err(dev, "lookup failed for mscm node\n");
+		ret = -ENODEV;
+		goto out_mscm_node;
+	}
+
+	rom_regmap = syscon_node_to_regmap(rom_node);
+	if (IS_ERR(rom_regmap)) {
+		dev_err(dev, "regmap lookup for ocrom failed %ld\n",
+			PTR_ERR(rom_regmap));
+		ret = PTR_ERR(rom_regmap);
+		goto out;
+	}
+
+	mscm_regmap = syscon_node_to_regmap(mscm_node);
+	if (IS_ERR(mscm_regmap)) {
+		dev_err(dev, "regmap lookup for mscm failed %ld\n",
+			PTR_ERR(mscm_regmap));
+		ret = PTR_ERR(mscm_regmap);
+		goto out;
+	}
+
+	ret = regmap_read(rom_regmap, ROM_REVISION_OFFSET, &rom_rev);
+	if (ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = regmap_read(mscm_regmap, MSCM_CPxCOUNT_OFFSET, &cpucount);
+	if (ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = regmap_read(mscm_regmap, MSCM_CPxCFG1_OFFSET, &l2size);
+	if (ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	soc_type[0] = cpucount ? '6' : '5'; /* Dual Core => VF6x0 */
+	soc_type[1] = l2size ? '1' : '0'; /* L2 Cache => VFx10 */
+
+	info->soc_dev_attr = devm_kzalloc(dev,
+				sizeof(info->soc_dev_attr), GFP_KERNEL);
+	if (!info->soc_dev_attr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	info->soc_dev_attr->machine = devm_kasprintf(dev,
+					GFP_KERNEL, "Freescale Vybrid");
+	info->soc_dev_attr->soc_id = devm_kasprintf(dev,
+					GFP_KERNEL,
+					"%02x%02x%02x%02x%02x%02x%02x%02x",
+					socid1[3], socid1[2], socid1[1],
+					socid1[0], socid2[3], socid2[2],
+					socid2[1], socid2[0]);
+	info->soc_dev_attr->family = devm_kasprintf(&pdev->dev,
+					GFP_KERNEL, "Freescale Vybrid VF%s",
+					soc_type);
+	info->soc_dev_attr->revision = devm_kasprintf(dev,
+					GFP_KERNEL, "%08x", rom_rev);
+
+	platform_set_drvdata(pdev, info);
+
+	info->soc_dev = soc_device_register(info->soc_dev_attr);
+	if (IS_ERR(info->soc_dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	of_node_put(mscm_node);
+out_mscm_node:
+	of_node_put(rom_node);
+out_rom_node:
+	kfree(socid2);
+out_socid2:
+	kfree(socid1);
+
+	return ret;
+}
+
+static int vf610_soc_remove(struct platform_device *pdev)
+{
+	struct vf610_soc *info = platform_get_drvdata(pdev);
+
+	if (info->soc_dev)
+		soc_device_unregister(info->soc_dev);
+
+	return 0;
+}
+
+static const struct of_device_id vf610_soc_match[] = {
+	{ .compatible = "fsl,vf610-soc", },
+	{ /* */ }
+};
+
+static struct platform_driver vf610_soc_driver = {
+	.probe		= vf610_soc_probe,
+	.remove		= vf610_soc_remove,
+	.driver		= {
+		.name = "vf610-soc",
+		.of_match_table = vf610_soc_match,
+	},
+};
+builtin_platform_driver(vf610_soc_driver);
-- 
2.8.2
