From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:01 +0100
Subject: [PATCH 2/6] mtd: physmap_of: add a hook for Versatile write protection
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support device tree probing of Versatile NOR flash
chips, there must be a way to add the VPP (write protection)
enable/disable callback. The register in question is in the
system controllers of these machines. Apart from this quirk,
the ARM flash chips are standard CFI flash chips from various
vendors.

Additionally, the Integrator/AP require you to set up the external
bus interface (EBI) to allow writes to the chip select where the
flash memory is connected.

Solve this by looking for the arm,versatile-flash compatible
string in the flash device tree node. In the driver,
add a special hook to check for the various Versatile syscons and
register a callback for .set_vpp() if this compatible is present.

Provide a special Kconfig entry for the addon hook so it will
not be compiled in if the Versatile boards are not supported.
Stubs in the header file make sure the impact will be zero on
other platforms. (Compilers optimze this out.)

With this patch, a large slew of ARM board file code can be
removed.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/maps/Kconfig                |  10 ++
 drivers/mtd/maps/Makefile               |   1 +
 drivers/mtd/maps/physmap_of.c           |   6 +
 drivers/mtd/maps/physmap_of_versatile.c | 253 ++++++++++++++++++++++++++++++++
 drivers/mtd/maps/physmap_of_versatile.h |  16 ++
 5 files changed, 286 insertions(+)
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.c
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.h

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 7c95a656f9e4..392f9eff5fb7 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -74,6 +74,16 @@ config MTD_PHYSMAP_OF
 	  physically into the CPU's memory. The mapping description here is
 	  taken from OF device tree.
 
+config MTD_PHYSMAP_OF_VERSATILE
+	bool "Support ARM Versatile physmap OF"
+	depends on MTD_PHYSMAP_OF
+	depends on MFD_SYSCON
+	default y if (ARCH_INTEGRATOR || ARCH_VERSATILE || REALVIEW_DT)
+	help
+	  This provides some extra DT physmap parsing for the ARM Versatile
+	  platforms, basically to add a VPP (write protection) callback so
+	  the flash can be taken out of write protection.
+
 config MTD_PMC_MSP_EVM
 	tristate "CFI Flash device mapped on PMC-Sierra MSP"
 	depends on PMC_MSP && MTD_CFI
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 141c91a5b24c..188873a72f1d 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
 obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
 obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
+obj-$(CONFIG_MTD_PHYSMAP_OF_VERSATILE) += physmap_of_versatile.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
 obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 70c453144f00..22f3858c0364 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -24,6 +24,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include "physmap_of_versatile.h"
 
 struct of_flash_list {
 	struct mtd_info *mtd;
@@ -240,6 +241,11 @@ static int of_flash_probe(struct platform_device *dev)
 		info->list[i].map.size = res_size;
 		info->list[i].map.bankwidth = be32_to_cpup(width);
 		info->list[i].map.device_node = dp;
+		err = of_flash_probe_versatile(dev, dp, &info->list[i].map);
+		if (err) {
+			dev_err(&dev->dev, "Can't probe Versatile VPP\n");
+			return err;
+		}
 
 		err = -ENOMEM;
 		info->list[i].map.virt = ioremap(info->list[i].map.phys,
diff --git a/drivers/mtd/maps/physmap_of_versatile.c b/drivers/mtd/maps/physmap_of_versatile.c
new file mode 100644
index 000000000000..fa40539e0d7f
--- /dev/null
+++ b/drivers/mtd/maps/physmap_of_versatile.c
@@ -0,0 +1,253 @@
+/*
+ * Versatile OF physmap driver add-on
+ *
+ * Copyright (c) 2016, Linaro Limited
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/mtd/map.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitops.h>
+#include "physmap_of_versatile.h"
+
+static struct regmap *syscon_regmap;
+
+enum versatile_flashprot {
+	INTEGRATOR_AP_FLASHPROT,
+	INTEGRATOR_CP_FLASHPROT,
+	VERSATILE_FLASHPROT,
+	REALVIEW_FLASHPROT,
+};
+
+static const struct of_device_id syscon_match[] = {
+	{
+		.compatible = "arm,integrator-ap-syscon",
+		.data = (void *)INTEGRATOR_AP_FLASHPROT,
+	},
+	{
+		.compatible = "arm,integrator-cp-syscon",
+		.data = (void *)INTEGRATOR_CP_FLASHPROT,
+	},
+	{
+		.compatible = "arm,core-module-versatile",
+		.data = (void *)VERSATILE_FLASHPROT,
+	},
+	{
+		.compatible = "arm,realview-eb-syscon",
+		.data = (void *)REALVIEW_FLASHPROT,
+	},
+	{
+		.compatible = "arm,realview-pb1176-syscon",
+		.data = (void *)REALVIEW_FLASHPROT,
+	},
+	{
+		.compatible = "arm,realview-pb11mp-syscon",
+		.data = (void *)REALVIEW_FLASHPROT,
+	},
+	{
+		.compatible = "arm,realview-pba8-syscon",
+		.data = (void *)REALVIEW_FLASHPROT,
+	},
+	{
+		.compatible = "arm,realview-pbx-syscon",
+		.data = (void *)REALVIEW_FLASHPROT,
+	},
+	{},
+};
+
+/*
+ * Flash protection handling for the Integrator/AP
+ */
+#define INTEGRATOR_SC_CTRLS_OFFSET	0x08
+#define INTEGRATOR_SC_CTRLC_OFFSET	0x0C
+#define INTEGRATOR_SC_CTRL_FLVPPEN	BIT(1)
+#define INTEGRATOR_SC_CTRL_FLWP		BIT(2)
+
+#define INTEGRATOR_EBI_CSR1_OFFSET	0x04
+/* The manual says bit 2, the code says bit 3, trust the code */
+#define INTEGRATOR_EBI_WRITE_ENABLE	BIT(3)
+#define INTEGRATOR_EBI_LOCK_OFFSET	0x20
+#define INTEGRATOR_EBI_LOCK_VAL		0xA05F
+
+static const struct of_device_id ebi_match[] = {
+	{ .compatible = "arm,external-bus-interface"},
+	{ },
+};
+
+static int ap_flash_init(struct platform_device *pdev)
+{
+	struct device_node *ebi;
+	static void __iomem *ebi_base;
+	u32 val;
+	int ret;
+
+	/* Look up the EBI */
+	ebi = of_find_matching_node(NULL, ebi_match);
+	if (!ebi) {
+		return -ENODEV;
+	}
+	ebi_base = of_iomap(ebi, 0);
+	if (!ebi_base)
+		return -ENODEV;
+
+	/* Clear VPP and write protection bits */
+	ret = regmap_write(syscon_regmap,
+		INTEGRATOR_SC_CTRLC_OFFSET,
+		INTEGRATOR_SC_CTRL_FLVPPEN | INTEGRATOR_SC_CTRL_FLWP);
+	if (ret)
+		dev_err(&pdev->dev, "error clearing Integrator VPP/WP\n");
+
+	/* Unlock the EBI */
+	writel(INTEGRATOR_EBI_LOCK_VAL, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
+
+	/* Enable write cycles on the EBI, CSR1 (flash) */
+	val = readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
+	val |= INTEGRATOR_EBI_WRITE_ENABLE;
+	writel(val, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
+
+	/* Lock the EBI again */
+	writel(0, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
+	iounmap(ebi_base);
+
+	return 0;
+}
+
+static void ap_flash_set_vpp(struct map_info *map, int on)
+{
+	int ret;
+
+	if (on) {
+		ret = regmap_write(syscon_regmap,
+			INTEGRATOR_SC_CTRLS_OFFSET,
+			INTEGRATOR_SC_CTRL_FLVPPEN | INTEGRATOR_SC_CTRL_FLWP);
+		if (ret)
+			pr_err("error enabling AP VPP\n");
+	} else {
+		ret = regmap_write(syscon_regmap,
+			INTEGRATOR_SC_CTRLC_OFFSET,
+			INTEGRATOR_SC_CTRL_FLVPPEN | INTEGRATOR_SC_CTRL_FLWP);
+		if (ret)
+			pr_err("error disabling AP VPP\n");
+	}
+}
+
+/*
+ * Flash protection handling for the Integrator/CP
+ */
+
+#define INTCP_FLASHPROG_OFFSET		0x04
+#define CINTEGRATOR_FLVPPEN		BIT(0)
+#define CINTEGRATOR_FLWREN		BIT(1)
+#define CINTEGRATOR_FLMASK		BIT(0)|BIT(1)
+
+static void cp_flash_set_vpp(struct map_info *map, int on)
+{
+	int ret;
+
+	if (on) {
+		ret = regmap_update_bits(syscon_regmap,
+				INTCP_FLASHPROG_OFFSET,
+				CINTEGRATOR_FLMASK,
+				CINTEGRATOR_FLVPPEN | CINTEGRATOR_FLWREN);
+		if (ret)
+			pr_err("error setting CP VPP\n");
+	} else {
+		ret = regmap_update_bits(syscon_regmap,
+				INTCP_FLASHPROG_OFFSET,
+				CINTEGRATOR_FLMASK,
+				0);
+		if (ret)
+			pr_err("error setting CP VPP\n");
+	}
+}
+
+/*
+ * Flash protection handling for the Versatiles and RealViews
+ */
+
+#define VERSATILE_SYS_FLASH_OFFSET            0x4C
+
+static void versatile_flash_set_vpp(struct map_info *map, int on)
+{
+	int ret;
+
+	ret = regmap_update_bits(syscon_regmap, VERSATILE_SYS_FLASH_OFFSET,
+				 0x01, !!on);
+	if (ret)
+		pr_err("error setting Versatile VPP\n");
+}
+
+int of_flash_probe_versatile(struct platform_device *pdev,
+			     struct device_node *np,
+			     struct map_info *map)
+{
+	struct device_node *sysnp;
+	const struct of_device_id *devid;
+	struct regmap *rmap;
+	static enum versatile_flashprot versatile_flashprot;
+	int ret;
+
+	/* Not all flash chips use this protection line */
+	if (!of_device_is_compatible(np, "arm,versatile-flash"))
+		return 0;
+
+	/* For first chip probed, look up the syscon regmap */
+	if (!syscon_regmap) {
+		sysnp = of_find_matching_node_and_match(NULL,
+							syscon_match,
+							&devid);
+		if (!sysnp)
+			return -ENODEV;
+
+		versatile_flashprot = (enum versatile_flashprot)devid->data;
+		rmap = syscon_node_to_regmap(sysnp);
+		if (IS_ERR(rmap))
+			return PTR_ERR(rmap);
+
+		syscon_regmap = rmap;
+	}
+
+	switch (versatile_flashprot) {
+	case INTEGRATOR_AP_FLASHPROT:
+		ret = ap_flash_init(pdev);
+		if (ret)
+			return ret;
+		map->set_vpp = ap_flash_set_vpp;
+		dev_info(&pdev->dev, "Integrator/AP flash protection\n");
+		break;
+	case INTEGRATOR_CP_FLASHPROT:
+		map->set_vpp = cp_flash_set_vpp;
+		dev_info(&pdev->dev, "Integrator/CP flash protection\n");
+		break;
+	case VERSATILE_FLASHPROT:
+	case REALVIEW_FLASHPROT:
+		map->set_vpp = versatile_flash_set_vpp;
+		dev_info(&pdev->dev, "versatile/realview flash protection\n");
+		break;
+	default:
+		dev_info(&pdev->dev, "device marked as Versatile flash "
+			 "but no system controller was found\n");
+		break;
+	}
+
+	return 0;
+}
diff --git a/drivers/mtd/maps/physmap_of_versatile.h b/drivers/mtd/maps/physmap_of_versatile.h
new file mode 100644
index 000000000000..5b86f6dc6b3d
--- /dev/null
+++ b/drivers/mtd/maps/physmap_of_versatile.h
@@ -0,0 +1,16 @@
+#include <linux/of.h>
+#include <linux/mtd/map.h>
+
+#ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
+int of_flash_probe_versatile(struct platform_device *pdev,
+			     struct device_node *np,
+			     struct map_info *map);
+#else
+static inline
+int of_flash_probe_versatile(struct platform_device *pdev,
+			     struct device_node *np,
+			     struct map_info *map)
+{
+	return 0;
+}
+#endif
-- 
2.4.3
