From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri,  9 Jun 2017 10:31:23 +0200
Subject: [RFC PATCH 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 controller
In-Reply-To: <20170609083123.6539-1-jlu@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <20170609083123.6539-8-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/edac/Kconfig             |   7 +
 drivers/edac/Makefile            |   1 +
 drivers/edac/armada_xp_mc_edac.c | 366 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 drivers/edac/armada_xp_mc_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 8d9f680c8545..4189061489af 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -443,6 +443,13 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_ARMADA_XP
+	bool "Marvell Armada XP Memory Controller ECC"
+	depends on ARCH_MVEBU
+	help
+	  Support for error correction and detection on the Marvell Aramada XP
+	  memory controller.
+
 config EDAC_AURORA_L2
 	bool "Marvell AURORA L2 Cache ECC"
 	depends on ARCH_MVEBU
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 04654da04fc9..3497404e6d97 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
+obj-$(CONFIG_EDAC_ARMADA_XP)		+= armada_xp_mc_edac.o
 obj-$(CONFIG_EDAC_AURORA_L2)		+= aurora_l2_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
diff --git a/drivers/edac/armada_xp_mc_edac.c b/drivers/edac/armada_xp_mc_edac.c
new file mode 100644
index 000000000000..2ac298227d9c
--- /dev/null
+++ b/drivers/edac/armada_xp_mc_edac.c
@@ -0,0 +1,366 @@
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
+#include "edac_mc.h"
+#include "edac_module.h"
+
+#define SDRAM_NUM_CS 4
+
+#define SDRAM_CONFIG_REG 0x0
+#define SDRAM_CONFIG_ECC_MASK        BIT(18)
+#define SDRAM_CONFIG_REGISTERED_MASK BIT(17)
+#define SDRAM_CONFIG_BUS_WIDTH_MASK  BIT(15)
+
+#define SDRAM_ADDR_CTRL_REG 0x10
+#define SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(cs)   (20+cs)
+#define SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(cs)           \
+	(0x1 << SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(cs))
+#define SDRAM_ADDR_CTRL_ADDR_SEL_MASK(cs)   BIT(16+cs)
+#define SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(cs)   (cs*4+2)
+#define SDRAM_ADDR_CTRL_SIZE_LOW_MASK(cs)            \
+	(0x3 << SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(cs))
+#define SDRAM_ADDR_CTRL_STRUCT_OFFSET(cs)       (cs*4)
+#define SDRAM_ADDR_CTRL_STRUCT_MASK(cs)              \
+	(0x3 << SDRAM_ADDR_CTRL_STRUCT_OFFSET(cs))
+
+#define SDRAM_ERR_DATA_H_REG 0x40
+#define SDRAM_ERR_DATA_L_REG 0x44
+
+#define SDRAM_ERR_RECV_ECC_REG 0x48
+#define SDRAM_ERR_RECV_ECC_VALUE_MASK 0xff
+
+#define SDRAM_ERR_CALC_ECC_REG 0x4c
+#define SDRAM_ERR_CALC_ECC_ROW_OFFSET             8
+#define SDRAM_ERR_CALC_ECC_ROW_MASK               \
+	(0xffff << SDRAM_ERR_CALC_ECC_ROW_OFFSET)
+#define SDRAM_ERR_CALC_ECC_VALUE_MASK          0xff
+
+#define SDRAM_ERR_ADDR_REG 0x50
+#define SDRAM_ERR_ADDR_BANK_OFFSET           23
+#define SDRAM_ERR_ADDR_BANK_MASK              \
+	(0x7 << SDRAM_ERR_ADDR_BANK_OFFSET)
+#define SDRAM_ERR_ADDR_COL_OFFSET             8
+#define SDRAM_ERR_ADDR_COL_MASK               \
+	(0x7fff << SDRAM_ERR_ADDR_COL_OFFSET)
+#define SDRAM_ERR_ADDR_CS_OFFSET              1
+#define SDRAM_ERR_ADDR_CS_MASK                \
+	(0x3 << SDRAM_ERR_ADDR_CS_OFFSET)
+#define SDRAM_ERR_ADDR_TYPE_MASK         BIT(0)
+
+#define SDRAM_ERR_CTRL_REG 0x54
+#define SDRAM_ERR_CTRL_ERR_THR_OFFSET          16
+#define SDRAM_ERR_CTRL_ERR_THR_MASK             \
+	(0xff << SDRAM_ERR_CTRL_ERR_THR_OFFSET)
+#define SDRAM_ERR_CTRL_ERR_PROP_MASK       BIT(9)
+
+#define SDRAM_ERR_SBE_COUNT_REG 0x58
+#define SDRAM_ERR_DBE_COUNT_REG 0x5c
+
+#define SDRAM_ERR_CAUSE_ERR_REG 0xd0
+#define SDRAM_ERR_CAUSE_MSG_REG 0xd8
+#define SDRAM_ERR_CAUSE_DBE_MASK BIT(1)
+#define SDRAM_ERR_CAUSE_SBE_MASK BIT(0)
+
+#define SDRAM_RANK_CTRL_REG 0x1e0
+#define SDRAM_RANK_CTRL_EXIST_MASK(cs) BIT(cs)
+
+struct armada_xp_mc_edac_drvdata {
+	void __iomem *base;
+
+	bool full_width; /* 32 or 64 bit */
+	bool cs_addr_sel[SDRAM_NUM_CS]; /* bank interleaving */
+
+	char msg[128];
+};
+
+/* derived from "DRAM Address Multiplexing" in the ARAMDA XP Functonal Spec */
+static uint32_t armada_xp_mc_edac_calc_address(struct armada_xp_mc_edac_drvdata
+					       *drvdata, uint8_t cs,
+					       uint8_t bank, uint16_t row,
+					       uint16_t col)
+{
+	if (drvdata->full_width) { /* 64 bit */
+		if (drvdata->cs_addr_sel[cs]) /* bank interleaved */
+			return (((row & 0xfff8) << 16) |
+				((bank & 0x7) << 16) |
+				((row & 0x7) << 13) |
+				((col & 0x3ff) << 3));
+		else
+			return (((row & 0xffff << 16) |
+				 ((bank & 0x7) << 13) |
+				 ((col & 0x3ff)) << 3));
+	} else { /* 32 bit */
+		if (drvdata->cs_addr_sel[cs]) /* bank interleaved */
+			return (((row & 0xfff0) << 15) |
+				((bank & 0x7) << 16) |
+				((row & 0xf) << 12) |
+				((col & 0x3ff) << 2));
+		else
+			return (((row & 0xffff << 15) |
+				 ((bank & 0x7) << 12) |
+				 ((col & 0x3ff)) << 2));
+	}
+}
+
+static void armada_xp_mc_edac_check(struct mem_ctl_info *mci)
+{
+	struct armada_xp_mc_edac_drvdata *drvdata = mci->pvt_info;
+	uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
+	uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
+	uint32_t row_val, col_val, bank_val, addr_val;
+	uint8_t syndrome_val, cs_val;
+	char *msg = drvdata->msg;
+
+	data_h = readl(drvdata->base + SDRAM_ERR_DATA_H_REG);
+	data_l = readl(drvdata->base + SDRAM_ERR_DATA_L_REG);
+	recv_ecc = readl(drvdata->base + SDRAM_ERR_RECV_ECC_REG);
+	calc_ecc = readl(drvdata->base + SDRAM_ERR_CALC_ECC_REG);
+	addr = readl(drvdata->base + SDRAM_ERR_ADDR_REG);
+	cnt_sbe = readl(drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	cnt_dbe = readl(drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+	cause_err = readl(drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
+	cause_msg = readl(drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear cause registers */
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear error counter registers */
+	if (cnt_sbe)
+		writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	if (cnt_dbe)
+		writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+
+	if (!cnt_sbe && !cnt_dbe)
+		return;
+
+	if ((addr & SDRAM_ERR_ADDR_TYPE_MASK) == 0) {
+		if (cnt_sbe)
+			cnt_sbe--;
+		else
+			dev_warn(mci->pdev, "inconsistent SBE count detected");
+	} else {
+		if (cnt_dbe)
+			cnt_dbe--;
+		else
+			dev_warn(mci->pdev, "inconsistent DBE count detected");
+	}
+
+	/* report earlier errors */
+	if (cnt_sbe)
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, cnt_sbe, /* error count */
+				     0, 0, 0, /* pfn, offset, syndrome */
+				     -1, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name,
+				     "details unavailable (multiple errors)");
+	if (cnt_dbe)
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, cnt_sbe, /* error count */
+				     0, 0, 0, /* pfn, offset, syndrome */
+				     -1, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name,
+				     "details unavailable (multiple errors)");
+
+	/* report details for most recent error */
+	cs_val = (addr & SDRAM_ERR_ADDR_CS_MASK)
+	    >> SDRAM_ERR_ADDR_CS_OFFSET;
+	bank_val = (addr & SDRAM_ERR_ADDR_BANK_MASK)
+	    >> SDRAM_ERR_ADDR_BANK_OFFSET;
+	row_val = (calc_ecc & SDRAM_ERR_CALC_ECC_ROW_MASK)
+	    >> SDRAM_ERR_CALC_ECC_ROW_OFFSET;
+	col_val = (addr & SDRAM_ERR_ADDR_COL_MASK)
+	    >> SDRAM_ERR_ADDR_COL_OFFSET;
+	syndrome_val = (recv_ecc ^ calc_ecc) & 0xff;
+	addr_val = armada_xp_mc_edac_calc_address(drvdata, cs_val, bank_val,
+						  row_val, col_val);
+	msg += sprintf(msg, "row=0x%04x ", row_val); /* 11 chars */
+	msg += sprintf(msg, "bank=0x%x ", bank_val); /*  9 chars */
+	msg += sprintf(msg, "col=0x%04x ", col_val); /* 11 chars */
+	msg += sprintf(msg, "cs=%d", cs_val);	     /*  4 chars */
+
+	if ((addr & SDRAM_ERR_ADDR_TYPE_MASK) == 0) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1,	/* error count */
+				     addr_val >> PAGE_SHIFT,
+				     addr_val & ~PAGE_MASK,
+				     syndrome_val,
+				     cs_val, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name, drvdata->msg);
+	} else {
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1,	/* error count */
+				     addr_val >> PAGE_SHIFT,
+				     addr_val & ~PAGE_MASK,
+				     syndrome_val,
+				     cs_val, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name, drvdata->msg);
+	}
+}
+
+static const struct of_device_id armada_xp_mc_edac_of_match[] = {
+	{.compatible = "marvell,armada-xp-sdram-controller",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, armada_xp_mc_edac_of_match);
+
+static int armada_xp_mc_edac_read_config(struct mem_ctl_info *mci)
+{
+	struct armada_xp_mc_edac_drvdata *drvdata = mci->pvt_info;
+	struct dimm_info *dimm;
+	unsigned int i, cs_struct, cs_size;
+	uint32_t config, addr_ctrl, rank_ctrl;
+
+	config = readl(drvdata->base + SDRAM_CONFIG_REG);
+	if (!(config & SDRAM_CONFIG_ECC_MASK))
+		dev_warn(mci->pdev, "SDRAM ECC is not enabled");
+
+	if (mci->tot_dimms != SDRAM_NUM_CS) {
+		dev_err(mci->pdev, "Invaild number of DIMMs");
+		return -EINVAL;
+	}
+
+	drvdata->full_width = !!(config & SDRAM_CONFIG_BUS_WIDTH_MASK);
+
+	addr_ctrl = readl(drvdata->base + SDRAM_ADDR_CTRL_REG);
+	rank_ctrl = readl(drvdata->base + SDRAM_RANK_CTRL_REG);
+	for (i = 0; i < SDRAM_NUM_CS; i++) {
+		dimm = mci->dimms[i];
+
+		if (!(rank_ctrl & SDRAM_RANK_CTRL_EXIST_MASK(i)))
+			continue;
+
+		drvdata->cs_addr_sel[i] =
+			!!(addr_ctrl & SDRAM_ADDR_CTRL_ADDR_SEL_MASK(i));
+
+		cs_struct = (addr_ctrl & SDRAM_ADDR_CTRL_STRUCT_MASK(i)) >>
+			SDRAM_ADDR_CTRL_STRUCT_OFFSET(i);
+		cs_size = ((addr_ctrl & SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(i)) >>
+			   (SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(i) - 2) |
+			   (addr_ctrl & SDRAM_ADDR_CTRL_SIZE_LOW_MASK(i) >>
+			    SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(i)));
+		switch (cs_size) {
+		case 0: /* 2GBit */
+			dimm->nr_pages = (0x80000000ULL >> PAGE_SHIFT);
+			break;
+		case 1: /* 256MBit */
+			dimm->nr_pages = (0x10000000ULL >> PAGE_SHIFT);
+			break;
+		case 2: /* 512MBit */
+			dimm->nr_pages = (0x20000000ULL >> PAGE_SHIFT);
+			break;
+		case 3: /* 1GBit */
+			dimm->nr_pages = (0x40000000ULL >> PAGE_SHIFT);
+			break;
+		case 4: /* 4GBit */
+			dimm->nr_pages = (0x100000000ULL >> PAGE_SHIFT);
+			break;
+		case 5: /* 8GBit */
+			dimm->nr_pages = (0x200000000ULL >> PAGE_SHIFT);
+			break;
+		}
+		dimm->grain = 8;
+		dimm->dtype = cs_struct ? DEV_X16 : DEV_X8;
+		dimm->mtype = (config & SDRAM_CONFIG_REGISTERED_MASK) ? MEM_RDDR3 : MEM_DDR3;
+		dimm->edac_mode = EDAC_SECDED;
+	}
+
+	return 0;
+}
+
+static int armada_xp_mc_edac_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[1];
+	struct armada_xp_mc_edac_drvdata *drvdata;
+	struct resource *r;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = SDRAM_NUM_CS;
+	layers[0].is_virt_csrow = true;
+
+	mci = devm_edac_mc_alloc(&pdev->dev, 0, ARRAY_SIZE(layers), layers,
+				 sizeof(*drvdata));
+	if (!mci)
+		return -ENOMEM;
+
+	drvdata = mci->pvt_info;
+	mci->pdev = &pdev->dev;
+	platform_set_drvdata(pdev, mci);
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
+	id = of_match_device(armada_xp_mc_edac_of_match, &pdev->dev);
+	mci->edac_check = armada_xp_mc_edac_check;
+	mci->mtype_cap = MEM_FLAG_DDR3;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = pdev->dev.driver->name;
+	mci->ctl_name = id ? id->compatible : "unknown";
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->scrub_mode = SCRUB_NONE;
+
+	if (armada_xp_mc_edac_read_config(mci))
+		return -EINVAL;
+
+	/* configure SBE threshold */
+	/* it seems that SBEs are not captured otherwise */
+	writel(1 << SDRAM_ERR_CTRL_ERR_THR_OFFSET,
+	       drvdata->base + SDRAM_ERR_CTRL_REG);
+
+	/* clear cause registers */
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear counter registers */
+	writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+
+	if (devm_edac_mc_add_mc(&pdev->dev, mci))
+		return -EINVAL;
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	return 0;
+}
+
+static struct platform_driver armada_xp_mc_edac_driver = {
+	.probe = armada_xp_mc_edac_probe,
+	.driver = {
+		.name = "armada_xp_mc_edac",
+		.of_match_table = armada_xp_mc_edac_of_match,
+	},
+};
+
+module_platform_driver(armada_xp_mc_edac_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Pengutronix");
+MODULE_DESCRIPTION("EDAC Driver for Marvell Armada XP SDRAM Controller");
-- 
2.11.0
