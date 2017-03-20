From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 20 Mar 2017 19:24:04 +0530
Subject: [PATCH v6 2/4] phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips
In-Reply-To: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1490018046-8549-3-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHY transceiver driver for QUSB2 phy controller that provides
HighSpeed functionality for DWC3 controller present on
Qualcomm chipsets.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v5:
 - Rebased on top of phy grouping series. So the driver now sits in
   drivers/phy/qualcomm/
 - Removed instances of readl_relaxed() and writel_relaxed(), and using
   readl() and writel() instead.
 - Replaced regulator handling with regulator_bulk() apis, so that
   qusb2_phy_toggle_power() method is completely dropped.
 - Removed memory barriers from the driver. Instead, using readl() over
   the register to ensure that the write is through to the device.
 - Fixed nits about return statement from probe() and qusb2_phy_poweron().

Changes since v4:
 - Updated the copyright year to 2017.
 - Removed unnecessary of_match_ptr() cast for the match table,
   since the driver is compiled for CONFIG_OF.

Changes since v3:
 - Added 'Reviewed-by' from Stephen.
 - Fixed debug message for qusb2_phy_set_tune2_param().
 - Replaced devm_reset_control_get() with devm_reset_control_get_by_index()
   since we are requesting only one reset.
 - Updated devm_nvmem_cell_get() with a NULL cell id.
 - Made error labels more idiomatic.
 - Refactored qusb2_setbits() and qusb2_clrbits() a little bit to accept
   base address and register offset as two separate arguments.

Changes since v2:
 - Removed selecting 'RESET_CONTROLLER' config.
 - Added error handling for clk_prepare_enable paths.
 - Removed explicitly setting ref_clk rate to 19.2 MHz. Don't need to
   do that since 'xo' is modeled as parent to this clock.
 - Removed 'ref_clk_src' handling. Driver doesn't need to request and
   handle this clock.
 - Moved nvmem_cell_get() to probe function.
 - Simplified phy pll status handling.
 - Using of_device_get_match_data() to get match data.
 - Uniformly using lowercase for hex numbers.
 - Fixed sparse warnings.
 - Using shorter variable names in structure and in functions.
 - Handling various comment style shortcomings.

Changes since v1:
 - removed reference to clk_enabled/pwr_enabled.
 - moved clock and regulator enable code to phy_power_on/off() callbacks.
 - fixed return on EPROBE_DEFER in qusb2_phy_probe().
 - fixed phy create and phy register ordering.
 - removed references to non-lkml links from commit message.
 - took care of other minor nits.
 - Fixed coccinelle warnings -
   'PTR_ERR applied after initialization to constant'
 - Addressed review comment, regarding qfprom access for tune2 param value.
   This driver is now based on qfprom patch[1] that allows byte access now.

 drivers/phy/qualcomm/Kconfig          |  10 +
 drivers/phy/qualcomm/Makefile         |   1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 491 ++++++++++++++++++++++++++++++++++
 3 files changed, 502 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qusb2.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 458d224f18a5..f31f05066da8 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -15,6 +15,16 @@ config PHY_QCOM_IPQ806X_SATA
 	depends on OF
 	select GENERIC_PHY
 
+config PHY_QCOM_QUSB2
+	tristate "Qualcomm QUSB2 PHY Driver"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support the HighSpeed QUSB2 PHY transceiver for USB
+	  controllers on Qualcomm chips. This driver supports the high-speed
+	  PHY which is usually paired with either the ChipIdea or Synopsys DWC3
+	  USB IPs on MSM SOCs.
+
 config PHY_QCOM_UFS
 	tristate "Qualcomm UFS PHY driver"
 	depends on OF && ARCH_QCOM
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index 07f7c7896f4d..eed5327a9206 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
+obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-14nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
new file mode 100644
index 000000000000..2b2b2b5222c4
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -0,0 +1,491 @@
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define QUSB2PHY_PLL_TEST		0x04
+#define CLK_REF_SEL			BIT(7)
+
+#define QUSB2PHY_PLL_TUNE		0x08
+#define QUSB2PHY_PLL_USER_CTL1		0x0c
+#define QUSB2PHY_PLL_USER_CTL2		0x10
+#define QUSB2PHY_PLL_AUTOPGM_CTL1	0x1c
+#define QUSB2PHY_PLL_PWR_CTRL		0x18
+
+#define QUSB2PHY_PLL_STATUS		0x38
+#define PLL_LOCKED			BIT(5)
+
+#define QUSB2PHY_PORT_TUNE1		0x80
+#define QUSB2PHY_PORT_TUNE2		0x84
+#define QUSB2PHY_PORT_TUNE3		0x88
+#define QUSB2PHY_PORT_TUNE4		0x8c
+#define QUSB2PHY_PORT_TUNE5		0x90
+#define QUSB2PHY_PORT_TEST2		0x9c
+
+#define QUSB2PHY_PORT_POWERDOWN		0xb4
+#define CLAMP_N_EN			BIT(5)
+#define FREEZIO_N			BIT(1)
+#define POWER_DOWN			BIT(0)
+
+#define QUSB2PHY_REFCLK_ENABLE		BIT(0)
+
+#define PHY_CLK_SCHEME_SEL		BIT(0)
+
+struct qusb2_phy_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+};
+#define QUSB2_PHY_INIT_CFG(o, v) \
+	{			\
+		.offset = o,	\
+		.val = v,	\
+	}
+
+static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PORT_TUNE1, 0xf8),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PORT_TUNE2, 0xb3),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PORT_TUNE4, 0xc0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+};
+
+struct qusb2_phy_cfg {
+	const struct qusb2_phy_init_tbl *tbl;
+	/* number of entries in the table */
+	unsigned int tbl_num;
+	/* offset to PHY_CLK_SCHEME register in TCSR map */
+	unsigned int clk_scheme_offset;
+};
+
+static const struct qusb2_phy_cfg msm8996_phy_cfg = {
+	.tbl = msm8996_init_tbl,
+	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
+};
+
+static const char * const qusb2_phy_vreg_names[] = {
+	"vdd-phy", "vdda-pll", "vdda-phy-dpdm",
+};
+#define QUSB2_NUM_VREGS		ARRAY_SIZE(qusb2_phy_vreg_names)
+
+/**
+ * struct qusb2_phy - structure holding qusb2 phy attributes
+ *
+ * @phy: generic phy
+ * @base: iomapped memory space for qubs2 phy
+ *
+ * @cfg_ahb_clk: AHB2PHY interface clock
+ * @ref_clk: phy reference clock
+ * @iface_clk: phy interface clock
+ * @phy_reset: phy reset control
+ * @vregs: regulator supplies bulk data
+ *
+ * @tcsr: TCSR syscon register map
+ * @cell: nvmem cell containing phy tuning value
+ *
+ * @cfg: phy config data
+ * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
+ */
+struct qusb2_phy {
+	struct phy *phy;
+	void __iomem *base;
+
+	struct clk *cfg_ahb_clk;
+	struct clk *ref_clk;
+	struct clk *iface_clk;
+	struct reset_control *phy_reset;
+	struct regulator_bulk_data vregs[QUSB2_NUM_VREGS];
+
+	struct regmap *tcsr;
+	struct nvmem_cell *cell;
+
+	const struct qusb2_phy_cfg *cfg;
+	bool has_se_clk_scheme;
+};
+
+static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qcom_qusb2_phy_configure(void __iomem *base,
+				const struct qusb2_phy_init_tbl tbl[],
+				int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		writel(tbl[i].val, base + tbl[i].offset);
+}
+
+/*
+ * Fetches HS Tx tuning value from nvmem and sets the
+ * QUSB2PHY_PORT_TUNE2 register.
+ * For error case, skip setting the value and use the default value.
+ */
+static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
+{
+	struct device *dev = &qphy->phy->dev;
+	u8 *val;
+
+	/*
+	 * Read efuse register having TUNE2 parameter's high nibble.
+	 * If efuse register shows value as 0x0, or if we fail to find
+	 * a valid efuse register settings, then use default value
+	 * as 0xB for high nibble that we have already set while
+	 * configuring phy.
+	 */
+	val = nvmem_cell_read(qphy->cell, NULL);
+	if (IS_ERR(val) || !val[0]) {
+		dev_dbg(dev, "failed to read a valid hs-tx trim value\n");
+		return;
+	}
+
+	/* Fused TUNE2 value is the higher nibble only */
+	qusb2_setbits(qphy->base, QUSB2PHY_PORT_TUNE2, val[0] << 0x4);
+}
+
+static int qusb2_phy_poweron(struct phy *phy)
+{
+	struct qusb2_phy *qphy = phy_get_drvdata(phy);
+	int num = ARRAY_SIZE(qphy->vregs);
+	int ret;
+
+	dev_vdbg(&phy->dev, "%s(): Powering-on QUSB2 phy\n", __func__);
+
+	/* turn on regulator supplies */
+	ret = regulator_bulk_enable(num, qphy->vregs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(qphy->iface_clk);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable iface_clk, %d\n", ret);
+		regulator_bulk_disable(num, qphy->vregs);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qusb2_phy_poweroff(struct phy *phy)
+{
+	struct qusb2_phy *qphy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(qphy->iface_clk);
+
+	regulator_bulk_disable(ARRAY_SIZE(qphy->vregs), qphy->vregs);
+
+	return 0;
+}
+
+static int qusb2_phy_init(struct phy *phy)
+{
+	struct qusb2_phy *qphy = phy_get_drvdata(phy);
+	unsigned int val;
+	unsigned int clk_scheme;
+	int ret;
+
+	dev_vdbg(&phy->dev, "%s(): Initializing QUSB2 phy\n", __func__);
+
+	/* enable ahb interface clock to program phy */
+	ret = clk_prepare_enable(qphy->cfg_ahb_clk);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		return ret;
+	}
+
+	/* Perform phy reset */
+	ret = reset_control_assert(qphy->phy_reset);
+	if (ret) {
+		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
+		goto disable_ahb_clk;
+	}
+
+	/* 100 us delay to keep PHY in reset mode */
+	usleep_range(100, 150);
+
+	ret = reset_control_deassert(qphy->phy_reset);
+	if (ret) {
+		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
+		goto disable_ahb_clk;
+	}
+
+	/* Disable the PHY */
+	qusb2_setbits(qphy->base, QUSB2PHY_PORT_POWERDOWN,
+			CLAMP_N_EN | FREEZIO_N | POWER_DOWN);
+
+	/* save reset value to override reference clock scheme later */
+	val = readl(qphy->base + QUSB2PHY_PLL_TEST);
+
+	qcom_qusb2_phy_configure(qphy->base, qphy->cfg->tbl,
+					qphy->cfg->tbl_num);
+
+	/* Set efuse value for tuning the PHY */
+	qusb2_phy_set_tune2_param(qphy);
+
+	/* Enable the PHY */
+	qusb2_clrbits(qphy->base, QUSB2PHY_PORT_POWERDOWN, POWER_DOWN);
+
+	/* Required to get phy pll lock successfully */
+	usleep_range(150, 160);
+
+	/* Default is single-ended clock on msm8996 */
+	qphy->has_se_clk_scheme = true;
+	/*
+	 * read TCSR_PHY_CLK_SCHEME register to check if single-ended
+	 * clock scheme is selected. If yes, then disable differential
+	 * ref_clk and use single-ended clock, otherwise use differential
+	 * ref_clk only.
+	 */
+	if (qphy->tcsr) {
+		ret = regmap_read(qphy->tcsr, qphy->cfg->clk_scheme_offset,
+							&clk_scheme);
+		if (ret) {
+			dev_err(&phy->dev, "failed to read clk scheme reg\n");
+			goto assert_phy_reset;
+		}
+
+		/* is it a differential clock scheme ? */
+		if (!(clk_scheme & PHY_CLK_SCHEME_SEL)) {
+			dev_vdbg(&phy->dev, "%s(): select differential clk\n",
+								__func__);
+			qphy->has_se_clk_scheme = false;
+		} else {
+			dev_vdbg(&phy->dev, "%s(): select single-ended clk\n",
+								__func__);
+		}
+	}
+
+	if (!qphy->has_se_clk_scheme) {
+		val &= ~CLK_REF_SEL;
+		ret = clk_prepare_enable(qphy->ref_clk);
+		if (ret) {
+			dev_err(&phy->dev, "failed to enable ref clk, %d\n",
+									ret);
+			goto assert_phy_reset;
+		}
+	} else {
+		val |= CLK_REF_SEL;
+	}
+
+	writel(val, qphy->base + QUSB2PHY_PLL_TEST);
+
+	/* ensure above write is through */
+	readl(qphy->base + QUSB2PHY_PLL_TEST);
+
+	/* Required to get phy pll lock successfully */
+	usleep_range(100, 110);
+
+	val = readb(qphy->base + QUSB2PHY_PLL_STATUS);
+	if (!(val & PLL_LOCKED)) {
+		dev_err(&phy->dev,
+			"QUSB2PHY pll lock failed: status reg = %x\n", val);
+		ret = -EBUSY;
+		goto disable_ref_clk;
+	}
+
+	return 0;
+
+disable_ref_clk:
+	if (!qphy->has_se_clk_scheme)
+		clk_disable_unprepare(qphy->ref_clk);
+assert_phy_reset:
+	reset_control_assert(qphy->phy_reset);
+disable_ahb_clk:
+	clk_disable_unprepare(qphy->cfg_ahb_clk);
+	return ret;
+}
+
+static int qusb2_phy_exit(struct phy *phy)
+{
+	struct qusb2_phy *qphy = phy_get_drvdata(phy);
+
+	/* Disable the PHY */
+	qusb2_setbits(qphy->base, QUSB2PHY_PORT_POWERDOWN,
+			CLAMP_N_EN | FREEZIO_N | POWER_DOWN);
+
+	if (!qphy->has_se_clk_scheme)
+		clk_disable_unprepare(qphy->ref_clk);
+
+	reset_control_assert(qphy->phy_reset);
+
+	clk_disable_unprepare(qphy->cfg_ahb_clk);
+
+	return 0;
+}
+
+static const struct phy_ops qusb2_phy_gen_ops = {
+	.init		= qusb2_phy_init,
+	.exit		= qusb2_phy_exit,
+	.power_on	= qusb2_phy_poweron,
+	.power_off	= qusb2_phy_poweroff,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id qusb2_phy_of_match_table[] = {
+	{
+		.compatible	= "qcom,msm8996-qusb2-phy",
+		.data		= &msm8996_phy_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qusb2_phy_of_match_table);
+
+static int qusb2_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qusb2_phy *qphy;
+	struct phy_provider *phy_provider;
+	struct phy *generic_phy;
+	struct resource *res;
+	int ret, i;
+	int num;
+
+	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
+	if (!qphy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qphy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qphy->base))
+		return PTR_ERR(qphy->base);
+
+	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");
+	if (IS_ERR(qphy->cfg_ahb_clk)) {
+		ret = PTR_ERR(qphy->cfg_ahb_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get cfg ahb clk, %d\n", ret);
+		return ret;
+	}
+
+	qphy->ref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(qphy->ref_clk)) {
+		ret = PTR_ERR(qphy->ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get ref clk, %d\n", ret);
+		return ret;
+	}
+
+	qphy->iface_clk = devm_clk_get(dev, "iface");
+	if (IS_ERR(qphy->iface_clk)) {
+		ret = PTR_ERR(qphy->iface_clk);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		qphy->iface_clk = NULL;
+		dev_dbg(dev, "failed to get iface clk, %d\n", ret);
+	}
+
+	qphy->phy_reset = devm_reset_control_get_by_index(&pdev->dev, 0);
+	if (IS_ERR(qphy->phy_reset)) {
+		dev_err(dev, "failed to get phy core reset\n");
+		return PTR_ERR(qphy->phy_reset);
+	}
+
+	num = ARRAY_SIZE(qphy->vregs);
+	for (i = 0; i < num; i++)
+		qphy->vregs[i].supply = qusb2_phy_vreg_names[i];
+
+	ret = devm_regulator_bulk_get(dev, num, qphy->vregs);
+	if (ret) {
+		dev_err(dev, "failed to get regulator supplies\n");
+		return ret;
+	}
+
+	/* Get the specific init parameters of QMP phy */
+	qphy->cfg = of_device_get_match_data(dev);
+
+	qphy->tcsr = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"qcom,tcsr-syscon");
+	if (IS_ERR(qphy->tcsr)) {
+		dev_dbg(dev, "failed to lookup TCSR regmap\n");
+		qphy->tcsr = NULL;
+	}
+
+	qphy->cell = devm_nvmem_cell_get(dev, NULL);
+	if (IS_ERR(qphy->cell)) {
+		if (PTR_ERR(qphy->cell) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		qphy->cell = NULL;
+		dev_dbg(dev, "failed to lookup tune2 hstx trim value\n");
+	}
+
+	generic_phy = devm_phy_create(dev, NULL, &qusb2_phy_gen_ops);
+	if (IS_ERR(generic_phy)) {
+		ret = PTR_ERR(generic_phy);
+		dev_err(dev, "failed to create phy, %d\n", ret);
+		return ret;
+	}
+	qphy->phy = generic_phy;
+
+	dev_set_drvdata(dev, qphy);
+	phy_set_drvdata(generic_phy, qphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (!IS_ERR(phy_provider))
+		dev_info(dev, "Registered Qcom-QUSB2 phy\n");
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver qusb2_phy_driver = {
+	.probe		= qusb2_phy_probe,
+	.driver = {
+		.name	= "qcom-qusb2-phy",
+		.of_match_table = qusb2_phy_of_match_table,
+	},
+};
+
+module_platform_driver(qusb2_phy_driver);
+
+MODULE_AUTHOR("Vivek Gautam <vivek.gautam@codeaurora.org>");
+MODULE_DESCRIPTION("Qualcomm QUSB2 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
