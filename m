From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 16 Mar 2017 09:16:40 +0100
Subject: [PATCH v2 1/2] clk: stm32f4: fix: exclude values 0 and 1 for PLLQ
In-Reply-To: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
References: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1489652201-19889-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

0000: PLLQ = 0, wrong configuration
0001: PLLQ = 1, wrong configuration
...
0010: PLLQ = 2
0011: PLLQ = 3
0100: PLLQ = 4
...
1111: PLLQ = 1

Use divider table to exclude 0 and 1 values.

Fixes: 83135ad3c517 ("clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469 boards")

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32f4.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index ab609a7..cf9449b3 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -429,6 +429,13 @@ enum {
 	{ 0, 2 }, { 1, 4 }, { 2, 6 }, { 3, 8 }, { 0 }
 };
 
+static const struct clk_div_table pll_divq_table[] = {
+	{ 2, 2 }, { 3, 3 }, { 4, 4 }, { 5, 5 }, { 6, 6 }, { 7, 7 },
+	{ 8, 8 }, { 9, 9 }, { 10, 10 }, { 11, 11 }, { 12, 12 }, { 13, 13 },
+	{ 14, 14 }, { 15, 15 },
+	{ 0 }
+};
+
 static const struct clk_div_table pll_divr_table[] = {
 	{ 2, 2 }, { 3, 3 }, { 4, 4 }, { 5, 5 }, { 6, 6 }, { 7, 7 }, { 0 }
 };
@@ -496,9 +503,9 @@ struct stm32f4_div_data {
 
 #define MAX_PLL_DIV 3
 static const struct stm32f4_div_data  div_data[MAX_PLL_DIV] = {
-	{ 16, 2, 0,			pll_divp_table	},
-	{ 24, 4, CLK_DIVIDER_ONE_BASED, NULL		},
-	{ 28, 3, 0,			pll_divr_table	},
+	{ 16, 2, 0, pll_divp_table },
+	{ 24, 4, 0, pll_divq_table },
+	{ 28, 3, 0, pll_divr_table },
 };
 
 struct stm32f4_pll_data {
-- 
1.9.1
