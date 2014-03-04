From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 04 Mar 2014 16:42:38 +0530
Subject: [PATCH v4 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
References: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1393931558-23502-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for exynos5260 clocks in clock driver.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/Makefile         |    1 +
 drivers/clk/samsung/clk-exynos5260.c | 1933 ++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h |  448 ++++++++
 3 files changed, 2382 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-exynos5260.c
 create mode 100644 drivers/clk/samsung/clk-exynos5260.h

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 77313e2..56e7d38 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
+obj-$(CONFIG_SOC_EXYNOS5260)	+= clk-exynos5260.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
new file mode 100644
index 0000000..d5e405c
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -0,0 +1,1933 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for Exynos5260 SoC.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#include "clk-exynos5260.h"
+#include "clk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clk/exynos5260-clk.h>
+
+static LIST_HEAD(clock_reg_cache_list);
+
+struct exynos5260_clock_reg_cache {
+	struct list_head node;
+	void __iomem *reg_base;
+	struct samsung_clk_reg_dump *rdump;
+	unsigned int rd_num;
+};
+
+struct exynos5260_cmu_info {
+	/* list and number of pll clocks */
+	struct samsung_pll_clock *pll_clks;
+	unsigned int nr_pll_clks;
+	/* list and number of mux clocks */
+	struct samsung_mux_clock *mux_clks;
+	unsigned int nr_mux_clks;
+	/* list and number of div clocks */
+	struct samsung_div_clock *div_clks;
+	unsigned int nr_div_clks;
+	/* list and number of gate clocks */
+	struct samsung_gate_clock *gate_clks;
+	unsigned int nr_gate_clks;
+	/* total number of clocks */
+	unsigned int nr_clk_ids;
+
+	/* list and number of clocks registers */
+	unsigned long *clk_regs;
+	unsigned int nr_clk_regs;
+};
+
+/*
+ * Applicable for all 2550 Type PLLS for Exynos5260, listed below
+ * DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL,
+ * BUS_PLL, MEDIA_PLL, G3D_PLL.
+ */
+static const struct samsung_pll_rate_table pll2550_24mhz_tbl[] = {
+	PLL_35XX_RATE(1700000000, 425, 6, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
+	PLL_35XX_RATE(1500000000, 250, 4, 0),
+	PLL_35XX_RATE(1400000000, 175, 3, 0),
+	PLL_35XX_RATE(1300000000, 325, 6, 0),
+	PLL_35XX_RATE(1200000000, 400, 4, 1),
+	PLL_35XX_RATE(1100000000, 275, 3, 1),
+	PLL_35XX_RATE(1000000000, 250, 3, 1),
+	PLL_35XX_RATE(933000000, 311, 4, 1),
+	PLL_35XX_RATE(900000000, 300, 4, 1),
+	PLL_35XX_RATE(800000000, 200, 3, 1),
+	PLL_35XX_RATE(733000000, 733, 12, 1),
+	PLL_35XX_RATE(700000000, 175, 3, 1),
+	PLL_35XX_RATE(667000000, 667, 12, 1),
+	PLL_35XX_RATE(633000000, 211, 4, 1),
+	PLL_35XX_RATE(620000000, 310, 3, 2),
+	PLL_35XX_RATE(600000000, 400, 4, 2),
+	PLL_35XX_RATE(543000000, 362, 4, 2),
+	PLL_35XX_RATE(533000000, 533, 6, 2),
+	PLL_35XX_RATE(500000000, 250, 3, 2),
+	PLL_35XX_RATE(450000000, 300, 4, 2),
+	PLL_35XX_RATE(400000000, 200, 3, 2),
+	PLL_35XX_RATE(350000000, 175, 3, 2),
+	PLL_35XX_RATE(300000000, 400, 4, 3),
+	PLL_35XX_RATE(266000000, 266, 3, 3),
+	PLL_35XX_RATE(200000000, 200, 3, 3),
+	PLL_35XX_RATE(160000000, 160, 3, 3),
+};
+
+/*
+ * Applicable for 2650 Type PLL for AUD_PLL.
+ */
+static const struct samsung_pll_rate_table pll2650_24mhz_tbl[] = {
+	PLL_36XX_RATE(1600000000, 200, 3, 0, 0),
+	PLL_36XX_RATE(1200000000, 100, 2, 0, 0),
+	PLL_36XX_RATE(1000000000, 250, 3, 1, 0),
+	PLL_36XX_RATE(800000000, 200, 3, 1, 0),
+	PLL_36XX_RATE(600000000, 100, 2, 1, 0),
+	PLL_36XX_RATE(532000000, 266, 3, 2, 0),
+	PLL_36XX_RATE(480000000, 160, 2, 2, 0),
+	PLL_36XX_RATE(432000000, 144, 2, 2, 0),
+	PLL_36XX_RATE(400000000, 200, 3, 2, 0),
+	PLL_36XX_RATE(394073130, 459, 7, 2, 49282),
+	PLL_36XX_RATE(333000000, 111, 2, 2, 0),
+	PLL_36XX_RATE(300000000, 100, 2, 2, 0),
+	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
+	PLL_36XX_RATE(200000000, 200, 3, 3, 0),
+	PLL_36XX_RATE(166000000, 166, 3, 3, 0),
+	PLL_36XX_RATE(133000000, 266, 3, 4, 0),
+	PLL_36XX_RATE(100000000, 200, 3, 4, 0),
+	PLL_36XX_RATE(66000000, 176, 2, 5, 0),
+};
+
+static struct of_device_id ext_clk_match[] __initdata = {
+	{ .compatible = "samsung,exynos5260-oscclk", .data = (void *)0, },
+	{ },
+};
+
+#ifdef CONFIG_PM_SLEEP
+
+static int exynos5260_clk_suspend(void)
+{
+	struct exynos5260_clock_reg_cache *cache;
+
+	list_for_each_entry(cache, &clock_reg_cache_list, node)
+		samsung_clk_save(cache->reg_base, cache->rdump,
+				cache->rd_num);
+
+	return 0;
+}
+
+static void exynos5260_clk_resume(void)
+{
+	struct exynos5260_clock_reg_cache *cache;
+
+	list_for_each_entry(cache, &clock_reg_cache_list, node)
+		samsung_clk_restore(cache->reg_base, cache->rdump,
+				cache->rd_num);
+}
+
+static struct syscore_ops exynos5260_clk_syscore_ops = {
+	.suspend = exynos5260_clk_suspend,
+	.resume = exynos5260_clk_resume,
+};
+
+static void exynos5260_clk_sleep_init(void __iomem *reg_base,
+			unsigned long *rdump,
+			unsigned long nr_rdump)
+{
+	struct exynos5260_clock_reg_cache *reg_cache;
+
+	reg_cache = kzalloc(sizeof(struct exynos5260_clock_reg_cache),
+			GFP_KERNEL);
+	if (!reg_cache)
+		panic("could not allocate register cache.\n");
+
+	reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
+
+	if (!reg_cache->rdump)
+		panic("could not allocate register dump storage.\n");
+
+	if (list_empty(&clock_reg_cache_list))
+		register_syscore_ops(&exynos5260_clk_syscore_ops);
+
+	reg_cache->rd_num = nr_rdump;
+	reg_cache->reg_base = reg_base;
+	list_add_tail(&reg_cache->node, &clock_reg_cache_list);
+}
+
+#else
+static void exynos5260_clk_sleep_init(void) {}
+#endif
+
+static struct samsung_clk_provider *
+__init exynos5260_cmu_register_one(struct device_node *np,
+			struct exynos5260_cmu_info *cmu)
+{
+	void __iomem *reg_base;
+	struct samsung_clk_provider *ctx;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
+
+	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
+	if (!ctx)
+		panic("%s: unable to alllocate ctx\n", __func__);
+
+	if (cmu->pll_clks)
+		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
+			reg_base);
+	if (cmu->mux_clks)
+		samsung_clk_register_mux(ctx,  cmu->mux_clks,
+			cmu->nr_mux_clks);
+	if (cmu->div_clks)
+		samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
+	if (cmu->gate_clks)
+		samsung_clk_register_gate(ctx, cmu->gate_clks,
+			cmu->nr_gate_clks);
+	if (cmu->clk_regs)
+		exynos5260_clk_sleep_init(reg_base, cmu->clk_regs,
+			cmu->nr_clk_regs);
+
+	return ctx;
+}
+
+
+/* CMU_AUD */
+
+static unsigned long aud_clk_regs[] __initdata = {
+	MUX_SEL_AUD,
+	DIV_AUD0,
+	DIV_AUD1,
+	EN_ACLK_AUD,
+	EN_PCLK_AUD,
+	EN_SCLK_AUD,
+	EN_IP_AUD,
+};
+
+PNAME(mout_aud_pll_user_p) = {"fin_pll", "fout_aud_pll"};
+PNAME(mout_sclk_aud_i2s_p) = {"mout_aud_pll_user", "ioclk_i2s_cdclk"};
+PNAME(mout_sclk_aud_pcm_p) = {"mout_aud_pll_user", "ioclk_pcm_extclk"};
+
+struct samsung_mux_clock aud_mux_clks[] __initdata = {
+	MUX(0, "mout_sclk_aud_pcm", mout_sclk_aud_pcm_p,
+			MUX_SEL_AUD, 8, 1),
+	MUX(0, "mout_sclk_aud_i2s", mout_sclk_aud_i2s_p,
+			MUX_SEL_AUD, 4, 1),
+	MUX(0, "mout_aud_pll_user", mout_aud_pll_user_p,
+			MUX_SEL_AUD, 0, 1),
+};
+
+struct samsung_div_clock aud_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_aud_131", "mout_aud_pll_user",
+			DIV_AUD0, 0, 4),
+	DIV(0, "dout_sclk_aud_uart", "mout_aud_pll_user",
+			DIV_AUD1, 12, 4),
+	DIV(0, "dout_sclk_aud_pcm", "mout_sclk_aud_pcm",
+			DIV_AUD1, 4, 8),
+	DIV(0, "dout_sclk_aud_i2s", "mout_sclk_aud_i2s",
+			DIV_AUD1, 0, 4),
+};
+
+struct samsung_gate_clock aud_gate_clks[] __initdata = {
+	GATE(AUD_CLK_AUD_UART, "clk_aud_uart", "dout_aclk_aud_131",
+			EN_IP_AUD, 4, 0, 0),
+	GATE(AUD_CLK_PCM, "clk_pcm", "dout_aclk_aud_131", EN_IP_AUD, 3, 0, 0),
+	GATE(AUD_CLK_I2S, "clk_i2s", "dout_aclk_aud_131", EN_IP_AUD, 2, 0, 0),
+	GATE(AUD_CLK_DMAC, "clk_dmac", "dout_aclk_aud_131",
+			EN_IP_AUD, 1, 0, 0),
+	GATE(0, "clk_sramc", "dout_aclk_aud_131", EN_IP_AUD, 0, 0, 0),
+
+	GATE(AUD_SCLK_AUD_UART, "sclk_aud_uart", "dout_sclk_aud_uart",
+			EN_SCLK_AUD, 2, CLK_SET_RATE_PARENT, 0),
+	GATE(AUD_SCLK_PCM, "sclk_aud_pcm", "dout_sclk_aud_pcm",
+			EN_SCLK_AUD, 1, CLK_SET_RATE_PARENT, 0),
+	GATE(AUD_SCLK_I2S, "sclk_aud_i2s", "dout_sclk_aud_i2s",
+			EN_SCLK_AUD, 0, CLK_SET_RATE_PARENT, 0),
+};
+
+static void __init exynos5260_clk_aud_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = aud_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(aud_mux_clks);
+	cmu.div_clks = aud_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(aud_div_clks);
+	cmu.gate_clks = aud_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(aud_gate_clks);
+	cmu.nr_clk_ids = AUD_NR_CLK;
+	cmu.clk_regs = aud_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(aud_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_aud, "samsung,exynos5260-clock-aud",
+		exynos5260_clk_aud_init);
+
+
+/* CMU_DISP */
+
+static unsigned long disp_clk_regs[] __initdata = {
+	MUX_SEL_DISP0,
+	MUX_SEL_DISP1,
+	MUX_SEL_DISP2,
+	MUX_SEL_DISP3,
+	MUX_SEL_DISP4,
+	DIV_DISP,
+	EN_ACLK_DISP,
+	EN_PCLK_DISP,
+	EN_SCLK_DISP0,
+	EN_SCLK_DISP1,
+	EN_IP_DISP,
+	EN_IP_DISP_BUS,
+};
+
+PNAME(mout_phyclk_dptx_phy_ch3_txd_clk_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_ch3_txd_clk"};
+PNAME(mout_phyclk_dptx_phy_ch2_txd_clk_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_ch2_txd_clk"};
+PNAME(mout_phyclk_dptx_phy_ch1_txd_clk_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_ch1_txd_clk"};
+PNAME(mout_phyclk_dptx_phy_ch0_txd_clk_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_ch0_txd_clk"};
+
+PNAME(mout_aclk_disp_222_user_p) = {"fin_pll", "dout_aclk_disp_222"};
+PNAME(mout_sclk_disp_pixel_user_p) = {"fin_pll", "dout_sclk_disp_pixel"};
+PNAME(mout_aclk_disp_333_user_p) = {"fin_pll", "dout_aclk_disp_333"};
+PNAME(mout_phyclk_hdmi_phy_tmds_clko_user_p) = {"fin_pll",
+			"phyclk_hdmi_phy_tmds_clko"};
+PNAME(mout_phyclk_hdmi_phy_ref_clko_user_p) = {"fin_pll",
+			"phyclk_hdmi_phy_ref_clko"};
+PNAME(mout_phyclk_hdmi_phy_pixel_clko_user_p) = {"fin_pll",
+			"phyclk_hdmi_phy_pixel_clko"};
+PNAME(mout_phyclk_hdmi_link_o_tmds_clkhi_user_p) = {"fin_pll",
+			"phyclk_hdmi_link_o_tmds_clkhi"};
+PNAME(mout_phyclk_mipi_dphy_4l_m_txbyte_clkhs_p) = {"fin_pll",
+			"phyclk_mipi_dphy_4l_m_txbyte_clkhs"};
+PNAME(mout_phyclk_dptx_phy_o_ref_clk_24m_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_o_ref_clk_24m"};
+PNAME(mout_phyclk_dptx_phy_clk_div2_user_p) = {"fin_pll",
+			"phyclk_dptx_phy_clk_div2"};
+PNAME(mout_sclk_dsim1_tx_clk_esc_clk_user_p) = {"fin_pll",
+			"sclk_dsim1_txclkescclk"};
+PNAME(mout_sclk_dsim1_tx_clk_esc3_user_p) = {"fin_pll",
+			"sclk_dsim1_txclkesc3"};
+PNAME(mout_sclk_dsim1_tx_clk_esc2_user_p) = {"fin_pll",
+			"sclk_dsim1_txclkesc2"};
+PNAME(mout_sclk_dsim1_tx_clk_esc1_user_p) = {"fin_pll",
+			"sclk_dsim1_txclkesc1"};
+PNAME(mout_sclk_dsim1_tx_clk_esc0_user_p) = {"fin_pll",
+			"sclk_dsim1_txclkesc0"};
+PNAME(mout_sclk_hdmi_pixel_p) = {"mout_sclk_disp_pixel_user",
+			"mout_aclk_disp_222_user"};
+PNAME(mout_phyclk_mipi_dphy_4lmrxclk_esc0_user_p) = {"fin_pll",
+			"phyclk_mipi_dphy_4l_m_rxclkesc0"};
+PNAME(mout_sclk_hdmi_spdif_p) = {"fin_pll", "ioclk_spdif_extclk",
+			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
+
+struct samsung_mux_clock disp_mux_clks[] __initdata = {
+	MUX(0, "mout_sclk_hdmi_spdif", mout_sclk_hdmi_spdif_p,
+			MUX_SEL_DISP4, 4, 2),
+
+	MUX(0, "mout_sclk_dsim1_tx_clk_esc_clk_user",
+			mout_sclk_dsim1_tx_clk_esc_clk_user_p,
+			MUX_SEL_DISP2, 28, 1),
+	MUX(0, "mout_sclk_dsim1_tx_clk_esc3_user",
+			mout_sclk_dsim1_tx_clk_esc3_user_p,
+			MUX_SEL_DISP2, 24, 1),
+	MUX(0, "mout_sclk_dsim1_tx_clk_esc2_user",
+			mout_sclk_dsim1_tx_clk_esc2_user_p,
+			MUX_SEL_DISP2, 20, 1),
+	MUX(0, "mout_sclk_dsim1_tx_clk_esc1_user",
+			mout_sclk_dsim1_tx_clk_esc1_user_p,
+			MUX_SEL_DISP2, 16, 1),
+	MUX(0, "mout_sclk_dsim1_tx_clk_esc0_user",
+			mout_sclk_dsim1_tx_clk_esc0_user_p,
+			MUX_SEL_DISP2, 12, 1),
+	MUX(0, "mout_sclk_hdmi_pixel", mout_sclk_hdmi_pixel_p,
+			MUX_SEL_DISP2, 4, 1),
+	MUX(0, "mout_phyclk_mipi_dphy_4lmrxclk_esc0_user",
+			mout_phyclk_mipi_dphy_4lmrxclk_esc0_user_p,
+			MUX_SEL_DISP2, 0, 1),
+
+	MUX(0, "mout_phyclk_hdmi_phy_tmds_clko_user",
+			mout_phyclk_hdmi_phy_tmds_clko_user_p,
+			MUX_SEL_DISP1, 28, 1),
+	MUX(0, "mout_phyclk_hdmi_phy_ref_clko_user",
+			mout_phyclk_hdmi_phy_ref_clko_user_p,
+			MUX_SEL_DISP1, 24, 1),
+	MUX(DISP_MOUT_HDMI_PHY_PIXEL, "mout_phyclk_hdmi_phy_pixel_clko_user",
+			mout_phyclk_hdmi_phy_pixel_clko_user_p,
+			MUX_SEL_DISP1, 20, 1),
+	MUX(0, "mout_phyclk_hdmi_link_o_tmds_clkhi_user",
+			mout_phyclk_hdmi_link_o_tmds_clkhi_user_p,
+			MUX_SEL_DISP1, 16, 1),
+	MUX(0, "mout_phyclk_mipi_dphy_4l_m_txbyte_clkhs",
+			mout_phyclk_mipi_dphy_4l_m_txbyte_clkhs_p,
+			MUX_SEL_DISP1, 8, 1),
+	MUX(0, "mout_phyclk_dptx_phy_o_ref_clk_24m_user",
+			mout_phyclk_dptx_phy_o_ref_clk_24m_user_p,
+			MUX_SEL_DISP1, 4, 1),
+	MUX(0, "mout_phyclk_dptx_phy_clk_div2_user",
+			mout_phyclk_dptx_phy_clk_div2_user_p,
+			MUX_SEL_DISP1, 0, 1),
+
+	MUX(0, "mout_phyclk_dptx_phy_ch3_txd_clk_user",
+			mout_phyclk_dptx_phy_ch3_txd_clk_user_p,
+			MUX_SEL_DISP0, 28, 1),
+	MUX(0, "mout_phyclk_dptx_phy_ch2_txd_clk_user",
+			mout_phyclk_dptx_phy_ch2_txd_clk_user_p,
+			MUX_SEL_DISP0, 24, 1),
+	MUX(0, "mout_phyclk_dptx_phy_ch1_txd_clk_user",
+			mout_phyclk_dptx_phy_ch1_txd_clk_user_p,
+			MUX_SEL_DISP0, 20, 1),
+	MUX(0, "mout_phyclk_dptx_phy_ch0_txd_clk_user",
+			mout_phyclk_dptx_phy_ch0_txd_clk_user_p,
+			MUX_SEL_DISP0, 16, 1),
+	MUX(0, "mout_aclk_disp_222_user", mout_aclk_disp_222_user_p,
+			MUX_SEL_DISP0, 8, 1),
+	MUX(0, "mout_sclk_disp_pixel_user", mout_sclk_disp_pixel_user_p,
+			MUX_SEL_DISP0, 4, 1),
+	MUX(0, "mout_aclk_disp_333_user", mout_aclk_disp_333_user_p,
+			MUX_SEL_DISP0, 0, 1),
+};
+
+struct samsung_div_clock disp_div_clks[] __initdata = {
+	DIV(0, "dout_sclk_hdmi_phy_pixel_clki", "mout_sclk_hdmi_pixel",
+			DIV_DISP, 16, 4),
+	DIV(0, "dout_sclk_fimd1_extclkpll", "mout_sclk_disp_pixel_user",
+			DIV_DISP, 12, 4),
+	DIV(0, "dout_pclk_disp_111", "mout_aclk_disp_222_user",
+			DIV_DISP, 8, 4),
+};
+
+struct samsung_gate_clock disp_gate_clks[] __initdata = {
+	GATE(DISP_CLK_SMMU_TV, "clk_smmu3_tv", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 25, 0, 0),
+	GATE(DISP_CLK_SMMU_FIMD1M1, "clk_smmu3_fimd1m1",
+			"mout_aclk_disp_222_user",
+			EN_IP_DISP, 23, 0, 0),
+	GATE(DISP_CLK_SMMU_FIMD1M0, "clk_smmu3_fimd1m0",
+			"mout_aclk_disp_222_user",
+			EN_IP_DISP, 22, 0, 0),
+	GATE(0, "clk_pixel_mixer", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_pixel_disp", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(DISP_CLK_MIXER, "clk_mixer", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 11, 0, 0),
+	GATE(DISP_CLK_MIPIPHY, "clk_mipi_dphy", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 10, 0, 0),
+	GATE(DISP_CLK_HDMIPHY, "clk_hdmiphy", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 9, 0, 0),
+	GATE(DISP_CLK_HDMI, "clk_hdmi", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 8, 0, 0),
+	GATE(DISP_CLK_FIMD1, "clk_fimd1", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 7, 0, 0),
+	GATE(DISP_CLK_DSIM1, "clk_dsim1", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 6, 0, 0),
+	GATE(DISP_CLK_DPPHY, "clk_dptx_phy", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 5, 0, 0),
+	GATE(DISP_CLK_DP, "clk_dptx_link", "mout_aclk_disp_222_user",
+			EN_IP_DISP, 4, 0, 0),
+
+	GATE(DISP_SCLK_PIXEL, "sclk_hdmi_phy_pixel_clki",
+			"dout_sclk_hdmi_phy_pixel_clki",
+			EN_SCLK_DISP0, 29, CLK_SET_RATE_PARENT, 0),
+	GATE(DISP_MOUT_HDMI_PHY_PIXEL_USER, "sclk_hdmi_link_i_pixel",
+			"mout_phyclk_hdmi_phy_pixel_clko_user",
+			EN_SCLK_DISP0, 26, CLK_SET_RATE_PARENT, 0),
+};
+
+static void __init exynos5260_clk_disp_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = disp_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(disp_mux_clks);
+	cmu.div_clks = disp_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(disp_div_clks);
+	cmu.gate_clks = disp_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(disp_gate_clks);
+	cmu.nr_clk_ids = DISP_NR_CLK;
+	cmu.clk_regs = disp_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(disp_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_disp, "samsung,exynos5260-clock-disp",
+		exynos5260_clk_disp_init);
+
+
+/* CMU_EGL */
+
+static unsigned long egl_clk_regs[] __initdata = {
+	EGL_PLL_LOCK,
+	EGL_PLL_CON0,
+	EGL_PLL_CON1,
+	EGL_PLL_FREQ_DET,
+	MUX_SEL_EGL,
+	MUX_ENABLE_EGL,
+	DIV_EGL,
+	DIV_EGL_PLL_FDET,
+	EN_ACLK_EGL,
+	EN_PCLK_EGL,
+	EN_SCLK_EGL,
+};
+
+PNAME(mout_egl_b_p) = {"mout_egl_pll", "dout_bus_pll"};
+PNAME(mout_egl_pll_p) = {"fin_pll", "fout_egl_pll"};
+
+struct samsung_mux_clock egl_mux_clks[] __initdata = {
+	MUX(0, "mout_egl_b", mout_egl_b_p, MUX_SEL_EGL, 16, 1),
+	MUX(0, "mout_egl_pll", mout_egl_pll_p, MUX_SEL_EGL, 4, 1),
+};
+
+struct samsung_div_clock egl_div_clks[] __initdata = {
+	DIV(0, "dout_egl_pll", "mout_egl_b", DIV_EGL, 24, 3),
+	DIV(0, "dout_egl_pclk_dbg", "dout_egl_atclk", DIV_EGL, 20, 3),
+	DIV(0, "dout_egl_atclk", "dout_egl2", DIV_EGL, 16, 3),
+	DIV(0, "dout_pclk_egl", "dout_egl_atclk", DIV_EGL, 12, 3),
+	DIV(0, "dout_aclk_egl", "dout_egl2", DIV_EGL, 8, 3),
+	DIV(0, "dout_egl2", "dout_egl1", DIV_EGL, 4, 3),
+	DIV(0, "dout_egl1", "mout_egl_b", DIV_EGL, 0, 3),
+};
+
+static struct samsung_pll_clock egl_pll_clks[] __initdata = {
+	PLL(pll_2550xx, EGL_FOUT_EGL_PLL, "fout_egl_pll", "fin_pll",
+		EGL_PLL_LOCK, EGL_PLL_CON0,
+		pll2550_24mhz_tbl),
+};
+
+static void __init exynos5260_clk_egl_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.pll_clks = egl_pll_clks;
+	cmu.nr_pll_clks =  ARRAY_SIZE(egl_pll_clks);
+	cmu.mux_clks = egl_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(egl_mux_clks);
+	cmu.div_clks = egl_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(egl_div_clks);
+	cmu.nr_clk_ids = EGL_NR_CLK;
+	cmu.clk_regs = egl_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(egl_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_egl, "samsung,exynos5260-clock-egl",
+		exynos5260_clk_egl_init);
+
+
+/* CMU_FSYS */
+
+static unsigned long fsys_clk_regs[] __initdata = {
+	MUX_SEL_FSYS0,
+	MUX_SEL_FSYS1,
+	EN_ACLK_FSYS,
+	EN_ACLK_FSYS_SECURE_RTIC,
+	EN_ACLK_FSYS_SECURE_SMMU_RTIC,
+	EN_SCLK_FSYS,
+	EN_IP_FSYS,
+	EN_IP_FSYS_SECURE_RTIC,
+	EN_IP_FSYS_SECURE_SMMU_RTIC,
+};
+
+PNAME(mout_phyclk_usbhost20_phyclk_user_p) = {"fin_pll",
+			"phyclk_usbhost20_phy_phyclock"};
+PNAME(mout_phyclk_usbhost20_freeclk_user_p) = {"fin_pll",
+			"phyclk_usbhost20_phy_freeclk"};
+PNAME(mout_phyclk_usbhost20_clk48mohci_user_p) = {"fin_pll",
+			"phyclk_usbhost20_phy_clk48mohci"};
+PNAME(mout_phyclk_usbdrd30_pipe_pclk_user_p) = {"fin_pll",
+			"phyclk_usbdrd30_udrd30_pipe_pclk"};
+PNAME(mout_phyclk_usbdrd30_phyclock_user_p) = {"fin_pll",
+			"phyclk_usbdrd30_udrd30_phyclock"};
+
+struct samsung_mux_clock fsys_mux_clks[] __initdata = {
+	MUX(0, "mout_phyclk_usbhost20_phyclk_user",
+			mout_phyclk_usbhost20_phyclk_user_p,
+			MUX_SEL_FSYS1, 16, 1),
+	MUX(0, "mout_phyclk_usbhost20_freeclk_user",
+			mout_phyclk_usbhost20_freeclk_user_p,
+			MUX_SEL_FSYS1, 12, 1),
+	MUX(0, "mout_phyclk_usbhost20_clk48mohci_user",
+			mout_phyclk_usbhost20_clk48mohci_user_p,
+			MUX_SEL_FSYS1, 8, 1),
+	MUX(0, "mout_phyclk_usbdrd30_pipe_pclk_user",
+			mout_phyclk_usbdrd30_pipe_pclk_user_p,
+			MUX_SEL_FSYS1, 4, 1),
+	MUX(0, "mout_phyclk_usbdrd30_phyclock_user",
+			mout_phyclk_usbdrd30_phyclock_user_p,
+			MUX_SEL_FSYS1, 0, 1),
+};
+
+struct samsung_gate_clock fsys_gate_clks[] __initdata = {
+	GATE(FSYS_CLK_TSI, "clk_tsi", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 20, 0, 0),
+	GATE(FSYS_CLK_USBLINK, "clk_usblink", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 18, 0, 0),
+	GATE(FSYS_CLK_USBHOST20, "clk_usbhost20", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 15, 0, 0),
+	GATE(FSYS_CLK_USBDRD30, "clk_usbdrd30", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 14, 0, 0),
+	GATE(FSYS_CLK_SROMC, "clk_sromc", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 13, 0, 0),
+	GATE(FSYS_CLK_PDMA, "clk_pdma", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 9, 0, 0),
+	GATE(FSYS_CLK_MMC2, "clk_mmc2", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 8, 0, 0),
+	GATE(FSYS_CLK_MMC1, "clk_mmc1", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 7, 0, 0),
+	GATE(FSYS_CLK_MMC0, "clk_mmc0", "dout_aclk_fsys_200",
+			EN_IP_FSYS, 6, 0, 0),
+
+	GATE(FSYS_CLK_RTIC, "clk_rtic", "mout_bustop_pll_user",
+			EN_IP_FSYS_SECURE_RTIC, 11, 0, 0),
+	GATE(FSYS_CLK_SMMU_RTIC, "clk_smmu_rtic", "mout_bustop_pll_user",
+			EN_IP_FSYS_SECURE_SMMU_RTIC, 12, 0, 0),
+
+	GATE(FSYS_PHYCLK_USBDRD30, "phyclk_usbdrd30_udrd30_phyclock_g",
+			"mout_phyclk_usbdrd30_phyclock_user",
+			EN_SCLK_FSYS, 7, 0, 0),
+	GATE(FSYS_PHYCLK_USBHOST20, "phyclk_usbhost20_phyclock",
+			"mout_phyclk_usbdrd30_phyclock_user",
+			EN_SCLK_FSYS, 1, 0, 0),
+};
+
+static void __init exynos5260_clk_fsys_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = fsys_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(fsys_mux_clks);
+	cmu.gate_clks = fsys_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(fsys_gate_clks);
+	cmu.nr_clk_ids = FSYS_NR_CLK;
+	cmu.clk_regs = fsys_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(fsys_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_fsys, "samsung,exynos5260-clock-fsys",
+		exynos5260_clk_fsys_init);
+
+
+/* CMU_G2D */
+
+static unsigned long g2d_clk_regs[] __initdata = {
+	MUX_SEL_G2D,
+	MUX_STAT_G2D,
+	DIV_G2D,
+	EN_ACLK_G2D,
+	EN_ACLK_G2D_SECURE_SSS,
+	EN_ACLK_G2D_SECURE_SLIM_SSS,
+	EN_ACLK_G2D_SECURE_SMMU_SLIM_SSS,
+	EN_ACLK_G2D_SECURE_SMMU_SSS,
+	EN_ACLK_G2D_SECURE_SMMU_MDMA,
+	EN_ACLK_G2D_SECURE_SMMU_G2D,
+	EN_PCLK_G2D,
+	EN_PCLK_G2D_SECURE_SMMU_SLIM_SSS,
+	EN_PCLK_G2D_SECURE_SMMU_SSS,
+	EN_PCLK_G2D_SECURE_SMMU_MDMA,
+	EN_PCLK_G2D_SECURE_SMMU_G2D,
+	EN_IP_G2D,
+	EN_IP_G2D_SECURE_SSS,
+	EN_IP_G2D_SECURE_SLIM_SSS,
+	EN_IP_G2D_SECURE_SMMU_SLIM_SSS,
+	EN_IP_G2D_SECURE_SMMU_SSS,
+	EN_IP_G2D_SECURE_SMMU_MDMA,
+	EN_IP_G2D_SECURE_SMMU_G2D,
+};
+
+PNAME(mout_aclk_g2d_333_user_p) = {"fin_pll", "dout_aclk_g2d_333"};
+
+struct samsung_mux_clock g2d_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_g2d_333_user", mout_aclk_g2d_333_user_p,
+			MUX_SEL_G2D, 0, 1),
+};
+
+struct samsung_div_clock g2d_div_clks[] __initdata = {
+	DIV(0, "dout_pclk_g2d_83", "mout_aclk_g2d_333_user",
+			DIV_G2D, 0, 3),
+};
+
+struct samsung_gate_clock g2d_gate_clks[] __initdata = {
+	GATE(G2D_CLK_SMMU3_JPEG, "clk_smmu3_jpeg", "mout_aclk_g2d_333_user",
+			EN_IP_G2D, 16, 0, 0),
+	GATE(G2D_CLK_MDMA, "clk_mdma", "mout_aclk_g2d_333_user",
+			EN_IP_G2D, 6, 0, 0),
+	GATE(G2D_CLK_JPEG, "clk_jpeg", "mout_aclk_g2d_333_user",
+			EN_IP_G2D, 5, 0, 0),
+	GATE(G2D_CLK_G2D, "clk_g2d", "mout_aclk_g2d_333_user",
+			EN_IP_G2D, 4, 0, 0),
+
+	GATE(G2D_CLK_SSS, "clk_sss", "mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SSS, 17, 0, 0),
+	GATE(G2D_CLK_SLIM_SSS, "clk_slim_sss", "mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SLIM_SSS, 11, 0, 0),
+	GATE(G2D_CLK_SMMU_SLIM_SSS, "clk_smmu_slim_sss",
+			"mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SMMU_SLIM_SSS, 13, 0, 0),
+	GATE(G2D_CLK_SMMU_SSS, "clk_smmu_sss", "mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SMMU_SSS, 14, 0, 0),
+	GATE(G2D_CLK_SMMU_MDMA, "clk_smmu_mdma", "mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SMMU_MDMA, 12, 0, 0),
+	GATE(G2D_CLK_SMMU3_G2D, "clk_smmu3_g2d", "mout_aclk_g2d_333_user",
+			EN_IP_G2D_SECURE_SMMU_G2D, 15, 0, 0),
+};
+
+static void __init exynos5260_clk_g2d_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = g2d_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(g2d_mux_clks);
+	cmu.div_clks = g2d_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(g2d_div_clks);
+	cmu.gate_clks = g2d_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(g2d_gate_clks);
+	cmu.nr_clk_ids = G2D_NR_CLK;
+	cmu.clk_regs = g2d_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(g2d_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_g2d, "samsung,exynos5260-clock-g2d",
+		exynos5260_clk_g2d_init);
+
+
+/* CMU_G3D */
+
+static unsigned long g3d_clk_regs[] __initdata = {
+	G3D_PLL_LOCK,
+	G3D_PLL_CON0,
+	G3D_PLL_CON1,
+	G3D_PLL_FDET,
+	MUX_SEL_G3D,
+	DIV_G3D,
+	DIV_G3D_PLL_FDET,
+	EN_ACLK_G3D,
+	EN_PCLK_G3D,
+	EN_SCLK_G3D,
+	EN_IP_G3D,
+};
+
+PNAME(mout_g3d_pll_p) = {"fin_pll", "fout_g3d_pll"};
+
+struct samsung_mux_clock g3d_mux_clks[] __initdata = {
+	MUX(0, "mout_g3d_pll", mout_g3d_pll_p, MUX_SEL_G3D, 0, 1),
+};
+
+struct samsung_div_clock g3d_div_clks[] __initdata = {
+	DIV(0, "dout_pclk_g3d", "dout_aclk_g3d", DIV_G3D, 0, 3),
+	DIV(0, "dout_aclk_g3d", "mout_g3d_pll", DIV_G3D, 4, 3),
+};
+
+struct samsung_gate_clock g3d_gate_clks[] __initdata = {
+	GATE(G3D_CLK_G3D_HPM, "clk_g3d_hpm", "dout_aclk_g3d",
+			EN_IP_G3D, 3, 0, 0),
+	GATE(G3D_CLK_G3D, "clk_g3d", "dout_aclk_g3d", EN_IP_G3D, 2, 0, 0),
+};
+
+static struct samsung_pll_clock g3d_pll_clks[] __initdata = {
+	PLL(pll_2550, G3D_FOUT_G3D_PLL, "fout_g3d_pll", "fin_pll",
+		G3D_PLL_LOCK, G3D_PLL_CON0,
+		pll2550_24mhz_tbl),
+};
+
+static void __init exynos5260_clk_g3d_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.pll_clks = g3d_pll_clks;
+	cmu.nr_pll_clks =  ARRAY_SIZE(g3d_pll_clks);
+	cmu.mux_clks = g3d_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(g3d_mux_clks);
+	cmu.div_clks = g3d_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(g3d_div_clks);
+	cmu.gate_clks = g3d_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(g3d_gate_clks);
+	cmu.nr_clk_ids = G3D_NR_CLK;
+	cmu.clk_regs = g3d_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(g3d_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_g3d, "samsung,exynos5260-clock-g3d",
+		exynos5260_clk_g3d_init);
+
+
+/* CMU_GSCL */
+
+static unsigned long gscl_clk_regs[] __initdata = {
+	MUX_SEL_GSCL,
+	DIV_GSCL,
+	EN_ACLK_GSCL,
+	EN_ACLK_GSCL_FIMC,
+	EN_ACLK_GSCL_SECURE_SMMU_GSCL0,
+	EN_ACLK_GSCL_SECURE_SMMU_GSCL1,
+	EN_ACLK_GSCL_SECURE_SMMU_MSCL0,
+	EN_ACLK_GSCL_SECURE_SMMU_MSCL1,
+	EN_PCLK_GSCL,
+	EN_PCLK_GSCL_FIMC,
+	EN_PCLK_GSCL_SECURE_SMMU_GSCL0,
+	EN_PCLK_GSCL_SECURE_SMMU_GSCL1,
+	EN_PCLK_GSCL_SECURE_SMMU_MSCL0,
+	EN_PCLK_GSCL_SECURE_SMMU_MSCL1,
+	EN_SCLK_GSCL,
+	EN_SCLK_GSCL_FIMC,
+	EN_IP_GSCL,
+	EN_IP_GSCL_FIMC,
+	EN_IP_GSCL_SECURE_SMMU_GSCL0,
+	EN_IP_GSCL_SECURE_SMMU_GSCL1,
+	EN_IP_GSCL_SECURE_SMMU_MSCL0,
+	EN_IP_GSCL_SECURE_SMMU_MSCL1,
+};
+
+PNAME(mout_aclk_gscl_333_user_p) = {"fin_pll", "fout_aud_pll"};
+PNAME(mout_aclk_m2m_400_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
+PNAME(mout_aclk_gscl_fimc_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
+PNAME(mout_aclk_csis_p) = {"dout_aclk_csis_200", "mout_aclk_gscl_fimc_user"};
+
+struct samsung_mux_clock gscl_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_csis", mout_aclk_csis_p, MUX_SEL_GSCL, 24, 1),
+	MUX(0, "mout_aclk_gscl_fimc_user", mout_aclk_gscl_fimc_user_p,
+			MUX_SEL_GSCL, 8, 1),
+	MUX(0, "mout_aclk_m2m_400_user", mout_aclk_m2m_400_user_p,
+			MUX_SEL_GSCL, 4, 1),
+	MUX(0, "mout_aclk_gscl_333_user", mout_aclk_gscl_333_user_p,
+			MUX_SEL_GSCL, 0, 1),
+};
+
+struct samsung_div_clock gscl_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_csis_200", "mout_aclk_m2m_400_user",
+			DIV_GSCL, 4, 3),
+	DIV(0, "dout_pclk_m2m_100", "mout_aclk_m2m_400_user",
+			DIV_GSCL, 0, 3),
+};
+
+struct samsung_gate_clock gscl_gate_clks[] __initdata = {
+	GATE(GSCL_CLK_PIXEL_GSCL1, "clk_pixel_gscl1", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 9, 0, 0),
+	GATE(GSCL_CLK_PIXEL_GSCL0, "clk_pixel_gscl0", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 8, 0, 0),
+	GATE(GSCL_CLK_MSCL1, "clk_mscl1", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 5, 0, 0),
+	GATE(GSCL_CLK_MSCL0, "clk_mscl0", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 4, 0, 0),
+	GATE(GSCL_CLK_GSCL1, "clk_gscl1", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 3, 0, 0),
+	GATE(GSCL_CLK_GSCL0, "clk_gscl0", "mout_aclk_gscl_333",
+			EN_IP_GSCL, 2, 0, 0),
+	GATE(GSCL_CLK_FIMC_LITE_D, "clk_fimc_lite_d",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 12, 0, 0),
+	GATE(GSCL_CLK_FIMC_LITE_B, "clk_fimc_lite_b",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 11, 0, 0),
+	GATE(GSCL_CLK_FIMC_LITE_A, "clk_fimc_lite_a",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 10, 0, 0),
+	GATE(GSCL_CLK_CSIS1, "clk_csis1", "mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 9, 0, 0),
+	GATE(GSCL_CLK_CSIS0, "clk_csis0", "mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 8, 0, 0),
+	GATE(GSCL_CLK_SMMU3_LITE_D, "clk_smmu3_lite_d",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 7, 0, 0),
+	GATE(GSCL_CLK_SMMU3_LITE_B, "clk_smmu3_lite_b",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 6, 0, 0),
+	GATE(GSCL_CLK_SMMU3_LITE_A, "clk_smmu3_lite_a",
+			"mout_aclk_gscl_fimc_user",
+			EN_IP_GSCL_FIMC, 5, 0, 0),
+	GATE(GSCL_CLK_SMMU3_GSCL0, "clk_smmu3_gscl0",
+			"mout_aclk_gscl_333",
+			EN_IP_GSCL_SECURE_SMMU_GSCL0, 17, 0, 0),
+	GATE(GSCL_CLK_SMMU3_GSCL1, "clk_smmu3_gscl1", "mout_aclk_gscl_333",
+			EN_IP_GSCL_SECURE_SMMU_GSCL1, 18, 0, 0),
+	GATE(GSCL_CLK_SMMU3_MSCL0, "clk_smmu3_mscl0",
+			"mout_aclk_m2m_400_user",
+			EN_IP_GSCL_SECURE_SMMU_MSCL0, 19, 0, 0),
+	GATE(GSCL_CLK_SMMU3_MSCL1, "clk_smmu3_mscl1",
+			"mout_aclk_m2m_400_user",
+			EN_IP_GSCL_SECURE_SMMU_MSCL1, 20, 0, 0),
+
+	GATE(GSCL_SCLK_CSIS1_WRAP, "sclk_csis1_wrap", "dout_aclk_csis_200",
+			EN_SCLK_GSCL_FIMC, 1, CLK_SET_RATE_PARENT, 0),
+	GATE(GSCL_SCLK_CSIS0_WRAP, "sclk_csis0_wrap", "dout_aclk_csis_200",
+			EN_SCLK_GSCL_FIMC, 0, CLK_SET_RATE_PARENT, 0),
+};
+
+static void __init exynos5260_clk_gscl_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = gscl_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(gscl_mux_clks);
+	cmu.div_clks = gscl_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(gscl_div_clks);
+	cmu.gate_clks = gscl_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(gscl_gate_clks);
+	cmu.nr_clk_ids = GSCL_NR_CLK;
+	cmu.clk_regs = gscl_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(gscl_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_gscl, "samsung,exynos5260-clock-gscl",
+		exynos5260_clk_gscl_init);
+
+
+/* CMU_ISP */
+
+static unsigned long isp_clk_regs[] __initdata = {
+	MUX_SEL_ISP0,
+	MUX_SEL_ISP1,
+	DIV_ISP,
+	EN_ACLK_ISP0,
+	EN_ACLK_ISP1,
+	EN_PCLK_ISP0,
+	EN_PCLK_ISP1,
+	EN_SCLK_ISP,
+	EN_IP_ISP0,
+	EN_IP_ISP1,
+};
+
+PNAME(mout_isp_400_user_p) = {"fin_pll", "dout_aclk_isp1_400"};
+PNAME(mout_isp_266_user_p)	 = {"fin_pll", "dout_aclk_isp1_266"};
+
+struct samsung_mux_clock isp_mux_clks[] __initdata = {
+	MUX(0, "mout_isp_400_user", mout_isp_400_user_p,
+			MUX_SEL_ISP0, 4, 1),
+	MUX(0, "mout_isp_266_user", mout_isp_266_user_p,
+			MUX_SEL_ISP0, 0, 1),
+};
+
+struct samsung_div_clock isp_div_clks[] __initdata = {
+	DIV(0, "dout_sclk_mpwm", "mout_kfc", DIV_ISP, 20, 2),
+	DIV(0, "dout_ca5_pclkdbg", "mout_kfc", DIV_ISP, 16, 4),
+	DIV(0, "dout_ca5_atclkin", "mout_kfc", DIV_ISP, 12, 3),
+	DIV(0, "dout_pclk_isp_133", "mout_kfc", DIV_ISP, 4, 4),
+	DIV(0, "dout_pclk_isp_66", "mout_kfc", DIV_ISP, 0, 3),
+};
+
+struct samsung_gate_clock isp_gate_clks[] __initdata = {
+	GATE(ISP_CLK_GIC, "clk_isp_gic", "mout_aclk_isp1_266",
+			EN_IP_ISP0, 15, 0, 0),
+
+	GATE(ISP_CLK_WDT, "clk_isp_wdt", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 31, 0, 0),
+	GATE(ISP_CLK_UART, "clk_isp_uart", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 30, 0, 0),
+	GATE(ISP_CLK_SPI1, "clk_isp_spi1", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 28, 0, 0),
+	GATE(ISP_CLK_SPI0, "clk_isp_spi0", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 27, 0, 0),
+
+	GATE(ISP_CLK_SMMU_SCALERP, "clk_isp_smmu_scalerp",
+			"mout_aclk_isp1_266",
+			EN_IP_ISP1, 26, 0, 0),
+	GATE(ISP_CLK_SMMU_SCALERC, "clk_isp_smmu_scalerc",
+			"mout_aclk_isp1_266",
+			EN_IP_ISP1, 25, 0, 0),
+	GATE(ISP_CLK_SMMU_ISPCX, "clk_smmu_ispcx", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 24, 0, 0),
+	GATE(ISP_CLK_SMMU_ISP, "clk_smmu_isp", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 23, 0, 0),
+	GATE(ISP_CLK_SMMU_FD, "clk_smmu_fd", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 22, 0, 0),
+	GATE(ISP_CLK_SMMU_DRC, "clk_smmu_drc", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 21, 0, 0),
+	GATE(ISP_CLK_PWM, "clk_isp_pwm", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 14, 0, 0),
+	GATE(ISP_CLK_MTCADC, "clk_isp_mtcadc", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 11, 0, 0),
+	GATE(ISP_CLK_MPWM, "clk_isp_mpwm", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 10, 0, 0),
+	GATE(ISP_CLK_MCUCTL, "clk_isp_mcuctl", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 9, 0, 0),
+	GATE(ISP_CLK_I2C1, "clk_isp_i2c1", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 8, 0, 0),
+	GATE(ISP_CLK_I2C0, "clk_isp_i2c0", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 7, 0, 0),
+	GATE(ISP_CLK_FIMC_SCALERP, "clk_isp_fimc_scalerp",
+			"mout_aclk_isp1_266",
+			EN_IP_ISP1, 6, 0, 0),
+	GATE(ISP_CLK_FIMC_SCALERC, "clk_isp_fimc_scalerc",
+			"mout_aclk_isp1_266",
+			EN_IP_ISP1, 5, 0, 0),
+	GATE(ISP_CLK_FIMC, "clk_isp_fimc", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 4, 0, 0),
+	GATE(ISP_CLK_FIMC_FD, "clk_isp_fimc_fd", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 3, 0, 0),
+	GATE(ISP_CLK_FIMC_DRC, "clk_isp_fimc_drc", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 2, 0, 0),
+	GATE(ISP_CLK_CA5, "clk_isp_ca5", "mout_aclk_isp1_266",
+			EN_IP_ISP1, 1, 0, 0),
+
+	GATE(ISP_SCLK_SPI0_EXT, "sclk_isp_spi0_ext", "fin_pll",
+			EN_SCLK_ISP, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(ISP_SCLK_SPI1_EXT, "sclk_isp_spi1_ext", "fin_pll",
+			EN_SCLK_ISP, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(ISP_SCLK_UART_EXT, "sclk_isp_uart_ext", "fin_pll",
+			EN_SCLK_ISP, 7, CLK_SET_RATE_PARENT, 0),
+};
+
+static void __init exynos5260_clk_isp_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = isp_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(isp_mux_clks);
+	cmu.div_clks = isp_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(isp_div_clks);
+	cmu.gate_clks = isp_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(isp_gate_clks);
+	cmu.nr_clk_ids = ISP_NR_CLK;
+	cmu.clk_regs = isp_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(isp_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_isp, "samsung,exynos5260-clock-isp",
+		exynos5260_clk_isp_init);
+
+
+/* CMU_KFC */
+
+static unsigned long kfc_clk_regs[] __initdata = {
+	KFC_PLL_LOCK,
+	KFC_PLL_CON0,
+	KFC_PLL_CON1,
+	KFC_PLL_FDET,
+	MUX_SEL_KFC0,
+	MUX_SEL_KFC2,
+	DIV_KFC,
+	DIV_KFC_PLL_FDET,
+	EN_ACLK_KFC,
+	EN_PCLK_KFC,
+	EN_SCLK_KFC,
+	EN_IP_KFC,
+};
+
+PNAME(mout_kfc_pll_p) = {"fin_pll", "fout_kfc_pll"};
+PNAME(mout_kfc_p)	 = {"mout_kfc_pll", "dout_media_pll"};
+
+struct samsung_mux_clock kfc_mux_clks[] __initdata = {
+	MUX(0, "mout_kfc_pll", mout_kfc_pll_p, MUX_SEL_KFC0, 0, 1),
+	MUX(0, "mout_kfc", mout_kfc_p, MUX_SEL_KFC2, 0, 1),
+};
+
+struct samsung_div_clock kfc_div_clks[] __initdata = {
+	DIV(0, "dout_kfc_pll", "mout_kfc", DIV_KFC, 24, 3),
+	DIV(0, "dout_pclk_kfc", "dout_kfc2", DIV_KFC, 20, 3),
+	DIV(0, "dout_aclk_kfc", "dout_kfc2", DIV_KFC, 16, 3),
+	DIV(0, "dout_kfc_pclk_dbg", "dout_kfc2", DIV_KFC, 12, 3),
+	DIV(0, "dout_kfc_atclk", "dout_kfc2", DIV_KFC, 8, 3),
+	DIV(0, "dout_kfc2", "dout_kfc1", DIV_KFC, 4, 3),
+	DIV(0, "dout_kfc1", "mout_kfc", DIV_KFC, 0, 3),
+};
+
+static struct samsung_pll_clock kfc_pll_clks[] __initdata = {
+	PLL(pll_2550xx, KFC_FOUT_KFC_PLL, "fout_kfc_pll", "fin_pll",
+		KFC_PLL_LOCK, KFC_PLL_CON0,
+		pll2550_24mhz_tbl),
+};
+
+static void __init exynos5260_clk_kfc_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.pll_clks = kfc_pll_clks;
+	cmu.nr_pll_clks =  ARRAY_SIZE(kfc_pll_clks);
+	cmu.mux_clks = kfc_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(kfc_mux_clks);
+	cmu.div_clks = kfc_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(kfc_div_clks);
+	cmu.nr_clk_ids = KFC_NR_CLK;
+	cmu.clk_regs = kfc_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(kfc_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_kfc, "samsung,exynos5260-clock-kfc",
+		exynos5260_clk_kfc_init);
+
+
+/* CMU_MFC */
+
+static unsigned long mfc_clk_regs[] __initdata = {
+	MUX_SEL_MFC,
+	DIV_MFC,
+	EN_ACLK_MFC,
+	EN_ACLK_SECURE_SMMU2_MFC,
+	EN_PCLK_MFC,
+	EN_PCLK_SECURE_SMMU2_MFC,
+	EN_IP_MFC,
+	EN_IP_MFC_SECURE_SMMU2_MFC,
+};
+
+PNAME(mout_aclk_mfc_333_user_p) = {"fin_pll", "dout_aclk_mfc_333"};
+
+struct samsung_mux_clock mfc_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_mfc_333_user", mout_aclk_mfc_333_user_p,
+			MUX_SEL_MFC, 0, 1),
+};
+
+struct samsung_div_clock mfc_div_clks[] __initdata = {
+	DIV(0, "dout_pclk_mfc_83", "mout_aclk_mfc_333_user",
+			DIV_MFC, 0, 3),
+};
+
+struct samsung_gate_clock mfc_gate_clks[] __initdata = {
+	GATE(MFC_CLK_MFC, "clk_mfc", "mout_aclk_mfc_333_user",
+			EN_IP_MFC, 1, 0, 0),
+
+	GATE(MFC_CLK_SMMU2_MFCM1, "clk_smmu2_mfcm1", "mout_aclk_mfc_333_user",
+			EN_IP_MFC_SECURE_SMMU2_MFC, 7, 0, 0),
+	GATE(MFC_CLK_SMMU2_MFCM0, "clk_smmu2_mfcm0", "mout_aclk_mfc_333_user",
+			EN_IP_MFC_SECURE_SMMU2_MFC, 6, 0, 0),
+};
+
+static void __init exynos5260_clk_mfc_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = mfc_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(mfc_mux_clks);
+	cmu.div_clks = mfc_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(mfc_div_clks);
+	cmu.gate_clks = mfc_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(mfc_gate_clks);
+	cmu.nr_clk_ids = MFC_NR_CLK;
+	cmu.clk_regs = mfc_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(mfc_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_mfc, "samsung,exynos5260-clock-mfc",
+		exynos5260_clk_mfc_init);
+
+
+/* CMU_MIF */
+
+static unsigned long mif_clk_regs[] __initdata = {
+	MEM_PLL_LOCK,
+	BUS_PLL_LOCK,
+	MEDIA_PLL_LOCK,
+	MEM_PLL_CON0,
+	MEM_PLL_CON1,
+	MEM_PLL_FDET,
+	BUS_PLL_CON0,
+	BUS_PLL_CON1,
+	BUS_PLL_FDET,
+	MEDIA_PLL_CON0,
+	MEDIA_PLL_CON1,
+	MEDIA_PLL_FDET,
+	MUX_SEL_MIF,
+	DIV_MIF,
+	DIV_MIF_PLL_FDET,
+	EN_ACLK_MIF,
+	EN_ACLK_MIF_SECURE_DREX1_TZ,
+	EN_ACLK_MIF_SECURE_DREX0_TZ,
+	EN_ACLK_MIF_SECURE_INTMEM,
+	EN_PCLK_MIF,
+	EN_PCLK_MIF_SECURE_MONOCNT,
+	EN_PCLK_MIF_SECURE_RTC_APBIF,
+	EN_PCLK_MIF_SECURE_DREX1_TZ,
+	EN_PCLK_MIF_SECURE_DREX0_TZ,
+	EN_SCLK_MIF,
+	EN_IP_MIF,
+	EN_IP_MIF_SECURE_MONOCNT,
+	EN_IP_MIF_SECURE_RTC_APBIF,
+	EN_IP_MIF_SECURE_DREX1_TZ,
+	EN_IP_MIF_SECURE_DREX0_TZ,
+	EN_IP_MIF_SECURE_INTEMEM,
+};
+
+PNAME(mout_mem_pll_p) = {"fin_pll", "fout_mem_pll"};
+PNAME(mout_bus_pll_p) = {"fin_pll", "fout_bus_pll"};
+PNAME(mout_media_pll_p) = {"fin_pll", "fout_media_pll"};
+PNAME(mout_mif_drex_p) = {"dout_mem_pll", "dout_bus_pll"};
+PNAME(mout_mif_drex2x_p) = {"dout_mem_pll", "dout_bus_pll"};
+PNAME(mout_clkm_phy_p) = {"mout_mif_drex", "dout_media_pll"};
+PNAME(mout_clk2x_phy_p) = {"mout_mif_drex2x", "dout_media_pll"};
+
+struct samsung_mux_clock mif_mux_clks[] __initdata = {
+	MUX(0, "mout_clk2x_phy", mout_clk2x_phy_p, MUX_SEL_MIF, 24, 1),
+	MUX(0, "mout_mif_drex2x", mout_mif_drex2x_p, MUX_SEL_MIF, 20, 1),
+	MUX(0, "mout_clkm_phy", mout_clkm_phy_p, MUX_SEL_MIF, 16, 1),
+	MUX(0, "mout_mif_drex", mout_mif_drex_p, MUX_SEL_MIF, 12, 1),
+	MUX(0, "mout_media_pll", mout_media_pll_p, MUX_SEL_MIF, 8, 1),
+	MUX(0, "mout_bus_pll", mout_bus_pll_p, MUX_SEL_MIF, 4, 1),
+	MUX(0, "mout_mem_pll", mout_mem_pll_p, MUX_SEL_MIF, 0, 1),
+};
+
+struct samsung_div_clock mif_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_bus_100", "dout_bus_pll", DIV_MIF, 28, 4),
+	DIV(0, "dout_aclk_bus_200", "dout_bus_pll", DIV_MIF, 24, 3),
+	DIV(0, "dout_aclk_mif_466", "dout_clk2x_phy", DIV_MIF, 20, 3),
+	DIV(0, "dout_clk2x_phy", "mout_clk2x_phy", DIV_MIF, 16, 4),
+	DIV(0, "dout_clkm_phy", "mout_clkm_phy", DIV_MIF, 12, 3),
+	DIV(0, "dout_bus_pll", "mout_bus_pll", DIV_MIF, 8, 3),
+	DIV(0, "dout_mem_pll", "mout_mem_pll", DIV_MIF, 4, 3),
+	DIV(0, "dout_media_pll", "mout_media_pll", DIV_MIF, 0, 3),
+};
+
+struct samsung_gate_clock mif_gate_clks[] __initdata = {
+	GATE(0, "clk_lpddr3phy_wrap1", "dout_clk2x_phy",
+			EN_IP_MIF, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_lpddr3phy_wrap0", "dout_clk2x_phy",
+			EN_IP_MIF, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_monocnt", "dout_aclk_bus_100",
+			EN_IP_MIF_SECURE_MONOCNT, 22,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_mif_rtc", "dout_aclk_bus_100",
+			EN_IP_MIF_SECURE_RTC_APBIF, 23,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_drex1", "dout_aclk_mif_466",
+			EN_IP_MIF_SECURE_DREX1_TZ, 9,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_drex0", "dout_aclk_mif_466",
+			EN_IP_MIF_SECURE_DREX0_TZ, 9,
+			CLK_IGNORE_UNUSED, 0),
+	GATE(0, "clk_intmem", "dout_aclk_bus_200",
+			EN_IP_MIF_SECURE_INTEMEM, 11,
+			CLK_IGNORE_UNUSED, 0),
+
+	GATE(0, "sclk_lpddr3phy_wrap_u1", "dout_clkm_phy",
+			EN_SCLK_MIF, 0, CLK_IGNORE_UNUSED |
+				CLK_SET_RATE_PARENT, 0),
+	GATE(0, "sclk_lpddr3phy_wrap_u0", "dout_clkm_phy",
+			EN_SCLK_MIF, 0, CLK_IGNORE_UNUSED |
+				CLK_SET_RATE_PARENT, 0),
+};
+
+static struct samsung_pll_clock mif_pll_clks[] __initdata = {
+	PLL(pll_2550xx, MIF_FOUT_MEM_PLL, "fout_mem_pll", "fin_pll",
+		MEM_PLL_LOCK, MEM_PLL_CON0,
+		pll2550_24mhz_tbl),
+	PLL(pll_2550xx, MIF_FOUT_BUS_PLL, "fout_bus_pll", "fin_pll",
+		BUS_PLL_LOCK, BUS_PLL_CON0,
+		pll2550_24mhz_tbl),
+	PLL(pll_2550xx, MIF_FOUT_MEDIA_PLL, "fout_media_pll", "fin_pll",
+		MEDIA_PLL_LOCK, MEDIA_PLL_CON0,
+		pll2550_24mhz_tbl),
+};
+
+static void __init exynos5260_clk_mif_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.pll_clks = mif_pll_clks;
+	cmu.nr_pll_clks =  ARRAY_SIZE(mif_pll_clks);
+	cmu.mux_clks = mif_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(mif_mux_clks);
+	cmu.div_clks = mif_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(mif_div_clks);
+	cmu.gate_clks = mif_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(mif_gate_clks);
+	cmu.nr_clk_ids = MIF_NR_CLK;
+	cmu.clk_regs = mif_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(mif_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_mif, "samsung,exynos5260-clock-mif",
+		exynos5260_clk_mif_init);
+
+
+/* CMU_PERI */
+
+static unsigned long peri_clk_regs[] __initdata = {
+	MUX_SEL_PERI,
+	MUX_SEL_PERI1,
+	DIV_PERI,
+	EN_PCLK_PERI0,
+	EN_PCLK_PERI1,
+	EN_PCLK_PERI2,
+	EN_PCLK_PERI3,
+	EN_PCLK_PERI_SECURE_CHIPID,
+	EN_PCLK_PERI_SECURE_PROVKEY0,
+	EN_PCLK_PERI_SECURE_PROVKEY1,
+	EN_PCLK_PERI_SECURE_SECKEY,
+	EN_PCLK_PERI_SECURE_ANTIRBKCNT,
+	EN_PCLK_PERI_SECURE_TOP_RTC,
+	EN_PCLK_PERI_SECURE_TZPC,
+	EN_SCLK_PERI,
+	EN_SCLK_PERI_SECURE_TOP_RTC,
+	EN_IP_PERI0,
+	EN_IP_PERI1,
+	EN_IP_PERI2,
+	EN_IP_PERI_SECURE_CHIPID,
+	EN_IP_PERI_SECURE_PROVKEY0,
+	EN_IP_PERI_SECURE_PROVKEY1,
+	EN_IP_PERI_SECURE_SECKEY,
+	EN_IP_PERI_SECURE_ANTIRBKCNT,
+	EN_IP_PERI_SECURE_TOP_RTC,
+	EN_IP_PERI_SECURE_TZPC,
+};
+
+PNAME(mout_sclk_pcm_p) = {"ioclk_pcm_extclk", "fin_pll", "dout_aclk_peri_aud",
+			"phyclk_hdmi_phy_ref_cko"};
+PNAME(mout_sclk_i2scod_p) = {"ioclk_i2s_cdclk", "fin_pll", "dout_aclk_peri_aud",
+			"phyclk_hdmi_phy_ref_cko"};
+PNAME(mout_sclk_spdif_p) = {"ioclk_spdif_extclk", "fin_pll",
+			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
+
+struct samsung_mux_clock peri_mux_clks[] __initdata = {
+	MUX(0, "mout_sclk_spdif", mout_sclk_spdif_p,
+			MUX_SEL_PERI1, 20, 2),
+	MUX(0, "mout_sclk_i2scod", mout_sclk_i2scod_p,
+			MUX_SEL_PERI1, 12, 2),
+	MUX(0, "mout_sclk_pcm", mout_sclk_pcm_p,
+			MUX_SEL_PERI1, 4, 2),
+};
+
+struct samsung_div_clock peri_div_clks[] __initdata = {
+	DIV(0, "dout_i2s", "mout_sclk_i2scod", DIV_PERI, 0, 6),
+	DIV(0, "dout_pcm", "mout_sclk_pcm", DIV_PERI, 0, 8),
+};
+
+struct samsung_gate_clock peri_gate_clks[] __initdata = {
+	GATE(PERI_CLK_WDT_KFC, "clk_wdt_kfc", "dout_aclk_peri_66",
+		EN_IP_PERI0, 25, 0, 0),
+	GATE(PERI_CLK_WDT_EGL, "clk_wdt_egl", "dout_aclk_peri_66",
+		EN_IP_PERI0, 24, 0, 0),
+	GATE(PERI_CLK_HSIC3, "clk_hsic3", "dout_aclk_peri_66",
+		EN_IP_PERI0, 23, 0, 0),
+	GATE(PERI_CLK_HSIC2, "clk_hsic2", "dout_aclk_peri_66",
+		EN_IP_PERI0, 22, 0, 0),
+	GATE(PERI_CLK_HSIC1, "clk_hsic1", "dout_aclk_peri_66",
+		EN_IP_PERI0, 21, 0, 0),
+	GATE(PERI_CLK_HSIC0, "clk_hsic0", "dout_aclk_peri_66",
+		EN_IP_PERI0, 20, 0, 0),
+	GATE(PERI_CLK_PCM, "clk_peri_pcm", "dout_aclk_peri_66",
+		EN_IP_PERI0, 18, 0, 0),
+	GATE(PERI_CLK_MCT, "clk_mct", "dout_aclk_peri_66",
+		EN_IP_PERI0, 17, 0, 0),
+	GATE(PERI_CLK_I2S, "clk_peri_i2s", "dout_aclk_peri_66",
+		EN_IP_PERI0, 16, 0, 0),
+	GATE(PERI_CLK_I2CHDMI, "clk_i2chdmi", "dout_aclk_peri_66",
+		EN_IP_PERI0, 15, 0, 0),
+	GATE(PERI_CLK_I2C7, "clk_i2c7", "dout_aclk_peri_66",
+		EN_IP_PERI0, 14, 0, 0),
+	GATE(PERI_CLK_I2C6, "clk_i2c6", "dout_aclk_peri_66",
+		EN_IP_PERI0, 13, 0, 0),
+	GATE(PERI_CLK_I2C5, "clk_i2c5", "dout_aclk_peri_66",
+		EN_IP_PERI0, 12, 0, 0),
+	GATE(PERI_CLK_I2C4, "clk_i2c4", "dout_aclk_peri_66",
+		EN_IP_PERI0, 11, 0, 0),
+	GATE(PERI_CLK_I2C9, "clk_i2c9", "dout_aclk_peri_66",
+		EN_IP_PERI0, 10, 0, 0),
+	GATE(PERI_CLK_I2C8, "clk_i2c8", "dout_aclk_peri_66",
+		EN_IP_PERI0, 9, 0, 0),
+	GATE(PERI_CLK_I2C11, "clk_i2c11", "dout_aclk_peri_66",
+		EN_IP_PERI0, 8, 0, 0),
+	GATE(PERI_CLK_I2C10, "clk_i2c10", "dout_aclk_peri_66",
+		EN_IP_PERI0, 7, 0, 0),
+	GATE(PERI_CLK_HDMICEC, "clk_hdmicec", "dout_aclk_peri_66",
+		EN_IP_PERI0, 6, 0, 0),
+	GATE(PERI_CLK_EFUSE_WRITER, "clk_efuse_writer", "dout_aclk_peri_66",
+		EN_IP_PERI0, 5, 0, 0),
+	GATE(PERI_CLK_ABB, "clk_abb", "dout_aclk_peri_66",
+		EN_IP_PERI0, 1, 0, 0),
+
+	GATE(PERI_CLK_UART2, "clk_uart2", "dout_aclk_peri_66",
+		EN_IP_PERI2, 21, 0, 0),
+	GATE(PERI_CLK_UART1, "clk_uart1", "dout_aclk_peri_66",
+		EN_IP_PERI2, 20, 0, 0),
+	GATE(PERI_CLK_UART0, "clk_uart0", "dout_aclk_peri_66",
+		EN_IP_PERI2, 19, 0, 0),
+	GATE(PERI_CLK_ADC, "clk_adc", "dout_aclk_peri_66",
+		EN_IP_PERI2, 18, 0, 0),
+	GATE(PERI_CLK_TMU4, "clk_tmu4", "dout_aclk_peri_66",
+		EN_IP_PERI2, 14, 0, 0),
+	GATE(PERI_CLK_TMU3, "clk_tmu3", "dout_aclk_peri_66",
+		EN_IP_PERI2, 13, 0, 0),
+	GATE(PERI_CLK_TMU2, "clk_tmu2", "dout_aclk_peri_66",
+		EN_IP_PERI2, 12, 0, 0),
+	GATE(PERI_CLK_TMU1, "clk_tmu1", "dout_aclk_peri_66",
+		EN_IP_PERI2, 11, 0, 0),
+	GATE(PERI_CLK_TMU0, "clk_tmu0", "dout_aclk_peri_66",
+		EN_IP_PERI2, 10, 0, 0),
+	GATE(PERI_CLK_SPI2, "clk_spi2", "dout_aclk_peri_66",
+		EN_IP_PERI2, 9, 0, 0),
+	GATE(PERI_CLK_SPI1, "clk_spi1", "dout_aclk_peri_66",
+		EN_IP_PERI2, 8, 0, 0),
+	GATE(PERI_CLK_SPI0, "clk_spi0", "dout_aclk_peri_66",
+		EN_IP_PERI2, 7, 0, 0),
+	GATE(PERI_CLK_SPDIF, "clk_spdif", "dout_aclk_peri_66",
+		EN_IP_PERI2, 6, 0, 0),
+	GATE(PERI_CLK_PWM, "clk_pwm", "dout_aclk_peri_66",
+		EN_IP_PERI2, 3, 0, 0),
+	GATE(PERI_CLK_UART4, "clk_uart4", "dout_aclk_peri_66",
+		EN_IP_PERI2, 0, 0, 0),
+
+	GATE(PERI_CLK_CHIPID, "clk_chipid", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_CHIPID, 2, 0, 0),
+	GATE(PERI_CLK_PROVKEY0, "clk_provkey0", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_PROVKEY0, 1, 0, 0),
+	GATE(PERI_CLK_PROVKEY1, "clk_provkey1", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_PROVKEY1, 2, 0, 0),
+	GATE(PERI_CLK_SECKEY, "clk_seckey", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_SECKEY, 5, 0, 0),
+	GATE(PERI_CLK_TOP_RTC, "clk_top_rtc", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TOP_RTC, 5, 0, 0),
+
+	GATE(PERI_CLK_TZPC10, "clk_tzpc10", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 20, 0, 0),
+	GATE(PERI_CLK_TZPC9, "clk_tzpc9", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 19, 0, 0),
+	GATE(PERI_CLK_TZPC8, "clk_tzpc8", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 18, 0, 0),
+	GATE(PERI_CLK_TZPC7, "clk_tzpc7", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 17, 0, 0),
+	GATE(PERI_CLK_TZPC6, "clk_tzpc6", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 16, 0, 0),
+	GATE(PERI_CLK_TZPC5, "clk_tzpc5", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 15, 0, 0),
+	GATE(PERI_CLK_TZPC4, "clk_tzpc4", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 14, 0, 0),
+	GATE(PERI_CLK_TZPC3, "clk_tzpc3", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 13, 0, 0),
+	GATE(PERI_CLK_TZPC2, "clk_tzpc2", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 12, 0, 0),
+	GATE(PERI_CLK_TZPC1, "clk_tzpc1", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 11, 0, 0),
+	GATE(PERI_CLK_TZPC0, "clk_tzpc0", "dout_aclk_peri_66",
+		EN_IP_PERI_SECURE_TZPC, 10, 0, 0),
+
+	GATE(PERI_SCLK_UART2, "sclk_uart2", "dout_sclk_peri_uart2",
+			EN_SCLK_PERI, 12, CLK_IGNORE_UNUSED |
+			CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_UART1, "sclk_uart1", "dout_sclk_peri_uart1",
+			EN_SCLK_PERI, 11, CLK_IGNORE_UNUSED |
+			CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_UART0, "sclk_uart0", "dout_sclk_peri_uart0",
+			EN_SCLK_PERI, 10, CLK_IGNORE_UNUSED |
+			CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_SPI2, "sclk_spi2", "dout_sclk_peri_spi2_b",
+			EN_SCLK_PERI, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_SPI1, "sclk_spi1", "dout_sclk_peri_spi1_b",
+			EN_SCLK_PERI, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_SPI0, "sclk_spi0", "dout_sclk_peri_spi0_b",
+			EN_SCLK_PERI, 7, CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_SPDIF, "sclk_spdif", "dout_sclk_peri_spi0_b",
+			EN_SCLK_PERI, 2, CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_I2S, "sclk_i2s", "dout_i2s", EN_SCLK_PERI, 1,
+			CLK_SET_RATE_PARENT, 0),
+	GATE(PERI_SCLK_PCM1, "sclk_pcm1", "dout_pcm", EN_SCLK_PERI, 0,
+			CLK_SET_RATE_PARENT, 0),
+};
+
+static void __init exynos5260_clk_peri_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.mux_clks = peri_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(peri_mux_clks);
+	cmu.div_clks = peri_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(peri_div_clks);
+	cmu.gate_clks = peri_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(peri_gate_clks);
+	cmu.nr_clk_ids = PERI_NR_CLK;
+	cmu.clk_regs = peri_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(peri_clk_regs);
+
+	exynos5260_cmu_register_one(np, &cmu);
+}
+
+CLK_OF_DECLARE(exynos5260_clk_peri, "samsung,exynos5260-clock-peri",
+		exynos5260_clk_peri_init);
+
+
+/* CMU_TOP */
+
+static unsigned long top_clk_regs[] __initdata = {
+	DISP_PLL_LOCK,
+	AUD_PLL_LOCK,
+	DISP_PLL_CON0,
+	DISP_PLL_CON1,
+	DISP_PLL_FDET,
+	AUD_PLL_CON0,
+	AUD_PLL_CON1,
+	AUD_PLL_CON2,
+	AUD_PLL_FDET,
+	MUX_SEL_TOP_PLL0,
+	MUX_SEL_TOP_MFC,
+	MUX_SEL_TOP_G2D,
+	MUX_SEL_TOP_GSCL,
+	MUX_SEL_TOP_ISP10,
+	MUX_SEL_TOP_ISP11,
+	MUX_SEL_TOP_DISP0,
+	MUX_SEL_TOP_DISP1,
+	MUX_SEL_TOP_BUS,
+	MUX_SEL_TOP_PERI0,
+	MUX_SEL_TOP_PERI1,
+	MUX_SEL_TOP_FSYS,
+	DIV_TOP_G2D_MFC,
+	DIV_TOP_GSCL_ISP0,
+	DIV_TOP_ISP10,
+	DIV_TOP_ISP11,
+	DIV_TOP_DISP,
+	DIV_TOP_BUS,
+	DIV_TOP_PERI0,
+	DIV_TOP_PERI1,
+	DIV_TOP_PERI2,
+	DIV_TOP_FSYS0,
+	DIV_TOP_FSYS1,
+	DIV_TOP_HPM,
+	DIV_TOP_PLL_FDET,
+	EN_ACLK_TOP,
+	EN_SCLK_TOP,
+	EN_IP_TOP,
+};
+
+PNAME(mout_memtop_pll_user_p) = {"fin_pll", "dout_mem_pll"};
+PNAME(mout_bustop_pll_user_p) = {"fin_pll", "dout_bus_pll"};
+PNAME(mout_mediatop_pll_user_p) = {"fin_pll", "dout_media_pll"};
+PNAME(mout_audtop_pll_user_p) = {"fin_pll", "mout_aud_pll"};
+PNAME(mout_aud_pll_p) = {"fin_pll", "fout_aud_pll"};
+PNAME(mout_disp_pll_p) = {"fin_pll", "fout_disp_pll"};
+
+PNAME(mout_mfc_bustop_333_p) = {"mout_bustop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_mfc_333_p) = {"mout_mediatop_pll_user", "mout_mfc_bustop_333"};
+
+PNAME(mout_g2d_bustop_333_p) = {"mout_bustop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_g2d_333_p) = {"mout_mediatop_pll_user", "mout_g2d_bustop_333"};
+
+PNAME(mout_gscl_bustop_333_p) = {"mout_bustop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_gscl_333_p) = {"mout_mediatop_pll_user",
+			"mout_gscl_bustop_333"};
+PNAME(mout_m2m_mediatop_400_p) = {"mout_mediatop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_gscl_400_p) = {"mout_bustop_pll_user",
+			"mout_m2m_mediatop_400"};
+PNAME(mout_gscl_bustop_fimc_p) = {"mout_bustop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_gscl_fimc_p) = {"mout_mediatop_pll_user",
+			"mout_gscl_bustop_fimc"};
+
+PNAME(mout_isp1_media_266_p) = {"mout_mediatop_pll_user",
+			"mout_memtop_pll_user"};
+PNAME(mout_aclk_isp1_266_p) = {"mout_bustop_pll_user", "mout_isp1_media_266"};
+PNAME(mout_isp1_media_400_p) = {"mout_mediatop_pll_user", "mout_disp_pll"};
+PNAME(mout_aclk_isp1_400_p) = {"mout_bustop_pll_user", "mout_isp1_media_400"};
+
+PNAME(mout_sclk_isp_spi_p) = {"fin_pll", "mout_bustop_pll_user"};
+PNAME(mout_sclk_isp_uart_p) = {"fin_pll", "mout_bustop_pll_user"};
+PNAME(mout_sclk_isp_sensor_p) = {"fin_pll", "mout_bustop_pll_user"};
+
+PNAME(mout_disp_disp_333_p) = {"mout_disp_pll", "mout_bustop_pll_user"};
+PNAME(mout_aclk_disp_333_p) = {"mout_mediatop_pll_user", "mout_disp_disp_333"};
+PNAME(mout_disp_disp_222_p) = {"mout_disp_pll", "mout_bustop_pll_user"};
+PNAME(mout_aclk_disp_222_p) = {"mout_mediatop_pll_user", "mout_disp_disp_222"};
+PNAME(mout_disp_media_pixel_p) = {"mout_mediatop_pll_user",
+			"mout_bustop_pll_user"};
+PNAME(mout_sclk_disp_pixel_p) = {"mout_disp_pll", "mout_disp_media_pixel"};
+
+PNAME(mout_bus_bustop_400_p) = {"mout_bustop_pll_user", "mout_memtop_pll_user"};
+PNAME(mout_bus_bustop_100_p) = {"mout_bustop_pll_user", "mout_memtop_pll_user"};
+
+PNAME(mout_sclk_peri_spi_clk_p) = {"fin_pll", "mout_bustop_pll_user"};
+PNAME(mout_sclk_peri_uart_uclk_p) = {"fin_pll", "mout_bustop_pll_user"};
+
+PNAME(mout_sclk_fsys_usb_p) = {"fin_pll", "mout_bustop_pll_user"};
+PNAME(mout_sclk_fsys_mmc_sdclkin_a_p) = {"fin_pll", "mout_bustop_pll_user"};
+PNAME(mout_sclk_fsys_mmc0_sdclkin_b_p) = {"mout_sclk_fsys_mmc0_sdclkin_a",
+			"mout_mediatop_pll_user"};
+PNAME(mout_sclk_fsys_mmc1_sdclkin_b_p) = {"mout_sclk_fsys_mmc1_sdclkin_a",
+			"mout_mediatop_pll_user"};
+PNAME(mout_sclk_fsys_mmc2_sdclkin_b_p) = {"mout_sclk_fsys_mmc2_sdclkin_a",
+			"mout_mediatop_pll_user"};
+
+struct samsung_fixed_rate_clock fixed_rate_ext_clks[] __initdata = {
+	FRATE(FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "xrtcxti", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ioclk_pcm_extclk", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ioclk_spdif_extclk", NULL, CLK_IS_ROOT, 0),
+	FRATE(0, "ioclk_i2s_cdclk", NULL, CLK_IS_ROOT, 0),
+};
+
+struct samsung_fixed_rate_clock fixed_rate_clks[] __initdata = {
+	FRATE(0, "phyclk_dptx_phy_ch3_txd_clk", NULL,
+			CLK_IS_ROOT, 270000000),
+	FRATE(0, "phyclk_dptx_phy_ch2_txd_clk", NULL,
+			CLK_IS_ROOT, 270000000),
+	FRATE(0, "phyclk_dptx_phy_ch1_txd_clk", NULL,
+			CLK_IS_ROOT, 270000000),
+	FRATE(0, "phyclk_dptx_phy_ch0_txd_clk", NULL,
+			CLK_IS_ROOT, 270000000),
+	FRATE(0, "phyclk_hdmi_phy_tmds_clko", NULL,
+			CLK_IS_ROOT, 250000000),
+	FRATE(TOP_HDMI_PHY_PIXEL_CLKO, "phyclk_hdmi_phy_pixel_clko", NULL,
+			CLK_IS_ROOT, 1660000000),
+	FRATE(0, "phyclk_hdmi_link_o_tmds_clkhi", NULL,
+			CLK_IS_ROOT, 125000000),
+	FRATE(0, "phyclk_mipi_dphy_4l_m_txbyteclkhs", NULL,
+			CLK_IS_ROOT, 187500000),
+	FRATE(0, "phyclk_dptx_phy_o_ref_clk_24m", NULL,
+			CLK_IS_ROOT, 24000000),
+	FRATE(0, "phyclk_dptx_phy_clk_div2", NULL,
+			CLK_IS_ROOT, 135000000),
+	FRATE(0, "phyclk_mipi_dphy_4l_m_rxclkesc0", NULL,
+			CLK_IS_ROOT, 20000000),
+	FRATE(0, "phyclk_usbhost20_phy_phyclock", NULL,
+			CLK_IS_ROOT, 60000000),
+	FRATE(0, "phyclk_usbhost20_phy_freeclk", NULL,
+			CLK_IS_ROOT, 60000000),
+	FRATE(0, "phyclk_usbhost20_phy_clk48mohci", NULL,
+			CLK_IS_ROOT, 48000000),
+	FRATE(0, "phyclk_usbdrd30_udrd30_pipe_pclk", NULL,
+			CLK_IS_ROOT, 125000000),
+	FRATE(0, "phyclk_usbdrd30_udrd30_phyclock", NULL,
+			CLK_IS_ROOT, 60000000),
+};
+
+struct samsung_mux_clock top_mux_clks[] __initdata = {
+	MUX(0, "mout_audtop_pll_user", mout_audtop_pll_user_p,
+			MUX_SEL_TOP_PLL0, 24, 1),
+	MUX(0, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP_PLL0, 16, 1),
+	MUX(TOP_MOUT_DISP_PLL, "mout_disp_pll", mout_disp_pll_p,
+			MUX_SEL_TOP_PLL0, 12, 1),
+	MUX(0, "mout_bustop_pll_user", mout_bustop_pll_user_p,
+			MUX_SEL_TOP_PLL0, 8, 1),
+	MUX(0, "mout_memtop_pll_user", mout_memtop_pll_user_p,
+			MUX_SEL_TOP_PLL0, 4, 1),
+	MUX(0, "mout_mediatop_pll_user", mout_mediatop_pll_user_p,
+			MUX_SEL_TOP_PLL0, 0, 1),
+
+
+	MUX(0, "mout_disp_disp_333", mout_disp_disp_333_p,
+			MUX_SEL_TOP_DISP0, 0, 1),
+	MUX(0, "mout_aclk_disp_333", mout_aclk_disp_333_p,
+			MUX_SEL_TOP_DISP0, 8, 1),
+	MUX(0, "mout_disp_disp_222", mout_disp_disp_222_p,
+			MUX_SEL_TOP_DISP0, 12, 1),
+	MUX(0, "mout_aclk_disp_222", mout_aclk_disp_222_p,
+			MUX_SEL_TOP_DISP0, 20, 1),
+	MUX(0, "mout_disp_media_pixel", mout_disp_media_pixel_p,
+			MUX_SEL_TOP_DISP1, 8, 1),
+	MUX(TOP_MOUT_FIMD1, "mout_sclk_disp_pixel", mout_sclk_disp_pixel_p,
+			MUX_SEL_TOP_DISP1, 0, 1),
+
+	MUX(0, "mout_sclk_peri_spi0_clk", mout_sclk_peri_spi_clk_p,
+			MUX_SEL_TOP_PERI1, 8, 1),
+	MUX(0, "mout_sclk_peri_spi1_clk", mout_sclk_peri_spi_clk_p,
+			MUX_SEL_TOP_PERI1, 4, 1),
+	MUX(0, "mout_sclk_peri_spi2_clk", mout_sclk_peri_spi_clk_p,
+			MUX_SEL_TOP_PERI1, 0, 1),
+	MUX(0, "mout_sclk_peri_uart0_uclk", mout_sclk_peri_uart_uclk_p,
+			MUX_SEL_TOP_PERI1, 20, 1),
+	MUX(0, "mout_sclk_peri_uart2_uclk", mout_sclk_peri_uart_uclk_p,
+			MUX_SEL_TOP_PERI1, 16, 1),
+	MUX(0, "mout_sclk_peri_uart1_uclk", mout_sclk_peri_uart_uclk_p,
+			MUX_SEL_TOP_PERI1, 12, 1),
+
+	MUX(0, "mout_bus4_bustop_100", mout_bus_bustop_100_p,
+			MUX_SEL_TOP_BUS, 28, 1),
+	MUX(0, "mout_bus4_bustop_400", mout_bus_bustop_400_p,
+			MUX_SEL_TOP_BUS, 24, 1),
+	MUX(0, "mout_bus3_bustop_100", mout_bus_bustop_100_p,
+			MUX_SEL_TOP_BUS, 20, 1),
+	MUX(0, "mout_bus3_bustop_400", mout_bus_bustop_400_p,
+			MUX_SEL_TOP_BUS, 16, 1),
+	MUX(0, "mout_bus2_bustop_400", mout_bus_bustop_400_p,
+			MUX_SEL_TOP_BUS, 12, 1),
+	MUX(0, "mout_bus2_bustop_100", mout_bus_bustop_100_p,
+			MUX_SEL_TOP_BUS, 8, 1),
+	MUX(0, "mout_bus1_bustop_100", mout_bus_bustop_100_p,
+			MUX_SEL_TOP_BUS, 4, 1),
+	MUX(0, "mout_bus1_bustop_400", mout_bus_bustop_400_p,
+			MUX_SEL_TOP_BUS, 0, 1),
+
+	MUX(0, "mout_sclk_fsys_usb", mout_sclk_fsys_usb_p,
+			MUX_SEL_TOP_FSYS, 0, 1),
+	MUX(0, "mout_sclk_fsys_mmc0_sdclkin_a",
+			mout_sclk_fsys_mmc_sdclkin_a_p,
+			MUX_SEL_TOP_FSYS, 20, 1),
+	MUX(0, "mout_sclk_fsys_mmc1_sdclkin_a",
+			mout_sclk_fsys_mmc_sdclkin_a_p,
+			MUX_SEL_TOP_FSYS, 12, 1),
+	MUX(0, "mout_sclk_fsys_mmc2_sdclkin_a",
+			mout_sclk_fsys_mmc_sdclkin_a_p,
+			MUX_SEL_TOP_FSYS, 4, 1),
+	MUX(0, "mout_sclk_fsys_mmc0_sdclkin_b",
+			mout_sclk_fsys_mmc0_sdclkin_b_p,
+			MUX_SEL_TOP_FSYS, 24, 1),
+	MUX(0, "mout_sclk_fsys_mmc1_sdclkin_b",
+			mout_sclk_fsys_mmc1_sdclkin_b_p,
+			MUX_SEL_TOP_FSYS, 16, 1),
+	MUX(0, "mout_sclk_fsys_mmc2_sdclkin_b",
+			mout_sclk_fsys_mmc2_sdclkin_b_p,
+			MUX_SEL_TOP_FSYS, 8, 1),
+
+	MUX(0, "mout_aclk_isp1_266", mout_aclk_isp1_266_p,
+			MUX_SEL_TOP_ISP10, 20, 1),
+	MUX(0, "mout_isp1_media_266", mout_isp1_media_266_p,
+			MUX_SEL_TOP_ISP10, 16, 1),
+	MUX(0, "mout_aclk_isp1_400", mout_aclk_isp1_400_p,
+			MUX_SEL_TOP_ISP10, 8 , 1),
+	MUX(0, "mout_isp1_media_400", mout_isp1_media_400_p,
+			MUX_SEL_TOP_ISP10, 4, 1),
+
+	MUX(0, "mout_sclk_isp1_spi0", mout_sclk_isp_spi_p,
+			MUX_SEL_TOP_ISP11, 4, 1),
+	MUX(0, "mout_sclk_isp1_spi1", mout_sclk_isp_spi_p,
+			MUX_SEL_TOP_ISP11, 8, 1),
+	MUX(0, "mout_sclk_isp1_uart", mout_sclk_isp_uart_p,
+			MUX_SEL_TOP_ISP11, 12, 1),
+	MUX(0, "mout_sclk_isp1_sensor2", mout_sclk_isp_sensor_p,
+			MUX_SEL_TOP_ISP11, 24, 1),
+	MUX(0, "mout_sclk_isp1_sensor1", mout_sclk_isp_sensor_p,
+			MUX_SEL_TOP_ISP11, 20, 1),
+	MUX(0, "mout_sclk_isp1_sensor0", mout_sclk_isp_sensor_p,
+			MUX_SEL_TOP_ISP11, 16, 1),
+
+	MUX(0, "mout_aclk_mfc_333", mout_aclk_mfc_333_p,
+			MUX_SEL_TOP_MFC, 8, 1),
+	MUX(0, "mout_mfc_bustop_333", mout_mfc_bustop_333_p,
+			MUX_SEL_TOP_MFC, 4, 1),
+
+	MUX(0, "mout_aclk_g2d_333", mout_aclk_g2d_333_p,
+			MUX_SEL_TOP_G2D, 8, 1),
+	MUX(0, "mout_g2d_bustop_333", mout_g2d_bustop_333_p,
+			MUX_SEL_TOP_G2D, 4, 1),
+
+	MUX(0, "mout_aclk_gscl_fimc", mout_aclk_gscl_fimc_p,
+			MUX_SEL_TOP_GSCL, 20, 1),
+	MUX(0, "mout_gscl_bustop_fimc", mout_gscl_bustop_fimc_p,
+			MUX_SEL_TOP_GSCL, 16, 1),
+	MUX(0, "mout_aclk_gscl_333", mout_aclk_gscl_333_p,
+			MUX_SEL_TOP_GSCL, 12, 1),
+	MUX(0, "mout_gscl_bustop_333", mout_gscl_bustop_333_p,
+			MUX_SEL_TOP_GSCL, 8, 1),
+	MUX(0, "mout_aclk_gscl_400", mout_aclk_gscl_400_p,
+			MUX_SEL_TOP_GSCL, 4, 1),
+	MUX(0, "mout_m2m_mediatop_400", mout_m2m_mediatop_400_p,
+			MUX_SEL_TOP_GSCL, 0, 1),
+};
+
+struct samsung_div_clock top_div_clks[] __initdata = {
+	DIV(0, "dout_aclk_mfc_333", "mout_aclk_mfc_333",
+			DIV_TOP_G2D_MFC, 4, 3),
+
+	DIV(0, "dout_aclk_g2d_333", "mout_aclk_g2d_333",
+			DIV_TOP_GSCL_ISP0, 0, 3),
+
+	DIV(0, "dout_sclk_isp1_sensor2_a", "mout_aclk_gscl_fimc",
+			DIV_TOP_GSCL_ISP0, 24, 4),
+	DIV(0, "dout_sclk_isp1_sensor1_a", "mout_aclk_gscl_400",
+			DIV_TOP_GSCL_ISP0, 20, 4),
+	DIV(0, "dout_sclk_isp1_sensor0_a", "mout_aclk_gscl_fimc",
+			DIV_TOP_GSCL_ISP0, 16, 4),
+	DIV(0, "dout_aclk_gscl_fimc", "mout_aclk_gscl_fimc",
+			DIV_TOP_GSCL_ISP0, 8, 3),
+	DIV(0, "dout_aclk_gscl_400", "mout_aclk_gscl_400",
+			DIV_TOP_GSCL_ISP0, 4, 3),
+	DIV(0, "dout_aclk_gscl_333", "mout_aclk_gscl_333",
+			DIV_TOP_GSCL_ISP0, 0, 3),
+
+	DIV(0, "dout_sclk_isp1_spi0_b", "dout_sclk_isp1_spi0_a",
+			DIV_TOP_ISP10, 16, 8),
+	DIV(0, "dout_sclk_isp1_spi0_a", "mout_sclk_isp1_spi0",
+			DIV_TOP_ISP10, 12, 4),
+	DIV(0, "dout_aclk_isp1_400", "mout_aclk_isp1_400",
+			DIV_TOP_ISP10, 4, 3),
+	DIV(0, "dout_aclk_isp1_266", "mout_aclk_isp1_266",
+			DIV_TOP_ISP10, 0, 3),
+	DIV(0, "dout_sclk_isp1_uart", "mout_sclk_isp1_uart",
+			DIV_TOP_ISP11, 12, 4),
+	DIV(0, "dout_sclk_isp1_spi1_b", "dout_sclk_isp1_spi1_a",
+			DIV_TOP_ISP11, 4, 8),
+	DIV(0, "dout_sclk_isp1_spi1_a", "mout_sclk_isp1_spi1",
+			DIV_TOP_ISP11, 0, 4),
+	DIV(0, "dout_sclk_isp1_sensor2_b", "dout_sclk_isp1_sensor2_a",
+			DIV_TOP_ISP11, 24, 4),
+	DIV(0, "dout_sclk_isp1_sensor1_b", "dout_sclk_isp1_sensor1_a",
+			DIV_TOP_ISP11, 20, 4),
+	DIV(0, "dout_sclk_isp1_sensor0_b", "dout_sclk_isp1_sensor0_a",
+			DIV_TOP_ISP11, 16, 4),
+
+	DIV(0, "dout_sclk_hpm_targetclk", "mout_bustop_pll_user",
+			DIV_TOP_HPM, 0, 3),
+
+	DIV(0, "dout_sclk_disp_pixel", "mout_sclk_disp_pixel",
+			DIV_TOP_DISP, 8, 3),
+	DIV(0, "dout_aclk_disp_222", "mout_aclk_disp_222",
+			DIV_TOP_DISP, 4, 3),
+	DIV(0, "dout_aclk_disp_333", "mout_aclk_disp_333",
+			DIV_TOP_DISP, 0, 3),
+
+	DIV(0, "dout_aclk_bus4_100", "mout_bus4_bustop_100",
+			DIV_TOP_BUS, 28, 4),
+	DIV(0, "dout_aclk_bus4_400", "mout_bus4_bustop_400",
+			DIV_TOP_BUS, 24, 3),
+	DIV(0, "dout_aclk_bus3_100", "mout_bus3_bustop_100",
+			DIV_TOP_BUS, 20, 4),
+	DIV(0, "dout_aclk_bus3_400", "mout_bus3_bustop_400",
+			DIV_TOP_BUS, 16, 3),
+	DIV(0, "dout_aclk_bus2_100", "mout_bus2_bustop_100",
+			DIV_TOP_BUS, 12, 4),
+	DIV(0, "dout_aclk_bus2_400", "mout_bus2_bustop_400",
+			DIV_TOP_BUS, 8, 3),
+	DIV(0, "dout_aclk_bus1_100", "mout_bus1_bustop_100",
+			DIV_TOP_BUS, 4, 4),
+	DIV(0, "dout_aclk_bus1_400", "mout_bus1_bustop_400",
+			DIV_TOP_BUS, 0, 3),
+
+	DIV(0, "dout_sclk_peri_spi1_b", "dout_sclk_peri_spi1_a",
+			DIV_TOP_PERI0, 20, 8),
+	DIV(0, "dout_sclk_peri_spi1_a", "mout_sclk_peri_spi1_clk",
+			DIV_TOP_PERI0, 16, 4),
+	DIV(0, "dout_sclk_peri_spi0_b", "dout_sclk_peri_spi0_a",
+			DIV_TOP_PERI0, 8, 8),
+	DIV(0, "dout_sclk_peri_spi0_a", "mout_sclk_peri_spi0_clk",
+			DIV_TOP_PERI0, 4, 4),
+	DIV(0, "dout_sclk_peri_uart0", "mout_sclk_peri_uart0_uclk",
+			DIV_TOP_PERI1, 24, 4),
+	DIV(0, "dout_sclk_peri_uart2", "mout_sclk_peri_uart2_uclk",
+			DIV_TOP_PERI1, 20, 4),
+	DIV(0, "dout_sclk_peri_uart1", "mout_sclk_peri_uart1_uclk",
+			DIV_TOP_PERI1, 16, 4),
+	DIV(0, "dout_sclk_peri_spi2_b", "dout_sclk_peri_spi2_a",
+			DIV_TOP_PERI1, 4, 8),
+	DIV(0, "dout_sclk_peri_spi2_a", "mout_sclk_peri_spi2_clk",
+			DIV_TOP_PERI1, 0, 4),
+	DIV(0, "dout_aclk_peri_aud", "mout_audtop_pll_user",
+			DIV_TOP_PERI2, 24, 3),
+	DIV(0, "dout_aclk_peri_66", "mout_bustop_pll_user",
+			DIV_TOP_PERI2, 20, 4),
+
+	DIV(0, "dout_sclk_fsys_mmc0_sdclkin_b",
+			"dout_sclk_fsys_mmc0_sdclkin_a",
+			DIV_TOP_FSYS0, 16, 8),
+	DIV(0, "dout_sclk_fsys_mmc0_sdclkin_a",
+			"mout_sclk_fsys_mmc0_sdclkin_b",
+			DIV_TOP_FSYS0, 12, 4),
+	DIV(0, "dout_sclk_fsys_usbdrd30_suspend_clk",
+			"mout_sclk_fsys_usb",
+			DIV_TOP_FSYS0, 4, 4),
+	DIV(0, "dout_aclk_fsys_200", "mout_bustop_pll_user",
+			DIV_TOP_FSYS0, 0, 3),
+
+	DIV(0, "dout_sclk_fsys_mmc2_sdclkin_b",
+			"dout_sclk_fsys_mmc2_sdclkin_a",
+			DIV_TOP_FSYS1, 16, 8),
+	DIV(0, "dout_sclk_fsys_mmc2_sdclkin_a",
+			"mout_sclk_fsys_mmc2_sdclkin_b",
+			DIV_TOP_FSYS1, 12, 4),
+	DIV(0, "dout_sclk_fsys_mmc1_sdclkin_b",
+			"dout_sclk_fsys_mmc1_sdclkin_a",
+			DIV_TOP_FSYS1, 4, 8),
+	DIV(0, "dout_sclk_fsys_mmc1_sdclkin_a",
+			"mout_sclk_fsys_mmc1_sdclkin_b",
+			DIV_TOP_FSYS1, 0, 4),
+};
+
+struct samsung_gate_clock top_gate_clks[] __initdata = {
+	GATE(TOP_SCLK_FIMD1, "sclk_disp_pixel", "dout_sclk_disp_pixel",
+			EN_ACLK_TOP, 10, CLK_SET_RATE_PARENT, 0),
+	GATE(TOP_SCLK_MMC2, "sclk_fsys_mmc2_sdclkin",
+			"dout_sclk_fsys_mmc2_sdclkin_b",
+			EN_SCLK_TOP, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(TOP_SCLK_MMC1, "sclk_fsys_mmc1_sdclkin",
+			"dout_sclk_fsys_mmc1_sdclkin_b",
+			EN_SCLK_TOP, 8, CLK_SET_RATE_PARENT,
+			0),
+	GATE(TOP_SCLK_MMC0, "sclk_fsys_mmc0_sdclkin",
+			"dout_sclk_fsys_mmc0_sdclkin_b",
+			EN_SCLK_TOP, 7, CLK_SET_RATE_PARENT, 0),
+};
+
+
+
+static struct samsung_pll_clock top_pll_clks[] __initdata = {
+	PLL(pll_2550xx, TOP_FOUT_DISP_PLL, "fout_disp_pll", "fin_pll",
+		DISP_PLL_LOCK, DISP_PLL_CON0,
+		pll2550_24mhz_tbl),
+	PLL(pll_2650xx, TOP_FOUT_AUD_PLL, "fout_aud_pll", "fin_pll",
+		AUD_PLL_LOCK, AUD_PLL_CON0,
+		pll2650_24mhz_tbl),
+};
+
+static void __init exynos5260_clk_top_init(struct device_node *np)
+{
+	struct exynos5260_cmu_info cmu;
+	struct samsung_clk_provider *ctx;
+
+	memset(&cmu, 0, sizeof(cmu));
+
+	cmu.pll_clks = top_pll_clks;
+	cmu.nr_pll_clks =  ARRAY_SIZE(top_pll_clks);
+	cmu.mux_clks = top_mux_clks;
+	cmu.nr_mux_clks = ARRAY_SIZE(top_mux_clks);
+	cmu.div_clks = top_div_clks;
+	cmu.nr_div_clks = ARRAY_SIZE(top_div_clks);
+	cmu.gate_clks = top_gate_clks;
+	cmu.nr_gate_clks = ARRAY_SIZE(top_gate_clks);
+	cmu.nr_clk_ids = TOP_NR_CLK;
+	cmu.clk_regs = top_clk_regs;
+	cmu.nr_clk_regs = ARRAY_SIZE(top_clk_regs);
+
+	ctx = exynos5260_cmu_register_one(np, &cmu);
+
+	samsung_clk_of_register_fixed_ext(ctx, fixed_rate_ext_clks,
+			ARRAY_SIZE(fixed_rate_ext_clks),
+			ext_clk_match);
+
+	samsung_clk_register_fixed_rate(ctx,
+		fixed_rate_clks,
+		ARRAY_SIZE(fixed_rate_clks));
+}
+
+CLK_OF_DECLARE(exynos5260_clk_top, "samsung,exynos5260-clock-top",
+		exynos5260_clk_top_init);
diff --git a/drivers/clk/samsung/clk-exynos5260.h b/drivers/clk/samsung/clk-exynos5260.h
new file mode 100644
index 0000000..7c3717a
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos5260.h
@@ -0,0 +1,448 @@
+#ifndef __CLK_EXYNOS5260_H
+#define __CLK_EXYNOS5260_H
+
+/*
+*Registers for CMU_AUD
+*/
+#define MUX_SEL_AUD		0x0200
+#define MUX_ENABLE_AUD		0x0300
+#define MUX_STAT_AUD		0x0400
+#define MUX_IGNORE_AUD		0x0500
+#define DIV_AUD0		0x0600
+#define DIV_AUD1		0x0604
+#define DIV_STAT_AUD0		0x0700
+#define DIV_STAT_AUD1		0x0704
+#define EN_ACLK_AUD		0x0800
+#define EN_PCLK_AUD		0x0900
+#define EN_SCLK_AUD		0x0a00
+#define EN_IP_AUD		0x0b00
+
+/*
+*Registers for CMU_DISP
+*/
+#define MUX_SEL_DISP0		0x0200
+#define MUX_SEL_DISP1		0x0204
+#define MUX_SEL_DISP2		0x0208
+#define MUX_SEL_DISP3		0x020C
+#define MUX_SEL_DISP4		0x0210
+#define MUX_ENABLE_DISP0	0x0300
+#define MUX_ENABLE_DISP1	0x0304
+#define MUX_ENABLE_DISP2	0x0308
+#define MUX_ENABLE_DISP3	0x030c
+#define MUX_ENABLE_DISP4	0x0310
+#define MUX_STAT_DISP0		0x0400
+#define MUX_STAT_DISP1		0x0404
+#define MUX_STAT_DISP2		0x0408
+#define MUX_STAT_DISP3		0x040c
+#define MUX_STAT_DISP4		0x0410
+#define MUX_IGNORE_DISP0	0x0500
+#define MUX_IGNORE_DISP1	0x0504
+#define MUX_IGNORE_DISP2	0x0508
+#define MUX_IGNORE_DISP3	0x050c
+#define MUX_IGNORE_DISP4	0x0510
+#define DIV_DISP		0x0600
+#define DIV_STAT_DISP		0x0700
+#define EN_ACLK_DISP		0x0800
+#define EN_PCLK_DISP		0x0900
+#define EN_SCLK_DISP0		0x0a00
+#define EN_SCLK_DISP1		0x0a04
+#define EN_IP_DISP		0x0b00
+#define EN_IP_DISP_BUS		0x0b04
+
+
+/*
+*Registers for CMU_EGL
+*/
+#define EGL_PLL_LOCK		0x0000
+#define EGL_DPLL_LOCK		0x0004
+#define EGL_PLL_CON0		0x0100
+#define EGL_PLL_CON1		0x0104
+#define EGL_PLL_FREQ_DET	0x010c
+#define EGL_DPLL_CON0		0x0110
+#define EGL_DPLL_CON1		0x0114
+#define EGL_DPLL_FREQ_DET	0x011c
+#define MUX_SEL_EGL		0x0200
+#define MUX_ENABLE_EGL		0x0300
+#define MUX_STAT_EGL		0x0400
+#define DIV_EGL			0x0600
+#define DIV_EGL_PLL_FDET	0x0604
+#define DIV_STAT_EGL		0x0700
+#define DIV_STAT_EGL_PLL_FDET	0x0704
+#define EN_ACLK_EGL		0x0800
+#define EN_PCLK_EGL		0x0900
+#define EN_SCLK_EGL		0x0a00
+#define EN_IP_EGL		0x0b00
+#define CLKOUT_CMU_EGL		0x0c00
+#define CLKOUT_CMU_EGL_DIV_STAT	0x0c04
+#define ARMCLK_STOPCTRL		0x1000
+#define EAGLE_EMA_CTRL		0x1008
+#define EAGLE_EMA_STATUS	0x100c
+#define PWR_CTRL		0x1020
+#define PWR_CTRL2		0x1024
+#define CLKSTOP_CTRL		0x1028
+#define INTR_SPREAD_EN		0x1080
+#define INTR_SPREAD_USE_STANDBYWFI	0x1084
+#define INTR_SPREAD_BLOCKING_DURATION	0x1088
+#define CMU_EGL_SPARE0		0x2000
+#define CMU_EGL_SPARE1		0x2004
+#define CMU_EGL_SPARE2		0x2008
+#define CMU_EGL_SPARE3		0x200c
+#define CMU_EGL_SPARE4		0x2010
+
+/*
+*Registers for CMU_FSYS
+*/
+
+#define MUX_SEL_FSYS0		0x0200
+#define MUX_SEL_FSYS1		0x0204
+#define MUX_ENABLE_FSYS0	0x0300
+#define MUX_ENABLE_FSYS1	0x0304
+#define MUX_STAT_FSYS0		0x0400
+#define MUX_STAT_FSYS1		0x0404
+#define MUX_IGNORE_FSYS0	0x0500
+#define MUX_IGNORE_FSYS1	0x0504
+#define EN_ACLK_FSYS		0x0800
+#define EN_ACLK_FSYS_SECURE_RTIC		0x0804
+#define EN_ACLK_FSYS_SECURE_SMMU_RTIC		0x0808
+#define EN_PCLK_FSYS		0x0900
+#define EN_SCLK_FSYS		0x0a00
+#define EN_IP_FSYS		0x0b00
+#define EN_IP_FSYS_SECURE_RTIC	0x0b04
+#define EN_IP_FSYS_SECURE_SMMU_RTIC	0x0b08
+
+/*
+*Registers for CMU_G2D
+*/
+
+#define MUX_SEL_G2D		0x0200
+#define MUX_ENABLE_G2D		0x0300
+#define MUX_STAT_G2D		0x0400
+#define DIV_G2D			0x0600
+#define DIV_STAT_G2D		0x0700
+#define EN_ACLK_G2D		0x0800
+#define EN_ACLK_G2D_SECURE_SSS			0x0804
+#define EN_ACLK_G2D_SECURE_SLIM_SSS		0x0808
+#define EN_ACLK_G2D_SECURE_SMMU_SLIM_SSS	0x080c
+#define EN_ACLK_G2D_SECURE_SMMU_SSS		0x0810
+#define EN_ACLK_G2D_SECURE_SMMU_MDMA		0x0814
+#define EN_ACLK_G2D_SECURE_SMMU_G2D		0x0818
+#define EN_PCLK_G2D				0x0900
+#define EN_PCLK_G2D_SECURE_SMMU_SLIM_SSS	0x0904
+#define EN_PCLK_G2D_SECURE_SMMU_SSS		0x0908
+#define EN_PCLK_G2D_SECURE_SMMU_MDMA		0x090c
+#define EN_PCLK_G2D_SECURE_SMMU_G2D		0x0910
+#define EN_IP_G2D				0x0b00
+#define EN_IP_G2D_SECURE_SSS			0x0b04
+#define EN_IP_G2D_SECURE_SLIM_SSS		0x0b08
+#define EN_IP_G2D_SECURE_SMMU_SLIM_SSS		0x0b0c
+#define EN_IP_G2D_SECURE_SMMU_SSS		0x0b10
+#define EN_IP_G2D_SECURE_SMMU_MDMA		0x0b14
+#define EN_IP_G2D_SECURE_SMMU_G2D		0x0b18
+
+/*
+*Registers for CMU_G3D
+*/
+
+#define G3D_PLL_LOCK		0x0000
+#define G3D_PLL_CON0		0x0100
+#define G3D_PLL_CON1		0x0104
+#define G3D_PLL_FDET		0x010c
+#define MUX_SEL_G3D		0x0200
+#define MUX_EN_G3D		0x0300
+#define MUX_STAT_G3D		0x0400
+#define MUX_IGNORE_G3D		0x0500
+#define DIV_G3D			0x0600
+#define DIV_G3D_PLL_FDET	0x0604
+#define DIV_STAT_G3D		0x0700
+#define DIV_STAT_G3D_PLL_FDET	0x0704
+#define EN_ACLK_G3D		0x0800
+#define EN_PCLK_G3D		0x0900
+#define EN_SCLK_G3D		0x0a00
+#define EN_IP_G3D		0x0b00
+#define CLKOUT_CMU_G3D		0x0c00
+#define CLKOUT_CMU_G3D_DIV_STAT		0x0c04
+#define G3DCLK_STOPCTRL		0x1000
+#define G3D_EMA_CTRL		0x1008
+#define G3D_EMA_STATUS		0x100c
+
+/*
+*Registers for CMU_GSCL
+*/
+
+#define MUX_SEL_GSCL		0x0200
+#define MUX_EN_GSCL		0x0300
+#define MUX_STAT_GSCL		0x0400
+#define MUX_IGNORE_GSCL		0x0500
+#define DIV_GSCL		0x0600
+#define DIV_STAT_GSCL		0x0700
+#define EN_ACLK_GSCL		0x0800
+#define EN_ACLK_GSCL_FIMC	0x0804
+#define EN_ACLK_GSCL_SECURE_SMMU_GSCL0		0x0808
+#define EN_ACLK_GSCL_SECURE_SMMU_GSCL1		0x080c
+#define EN_ACLK_GSCL_SECURE_SMMU_MSCL0		0x0810
+#define EN_ACLK_GSCL_SECURE_SMMU_MSCL1		0x0814
+#define EN_PCLK_GSCL				0x0900
+#define EN_PCLK_GSCL_FIMC			0x0904
+#define EN_PCLK_GSCL_SECURE_SMMU_GSCL0		0x0908
+#define EN_PCLK_GSCL_SECURE_SMMU_GSCL1		0x090c
+#define EN_PCLK_GSCL_SECURE_SMMU_MSCL0		0x0910
+#define EN_PCLK_GSCL_SECURE_SMMU_MSCL1		0x0914
+#define EN_SCLK_GSCL		0x0a00
+#define EN_SCLK_GSCL_FIMC	0x0a04
+#define EN_IP_GSCL		0x0b00
+#define EN_IP_GSCL_FIMC		0x0b04
+#define EN_IP_GSCL_SECURE_SMMU_GSCL0		0x0b08
+#define EN_IP_GSCL_SECURE_SMMU_GSCL1		0x0b0c
+#define EN_IP_GSCL_SECURE_SMMU_MSCL0		0x0b10
+#define EN_IP_GSCL_SECURE_SMMU_MSCL1		0x0b14
+
+/*
+*Registers for CMU_ISP
+*/
+#define MUX_SEL_ISP0		0x0200
+#define MUX_SEL_ISP1		0x0204
+#define MUX_ENABLE_ISP0		0x0300
+#define MUX_ENABLE_ISP1		0x0304
+#define MUX_STAT_ISP0		0x0400
+#define MUX_STAT_ISP1		0x0404
+#define MUX_IGNORE_ISP0		0x0500
+#define MUX_IGNORE_ISP1		0x0504
+#define DIV_ISP			0x0600
+#define DIV_STAT_ISP		0x0700
+#define EN_ACLK_ISP0		0x0800
+#define EN_ACLK_ISP1		0x0804
+#define EN_PCLK_ISP0		0x0900
+#define EN_PCLK_ISP1		0x0904
+#define EN_SCLK_ISP		0x0a00
+#define EN_IP_ISP0		0x0b00
+#define EN_IP_ISP1		0x0b04
+
+/*
+*Registers for CMU_KFC
+*/
+#define KFC_PLL_LOCK		0x0000
+#define KFC_PLL_CON0		0x0100
+#define KFC_PLL_CON1		0x0104
+#define KFC_PLL_FDET		0x010c
+#define MUX_SEL_KFC0		0x0200
+#define MUX_SEL_KFC2		0x0208
+#define MUX_ENABLE_KFC0		0x0300
+#define MUX_ENABLE_KFC2		0x0308
+#define MUX_STAT_KFC0		0x0400
+#define MUX_STAT_KFC2		0x0408
+#define DIV_KFC			0x0600
+#define DIV_KFC_PLL_FDET	0x0604
+#define DIV_STAT_KFC		0x0700
+#define DIV_STAT_KFC_PLL_FDET	0x0704
+#define EN_ACLK_KFC		0x0800
+#define EN_PCLK_KFC		0x0900
+#define EN_SCLK_KFC		0x0a00
+#define EN_IP_KFC		0x0b00
+#define CLKOUT_CMU_KFC		0x0c00
+#define CLKOUT_CMU_KFC_DIV_STAT		0x0c04
+#define ARMCLK_STOPCTRL_KFC	0x1000
+#define ARM_EMA_CTRL		0x1008
+#define ARM_EMA_STATUS		0x100c
+#define PWR_CTRL_KFC		0x1020
+#define PWR_CTRL2_KFC		0x1024
+#define CLKSTOP_CTRL_KFC	0x1028
+#define INTR_SPREAD_ENABLE_KFC			0x1080
+#define INTR_SPREAD_USE_STANDBYWFI_KFC		0x1084
+#define INTR_SPREAD_BLOCKING_DURATION_KFC	0x1088
+#define CMU_KFC_SPARE0		0x2000
+#define CMU_KFC_SPARE1		0x2004
+#define CMU_KFC_SPARE2		0x2008
+#define CMU_KFC_SPARE3		0x200c
+#define CMU_KFC_SPARE4		0x2010
+
+/*
+*Registers for CMU_MFC
+*/
+#define MUX_SEL_MFC		0x0200
+#define MUX_ENABLE_MFC		0x0300
+#define MUX_STAT_MFC		0x0400
+#define DIV_MFC			0x0600
+#define DIV_STAT_MFC		0x0700
+#define EN_ACLK_MFC		0x0800
+#define EN_ACLK_SECURE_SMMU2_MFC	0x0804
+#define EN_PCLK_MFC		0x0900
+#define EN_PCLK_SECURE_SMMU2_MFC	0x0904
+#define EN_IP_MFC			0x0b00
+#define EN_IP_MFC_SECURE_SMMU2_MFC		0x0b04
+
+/*
+*Registers for CMU_MIF
+*/
+#define MEM_PLL_LOCK		0x0000
+#define BUS_PLL_LOCK		0x0004
+#define MEDIA_PLL_LOCK		0x0008
+#define MEM_PLL_CON0		0x0100
+#define MEM_PLL_CON1		0x0104
+#define MEM_PLL_FDET		0x010c
+#define BUS_PLL_CON0		0x0110
+#define BUS_PLL_CON1		0x0114
+#define BUS_PLL_FDET		0x011c
+#define MEDIA_PLL_CON0		0x0120
+#define MEDIA_PLL_CON1		0x0124
+#define MEDIA_PLL_FDET		0x012c
+#define MUX_SEL_MIF		0x0200
+#define MUX_ENABLE_MIF		0x0300
+#define MUX_STAT_MIF		0x0400
+#define MUX_IGNORE_MIF		0x0500
+#define DIV_MIF			0x0600
+#define DIV_MIF_PLL_FDET	0x0604
+#define DIV_STAT_MIF		0x0700
+#define DIV_STAT_MIF_PLL_FDET	0x0704
+#define EN_ACLK_MIF		0x0800
+#define EN_ACLK_MIF_SECURE_DREX1_TZ	0x0804
+#define EN_ACLK_MIF_SECURE_DREX0_TZ	0x0808
+#define EN_ACLK_MIF_SECURE_INTMEM	0x080c
+#define EN_PCLK_MIF			0x0900
+#define EN_PCLK_MIF_SECURE_MONOCNT	0x0904
+#define EN_PCLK_MIF_SECURE_RTC_APBIF	0x0908
+#define EN_PCLK_MIF_SECURE_DREX1_TZ	0x090c
+#define EN_PCLK_MIF_SECURE_DREX0_TZ	0x0910
+#define EN_SCLK_MIF			0x0a00
+#define EN_IP_MIF			0x0b00
+#define EN_IP_MIF_SECURE_MONOCNT	0x0b04
+#define EN_IP_MIF_SECURE_RTC_APBIF	0x0b08
+#define EN_IP_MIF_SECURE_DREX1_TZ	0x0b0c
+#define EN_IP_MIF_SECURE_DREX0_TZ	0x0b10
+#define EN_IP_MIF_SECURE_INTEMEM	0x0b14
+#define CLKOUT_CMU_MIF_DIV_STAT		0x0c04
+#define DREX_FREQ_CTRL			0x1000
+#define PAUSE				0x1004
+#define DDRPHY_LOCK_CTRL		0x1008
+#define CLKOUT_CMU_MIF		0xcb00
+
+/*
+*Registers for CMU_PERI
+*/
+#define MUX_SEL_PERI		0x0200
+#define MUX_SEL_PERI1		0x0204
+#define MUX_ENABLE_PERI		0x0300
+#define MUX_ENABLE_PERI1	0x0304
+#define MUX_STAT_PERI		0x0400
+#define MUX_STAT_PERI1		0x0404
+#define MUX_IGNORE_PERI		0x0500
+#define MUX_IGNORE_PERI1	0x0504
+#define DIV_PERI		0x0600
+#define DIV_STAT_PERI		0x0700
+#define EN_PCLK_PERI0		0x0800
+#define EN_PCLK_PERI1		0x0804
+#define EN_PCLK_PERI2		0x0808
+#define EN_PCLK_PERI3		0x080c
+#define EN_PCLK_PERI_SECURE_CHIPID	0x0810
+#define EN_PCLK_PERI_SECURE_PROVKEY0	0x0814
+#define EN_PCLK_PERI_SECURE_PROVKEY1	0x0818
+#define EN_PCLK_PERI_SECURE_SECKEY	0x081c
+#define EN_PCLK_PERI_SECURE_ANTIRBKCNT	0x0820
+#define EN_PCLK_PERI_SECURE_TOP_RTC	0x0824
+#define EN_PCLK_PERI_SECURE_TZPC	0x0828
+#define EN_SCLK_PERI			0x0a00
+#define EN_SCLK_PERI_SECURE_TOP_RTC	0x0a04
+#define EN_IP_PERI0			0x0b00
+#define EN_IP_PERI1			0x0b04
+#define EN_IP_PERI2			0x0b08
+#define EN_IP_PERI_SECURE_CHIPID	0x0b0c
+#define EN_IP_PERI_SECURE_PROVKEY0	0x0b10
+#define EN_IP_PERI_SECURE_PROVKEY1	0x0b14
+#define EN_IP_PERI_SECURE_SECKEY	0x0b18
+#define EN_IP_PERI_SECURE_ANTIRBKCNT	0x0b1c
+#define EN_IP_PERI_SECURE_TOP_RTC	0x0b20
+#define EN_IP_PERI_SECURE_TZPC		0x0b24
+
+/*
+*Registers for CMU_TOP
+*/
+#define DISP_PLL_LOCK		0x0000
+#define AUD_PLL_LOCK		0x0004
+#define DISP_PLL_CON0		0x0100
+#define DISP_PLL_CON1		0x0104
+#define DISP_PLL_FDET		0x0108
+#define AUD_PLL_CON0		0x0110
+#define AUD_PLL_CON1		0x0114
+#define AUD_PLL_CON2		0x0118
+#define AUD_PLL_FDET		0x011c
+#define MUX_SEL_TOP_PLL0	0x0200
+#define MUX_SEL_TOP_MFC		0x0204
+#define MUX_SEL_TOP_G2D		0x0208
+#define MUX_SEL_TOP_GSCL	0x020c
+#define MUX_SEL_TOP_ISP10	0x0214
+#define MUX_SEL_TOP_ISP11	0x0218
+#define MUX_SEL_TOP_DISP0	0x021c
+#define MUX_SEL_TOP_DISP1	0x0220
+#define MUX_SEL_TOP_BUS		0x0224
+#define MUX_SEL_TOP_PERI0	0x0228
+#define MUX_SEL_TOP_PERI1	0x022c
+#define MUX_SEL_TOP_FSYS	0x0230
+#define MUX_ENABLE_TOP_PLL0	0x0300
+#define MUX_ENABLE_TOP_MFC	0x0304
+#define MUX_ENABLE_TOP_G2D	0x0308
+#define MUX_ENABLE_TOP_GSCL	0x030c
+#define MUX_ENABLE_TOP_ISP10	0x0314
+#define MUX_ENABLE_TOP_ISP11	0x0318
+#define MUX_ENABLE_TOP_DISP0	0x031c
+#define MUX_ENABLE_TOP_DISP1	0x0320
+#define MUX_ENABLE_TOP_BUS	0x0324
+#define MUX_ENABLE_TOP_PERI0	0x0328
+#define MUX_ENABLE_TOP_PERI1	0x032c
+#define MUX_ENABLE_TOP_FSYS	0x0330
+#define MUX_STAT_TOP_PLL0	0x0400
+#define MUX_STAT_TOP_MFC	0x0404
+#define MUX_STAT_TOP_G2D	0x0408
+#define MUX_STAT_TOP_GSCL	0x040c
+#define MUX_STAT_TOP_ISP10	0x0414
+#define MUX_STAT_TOP_ISP11	0x0418
+#define MUX_STAT_TOP_DISP0	0x041c
+#define MUX_STAT_TOP_DISP1	0x0420
+#define MUX_STAT_TOP_BUS	0x0424
+#define MUX_STAT_TOP_PERI0	0x0428
+#define MUX_STAT_TOP_PERI1	0x042c
+#define MUX_STAT_TOP_FSYS	0x0430
+#define MUX_IGNORE_TOP_PLL0	0x0500
+#define MUX_IGNORE_TOP_MFC	0x0504
+#define MUX_IGNORE_TOP_G2D	0x0508
+#define MUX_IGNORE_TOP_GSCL	0x050c
+#define MUX_IGNORE_TOP_ISP10	0x0514
+#define MUX_IGNORE_TOP_ISP11	0x0518
+#define MUX_IGNORE_TOP_DISP0	0x051c
+#define MUX_IGNORE_TOP_DISP1	0x0520
+#define MUX_IGNORE_TOP_BUS	0x0524
+#define MUX_IGNORE_TOP_PERI0	0x0528
+#define MUX_IGNORE_TOP_PERI1	0x052c
+#define MUX_IGNORE_TOP_FSYS	0x0530
+#define DIV_TOP_G2D_MFC		0x0600
+#define DIV_TOP_GSCL_ISP0	0x0604
+#define DIV_TOP_ISP10		0x0608
+#define DIV_TOP_ISP11		0x060c
+#define DIV_TOP_DISP		0x0610
+#define DIV_TOP_BUS		0x0614
+#define DIV_TOP_PERI0		0x0618
+#define DIV_TOP_PERI1		0x061c
+#define DIV_TOP_PERI2		0x0620
+#define DIV_TOP_FSYS0		0x0624
+#define DIV_TOP_FSYS1		0x0628
+#define DIV_TOP_HPM		0x062c
+#define DIV_TOP_PLL_FDET	0x0630
+#define DIV_STAT_TOP_G2D_MFC	0x0700
+#define DIV_STAT_TOP_GSCL_ISP0	0x0704
+#define DIV_STAT_TOP_ISP10	0x0708
+#define DIV_STAT_TOP_ISP11	0x070c
+#define DIV_STAT_TOP_DISP	0x0710
+#define DIV_STAT_TOP_BUS	0x0714
+#define DIV_STAT_TOP_PERI0	0x0718
+#define DIV_STAT_TOP_PERI1	0x071c
+#define DIV_STAT_TOP_PERI2	0x0720
+#define DIV_STAT_TOP_FSYS0	0x0724
+#define DIV_STAT_TOP_FSYS1	0x0728
+#define DIV_STAT_TOP_HPM	0x072c
+#define DIV_STAT_TOP_PLL_FDET	0x0730
+#define EN_ACLK_TOP		0x0800
+#define EN_SCLK_TOP		0x0a00
+#define EN_IP_TOP		0x0b00
+#define CLKOUT_CMU_TOP		0x0c00
+#define CLKOUT_CMU_TOP_DIV_STAT	0x0c04
+
+#endif /*__CLK_EXYNOS5260_H */
+
-- 
1.7.9.5
