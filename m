From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Mar 2017 11:32:25 +0100
Subject: [PATCH v2 3/5] clk: meson-gxbb: Add GXL/GXM GP0 Variant
In-Reply-To: <1490178747-14837-1-git-send-email-narmstrong@baylibre.com>
References: <1490178747-14837-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490178747-14837-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock tree in the Amlogic GXBB and GXL/GXM SoCs is shared, but the GXL/GXM
SoCs embeds a different GP0 PLL, and needs different parameters with a vendor
provided reduced rate table.

This patch adds the GXL GP0 variant, and adds a GXL DT compatible in order
to use the GXL GP0 PLL instead of the GXBB specific one.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 301 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/gxbb.h |   2 +
 2 files changed, 275 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index db95038..7519766 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
 
@@ -120,7 +121,7 @@
 	{ /* sentinel */ },
 };
 
-static const struct pll_rate_table gp0_pll_rate_table[] = {
+static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
 	PLL_RATE(96000000, 32, 1, 3),
 	PLL_RATE(99000000, 33, 1, 3),
 	PLL_RATE(102000000, 34, 1, 3),
@@ -248,6 +249,35 @@
 	{ /* sentinel */ },
 };
 
+static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
+	PLL_RATE(504000000, 42, 1, 1),
+	PLL_RATE(516000000, 43, 1, 1),
+	PLL_RATE(528000000, 44, 1, 1),
+	PLL_RATE(540000000, 45, 1, 1),
+	PLL_RATE(552000000, 46, 1, 1),
+	PLL_RATE(564000000, 47, 1, 1),
+	PLL_RATE(576000000, 48, 1, 1),
+	PLL_RATE(588000000, 49, 1, 1),
+	PLL_RATE(600000000, 50, 1, 1),
+	PLL_RATE(612000000, 51, 1, 1),
+	PLL_RATE(624000000, 52, 1, 1),
+	PLL_RATE(636000000, 53, 1, 1),
+	PLL_RATE(648000000, 54, 1, 1),
+	PLL_RATE(660000000, 55, 1, 1),
+	PLL_RATE(672000000, 56, 1, 1),
+	PLL_RATE(684000000, 57, 1, 1),
+	PLL_RATE(696000000, 58, 1, 1),
+	PLL_RATE(708000000, 59, 1, 1),
+	PLL_RATE(720000000, 60, 1, 1),
+	PLL_RATE(732000000, 61, 1, 1),
+	PLL_RATE(744000000, 62, 1, 1),
+	PLL_RATE(756000000, 63, 1, 1),
+	PLL_RATE(768000000, 64, 1, 1),
+	PLL_RATE(780000000, 65, 1, 1),
+	PLL_RATE(792000000, 66, 1, 1),
+	{ /* sentinel */ },
+};
+
 static const struct clk_div_table cpu_div_table[] = {
 	{ .val = 1, .div = 1 },
 	{ .val = 2, .div = 2 },
@@ -381,8 +411,51 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 		.no_init_reset = true,
 		.clear_reset_for_lock = true,
 	},
-	.rate_table = gp0_pll_rate_table,
-	.rate_count = ARRAY_SIZE(gp0_pll_rate_table),
+	.rate_table = gxbb_gp0_pll_rate_table,
+	.rate_count = ARRAY_SIZE(gxbb_gp0_pll_rate_table),
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "gp0_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+struct pll_params_table gxl_gp0_params_table[] = {
+	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
+	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
+	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
+	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a59a288),
+	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0xc000004d),
+	PLL_PARAM(HHI_GP0_PLL_CNTL5, 0x00078000),
+};
+
+static struct meson_clk_pll gxl_gp0_pll = {
+	.m = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 0,
+		.width   = 9,
+	},
+	.n = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 9,
+		.width   = 5,
+	},
+	.od = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 16,
+		.width   = 2,
+	},
+	.params = {
+		.params_table = gxl_gp0_params_table,
+		.params_count =	ARRAY_SIZE(gxl_gp0_params_table),
+		.no_init_reset = true,
+		.reset_lock_loop = true,
+	},
+	.rate_table = gxl_gp0_pll_rate_table,
+	.rate_count = ARRAY_SIZE(gxl_gp0_pll_rate_table),
 	.lock = &clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
@@ -976,6 +1049,119 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 	.num = NR_CLKS,
 };
 
+static struct clk_hw_onecell_data gxl_hw_onecell_data = {
+	.hws = {
+		[CLKID_SYS_PLL]		    = &gxbb_sys_pll.hw,
+		[CLKID_CPUCLK]		    = &gxbb_cpu_clk.hw,
+		[CLKID_HDMI_PLL]	    = &gxbb_hdmi_pll.hw,
+		[CLKID_FIXED_PLL]	    = &gxbb_fixed_pll.hw,
+		[CLKID_FCLK_DIV2]	    = &gxbb_fclk_div2.hw,
+		[CLKID_FCLK_DIV3]	    = &gxbb_fclk_div3.hw,
+		[CLKID_FCLK_DIV4]	    = &gxbb_fclk_div4.hw,
+		[CLKID_FCLK_DIV5]	    = &gxbb_fclk_div5.hw,
+		[CLKID_FCLK_DIV7]	    = &gxbb_fclk_div7.hw,
+		[CLKID_GP0_PLL]		    = &gxl_gp0_pll.hw,
+		[CLKID_MPEG_SEL]	    = &gxbb_mpeg_clk_sel.hw,
+		[CLKID_MPEG_DIV]	    = &gxbb_mpeg_clk_div.hw,
+		[CLKID_CLK81]		    = &gxbb_clk81.hw,
+		[CLKID_MPLL0]		    = &gxbb_mpll0.hw,
+		[CLKID_MPLL1]		    = &gxbb_mpll1.hw,
+		[CLKID_MPLL2]		    = &gxbb_mpll2.hw,
+		[CLKID_DDR]		    = &gxbb_ddr.hw,
+		[CLKID_DOS]		    = &gxbb_dos.hw,
+		[CLKID_ISA]		    = &gxbb_isa.hw,
+		[CLKID_PL301]		    = &gxbb_pl301.hw,
+		[CLKID_PERIPHS]		    = &gxbb_periphs.hw,
+		[CLKID_SPICC]		    = &gxbb_spicc.hw,
+		[CLKID_I2C]		    = &gxbb_i2c.hw,
+		[CLKID_SAR_ADC]		    = &gxbb_sar_adc.hw,
+		[CLKID_SMART_CARD]	    = &gxbb_smart_card.hw,
+		[CLKID_RNG0]		    = &gxbb_rng0.hw,
+		[CLKID_UART0]		    = &gxbb_uart0.hw,
+		[CLKID_SDHC]		    = &gxbb_sdhc.hw,
+		[CLKID_STREAM]		    = &gxbb_stream.hw,
+		[CLKID_ASYNC_FIFO]	    = &gxbb_async_fifo.hw,
+		[CLKID_SDIO]		    = &gxbb_sdio.hw,
+		[CLKID_ABUF]		    = &gxbb_abuf.hw,
+		[CLKID_HIU_IFACE]	    = &gxbb_hiu_iface.hw,
+		[CLKID_ASSIST_MISC]	    = &gxbb_assist_misc.hw,
+		[CLKID_SPI]		    = &gxbb_spi.hw,
+		[CLKID_I2S_SPDIF]	    = &gxbb_i2s_spdif.hw,
+		[CLKID_ETH]		    = &gxbb_eth.hw,
+		[CLKID_DEMUX]		    = &gxbb_demux.hw,
+		[CLKID_AIU_GLUE]	    = &gxbb_aiu_glue.hw,
+		[CLKID_IEC958]		    = &gxbb_iec958.hw,
+		[CLKID_I2S_OUT]		    = &gxbb_i2s_out.hw,
+		[CLKID_AMCLK]		    = &gxbb_amclk.hw,
+		[CLKID_AIFIFO2]		    = &gxbb_aififo2.hw,
+		[CLKID_MIXER]		    = &gxbb_mixer.hw,
+		[CLKID_MIXER_IFACE]	    = &gxbb_mixer_iface.hw,
+		[CLKID_ADC]		    = &gxbb_adc.hw,
+		[CLKID_BLKMV]		    = &gxbb_blkmv.hw,
+		[CLKID_AIU]		    = &gxbb_aiu.hw,
+		[CLKID_UART1]		    = &gxbb_uart1.hw,
+		[CLKID_G2D]		    = &gxbb_g2d.hw,
+		[CLKID_USB0]		    = &gxbb_usb0.hw,
+		[CLKID_USB1]		    = &gxbb_usb1.hw,
+		[CLKID_RESET]		    = &gxbb_reset.hw,
+		[CLKID_NAND]		    = &gxbb_nand.hw,
+		[CLKID_DOS_PARSER]	    = &gxbb_dos_parser.hw,
+		[CLKID_USB]		    = &gxbb_usb.hw,
+		[CLKID_VDIN1]		    = &gxbb_vdin1.hw,
+		[CLKID_AHB_ARB0]	    = &gxbb_ahb_arb0.hw,
+		[CLKID_EFUSE]		    = &gxbb_efuse.hw,
+		[CLKID_BOOT_ROM]	    = &gxbb_boot_rom.hw,
+		[CLKID_AHB_DATA_BUS]	    = &gxbb_ahb_data_bus.hw,
+		[CLKID_AHB_CTRL_BUS]	    = &gxbb_ahb_ctrl_bus.hw,
+		[CLKID_HDMI_INTR_SYNC]	    = &gxbb_hdmi_intr_sync.hw,
+		[CLKID_HDMI_PCLK]	    = &gxbb_hdmi_pclk.hw,
+		[CLKID_USB1_DDR_BRIDGE]	    = &gxbb_usb1_ddr_bridge.hw,
+		[CLKID_USB0_DDR_BRIDGE]	    = &gxbb_usb0_ddr_bridge.hw,
+		[CLKID_MMC_PCLK]	    = &gxbb_mmc_pclk.hw,
+		[CLKID_DVIN]		    = &gxbb_dvin.hw,
+		[CLKID_UART2]		    = &gxbb_uart2.hw,
+		[CLKID_SANA]		    = &gxbb_sana.hw,
+		[CLKID_VPU_INTR]	    = &gxbb_vpu_intr.hw,
+		[CLKID_SEC_AHB_AHB3_BRIDGE] = &gxbb_sec_ahb_ahb3_bridge.hw,
+		[CLKID_CLK81_A53]	    = &gxbb_clk81_a53.hw,
+		[CLKID_VCLK2_VENCI0]	    = &gxbb_vclk2_venci0.hw,
+		[CLKID_VCLK2_VENCI1]	    = &gxbb_vclk2_venci1.hw,
+		[CLKID_VCLK2_VENCP0]	    = &gxbb_vclk2_vencp0.hw,
+		[CLKID_VCLK2_VENCP1]	    = &gxbb_vclk2_vencp1.hw,
+		[CLKID_GCLK_VENCI_INT0]	    = &gxbb_gclk_venci_int0.hw,
+		[CLKID_GCLK_VENCI_INT]	    = &gxbb_gclk_vencp_int.hw,
+		[CLKID_DAC_CLK]		    = &gxbb_dac_clk.hw,
+		[CLKID_AOCLK_GATE]	    = &gxbb_aoclk_gate.hw,
+		[CLKID_IEC958_GATE]	    = &gxbb_iec958_gate.hw,
+		[CLKID_ENC480P]		    = &gxbb_enc480p.hw,
+		[CLKID_RNG1]		    = &gxbb_rng1.hw,
+		[CLKID_GCLK_VENCI_INT1]	    = &gxbb_gclk_venci_int1.hw,
+		[CLKID_VCLK2_VENCLMCC]	    = &gxbb_vclk2_venclmcc.hw,
+		[CLKID_VCLK2_VENCL]	    = &gxbb_vclk2_vencl.hw,
+		[CLKID_VCLK_OTHER]	    = &gxbb_vclk_other.hw,
+		[CLKID_EDP]		    = &gxbb_edp.hw,
+		[CLKID_AO_MEDIA_CPU]	    = &gxbb_ao_media_cpu.hw,
+		[CLKID_AO_AHB_SRAM]	    = &gxbb_ao_ahb_sram.hw,
+		[CLKID_AO_AHB_BUS]	    = &gxbb_ao_ahb_bus.hw,
+		[CLKID_AO_IFACE]	    = &gxbb_ao_iface.hw,
+		[CLKID_AO_I2C]		    = &gxbb_ao_i2c.hw,
+		[CLKID_SD_EMMC_A]	    = &gxbb_emmc_a.hw,
+		[CLKID_SD_EMMC_B]	    = &gxbb_emmc_b.hw,
+		[CLKID_SD_EMMC_C]	    = &gxbb_emmc_c.hw,
+		[CLKID_SAR_ADC_CLK]	    = &gxbb_sar_adc_clk.hw,
+		[CLKID_SAR_ADC_SEL]	    = &gxbb_sar_adc_clk_sel.hw,
+		[CLKID_SAR_ADC_DIV]	    = &gxbb_sar_adc_clk_div.hw,
+		[CLKID_MALI_0_SEL]	    = &gxbb_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]	    = &gxbb_mali_0_div.hw,
+		[CLKID_MALI_0]		    = &gxbb_mali_0.hw,
+		[CLKID_MALI_1_SEL]	    = &gxbb_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]	    = &gxbb_mali_1_div.hw,
+		[CLKID_MALI_1]		    = &gxbb_mali_1.hw,
+		[CLKID_MALI]		    = &gxbb_mali.hw,
+	},
+	.num = NR_CLKS,
+};
+
 /* Convenience tables to populate base addresses in .probe */
 
 static struct meson_clk_pll *const gxbb_clk_plls[] = {
@@ -985,6 +1171,13 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 	&gxbb_gp0_pll,
 };
 
+static struct meson_clk_pll *const gxl_clk_plls[] = {
+	&gxbb_fixed_pll,
+	&gxbb_hdmi_pll,
+	&gxbb_sys_pll,
+	&gxl_gp0_pll,
+};
+
 static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
 	&gxbb_mpll0,
 	&gxbb_mpll1,
@@ -1094,14 +1287,70 @@ struct pll_params_table gxbb_gp0_params_table[] = {
 	&gxbb_mali_1_div,
 };
 
+struct clkc_data {
+	struct clk_gate *const *clk_gates;
+	unsigned int clk_gates_count;
+	struct meson_clk_mpll *const *clk_mplls;
+	unsigned int clk_mplls_count;
+	struct meson_clk_pll *const *clk_plls;
+	unsigned int clk_plls_count;
+	struct clk_mux *const *clk_muxes;
+	unsigned int clk_muxes_count;
+	struct clk_divider *const *clk_dividers;
+	unsigned int clk_dividers_count;
+	struct meson_clk_cpu *cpu_clk;
+	struct clk_hw_onecell_data *hw_onecell_data;
+};
+
+static const struct clkc_data gxbb_clkc_data = {
+	.clk_gates = gxbb_clk_gates,
+	.clk_gates_count = ARRAY_SIZE(gxbb_clk_gates),
+	.clk_mplls = gxbb_clk_mplls,
+	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
+	.clk_plls = gxbb_clk_plls,
+	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
+	.clk_muxes = gxbb_clk_muxes,
+	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
+	.clk_dividers = gxbb_clk_dividers,
+	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
+	.cpu_clk = &gxbb_cpu_clk,
+	.hw_onecell_data = &gxbb_hw_onecell_data,
+};
+
+static const struct clkc_data gxl_clkc_data = {
+	.clk_gates = gxbb_clk_gates,
+	.clk_gates_count = ARRAY_SIZE(gxbb_clk_gates),
+	.clk_mplls = gxbb_clk_mplls,
+	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
+	.clk_plls = gxl_clk_plls,
+	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
+	.clk_muxes = gxbb_clk_muxes,
+	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
+	.clk_dividers = gxbb_clk_dividers,
+	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
+	.cpu_clk = &gxbb_cpu_clk,
+	.hw_onecell_data = &gxl_hw_onecell_data,
+};
+
+static const struct of_device_id clkc_match_table[] = {
+	{ .compatible = "amlogic,gxbb-clkc", .data = &gxbb_clkc_data },
+	{ .compatible = "amlogic,gxl-clkc", .data = &gxl_clkc_data },
+	{},
+};
+
 static int gxbb_clkc_probe(struct platform_device *pdev)
 {
+	const struct clkc_data *clkc_data;
 	void __iomem *clk_base;
 	int ret, clkid, i;
 	struct clk_hw *parent_hw;
 	struct clk *parent_clk;
 	struct device *dev = &pdev->dev;
 
+	clkc_data = of_device_get_match_data(&pdev->dev);
+	if (!clkc_data)
+		return -EINVAL;
+
 	/*  Generic clocks and PLLs */
 	clk_base = of_iomap(dev->of_node, 0);
 	if (!clk_base) {
@@ -1110,36 +1359,37 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	}
 
 	/* Populate base address for PLLs */
-	for (i = 0; i < ARRAY_SIZE(gxbb_clk_plls); i++)
-		gxbb_clk_plls[i]->base = clk_base;
+	for (i = 0; i < clkc_data->clk_plls_count; i++)
+		clkc_data->clk_plls[i]->base = clk_base;
 
 	/* Populate base address for MPLLs */
-	for (i = 0; i < ARRAY_SIZE(gxbb_clk_mplls); i++)
-		gxbb_clk_mplls[i]->base = clk_base;
+	for (i = 0; i < clkc_data->clk_mplls_count; i++)
+		clkc_data->clk_mplls[i]->base = clk_base;
 
 	/* Populate the base address for CPU clk */
-	gxbb_cpu_clk.base = clk_base;
+	clkc_data->cpu_clk->base = clk_base;
 
 	/* Populate base address for gates */
-	for (i = 0; i < ARRAY_SIZE(gxbb_clk_gates); i++)
-		gxbb_clk_gates[i]->reg = clk_base +
-			(u64)gxbb_clk_gates[i]->reg;
+	for (i = 0; i < clkc_data->clk_gates_count; i++)
+		clkc_data->clk_gates[i]->reg = clk_base +
+			(u64)clkc_data->clk_gates[i]->reg;
 
 	/* Populate base address for muxes */
-	for (i = 0; i < ARRAY_SIZE(gxbb_clk_muxes); i++)
-		gxbb_clk_muxes[i]->reg = clk_base +
-			(u64)gxbb_clk_muxes[i]->reg;
+	for (i = 0; i < clkc_data->clk_muxes_count; i++)
+		clkc_data->clk_muxes[i]->reg = clk_base +
+			(u64)clkc_data->clk_muxes[i]->reg;
 
 	/* Populate base address for dividers */
-	for (i = 0; i < ARRAY_SIZE(gxbb_clk_dividers); i++)
-		gxbb_clk_dividers[i]->reg = clk_base +
-			(u64)gxbb_clk_dividers[i]->reg;
+	for (i = 0; i < clkc_data->clk_dividers_count; i++)
+		clkc_data->clk_dividers[i]->reg = clk_base +
+			(u64)clkc_data->clk_dividers[i]->reg;
 
 	/*
 	 * register all clks
 	 */
-	for (clkid = 0; clkid < NR_CLKS; clkid++) {
-		ret = devm_clk_hw_register(dev, gxbb_hw_onecell_data.hws[clkid]);
+	for (clkid = 0; clkid < clkc_data->hw_onecell_data->num; clkid++) {
+		ret = devm_clk_hw_register(dev,
+					clkc_data->hw_onecell_data->hws[clkid]);
 		if (ret)
 			goto iounmap;
 	}
@@ -1158,9 +1408,9 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	 * a new clk_hw, and this hack will no longer work. Releasing the ccr
 	 * feature before that time solves the problem :-)
 	 */
-	parent_hw = clk_hw_get_parent(&gxbb_cpu_clk.hw);
+	parent_hw = clk_hw_get_parent(&clkc_data->cpu_clk->hw);
 	parent_clk = parent_hw->clk;
-	ret = clk_notifier_register(parent_clk, &gxbb_cpu_clk.clk_nb);
+	ret = clk_notifier_register(parent_clk, &clkc_data->cpu_clk->clk_nb);
 	if (ret) {
 		pr_err("%s: failed to register clock notifier for cpu_clk\n",
 				__func__);
@@ -1168,23 +1418,18 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	}
 
 	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-			&gxbb_hw_onecell_data);
+			clkc_data->hw_onecell_data);
 
 iounmap:
 	iounmap(clk_base);
 	return ret;
 }
 
-static const struct of_device_id gxbb_clkc_match_table[] = {
-	{ .compatible = "amlogic,gxbb-clkc" },
-	{ }
-};
-
 static struct platform_driver gxbb_driver = {
 	.probe		= gxbb_clkc_probe,
 	.driver		= {
 		.name	= "gxbb-clkc",
-		.of_match_table = gxbb_clkc_match_table,
+		.of_match_table = clkc_match_table,
 	},
 };
 
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 73efdc3..b710e06 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -71,6 +71,8 @@
 #define HHI_GP0_PLL_CNTL2		0x44 /* 0x11 offset in data sheet */
 #define HHI_GP0_PLL_CNTL3		0x48 /* 0x12 offset in data sheet */
 #define HHI_GP0_PLL_CNTL4		0x4c /* 0x13 offset in data sheet */
+#define	HHI_GP0_PLL_CNTL5		0x50 /* 0x14 offset in data sheet */
+#define	HHI_GP0_PLL_CNTL1		0x58 /* 0x16 offset in data sheet */
 
 #define HHI_XTAL_DIVN_CNTL		0xbc /* 0x2f offset in data sheet */
 #define HHI_TIMER90K			0xec /* 0x3b offset in data sheet */
-- 
1.9.1
