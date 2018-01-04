From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:13 +0200
Subject: [PATCH v2 09/11] clk: qcom: Add ACD path to CPU clock driver for
 msm8996
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-10-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMUX for each duplex allows for selection of ACD clock source.
The DVM (Dynamic Variation Monitor) will flag an error
when a voltage droop event is detected. This flagged error
enables ACD to provide a div-by-2 clock, sourced from the primary PLL.
The duplex will be provided the divided clock
until a pre-programmed delay has expired.

This change configures ACD during the probe and switches
the PMUXes to the ACD clock source.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 122 ++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index f1bfd13..d38ff6d 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/clk-provider.h>
 #include "clk-alpha-pll.h"
+#include <soc/qcom/kryo-l2-accessors.h>
 
 #define VCO(a, b, c) { \
 	.val = a,\
@@ -29,6 +30,27 @@
 #define ACD_INDEX		2
 #define ALT_INDEX		3
 #define DIV_2_THRESHOLD		600000000
+#define PWRCL_REG_OFFSET 0x0
+#define PERFCL_REG_OFFSET 0x80000
+#define MUX_OFFSET	0x40
+#define ALT_PLL_OFFSET	0x100
+#define SSSCTL_OFFSET 0x160
+/*
+APCy_QLL_SSSCTL value:
+SACDRCLEN=1
+SSWEN=1
+SSTRTEN=1
+SSTPAPMSWEN=1
+*/
+#define SSSCTL_VAL 0xF
+
+enum {
+	APC_BASE,
+	EFUSE_BASE,
+	NUM_BASES
+};
+
+static void __iomem *vbases[NUM_BASES];
 
 /* PLLs */
 
@@ -44,7 +66,7 @@
 };
 
 static struct clk_alpha_pll perfcl_pll = {
-	.offset = 0x80000,
+	.offset = PERFCL_REG_OFFSET,
 	.min_rate = 600000000,
 	.max_rate = 3000000000,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_16BIT_ALPHA
@@ -58,7 +80,7 @@
 };
 
 static struct clk_alpha_pll pwrcl_pll = {
-	.offset = 0x0,
+	.offset = PWRCL_REG_OFFSET,
 	.min_rate = 600000000,
 	.max_rate = 3000000000,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_16BIT_ALPHA
@@ -90,7 +112,7 @@
 };
 
 static struct clk_alpha_pll perfcl_alt_pll = {
-	.offset = 0x80100,
+	.offset = PERFCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
@@ -103,7 +125,7 @@
 };
 
 static struct clk_alpha_pll pwrcl_alt_pll = {
-	.offset = 0x100,
+	.offset = PWRCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
@@ -114,6 +136,7 @@
 		.ops = &clk_alpha_pll_hwfsm_ops,
 	},
 };
+static void qcom_cpu_clk_msm8996_acd_init(void);
 
 /* Mux'es */
 
@@ -197,6 +220,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		qcom_cpu_clk_msm8996_acd_init();
 		break;
 	case POST_RATE_CHANGE:
 		if (cnd->new_rate < DIV_2_THRESHOLD)
@@ -204,7 +228,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 							  DIV_2_INDEX);
 		else
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  PLL_INDEX);
+							  ACD_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -221,7 +245,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux pwrcl_smux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -237,7 +261,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux perfcl_smux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -253,7 +277,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux pwrcl_pmux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
@@ -274,7 +298,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux perfcl_pmux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
@@ -342,7 +366,17 @@ struct clk_hw_clks {
 						   CLK_SET_RATE_PARENT, 1, 2);
 	pwrcl_smux.pll = hws->hws[1];
 
-	hws->num = 2;
+	hws->hws[2] = clk_hw_register_fixed_factor(dev, "perfcl_pll_acd",
+						   "perfcl_pll",
+						   CLK_SET_RATE_PARENT, 1, 1);
+	perfcl_pmux.pll = hws->hws[2];
+
+	hws->hws[3] = clk_hw_register_fixed_factor(dev, "pwrcl_pll_acd",
+						   "pwrcl_pll",
+						   CLK_SET_RATE_PARENT, 1, 1);
+	pwrcl_pmux.pll = hws->hws[3];
+
+	hws->num = 4;
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		ret = devm_clk_register_regmap(dev, clks[i]);
@@ -378,10 +412,65 @@ struct clk_hw_clks {
 	return ret;
 }
 
+#define CPU_AFINITY_MASK 0xFFF
+#define PWRCL_CPU_REG_MASK 0x3
+#define PERFCL_CPU_REG_MASK 0x103
+
+/* ACD static settings (HMSS HPG 7.2.2) */
+#define L2ACDCR_REG 0x580ULL
+#define L2ACDTD_REG 0x581ULL
+#define L2ACDDVMRC_REG 0x584ULL
+#define L2ACDSSCR_REG 0x589ULL
+#define ACDTD_VAL 0x00006A11
+#define ACDCR_VAL 0x002C5FFD
+#define ACDSSCR_VAL 0x00000601
+#define ACDDVMRC_VAL 0x000E0F0F
+
+static DEFINE_SPINLOCK(acd_lock);
+
+static void qcom_cpu_clk_msm8996_acd_init(void)
+{
+	u64 hwid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&acd_lock, flags);
+
+	hwid = read_cpuid_mpidr() & CPU_AFINITY_MASK;
+
+	/* Program ACD Tunable-Length Delay (TLD) */
+	set_l2_indirect_reg(L2ACDTD_REG, ACDTD_VAL);
+	/* Initial ACD for *this* cluster */
+	set_l2_indirect_reg(L2ACDDVMRC_REG, ACDDVMRC_VAL);
+	/* Program ACD soft start control bits. */
+	set_l2_indirect_reg(L2ACDSSCR_REG, ACDSSCR_VAL);
+
+	if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
+		/* Enable Soft Stop/Start */
+		if (vbases[APC_BASE])
+			writel_relaxed(SSSCTL_VAL, vbases[APC_BASE] +
+					PWRCL_REG_OFFSET + SSSCTL_OFFSET);
+		/* Ensure SSSCTL config goes through before enabling ACD. */
+		mb();
+		/* Program ACD control bits */
+		set_l2_indirect_reg(L2ACDCR_REG, ACDCR_VAL);
+	}
+	if (PERFCL_CPU_REG_MASK == (hwid | PERFCL_CPU_REG_MASK)) { //else {
+		/* Program ACD control bits */
+		set_l2_indirect_reg(L2ACDCR_REG, ACDCR_VAL);
+		/* Enable Soft Stop/Start */
+		if (vbases[APC_BASE])
+			writel_relaxed(SSSCTL_VAL, vbases[APC_BASE] +
+					PERFCL_REG_OFFSET + SSSCTL_OFFSET);
+		/* Ensure SSSCTL config goes through before enabling ACD. */
+		mb();
+	}
+
+	spin_unlock_irqrestore(&acd_lock, flags);
+}
+
 static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 {
 	int ret;
-	void __iomem *base;
 	struct resource *res;
 	struct regmap *regmap_cpu;
 	struct clk_hw_clks *hws;
@@ -394,17 +483,17 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	hws = devm_kzalloc(dev, sizeof(*hws) + 2 * sizeof(struct clk_hw *),
+	hws = devm_kzalloc(dev, sizeof(*hws) + 4 * sizeof(struct clk_hw *),
 			   GFP_KERNEL);
 	if (!hws)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	vbases[APC_BASE] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vbases[APC_BASE]))
+		return PTR_ERR(vbases[APC_BASE]);
 
-	regmap_cpu = devm_regmap_init_mmio(dev, base,
+	regmap_cpu = devm_regmap_init_mmio(dev, vbases[APC_BASE],
 					   &cpu_msm8996_regmap_config);
 	if (IS_ERR(regmap_cpu))
 		return PTR_ERR(regmap_cpu);
@@ -412,6 +501,7 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 	ret = qcom_cpu_clk_msm8996_register_clks(dev, hws, regmap_cpu);
 	if (ret)
 		return ret;
+	qcom_cpu_clk_msm8996_acd_init();
 
 	data->hws[0] = &pwrcl_pmux.clkr.hw;
 	data->hws[1] = &perfcl_pmux.clkr.hw;
-- 
1.9.1
