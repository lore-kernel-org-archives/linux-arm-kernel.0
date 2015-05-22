From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 22 May 2015 16:21:54 +0530
Subject: [PATCH v3 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <cover.1432290463.git.maitysanchayan@gmail.com>
References: <cover.1432290463.git.maitysanchayan@gmail.com>
Message-ID: <d27c4ba234cd298914676884a9604ea8472a17d0.1432290463.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a SoC driver to be used by the Freescale Vybrid SoC's.
We create the "fsl" directory for holding the different Freescale
designs. Driver utilises syscon to get the various register values
needed. After this sysfs exposes some SoC specific properties as
below:

> cd /sys/devices/soc0
> ls
family     machine    power      revision   soc_id     subsystem  uevent
> cat family
Freescale Vybrid VF610
> cat machine
Freescale Vybrid
> cat revision
00000013
> cat soc_id
df6472a60c1c39d4

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/soc/Kconfig         |   1 +
 drivers/soc/Makefile        |   1 +
 drivers/soc/fsl/Kconfig     |   9 ++++
 drivers/soc/fsl/Makefile    |   1 +
 drivers/soc/fsl/soc-vf610.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/soc-vf610.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index d8bde82..8b4dd2b 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 70042b2..142676e 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_SOC_VF610)         += fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
new file mode 100644
index 0000000..d0ac671
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig
@@ -0,0 +1,9 @@
+#
+# Freescale SoC drivers
+
+config SOC_VF610
+	   bool "SoC bus device for the Freescale Vybrid platform"
+	   select SOC_BUS
+	   help
+	     Include support for the SoC bus on the Freescale Vybrid platform
+		 providing some sysfs information about the module variant.
\ No newline at end of file
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
new file mode 100644
index 0000000..5fccbba
--- /dev/null
+++ b/drivers/soc/fsl/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_VF610)		+= soc-vf610.o
diff --git a/drivers/soc/fsl/soc-vf610.c b/drivers/soc/fsl/soc-vf610.c
new file mode 100644
index 0000000..faeb567
--- /dev/null
+++ b/drivers/soc/fsl/soc-vf610.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2015 Toradex AG
+ *
+ * Author: Sanchayan Maity <sanchayan.maity@toradex.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define OCOTP_CFG0_OFFSET      0x00000410
+#define OCOTP_CFG1_OFFSET      0x00000420
+#define MSCM_CPxCOUNT_OFFSET   0x0000002C
+#define MSCM_CPxCFG1_OFFSET    0x00000014
+#define ROM_REVISION_OFFSET    0x00000080
+
+static const struct of_device_id vf610_soc_bus_match[] = {
+	{ .compatible = "fsl,vf610-mscm-cpucfg", },
+	{ /* sentinel */ }
+};
+
+static int __init vf610_soc_init(void)
+{
+	struct regmap *ocotp_regmap, *mscm_regmap, *rom_regmap;
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	char soc_type[] = "xx0";
+	u32 cpxcount, cpxcfg1;
+	u32 soc_id1, soc_id2, rom_rev;
+	u64 soc_id;
+	int ret;
+
+	np = of_find_matching_node(NULL, vf610_soc_bus_match);
+	if (!np)
+		return -ENODEV;
+
+	ocotp_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocotp");
+	if (IS_ERR(ocotp_regmap)) {
+		pr_err("regmap lookup for octop failed\n");
+		return PTR_ERR(ocotp_regmap);
+	}
+
+	mscm_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-mscm-cpucfg");
+	if (IS_ERR(mscm_regmap)) {
+		pr_err("regmap lookup for mscm failed");
+		return PTR_ERR(mscm_regmap);
+	}
+
+	rom_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocrom");
+	if (IS_ERR(rom_regmap)) {
+		pr_err("regmap lookup for ocrom failed");
+		return PTR_ERR(rom_regmap);
+	}
+
+	ret = regmap_read(ocotp_regmap, OCOTP_CFG0_OFFSET, &soc_id1);
+	if (ret)
+		return -ENODEV;
+
+	ret = regmap_read(ocotp_regmap, OCOTP_CFG1_OFFSET, &soc_id2);
+	if (ret)
+		return -ENODEV;
+
+	soc_id = (u64) soc_id1 << 32 | soc_id2;
+	add_device_randomness(&soc_id, sizeof(soc_id));
+
+	ret = regmap_read(mscm_regmap, MSCM_CPxCOUNT_OFFSET, &cpxcount);
+	if (ret)
+		return -ENODEV;
+
+	ret = regmap_read(mscm_regmap, MSCM_CPxCFG1_OFFSET, &cpxcfg1);
+	if (ret)
+		return -ENODEV;
+
+	soc_type[0] = cpxcount ? '6' : '5'; /* Dual Core => VF6x0 */
+	soc_type[1] = cpxcfg1 ? '1' : '0'; /* L2 Cache => VFx10 */
+
+	ret = regmap_read(rom_regmap, ROM_REVISION_OFFSET, &rom_rev);
+	if (ret)
+		return -ENODEV;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->machine = kasprintf(GFP_KERNEL, "Freescale Vybrid");
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%016llx", soc_id);
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Freescale Vybrid VF%s",
+								 soc_type);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%08x", rom_rev);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr->machine);
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+device_initcall(vf610_soc_init);
-- 
2.4.1
