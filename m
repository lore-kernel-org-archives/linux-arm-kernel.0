From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri,  9 Jun 2017 10:31:22 +0200
Subject: [RFC PATCH 6/7] EDAC: Add driver for the AURORA L2 cache
In-Reply-To: <20170609083123.6539-1-jlu@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <20170609083123.6539-7-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/include/asm/hardware/cache-aurora-l2.h |  49 +++++
 drivers/edac/Kconfig                            |   7 +
 drivers/edac/Makefile                           |   1 +
 drivers/edac/aurora_l2_edac.c                   | 252 ++++++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 drivers/edac/aurora_l2_edac.c

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index dc5c479ec4c3..80e4aad136df 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -14,6 +14,10 @@
 #ifndef __ASM_ARM_HARDWARE_AURORA_L2_H
 #define __ASM_ARM_HARDWARE_AURORA_L2_H
 
+/* Parity and ECC are configured in L2X0_AUX_CTRL */
+#define AURORA_CTRL_PARITY_EN	(1 << 21)
+#define AURORA_CTRL_ECC_EN	(1 << 20)
+
 #define AURORA_SYNC_REG		    0x700
 #define AURORA_RANGE_BASE_ADDR_REG  0x720
 #define AURORA_FLUSH_PHY_ADDR_REG   0x7f0
@@ -41,6 +45,51 @@
 #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
 	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
 
+#define AURORA_ERR_CNT_REG          0x600
+#define AURORA_ERR_ATTR_CAP_REG     0x608
+#define AURORA_ERR_ADDR_CAP_REG     0x60c
+#define AURORA_ERR_WAY_CAP_REG      0x610
+#define AURORA_ERR_INJECT_CTL_REG   0x614
+#define AURORA_ERR_INJECT_MASK_REG  0x618
+
+#define AURORA_ERR_CNT_CLR_OFFSET         31
+#define AURORA_ERR_CNT_CLR		   \
+	(0x1 << AURORA_ERR_CNT_CLR_OFFSET)
+#define AURORA_ERR_CNT_UE_OFFSET          16
+#define AURORA_ERR_CNT_UE_MASK             \
+	(0x7fff << AURORA_ERR_CNT_UE_OFFSET)
+#define AURORA_ERR_CNT_CE_OFFSET            0
+#define AURORA_ERR_CNT_CE_MASK              \
+	(0xffff << AURORA_ERR_CNT_CE_OFFSET)
+
+#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET       16
+#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_MASK          \
+	(0x7 << AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET       12
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_MASK          \
+	(0xf << AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET          8
+#define AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK            \
+	(0x3 << AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_VALID_OFFSET             0
+#define AURORA_ERR_ATTR_CAP_VALID                    \
+	(0x1 << AURORA_ERR_ATTR_CAP_VALID_OFFSET)
+
+#define AURORA_ERR_ADDR_CAP_ADDR_MASK 0xffffffe0
+
+#define AURORA_ERR_WAY_CAP_INDEX_OFFSET          8
+#define AURORA_ERR_WAY_CAP_INDEX_MASK            \
+	(0xfff << AURORA_ERR_WAY_CAP_INDEX_OFFSET)
+#define AURORA_ERR_WAY_CAP_WAY_OFFSET          1
+#define AURORA_ERR_WAY_CAP_WAY_MASK            \
+	(0xf << AURORA_ERR_WAY_CAP_WAY_OFFSET)
+
+#define AURORA_ERR_INJECT_CTL_ADDR_MASK 0xfffffff0
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET   12
+#define AURORA_ERR_INJECT_CTL_EN_MASK          0x3
+#define AURORA_ERR_INJECT_CTL_EN_PARITY        0x2
+#define AURORA_ERR_INJECT_CTL_EN_ECC           0x1
+
 #define AURORA_MAX_RANGE_SIZE	1024
 
 #define AURORA_WAY_SIZE_SHIFT	2
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2aeed18..8d9f680c8545 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -443,6 +443,13 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_AURORA_L2
+	bool "Marvell AURORA L2 Cache ECC"
+	depends on ARCH_MVEBU
+	help
+	  Support for error correction and detection on the Marvell AURORA L2
+	  cache controller (as found on ARMADA XP).
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on ARCH_ZYNQ
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 0fd9ffa63299..04654da04fc9 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -76,5 +76,6 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
+obj-$(CONFIG_EDAC_AURORA_L2)		+= aurora_l2_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
diff --git a/drivers/edac/aurora_l2_edac.c b/drivers/edac/aurora_l2_edac.c
new file mode 100644
index 000000000000..8bb0ca03e5de
--- /dev/null
+++ b/drivers/edac/aurora_l2_edac.c
@@ -0,0 +1,252 @@
+/*
+ * Copyright (C) 2017 Pengutronix, Jan Luebbe <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/edac.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/cache-aurora-l2.h>
+
+#include "edac_device.h"
+#include "edac_module.h"
+
+struct aurora_l2_edac_drvdata {
+	void __iomem *base;
+
+	char msg[128];
+
+	/* error injection via debugfs */
+	uint32_t inject_addr;
+	uint32_t inject_mask;
+	uint8_t inject_ctl;
+
+	struct dentry *debugfs;
+};
+
+static void aurora_l2_edac_inject(struct aurora_l2_edac_drvdata *drvdata)
+{
+	drvdata->inject_addr &= AURORA_ERR_INJECT_CTL_ADDR_MASK;
+	drvdata->inject_ctl &= AURORA_ERR_INJECT_CTL_EN_MASK;
+	writel(0, drvdata->base + AURORA_ERR_INJECT_CTL_REG);
+	writel(drvdata->inject_mask,
+	       drvdata->base + AURORA_ERR_INJECT_MASK_REG);
+	writel(drvdata->inject_addr | drvdata->inject_ctl,
+	       drvdata->base + AURORA_ERR_INJECT_CTL_REG);
+}
+
+static void aurora_l2_edac_check(struct edac_device_ctl_info *dci)
+{
+	struct aurora_l2_edac_drvdata *drvdata = dci->pvt_info;
+	uint32_t cnt, attr_cap, addr_cap, way_cap;
+	unsigned int cnt_ce, cnt_ue;
+
+	cnt = readl(drvdata->base + AURORA_ERR_CNT_REG);
+	attr_cap = readl(drvdata->base + AURORA_ERR_ATTR_CAP_REG);
+	addr_cap = readl(drvdata->base + AURORA_ERR_ADDR_CAP_REG);
+	way_cap = readl(drvdata->base + AURORA_ERR_WAY_CAP_REG);
+
+	cnt_ce = (cnt & AURORA_ERR_CNT_CE_MASK) >> AURORA_ERR_CNT_CE_OFFSET;
+	cnt_ue = (cnt & AURORA_ERR_CNT_UE_MASK) >> AURORA_ERR_CNT_UE_OFFSET;
+	/* clear error counter registers */
+	if (cnt_ce || cnt_ue)
+		writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
+
+	if (attr_cap & AURORA_ERR_ATTR_CAP_VALID) {
+		char *msg = drvdata->msg;
+		switch ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_SOURCE_MASK)
+			>> AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET) {
+		case 0:
+			msg += sprintf(msg, "src=CPU0 ");
+			break;
+		case 1:
+			msg += sprintf(msg, "src=CPU1 ");
+			break;
+		case 2:
+			msg += sprintf(msg, "src=CPU2 ");
+			break;
+		case 3:
+			msg += sprintf(msg, "src=CPU3 ");
+			break;
+		case 7:
+			msg += sprintf(msg, "src=IO ");
+			break;
+		}
+		/* msg size <= 9 */
+		switch ((attr_cap & AURORA_ERR_ATTR_CAP_TRANS_TYPE_MASK)
+			>> AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET) {
+		case 0:
+			msg += sprintf(msg, "txn=Data-Read ");
+			break;
+		case 1:
+			msg += sprintf(msg, "txn=Isn-Read ");
+			break;
+		case 2:
+			msg += sprintf(msg, "txn=Clean-Flush ");
+			break;
+		case 3:
+			msg += sprintf(msg, "txn=Eviction ");
+			break;
+		case 4:
+			msg += sprintf(msg, "txn=Read-Modify-Write ");
+			break;
+		}
+		/* msg size <= 31 */
+		switch ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK)
+			>> AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET) {
+		case 0:
+			msg += sprintf(msg, "err=CorrECC ");
+			break;
+		case 1:
+			msg += sprintf(msg, "err=UnCorrECC ");
+			break;
+		case 2:
+			msg += sprintf(msg, "err=TagParity ");
+			break;
+		}
+		/* msg size <= 45 */
+		msg +=
+		    sprintf(msg, "addr=0x%x ",
+			    addr_cap & AURORA_ERR_ADDR_CAP_ADDR_MASK);
+		msg +=
+		    sprintf(msg, "index=0x%x ",
+			    (way_cap & AURORA_ERR_WAY_CAP_INDEX_MASK)
+			    >> AURORA_ERR_WAY_CAP_INDEX_OFFSET);
+		msg +=
+		    sprintf(msg, "way=0x%x",
+			    (way_cap & AURORA_ERR_WAY_CAP_WAY_MASK)
+			    >> AURORA_ERR_WAY_CAP_WAY_OFFSET);
+		/* msg size <= 92 */
+		/* clear error capture registers */
+		writel(AURORA_ERR_ATTR_CAP_VALID,
+		       drvdata->base + AURORA_ERR_ATTR_CAP_REG);
+		if ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK)
+		    >> AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET) {
+			/* UnCorrECC or TagParity */
+			if (cnt_ue)
+				cnt_ue--;
+			edac_device_handle_ue(dci, 0, 0, drvdata->msg);
+		} else {
+			if (cnt_ce)
+				cnt_ce--;
+			edac_device_handle_ce(dci, 0, 0, drvdata->msg);
+		}
+	}
+
+	/* report remaining errors */
+	while (cnt_ue--)
+		edac_device_handle_ue(dci, 0, 0,
+				      "details unavailable (multiple errors)");
+	while (cnt_ce--)
+		edac_device_handle_ue(dci, 0, 0,
+				      "details unavailable (multiple errors)");
+
+	aurora_l2_edac_inject(drvdata);
+}
+
+static const struct of_device_id aurora_l2_edac_of_match[] = {
+	{.compatible = "marvell,aurora-system-cache",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, aurora_l2_edac_of_match);
+
+static int aurora_l2_edac_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct edac_device_ctl_info *dci;
+	struct aurora_l2_edac_drvdata *drvdata;
+	struct resource *r;
+	uint32_t l2x0_aux_ctrl;
+
+	dci =
+	    devm_edac_device_alloc_ctl_info(&pdev->dev, sizeof(*drvdata), "cpu",
+					    1, "L", 1, 2, NULL, 0, 0);
+	if (!dci)
+		return -ENOMEM;
+
+	drvdata = dci->pvt_info;
+	dci->dev = &pdev->dev;
+	platform_set_drvdata(pdev, dci);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "Unable to get mem resource\n");
+		return -ENODEV;
+	}
+
+	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(&pdev->dev, "Unable to map regs\n");
+		return PTR_ERR(drvdata->base);
+	}
+
+	l2x0_aux_ctrl = readl(drvdata->base + L2X0_AUX_CTRL);
+	if (!(l2x0_aux_ctrl & AURORA_CTRL_PARITY_EN))
+		dev_warn(&pdev->dev, "tag parity is not enabled");
+	if (!(l2x0_aux_ctrl & AURORA_CTRL_ECC_EN))
+		dev_warn(&pdev->dev, "data ECC is not enabled");
+
+	id = of_match_device(aurora_l2_edac_of_match, &pdev->dev);
+	dci->edac_check = aurora_l2_edac_check;
+	dci->mod_name = pdev->dev.driver->name;
+	dci->ctl_name = id ? id->compatible : "unknown";
+	dci->dev_name = dev_name(&pdev->dev);
+
+	/* clear registers */
+	writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
+	writel(AURORA_ERR_ATTR_CAP_VALID,
+	       drvdata->base + AURORA_ERR_ATTR_CAP_REG);
+
+	if (devm_edac_device_add_device(&pdev->dev, dci))
+		return -EINVAL;
+
+	drvdata->debugfs = edac_debugfs_create_dir(dev_name(&pdev->dev));
+	if (drvdata->debugfs) {
+		edac_debugfs_create_x32("inject_addr", S_IRUGO | S_IWUSR,
+					drvdata->debugfs,
+					&drvdata->inject_addr);
+		edac_debugfs_create_x32("inject_mask", S_IRUGO | S_IWUSR,
+					drvdata->debugfs,
+					&drvdata->inject_mask);
+		edac_debugfs_create_x8("inject_ctl", S_IRUGO | S_IWUSR,
+				       drvdata->debugfs, &drvdata->inject_ctl);
+	}
+
+	return 0;
+}
+
+static int aurora_l2_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+	struct aurora_l2_edac_drvdata *drvdata = dci->pvt_info;
+
+	edac_debugfs_remove_recursive(drvdata->debugfs);
+	return 0;
+}
+
+static struct platform_driver aurora_l2_edac_driver = {
+	.probe = aurora_l2_edac_probe,
+	.remove = aurora_l2_edac_remove,
+	.driver = {
+		.name = "aurora_l2_edac",
+		.of_match_table = aurora_l2_edac_of_match,
+	},
+};
+
+module_platform_driver(aurora_l2_edac_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Pengutronix");
+MODULE_DESCRIPTION("EDAC Driver for Marvell Aurora L2 Cache");
-- 
2.11.0
