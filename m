From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:47 +0100
Subject: [PATCH v3 7/9] clk: stm32f4: SDIO & 48Mhz clock management for
 STM32F469 board
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-8-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

In the stm32f469 soc, the 48Mhz clock could be derived from pll-q or
from pll-sai-p.

The SDIO clock could be also derived from 48Mhz or from sys clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 02339d1..161449d 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -206,7 +206,7 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
-	{ STM32F4_RCC_APB2ENR, 11,	"sdio",		"pll48" },
+	{ STM32F4_RCC_APB2ENR, 11,	"sdio",		"sdmux" },
 	{ STM32F4_RCC_APB2ENR, 12,	"spi1",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 13,	"spi4",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 14,	"syscfg",	"apb2_div" },
@@ -940,6 +940,10 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
 static const char *sai_parents[4] = { "pllsai-q-div", "plli2s-q-div", NULL,
 	"no-clock" };
 
+static const char *pll48_parents[2] = { "pll-q", "pllsai-p" };
+
+static const char *sdmux_parents[2] = { "pll48", "sys" };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -994,6 +998,45 @@ struct stm32f4_clk_data {
 	},
 };
 
+static const struct stm32_aux_clk stm32f469_aux_clk[] = {
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
+		CLK_SAI1, "sai1-a", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 20, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI2, "sai1-b", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 22, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		NO_IDX, "pll48", pll48_parents, ARRAY_SIZE(pll48_parents),
+		STM32F4_RCC_DCKCFGR, 27, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		NO_IDX, "sdmux", sdmux_parents, ARRAY_SIZE(sdmux_parents),
+		STM32F4_RCC_DCKCFGR, 28, 1,
+		NO_GATE, 0,
+		0
+	},
+};
+
 static const struct stm32f4_clk_data stm32f429_clk_data = {
 	.gates_data	= stm32f429_gates,
 	.gates_map	= stm32f42xx_gate_map,
@@ -1008,8 +1051,8 @@ struct stm32f4_clk_data {
 	.gates_map	= stm32f46xx_gate_map,
 	.gates_num	= ARRAY_SIZE(stm32f469_gates),
 	.pll_data	= stm32f469_pll,
-	.aux_clk	= stm32f429_aux_clk,
-	.aux_clk_num	= ARRAY_SIZE(stm32f429_aux_clk),
+	.aux_clk	= stm32f469_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f469_aux_clk),
 };
 
 static const struct of_device_id stm32f4_of_match[] = {
-- 
1.9.1
