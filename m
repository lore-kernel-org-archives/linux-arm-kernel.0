From: andrea.merello@gmail.com (Andrea Merello)
Date: Thu,  8 Sep 2016 09:01:03 +0200
Subject: [PATCH] clk: stm32f4: don't assume 48MHz clock is derived from
 primary PLL
Message-ID: <1473318063-21782-1-git-send-email-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver just look at the PLLs configurations set by the
bootloader, but it assumes the 48MHz clock is derived from the primary
PLL; however using PLLSAI is another option for generating the 48MHz
clock.

This patch make the driver to check for this, and eventually adjust the
clock tree accordingly

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Bruno Herrera <bruherrera@gmail.com>
---
 drivers/clk/clk-stm32f4.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 02d6810..7f1ba8f 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#define STM32F4_RCC_CR			0x00
 #define STM32F4_RCC_PLLCFGR		0x04
 #define STM32F4_RCC_CFGR		0x08
 #define STM32F4_RCC_AHB1ENR		0x30
@@ -31,6 +32,8 @@
 #define STM32F4_RCC_AHB3ENR		0x38
 #define STM32F4_RCC_APB1ENR		0x40
 #define STM32F4_RCC_APB2ENR		0x44
+#define STM32F4_RCC_PLLSAICFGR		0x88
+#define STM32F4_RCC_DCKCFGR		0x8C
 
 struct stm32f4_gate_data {
 	u8	offset;
@@ -238,16 +241,35 @@ static struct clk *clk_register_apb_mul(struct device *dev, const char *name,
 static void stm32f4_rcc_register_pll(const char *hse_clk, const char *hsi_clk)
 {
 	unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
-
+	unsigned long pllsaicfgr = readl(base + STM32F4_RCC_PLLSAICFGR);
+	unsigned long dckcfgr = readl(base + STM32F4_RCC_DCKCFGR);
+	unsigned long rcccr = readl(base + STM32F4_RCC_CR);
+	bool saien = rcccr & BIT(28);
 	unsigned long pllm   = pllcfgr & 0x3f;
 	unsigned long plln   = (pllcfgr >> 6) & 0x1ff;
 	unsigned long pllp   = BIT(((pllcfgr >> 16) & 3) + 1);
 	const char   *pllsrc = pllcfgr & BIT(22) ? hse_clk : hsi_clk;
 	unsigned long pllq   = (pllcfgr >> 24) & 0xf;
+	bool src48_sai = dckcfgr & BIT(27);
+	unsigned long pllsain = (pllsaicfgr >> 6) & 0x1ff;
+	unsigned long pllsaip = BIT(((pllsaicfgr >> 16) & 3) + 1);
 
 	clk_register_fixed_factor(NULL, "vco", pllsrc, 0, plln, pllm);
 	clk_register_fixed_factor(NULL, "pll", "vco", 0, 1, pllp);
-	clk_register_fixed_factor(NULL, "pll48", "vco", 0, 1, pllq);
+
+	if (src48_sai && !saien) {
+		pr_err("48MHz derived from SAI PLL, but SAI PLL disabled (blame the bootloader)\n");
+		return;
+	}
+
+	if (saien)
+		clk_register_fixed_factor(NULL, "sai",
+					pllsrc, 0, pllsain, pllm);
+
+	if (src48_sai)
+		clk_register_fixed_factor(NULL, "pll48", "sai", 0, 1, pllsaip);
+	else
+		clk_register_fixed_factor(NULL, "pll48", "vco", 0, 1, pllq);
 }
 
 /*
-- 
2.7.4
