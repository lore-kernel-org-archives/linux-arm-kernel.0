From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Jan 2017 14:59:23 +0100
Subject: [PATCH 2/4] clk: stm32f7: Introduce stm32f7 clocks for STM32F746
 boards
In-Reply-To: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
References: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1483711165-17149-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch enables clocks for STM32F746 boards.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 277 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 42f8534..344a411 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -48,6 +48,7 @@
 #define STM32F4_RCC_PLLI2SCFGR		0x84
 #define STM32F4_RCC_PLLSAICFGR		0x88
 #define STM32F4_RCC_DCKCFGR		0x8c
+#define STM32F7_RCC_DCKCFGR2		0x90
 
 #define NONE -1
 #define NO_IDX  NONE
@@ -224,6 +225,80 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
+static const struct stm32f4_gate_data stm32f746_gates[] __initconst = {
+	{ STM32F4_RCC_AHB1ENR,  0,	"gpioa",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  1,	"gpiob",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  2,	"gpioc",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  3,	"gpiod",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  4,	"gpioe",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  5,	"gpiof",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  6,	"gpiog",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  7,	"gpioh",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  8,	"gpioi",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  9,	"gpioj",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 10,	"gpiok",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 12,	"crc",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 18,	"bkpsra",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 20,	"dtcmram",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 21,	"dma1",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 22,	"dma2",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 23,	"dma2d",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 25,	"ethmac",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 26,	"ethmactx",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 27,	"ethmacrx",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 28,	"ethmacptp",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 29,	"otghs",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 30,	"otghsulpi",	"ahb_div" },
+
+	{ STM32F4_RCC_AHB2ENR,  0,	"dcmi",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  4,	"cryp",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  5,	"hash",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  6,	"rng",		"pll48"   },
+	{ STM32F4_RCC_AHB2ENR,  7,	"otgfs",	"pll48"   },
+
+	{ STM32F4_RCC_AHB3ENR,  0,	"fmc",		"ahb_div",
+		CLK_IGNORE_UNUSED },
+	{ STM32F4_RCC_AHB3ENR,  1,	"qspi",		"ahb_div",
+		CLK_IGNORE_UNUSED },
+
+	{ STM32F4_RCC_APB1ENR,  0,	"tim2",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  1,	"tim3",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  2,	"tim4",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  3,	"tim5",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  4,	"tim6",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  5,	"tim7",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  6,	"tim12",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  7,	"tim13",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  8,	"tim14",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR, 11,	"wwdg",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 14,	"spi2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 15,	"spi3",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 16,	"spdifrx",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 25,	"can1",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 26,	"can2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 27,	"cec",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 28,	"pwr",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 29,	"dac",		"apb1_div" },
+
+	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 11,	"sdmmc",	"sdmux"    },
+	{ STM32F4_RCC_APB2ENR, 12,	"spi1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 13,	"spi4",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 14,	"syscfg",	"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 16,	"tim9",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 17,	"tim10",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 18,	"tim11",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 23,	"sai2",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
+};
+
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
  * have gate bits associated with them. Its combined hweight is 71.
@@ -238,6 +313,10 @@ struct stm32f4_gate_data {
 						       0x0000000000000003ull,
 						       0x0c777f33f6fec9ffull };
 
+static const u64 stm32f746_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
+						      0x0000000000000003ull,
+						      0x04f77f033e01c9ffull };
+
 static const u64 *stm32f4_gate_map;
 
 static struct clk_hw **clks;
@@ -247,6 +326,8 @@ struct stm32f4_gate_data {
 
 static struct regmap *pdrm;
 
+static int stm32fx_end_primary_clk;
+
 /*
  * "Multiplier" device for APBx clocks.
  *
@@ -685,7 +766,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	u64 table[MAX_GATE_MAP];
 
 	if (primary == 1) {
-		if (WARN_ON(secondary >= END_PRIMARY_CLK))
+		if (WARN_ON(secondary >= stm32fx_end_primary_clk))
 			return -EINVAL;
 		return secondary;
 	}
@@ -702,7 +783,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	table[BIT_ULL_WORD(secondary)] &=
 	    GENMASK_ULL(secondary % BITS_PER_LONG_LONG, 0);
 
-	return END_PRIMARY_CLK - 1 + hweight64(table[0]) +
+	return stm32fx_end_primary_clk - 1 + hweight64(table[0]) +
 	       (BIT_ULL_WORD(secondary) >= 1 ? hweight64(table[1]) : 0) +
 	       (BIT_ULL_WORD(secondary) >= 2 ? hweight64(table[2]) : 0);
 }
@@ -955,6 +1036,17 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 
 static const char *sdmux_parents[2] = { "pll48", "sys" };
 
+static const char *hdmi_parents[2] = { "lse", "hsi_div488" };
+
+static const char *spdif_parent[1] = { "plli2s-p" };
+
+static const char *lptim_parent[4] = { "apb1_mul", "lsi", "hsi", "lse" };
+
+static const char *uart_parents1[4] = { "apb2_div", "sys", "hsi", "lse" };
+static const char *uart_parents2[4] = { "apb1_div", "sys", "hsi", "lse" };
+
+static const char *i2c_parents[4] = { "apb1_div", "sys", "hsi", "no-clock" };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -975,6 +1067,7 @@ struct stm32f4_clk_data {
 	const struct stm32f4_pll_data *pll_data;
 	const struct stm32_aux_clk *aux_clk;
 	int aux_clk_num;
+	int end_primary;
 };
 
 static const struct stm32_aux_clk stm32f429_aux_clk[] = {
@@ -1043,7 +1136,154 @@ struct stm32f4_clk_data {
 	},
 };
 
+static const struct stm32_aux_clk stm32f746_aux_clk[] = {
+	{
+		CLK_LCD, "lcd-tft", lcd_parent, ARRAY_SIZE(lcd_parent),
+		NO_MUX, 0, 0,
+		STM32F4_RCC_APB2ENR, 26,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_I2S, "i2s", i2s_parents, ARRAY_SIZE(i2s_parents),
+		STM32F4_RCC_CFGR, 23, 1,
+		NO_GATE, 0,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI1, "sai1_clk", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 20, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI2, "sai2_clk", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 22, 3,
+		STM32F4_RCC_APB2ENR, 23,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		NO_IDX, "pll48", pll48_parents, ARRAY_SIZE(pll48_parents),
+		STM32F7_RCC_DCKCFGR2, 27, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		NO_IDX, "sdmux", sdmux_parents, ARRAY_SIZE(sdmux_parents),
+		STM32F7_RCC_DCKCFGR2, 28, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		CLK_HDMI_CEC, "hdmi-cec",
+		hdmi_parents, ARRAY_SIZE(hdmi_parents),
+		STM32F7_RCC_DCKCFGR2, 26, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		CLK_SPDIF, "spdif-rx",
+		spdif_parent, ARRAY_SIZE(spdif_parent),
+		STM32F7_RCC_DCKCFGR2, 22, 3,
+		STM32F4_RCC_APB2ENR, 23,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_USART1, "usart1",
+		uart_parents1, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 0, 3,
+		STM32F4_RCC_APB2ENR, 4,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART2, "usart2",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 2, 3,
+		STM32F4_RCC_APB1ENR, 17,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART3, "usart3",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 4, 3,
+		STM32F4_RCC_APB1ENR, 18,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART4, "uart4",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 6, 3,
+		STM32F4_RCC_APB1ENR, 19,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART5, "uart5",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 8, 3,
+		STM32F4_RCC_APB1ENR, 20,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART6, "usart6",
+		uart_parents1, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 10, 3,
+		STM32F4_RCC_APB2ENR, 5,
+		CLK_SET_RATE_PARENT,
+	},
+
+	{
+		CLK_UART7, "uart7",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 12, 3,
+		STM32F4_RCC_APB1ENR, 30,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART8, "uart8",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 14, 3,
+		STM32F4_RCC_APB1ENR, 31,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C1, "i2c1",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 16, 3,
+		STM32F4_RCC_APB1ENR, 21,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C2, "i2c2",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 18, 3,
+		STM32F4_RCC_APB1ENR, 22,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C3, "i2c3",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 20, 3,
+		STM32F4_RCC_APB1ENR, 23,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C4, "i2c4",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 22, 3,
+		STM32F4_RCC_APB1ENR, 24,
+		CLK_SET_RATE_PARENT,
+	},
+
+	{
+		CLK_LPTIMER, "lptim1",
+		lptim_parent, ARRAY_SIZE(lptim_parent),
+		STM32F7_RCC_DCKCFGR2, 24, 3,
+		STM32F4_RCC_APB1ENR, 9,
+		CLK_SET_RATE_PARENT
+	},
+};
+
 static const struct stm32f4_clk_data stm32f429_clk_data = {
+	.end_primary	= END_PRIMARY_CLK,
 	.gates_data	= stm32f429_gates,
 	.gates_map	= stm32f42xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f429_gates),
@@ -1053,6 +1293,7 @@ struct stm32f4_clk_data {
 };
 
 static const struct stm32f4_clk_data stm32f469_clk_data = {
+	.end_primary	= END_PRIMARY_CLK,
 	.gates_data	= stm32f469_gates,
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
@@ -1061,6 +1302,16 @@ struct stm32f4_clk_data {
 	.aux_clk_num	= ARRAY_SIZE(stm32f469_aux_clk),
 };
 
+static const struct stm32f4_clk_data stm32f746_clk_data = {
+	.end_primary	= END_PRIMARY_CLK_F7,
+	.gates_data	= stm32f746_gates,
+	.gates_map	= stm32f746_gate_map,
+	.gates_num	= ARRAY_SIZE(stm32f746_gates),
+	.pll_data	= stm32f469_pll,
+	.aux_clk	= stm32f746_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f746_aux_clk),
+};
+
 static const struct of_device_id stm32f4_of_match[] = {
 	{
 		.compatible = "st,stm32f42xx-rcc",
@@ -1070,6 +1321,10 @@ struct stm32f4_clk_data {
 		.compatible = "st,stm32f469-rcc",
 		.data = &stm32f469_clk_data
 	},
+	{
+		.compatible = "st,stm32f746-rcc",
+		.data = &stm32f746_clk_data
+	},
 	{}
 };
 
@@ -1161,7 +1416,9 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	data = match->data;
 
-	clks = kmalloc_array(data->gates_num + END_PRIMARY_CLK,
+	stm32fx_end_primary_clk = data->end_primary;
+
+	clks = kmalloc_array(data->gates_num + stm32fx_end_primary_clk,
 			sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		goto fail;
@@ -1175,8 +1432,9 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	i2s_parents[1] = i2s_in_clk;
 	sai_parents[2] = i2s_in_clk;
 
-	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
-			16000000, 160000);
+	clks[CLK_HSI] = clk_hw_register_fixed_rate_with_accuracy(NULL, "hsi",
+			NULL, 0, 16000000, 160000);
+
 	pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
 	pllsrc = pllcfgr & BIT(22) ? hse_clk : "hsi";
 	pllm = pllcfgr & 0x3f;
@@ -1215,7 +1473,8 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	}
 
 	sys_parents[1] = hse_clk;
-	clk_register_mux_table(
+
+	clks[CLK_SYSCLK] = clk_hw_register_mux_table(
 	    NULL, "sys", sys_parents, ARRAY_SIZE(sys_parents), 0,
 	    base + STM32F4_RCC_CFGR, 0, 3, 0, NULL, &stm32f4_clk_lock);
 
@@ -1319,6 +1578,11 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 			clks[aux_clk->idx] = hw;
 	}
 
+	if (of_device_is_compatible(np, "st,stm32f746-rcc"))
+
+		clk_hw_register_fixed_factor(NULL, "hsi_div488", "hsi", 0,
+				1, 488);
+
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
@@ -1327,3 +1591,4 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 }
 CLK_OF_DECLARE_DRIVER(stm32f42xx_rcc, "st,stm32f42xx-rcc", stm32f4_rcc_init);
 CLK_OF_DECLARE_DRIVER(stm32f46xx_rcc, "st,stm32f469-rcc", stm32f4_rcc_init);
+CLK_OF_DECLARE_DRIVER(stm32f746_rcc, "st,stm32f746-rcc", stm32f4_rcc_init);
-- 
1.9.1
