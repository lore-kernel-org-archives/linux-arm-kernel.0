From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 13 Jan 2015 16:57:42 +0530
Subject: [PATCH V2 3/3] clk: samsung: exynos7: add clocks for audio block
In-Reply-To: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
References: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
Message-ID: <1421148462-11755-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required clk support for I2S,PCM amd SPDIF

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |    9 ++
 drivers/clk/samsung/clk-exynos7.c                  |  143 +++++++++++++++++++-
 include/dt-bindings/clock/exynos7-clk.h            |   24 +++-
 3 files changed, 171 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index 9282f71..6bf1e74 100644
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -35,6 +35,7 @@ Required Properties for Clock Controller:
 	- "samsung,exynos7-clock-fsys0"
 	- "samsung,exynos7-clock-fsys1"
 	- "samsung,exynos7-clock-mscl"
+	- "samsung,exynos7-clock-aud"
 
  - reg: physical base address of the controller and the length of
 	memory mapped region.
@@ -54,6 +55,7 @@ Input clocks for top0 clock controller:
 	- dout_sclk_bus1_pll
 	- dout_sclk_cc_pll
 	- dout_sclk_mfc_pll
+	- dout_sclk_aud_pll
 
 Input clocks for top1 clock controller:
 	- fin_pll
@@ -82,6 +84,9 @@ Input clocks for peric1 clock controller:
 	- sclk_spi2
 	- sclk_spi3
 	- sclk_spi4
+	- sclk_i2s1
+	- sclk_pcm1
+	- sclk_spdif
 
 Input clocks for peris clock controller:
 	- fin_pll
@@ -97,3 +102,7 @@ Input clocks for fsys1 clock controller:
 	- dout_aclk_fsys1_200
 	- dout_sclk_mmc0
 	- dout_sclk_mmc1
+
+Input clocks for aud clock controller:
+	- fin_pll
+	- fout_aud_pll
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index d40c09d..03d36e8 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -46,6 +46,7 @@ static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
 };
 
 /* List of parent clocks for Muxes in CMU_TOPC */
+PNAME(mout_aud_pll_ctrl_p)	= { "fin_pll", "fout_aud_pll" };
 PNAME(mout_bus0_pll_ctrl_p)	= { "fin_pll", "fout_bus0_pll" };
 PNAME(mout_bus1_pll_ctrl_p)	= { "fin_pll", "fout_bus1_pll" };
 PNAME(mout_cc_pll_ctrl_p)	= { "fin_pll", "fout_cc_pll" };
@@ -105,6 +106,7 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
 
 	MUX(0, "mout_sclk_bus0_pll_out", mout_sclk_bus0_pll_out_p,
 		MUX_SEL_TOPC1, 16, 1),
+	MUX(0, "mout_aud_pll_ctrl", mout_aud_pll_ctrl_p, MUX_SEL_TOPC1, 0, 1),
 
 	MUX(0, "mout_aclk_ccore_133", mout_topc_group2,	MUX_SEL_TOPC2, 4, 2),
 
@@ -129,6 +131,13 @@ static struct samsung_div_clock topc_div_clks[] __initdata = {
 		DIV_TOPC3, 12, 3),
 	DIV(DOUT_SCLK_MFC_PLL, "dout_sclk_mfc_pll", "mout_mfc_pll_ctrl",
 		DIV_TOPC3, 16, 3),
+	DIV(DOUT_SCLK_AUD_PLL, "dout_sclk_aud_pll", "mout_aud_pll_ctrl",
+		DIV_TOPC3, 28, 3),
+};
+
+static struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initdata = {
+	PLL_36XX_RATE(491520000, 20, 1, 0, 31457),
+	{},
 };
 
 static struct samsung_gate_clock topc_gate_clks[] __initdata = {
@@ -145,8 +154,8 @@ static struct samsung_pll_clock topc_pll_clks[] __initdata = {
 		BUS1_DPLL_CON0, NULL),
 	PLL(pll_1452x, 0, "fout_mfc_pll", "fin_pll", MFC_PLL_LOCK,
 		MFC_PLL_CON0, NULL),
-	PLL(pll_1460x, 0, "fout_aud_pll", "fin_pll", AUD_PLL_LOCK,
-		AUD_PLL_CON0, NULL),
+	PLL(pll_1460x, FOUT_AUD_PLL, "fout_aud_pll", "fin_pll", AUD_PLL_LOCK,
+		AUD_PLL_CON0, pll1460x_24mhz_tbl),
 };
 
 static struct samsung_cmu_info topc_cmu_info __initdata = {
@@ -177,13 +186,16 @@ CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
 #define MUX_SEL_TOP00			0x0200
 #define MUX_SEL_TOP01			0x0204
 #define MUX_SEL_TOP03			0x020C
+#define MUX_SEL_TOP0_PERIC0		0x0230
 #define MUX_SEL_TOP0_PERIC1		0x0234
 #define MUX_SEL_TOP0_PERIC2		0x0238
 #define MUX_SEL_TOP0_PERIC3		0x023C
 #define DIV_TOP03			0x060C
+#define DIV_TOP0_PERIC0			0x0630
 #define DIV_TOP0_PERIC1			0x0634
 #define DIV_TOP0_PERIC2			0x0638
 #define DIV_TOP0_PERIC3			0x063C
+#define ENABLE_SCLK_TOP0_PERIC0		0x0A30
 #define ENABLE_SCLK_TOP0_PERIC1		0x0A34
 #define ENABLE_SCLK_TOP0_PERIC2		0x0A38
 #define ENABLE_SCLK_TOP0_PERIC3		0x0A3C
@@ -193,6 +205,7 @@ PNAME(mout_bus0_pll_p)	= { "fin_pll", "dout_sclk_bus0_pll" };
 PNAME(mout_bus1_pll_p)	= { "fin_pll", "dout_sclk_bus1_pll" };
 PNAME(mout_cc_pll_p)	= { "fin_pll", "dout_sclk_cc_pll" };
 PNAME(mout_mfc_pll_p)	= { "fin_pll", "dout_sclk_mfc_pll" };
+PNAME(mout_aud_pll_p)	= { "fin_pll", "dout_sclk_aud_pll" };
 
 PNAME(mout_top0_half_bus0_pll_p) = {"mout_top0_bus0_pll",
 	"ffac_top0_bus0_pll_div2"};
@@ -206,24 +219,34 @@ PNAME(mout_top0_half_mfc_pll_p) = {"mout_top0_mfc_pll",
 PNAME(mout_top0_group1) = {"mout_top0_half_bus0_pll",
 	"mout_top0_half_bus1_pll", "mout_top0_half_cc_pll",
 	"mout_top0_half_mfc_pll"};
+PNAME(mout_top0_group3) = {"ioclk_audiocdclk0",
+	"ioclk_audiocdclk1", "ioclk_spdif_extclk",
+	"mout_top0_aud_pll", "mout_top0_half_bus0_pll",
+	"mout_top0_half_bus1_pll"};
+PNAME(mout_top0_group4) = {"ioclk_audiocdclk1", "mout_top0_aud_pll",
+	"mout_top0_half_bus0_pll", "mout_top0_half_bus1_pll"};
 
 static unsigned long top0_clk_regs[] __initdata = {
 	MUX_SEL_TOP00,
 	MUX_SEL_TOP01,
 	MUX_SEL_TOP03,
+	MUX_SEL_TOP0_PERIC0,
 	MUX_SEL_TOP0_PERIC1,
 	MUX_SEL_TOP0_PERIC2,
 	MUX_SEL_TOP0_PERIC3,
 	DIV_TOP03,
+	DIV_TOP0_PERIC0,
 	DIV_TOP0_PERIC1,
 	DIV_TOP0_PERIC2,
 	DIV_TOP0_PERIC3,
+	ENABLE_SCLK_TOP0_PERIC0,
 	ENABLE_SCLK_TOP0_PERIC1,
 	ENABLE_SCLK_TOP0_PERIC2,
 	ENABLE_SCLK_TOP0_PERIC3,
 };
 
 static struct samsung_mux_clock top0_mux_clks[] __initdata = {
+	MUX(0, "mout_top0_aud_pll", mout_aud_pll_p, MUX_SEL_TOP00, 0, 1),
 	MUX(0, "mout_top0_mfc_pll", mout_mfc_pll_p, MUX_SEL_TOP00, 4, 1),
 	MUX(0, "mout_top0_cc_pll", mout_cc_pll_p, MUX_SEL_TOP00, 8, 1),
 	MUX(0, "mout_top0_bus1_pll", mout_bus1_pll_p, MUX_SEL_TOP00, 12, 1),
@@ -241,6 +264,10 @@ static struct samsung_mux_clock top0_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk_peric1_66", mout_top0_group1, MUX_SEL_TOP03, 12, 2),
 	MUX(0, "mout_aclk_peric0_66", mout_top0_group1, MUX_SEL_TOP03, 20, 2),
 
+	MUX(0, "mout_sclk_spdif", mout_top0_group3, MUX_SEL_TOP0_PERIC0, 4, 3),
+	MUX(0, "mout_sclk_pcm1", mout_top0_group4, MUX_SEL_TOP0_PERIC0, 8, 2),
+	MUX(0, "mout_sclk_i2s1", mout_top0_group4, MUX_SEL_TOP0_PERIC0, 20, 2),
+
 	MUX(0, "mout_sclk_spi1", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 8, 2),
 	MUX(0, "mout_sclk_spi0", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 20, 2),
 
@@ -259,6 +286,10 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
 	DIV(DOUT_ACLK_PERIC0, "dout_aclk_peric0_66", "mout_aclk_peric0_66",
 		DIV_TOP03, 20, 6),
 
+	DIV(0, "dout_sclk_spdif", "mout_sclk_spdif", DIV_TOP0_PERIC0, 4, 4),
+	DIV(0, "dout_sclk_pcm1", "mout_sclk_pcm1", DIV_TOP0_PERIC0, 8, 12),
+	DIV(0, "dout_sclk_i2s1", "mout_sclk_i2s1", DIV_TOP0_PERIC0, 20, 10),
+
 	DIV(0, "dout_sclk_spi1", "mout_sclk_spi1", DIV_TOP0_PERIC1, 8, 12),
 	DIV(0, "dout_sclk_spi0", "mout_sclk_spi0", DIV_TOP0_PERIC1, 20, 12),
 
@@ -273,6 +304,13 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
 };
 
 static struct samsung_gate_clock top0_gate_clks[] __initdata = {
+	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "dout_sclk_spdif",
+		ENABLE_SCLK_TOP0_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "dout_sclk_pcm1",
+		ENABLE_SCLK_TOP0_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_I2S1, "sclk_i2s1", "dout_sclk_i2s1",
+		ENABLE_SCLK_TOP0_PERIC0, 20, CLK_SET_RATE_PARENT, 0),
+
 	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_sclk_spi1",
 		ENABLE_SCLK_TOP0_PERIC1, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_sclk_spi0",
@@ -642,6 +680,12 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
 		ENABLE_PCLK_PERIC1, 15, 0, 0),
 	GATE(PCLK_SPI4, "pclk_spi4", "mout_aclk_peric1_66_user",
 		ENABLE_PCLK_PERIC1, 16, 0, 0),
+	GATE(PCLK_I2S1, "pclk_i2s1", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 17, CLK_SET_RATE_PARENT, 0),
+	GATE(PCLK_PCM1, "pclk_pcm1", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 18, 0, 0),
+	GATE(PCLK_SPDIF, "pclk_spdif", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 19, 0, 0),
 
 	GATE(SCLK_UART1, "sclk_uart1_user", "mout_sclk_uart1_user",
 		ENABLE_SCLK_PERIC10, 9, 0, 0),
@@ -659,6 +703,12 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
 		ENABLE_SCLK_PERIC10, 15, CLK_SET_RATE_PARENT, 0),
 	GATE(SCLK_SPI4, "sclk_spi4_user", "mout_sclk_spi4_user",
 		ENABLE_SCLK_PERIC10, 16, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_I2S1, "sclk_i2s1_user", "sclk_i2s1",
+		ENABLE_SCLK_PERIC10, 17, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_PCM1, "sclk_pcm1_user", "sclk_pcm1",
+		ENABLE_SCLK_PERIC10, 18, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_SPDIF, "sclk_spdif_user", "sclk_spdif",
+		ENABLE_SCLK_PERIC10, 19, CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_cmu_info peric1_cmu_info __initdata = {
@@ -1006,3 +1056,92 @@ static void __init exynos7_clk_mscl_init(struct device_node *np)
 
 CLK_OF_DECLARE(exynos7_clk_mscl, "samsung,exynos7-clock-mscl",
 		exynos7_clk_mscl_init);
+
+/* Register Offset definitions for CMU_AUD (0x114C0000) */
+#define	MUX_SEL_AUD			0x0200
+#define	DIV_AUD0			0x0600
+#define	DIV_AUD1			0x0604
+#define	ENABLE_ACLK_AUD			0x0800
+#define	ENABLE_PCLK_AUD			0x0900
+#define	ENABLE_SCLK_AUD			0x0A00
+
+/*
+ * List of parent clocks for Muxes in CMU_AUD
+ */
+PNAME(mout_aud_pll_user_p) = { "fin_pll", "fout_aud_pll" };
+PNAME(mout_aud_group_p) = { "dout_aud_cdclk", "ioclk_audiocdclk0" };
+
+static unsigned long aud_clk_regs[] __initdata = {
+	MUX_SEL_AUD,
+	DIV_AUD0,
+	DIV_AUD1,
+	ENABLE_ACLK_AUD,
+	ENABLE_PCLK_AUD,
+	ENABLE_SCLK_AUD,
+};
+
+static struct samsung_mux_clock aud_mux_clks[] __initdata = {
+	MUX(0, "mout_sclk_i2s", mout_aud_group_p, MUX_SEL_AUD, 12, 1),
+	MUX(0, "mout_sclk_pcm", mout_aud_group_p, MUX_SEL_AUD, 16, 1),
+	MUX(0, "mout_aud_pll_user", mout_aud_pll_user_p, MUX_SEL_AUD, 20, 1),
+};
+
+static struct samsung_div_clock aud_div_clks[] __initdata = {
+	DIV(0, "dout_aud_ca5", "mout_aud_pll_user", DIV_AUD0, 0, 4),
+	DIV(0, "dout_aclk_aud", "dout_aud_ca5", DIV_AUD0, 4, 4),
+	DIV(0, "dout_aud_pclk_dbg", "dout_aud_ca5", DIV_AUD0, 8, 4),
+
+	DIV(0, "dout_sclk_i2s", "mout_sclk_i2s", DIV_AUD1, 0, 4),
+	DIV(0, "dout_sclk_pcm", "mout_sclk_pcm", DIV_AUD1, 4, 8),
+	DIV(0, "dout_sclk_uart", "dout_aud_cdclk", DIV_AUD1, 12, 4),
+	DIV(0, "dout_sclk_slimbus", "dout_aud_cdclk", DIV_AUD1, 16, 5),
+	DIV(0, "dout_aud_cdclk", "mout_aud_pll_user", DIV_AUD1, 24, 4),
+};
+
+static struct samsung_gate_clock aud_gate_clks[] __initdata = {
+	GATE(SCLK_PCM, "sclk_pcm", "dout_sclk_pcm",
+			ENABLE_SCLK_AUD, 27, CLK_SET_RATE_PARENT, 0),
+	GATE(SCLK_I2S, "sclk_i2s", "dout_sclk_i2s",
+			ENABLE_SCLK_AUD, 28, CLK_SET_RATE_PARENT, 0),
+	GATE(0, "sclk_uart", "dout_sclk_uart", ENABLE_SCLK_AUD, 29, 0, 0),
+	GATE(0, "sclk_slimbus", "dout_sclk_slimbus",
+			ENABLE_SCLK_AUD, 30, 0, 0),
+
+	GATE(0, "pclk_dbg_aud", "dout_aud_pclk_dbg", ENABLE_PCLK_AUD, 19, 0, 0),
+	GATE(0, "pclk_gpio_aud", "dout_aclk_aud", ENABLE_PCLK_AUD, 20, 0, 0),
+	GATE(0, "pclk_wdt1", "dout_aclk_aud", ENABLE_PCLK_AUD, 22, 0, 0),
+	GATE(0, "pclk_wdt0", "dout_aclk_aud", ENABLE_PCLK_AUD, 23, 0, 0),
+	GATE(0, "pclk_slimbus", "dout_aclk_aud", ENABLE_PCLK_AUD, 24, 0, 0),
+	GATE(0, "pclk_uart", "dout_aclk_aud", ENABLE_PCLK_AUD, 25, 0, 0),
+	GATE(PCLK_PCM, "pclk_pcm", "dout_aclk_aud",
+			ENABLE_PCLK_AUD, 26, CLK_SET_RATE_PARENT, 0),
+	GATE(PCLK_I2S, "pclk_i2s", "dout_aclk_aud",
+			ENABLE_PCLK_AUD, 27, CLK_SET_RATE_PARENT, 0),
+	GATE(0, "pclk_timer", "dout_aclk_aud", ENABLE_PCLK_AUD, 28, 0, 0),
+	GATE(0, "pclk_smmu_aud", "dout_aclk_aud", ENABLE_PCLK_AUD, 31, 0, 0),
+
+	GATE(0, "aclk_smmu_aud", "dout_aclk_aud", ENABLE_ACLK_AUD, 27, 0, 0),
+	GATE(0, "aclk_acel_lh_async_si_top", "dout_aclk_aud",
+			 ENABLE_ACLK_AUD, 28, 0, 0),
+	GATE(ACLK_ADMA, "aclk_dmac", "dout_aclk_aud", ENABLE_ACLK_AUD, 31, 0, 0),
+};
+
+static struct samsung_cmu_info aud_cmu_info __initdata = {
+	.mux_clks		= aud_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(aud_mux_clks),
+	.div_clks		= aud_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(aud_div_clks),
+	.gate_clks		= aud_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
+	.nr_clk_ids		= AUD_NR_CLK,
+	.clk_regs		= aud_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
+};
+
+static void __init exynos7_clk_aud_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &aud_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_aud, "samsung,exynos7-clock-aud",
+		exynos7_clk_aud_init);
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 75c5888..e33c75a 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -19,7 +19,9 @@
 #define DOUT_ACLK_CCORE_133		6
 #define DOUT_ACLK_MSCL_532		7
 #define ACLK_MSCL_532			8
-#define TOPC_NR_CLK			9
+#define DOUT_SCLK_AUD_PLL		9
+#define FOUT_AUD_PLL			10
+#define TOPC_NR_CLK			11
 
 /* TOP0 */
 #define DOUT_ACLK_PERIC1		1
@@ -33,7 +35,10 @@
 #define CLK_SCLK_SPI2			9
 #define CLK_SCLK_SPI3			10
 #define CLK_SCLK_SPI4			11
-#define TOP0_NR_CLK			12
+#define CLK_SCLK_SPDIF			12
+#define CLK_SCLK_PCM1			13
+#define CLK_SCLK_I2S1			14
+#define TOP0_NR_CLK			15
 
 /* TOP1 */
 #define DOUT_ACLK_FSYS1_200		1
@@ -87,7 +92,13 @@
 #define SCLK_SPI2			19
 #define SCLK_SPI3			20
 #define SCLK_SPI4			21
-#define PERIC1_NR_CLK			22
+#define PCLK_I2S1			22
+#define PCLK_PCM1			23
+#define PCLK_SPDIF			24
+#define SCLK_I2S1			25
+#define SCLK_PCM1			26
+#define SCLK_SPDIF			27
+#define PERIC1_NR_CLK			28
 
 /* PERIS */
 #define PCLK_CHIPID			1
@@ -151,4 +162,11 @@
 #define PCLK_PMU_MSCL			32
 #define MSCL_NR_CLK			33
 
+/* AUD */
+#define SCLK_I2S			1
+#define SCLK_PCM			2
+#define PCLK_I2S			3
+#define PCLK_PCM			4
+#define ACLK_ADMA			5
+#define AUD_NR_CLK			6
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS7_H */
-- 
1.7.4.4
