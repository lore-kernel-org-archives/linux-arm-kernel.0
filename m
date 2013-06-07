From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Fri, 07 Jun 2013 06:19:01 -0600
Subject: [PATCH 2/3] clk: tegra: T114: add DFLL source clocks
In-Reply-To: <20130607121505.21868.72360.stgit@dusk.lan>
References: <20130607121505.21868.72360.stgit@dusk.lan>
Message-ID: <20130607121858.21868.73882.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the input clocks needed by the DFLL IP blocks.  Initialize them to
51MHz (as required by the DFLL GFD) and to use the PLL_P clock source.

This patch is a collaboration with Peter De Schrijver
<pdeschrijver@nvidia.com>.

Thanks to Laxman Dewangan <ldewangan@nvidia.com> for identifying the
requirement to keep the DFLL clocks enabled to resolve PWR_I2C timeout
issues.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Reviewed-by: Andrew Chew <achew@nvidia.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index c6e35d4..b35c78d 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -269,6 +269,8 @@
 #define CLK_SOURCE_I2CSLOW 0x3fc
 #define CLK_SOURCE_SE 0x42c
 #define CLK_SOURCE_MSELECT 0x3b4
+#define CLK_SOURCE_DFLL_REF 0x62c
+#define CLK_SOURCE_DFLL_SOC 0x630
 #define CLK_SOURCE_SOC_THERM 0x644
 #define CLK_SOURCE_XUSB_HOST_SRC 0x600
 #define CLK_SOURCE_XUSB_FALCON_SRC 0x604
@@ -792,6 +794,7 @@ enum tegra114_clk {
 	audio1, audio2, audio3, audio4, spdif, clk_out_1, clk_out_2, clk_out_3,
 	blink, xusb_host_src = 252, xusb_falcon_src, xusb_fs_src, xusb_ss_src,
 	xusb_dev_src, xusb_dev, xusb_hs_src, sclk, hclk, pclk, cclk_g, cclk_lp,
+	dfll_ref = 264, dfll_soc,
 
 	/* Mux clocks */
 
@@ -1796,6 +1799,8 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_MUX("i2cslow", NULL, "i2cslow", mux_pllp_pllc_clk32_clkm, CLK_SOURCE_I2CSLOW, 81, &periph_u_regs, TEGRA_PERIPH_ON_APB, i2cslow),
 	TEGRA_INIT_DATA_INT8("se", NULL, "se", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_SE, 127, &periph_v_regs, TEGRA_PERIPH_ON_APB, se),
 	TEGRA_INIT_DATA_INT_FLAGS("mselect", NULL, "mselect", mux_pllp_clkm, CLK_SOURCE_MSELECT, 99, &periph_v_regs, 0, mselect, CLK_IGNORE_UNUSED),
+	TEGRA_INIT_DATA_MUX("dfll_ref", "ref", "t114_dfll", mux_pllp_clkm, CLK_SOURCE_DFLL_REF, 155, &periph_w_regs, TEGRA_PERIPH_ON_APB, dfll_ref),
+	TEGRA_INIT_DATA_MUX("dfll_soc", "soc", "t114_dfll", mux_pllp_clkm, CLK_SOURCE_DFLL_SOC, 155, &periph_w_regs, TEGRA_PERIPH_ON_APB, dfll_soc),
 	TEGRA_INIT_DATA_MUX8("soc_therm", NULL, "soc_therm", mux_pllm_pllc_pllp_plla, CLK_SOURCE_SOC_THERM, 78, &periph_u_regs, TEGRA_PERIPH_ON_APB, soc_therm),
 	TEGRA_INIT_DATA_XUSB("xusb_host_src", "host_src", "tegra_xhci", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_HOST_SRC, 143, &periph_w_regs, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET, xusb_host_src),
 	TEGRA_INIT_DATA_XUSB("xusb_falcon_src", "falcon_src", "tegra_xhci", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_FALCON_SRC, 143, &periph_w_regs, TEGRA_PERIPH_NO_RESET, xusb_falcon_src),
@@ -2057,6 +2062,10 @@ static const struct of_device_id pmc_match[] __initconst = {
 	{},
 };
 
+/*
+ * dfll_soc/dfll_ref apparently must be kept enabled, otherwise I2C5
+ * breaks
+ */
 static __initdata struct tegra_clk_init_table init_table[] = {
 	{uarta, pll_p, 408000000, 0},
 	{uartb, pll_p, 408000000, 0},
@@ -2072,6 +2081,8 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{i2s2, pll_a_out0, 11289600, 0},
 	{i2s3, pll_a_out0, 11289600, 0},
 	{i2s4, pll_a_out0, 11289600, 0},
+	{dfll_soc, pll_p, 51000000, 1},
+	{dfll_ref, pll_p, 51000000, 1},
 	{clk_max, clk_max, 0, 0}, /* This MUST be the last entry. */
 };
 
