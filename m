From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 30 Sep 2016 16:25:08 +0200
Subject: [PATCH 5/6] clk: stm32f469: Add QSPI clock
In-Reply-To: <1475245509-6487-1-git-send-email-gabriel.fernandez@st.com>
References: <1475245509-6487-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1475245509-6487-6-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the QSPI clock for stm32f469 discovery board.
The gate mapping is a little bit different from stm32f429 soc.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   4 +-
 drivers/clk/clk-stm32f4.c                          | 173 ++++++++++++++++++---
 2 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index fee3205..eace3de 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -8,7 +8,9 @@ Please also refer to clock-bindings.txt in this directory for common clock
 controller binding usage.
 
 Required properties:
-- compatible: Should be "st,stm32f42xx-rcc"
+- compatible: Should be:
+  "st,stm32f42xx-rcc"
+  "st,stm32f46xx-rcc"
 - reg: should be register base and length as documented in the
   datasheet
 - #clock-cells: 2, device nodes should specify the clock in their "clocks"
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 6e26d39..bc75d83 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -54,7 +54,7 @@ struct stm32f4_rgate_data {
 	unsigned long flags;
 };
 
-static const struct stm32f4_gate_data stm32f4_gates[] __initconst = {
+static const struct stm32f4_gate_data stm32f429_gates[] __initconst = {
 	{ STM32F4_RCC_AHB1ENR,  0,	"gpioa",	"ahb_div" },
 	{ STM32F4_RCC_AHB1ENR,  1,	"gpiob",	"ahb_div" },
 	{ STM32F4_RCC_AHB1ENR,  2,	"gpioc",	"ahb_div" },
@@ -134,23 +134,109 @@ static const struct stm32f4_gate_data stm32f4_gates[] __initconst = {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
+static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
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
+	{ STM32F4_RCC_AHB1ENR, 20,	"ccmdatam",	"ahb_div" },
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
+	{ STM32F4_RCC_AHB2ENR,  6,	"rng",		"pll48" },
+	{ STM32F4_RCC_AHB2ENR,  7,	"otgfs",	"pll48" },
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
+	{ STM32F4_RCC_APB1ENR, 17,	"uart2",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 18,	"uart3",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 19,	"uart4",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 20,	"uart5",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 21,	"i2c1",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 22,	"i2c2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 23,	"i2c3",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 25,	"can1",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 26,	"can2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 28,	"pwr",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 29,	"dac",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 30,	"uart7",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 31,	"uart8",	"apb1_div" },
+
+	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  4,	"usart1",	"apb2_div" },
+	{ STM32F4_RCC_APB2ENR,  5,	"usart6",	"apb2_div" },
+	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 11,	"sdio",		"pll48" },
+	{ STM32F4_RCC_APB2ENR, 12,	"spi1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 13,	"spi4",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 14,	"syscfg",	"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 16,	"tim9",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 17,	"tim10",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 18,	"tim11",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
+};
+
 enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC, END_PRIMARY_CLK };
-/*
- * MAX_CLKS is the maximum value in the enumeration below plus the combined
- * hweight of stm32f42xx_gate_map (plus one).
- */
-#define MAX_CLKS (71 + END_PRIMARY_CLK + 1)
 
 
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
  * have gate bits associated with them. Its combined hweight is 71.
  */
-static const u64 stm32f42xx_gate_map[] = { 0x000000f17ef417ffull,
-					   0x0000000000000001ull,
-					   0x04777f33f6fec9ffull };
+#define MAX_GATE_MAP 3
+
+static const u64 stm32f42xx_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
+						       0x0000000000000001ull,
+						       0x04777f33f6fec9ffull };
+
+static const u64 stm32f46xx_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
+						       0x0000000000000003ull,
+						       0x0c777f33f6fec9ffull };
+
+const u64 *stm32f4_gate_map;
+
+static struct clk_hw **clks;
 
-static struct clk_hw *clks[MAX_CLKS];
 static DEFINE_SPINLOCK(stm32f4_clk_lock);
 static void __iomem *base;
 
@@ -270,7 +356,7 @@ static void stm32f4_rcc_register_pll(const char *hse_clk, const char *hsi_clk)
  */
 static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 {
-	u64 table[ARRAY_SIZE(stm32f42xx_gate_map)];
+	u64 table[MAX_GATE_MAP];
 
 	if (primary == 1) {
 		if (WARN_ON(secondary >= END_PRIMARY_CLK))
@@ -278,7 +364,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 		return secondary;
 	}
 
-	memcpy(table, stm32f42xx_gate_map, sizeof(table));
+	memcpy(table, stm32f4_gate_map, sizeof(table));
 
 	/* only bits set in table can be used as indices */
 	if (WARN_ON(secondary >= BITS_PER_BYTE * sizeof(table) ||
@@ -540,10 +626,42 @@ static const struct clk_div_table apb_div_table[] = {
 	{ 0 },
 };
 
+struct stm32f4_clk_data {
+	const struct stm32f4_gate_data *gates_data;
+	const u64 *gates_map;
+	int gates_num;
+};
+
+static const struct stm32f4_clk_data stm32f429_clk_data = {
+	.gates_data	= stm32f429_gates,
+	.gates_map	= stm32f42xx_gate_map,
+	.gates_num	= ARRAY_SIZE(stm32f429_gates),
+};
+
+static const struct stm32f4_clk_data stm32f469_clk_data = {
+	.gates_data	= stm32f469_gates,
+	.gates_map	= stm32f46xx_gate_map,
+	.gates_num	= ARRAY_SIZE(stm32f469_gates),
+};
+
+static const struct of_device_id stm32f4_of_match[] = {
+	{
+		.compatible = "st,stm32f42xx-rcc",
+		.data = &stm32f429_clk_data
+	},
+	{
+		.compatible = "st,stm32f46xx-rcc",
+		.data = &stm32f469_clk_data
+	},
+	{}
+};
+
 static void __init stm32f4_rcc_init(struct device_node *np)
 {
 	const char *hse_clk;
 	int n;
+	const struct of_device_id *match;
+	const struct stm32f4_clk_data *data;
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -557,6 +675,19 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		goto fail;
 	}
 
+	match = of_match_node(stm32f4_of_match, np);
+	if (WARN_ON(!match))
+		return;
+
+	data = match->data;
+
+	clks = kmalloc_array(data->gates_num + END_PRIMARY_CLK,
+			sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!clks)
+		goto fail;
+
+	stm32f4_gate_map = data->gates_map;
+
 	hse_clk = of_clk_get_parent_name(np, 0);
 
 	clk_register_fixed_rate_with_accuracy(NULL, "hsi", NULL, 0,
@@ -589,11 +720,15 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	clks[FCLK] = clk_hw_register_fixed_factor(NULL, "fclk", "ahb_div",
 					       0, 1, 1);
 
-	for (n = 0; n < ARRAY_SIZE(stm32f4_gates); n++) {
-		const struct stm32f4_gate_data *gd = &stm32f4_gates[n];
-		unsigned int secondary =
-		    8 * (gd->offset - STM32F4_RCC_AHB1ENR) + gd->bit_idx;
-		int idx = stm32f4_rcc_lookup_clk_idx(0, secondary);
+	for (n = 0; n < data->gates_num; n++) {
+		const struct stm32f4_gate_data *gd;
+		unsigned int secondary;
+		int idx;
+
+		gd = (struct stm32f4_gate_data *) &data->gates_data[n];
+		secondary = 8 * (gd->offset - STM32F4_RCC_AHB1ENR) +
+			gd->bit_idx;
+		idx = stm32f4_rcc_lookup_clk_idx(0, secondary);
 
 		if (idx < 0)
 			goto fail;
@@ -645,6 +780,8 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
+	kfree(clks);
 	iounmap(base);
 }
-CLK_OF_DECLARE(stm32f4_rcc, "st,stm32f42xx-rcc", stm32f4_rcc_init);
+CLK_OF_DECLARE(stm32f42xx_rcc, "st,stm32f42xx-rcc", stm32f4_rcc_init);
+CLK_OF_DECLARE(stm32f46xx_rcc, "st,stm32f46xx-rcc", stm32f4_rcc_init);
-- 
1.9.1
