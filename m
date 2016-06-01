From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:14 -0700
Subject: [PATCH 15/34] clk: efm32gg: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-16-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-efm32gg.c | 63 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/clk-efm32gg.c b/drivers/clk/clk-efm32gg.c
index 22e4c659704e..8802a2dd56ac 100644
--- a/drivers/clk/clk-efm32gg.c
+++ b/drivers/clk/clk-efm32gg.c
@@ -10,24 +10,31 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/clock/efm32-cmu.h>
 
 #define CMU_HFPERCLKEN0		0x44
+#define CMU_MAX_CLKS		37
 
-static struct clk *clk[37];
-static struct clk_onecell_data clk_data = {
-	.clks = clk,
-	.clk_num = ARRAY_SIZE(clk),
-};
+static struct clk_hw_onecell_data *clk_data;
 
 static void __init efm32gg_cmu_init(struct device_node *np)
 {
 	int i;
 	void __iomem *base;
+	struct clk_hw **hws;
 
-	for (i = 0; i < ARRAY_SIZE(clk); ++i)
-		clk[i] = ERR_PTR(-ENOENT);
+	clk_data = kzalloc(sizeof(*clk_data) +
+			   sizeof(*clk_data->hws) * CMU_MAX_CLKS, GFP_KERNEL);
+
+	if (!clk_data)
+		return;
+
+	hws = clk_data->hws;
+
+	for (i = 0; i < CMU_MAX_CLKS; ++i)
+		hws[i] = ERR_PTR(-ENOENT);
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -35,46 +42,46 @@ static void __init efm32gg_cmu_init(struct device_node *np)
 		return;
 	}
 
-	clk[clk_HFXO] = clk_register_fixed_rate(NULL, "HFXO", NULL,
-			0, 48000000);
+	hws[clk_HFXO] = clk_hw_register_fixed_rate(NULL, "HFXO", NULL, 0,
+						   48000000);
 
-	clk[clk_HFPERCLKUSART0] = clk_register_gate(NULL, "HFPERCLK.USART0",
+	hws[clk_HFPERCLKUSART0] = clk_hw_register_gate(NULL, "HFPERCLK.USART0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 0, 0, NULL);
-	clk[clk_HFPERCLKUSART1] = clk_register_gate(NULL, "HFPERCLK.USART1",
+	hws[clk_HFPERCLKUSART1] = clk_hw_register_gate(NULL, "HFPERCLK.USART1",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 1, 0, NULL);
-	clk[clk_HFPERCLKUSART2] = clk_register_gate(NULL, "HFPERCLK.USART2",
+	hws[clk_HFPERCLKUSART2] = clk_hw_register_gate(NULL, "HFPERCLK.USART2",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 2, 0, NULL);
-	clk[clk_HFPERCLKUART0] = clk_register_gate(NULL, "HFPERCLK.UART0",
+	hws[clk_HFPERCLKUART0] = clk_hw_register_gate(NULL, "HFPERCLK.UART0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 3, 0, NULL);
-	clk[clk_HFPERCLKUART1] = clk_register_gate(NULL, "HFPERCLK.UART1",
+	hws[clk_HFPERCLKUART1] = clk_hw_register_gate(NULL, "HFPERCLK.UART1",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 4, 0, NULL);
-	clk[clk_HFPERCLKTIMER0] = clk_register_gate(NULL, "HFPERCLK.TIMER0",
+	hws[clk_HFPERCLKTIMER0] = clk_hw_register_gate(NULL, "HFPERCLK.TIMER0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 5, 0, NULL);
-	clk[clk_HFPERCLKTIMER1] = clk_register_gate(NULL, "HFPERCLK.TIMER1",
+	hws[clk_HFPERCLKTIMER1] = clk_hw_register_gate(NULL, "HFPERCLK.TIMER1",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 6, 0, NULL);
-	clk[clk_HFPERCLKTIMER2] = clk_register_gate(NULL, "HFPERCLK.TIMER2",
+	hws[clk_HFPERCLKTIMER2] = clk_hw_register_gate(NULL, "HFPERCLK.TIMER2",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 7, 0, NULL);
-	clk[clk_HFPERCLKTIMER3] = clk_register_gate(NULL, "HFPERCLK.TIMER3",
+	hws[clk_HFPERCLKTIMER3] = clk_hw_register_gate(NULL, "HFPERCLK.TIMER3",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 8, 0, NULL);
-	clk[clk_HFPERCLKACMP0] = clk_register_gate(NULL, "HFPERCLK.ACMP0",
+	hws[clk_HFPERCLKACMP0] = clk_hw_register_gate(NULL, "HFPERCLK.ACMP0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 9, 0, NULL);
-	clk[clk_HFPERCLKACMP1] = clk_register_gate(NULL, "HFPERCLK.ACMP1",
+	hws[clk_HFPERCLKACMP1] = clk_hw_register_gate(NULL, "HFPERCLK.ACMP1",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 10, 0, NULL);
-	clk[clk_HFPERCLKI2C0] = clk_register_gate(NULL, "HFPERCLK.I2C0",
+	hws[clk_HFPERCLKI2C0] = clk_hw_register_gate(NULL, "HFPERCLK.I2C0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 11, 0, NULL);
-	clk[clk_HFPERCLKI2C1] = clk_register_gate(NULL, "HFPERCLK.I2C1",
+	hws[clk_HFPERCLKI2C1] = clk_hw_register_gate(NULL, "HFPERCLK.I2C1",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 12, 0, NULL);
-	clk[clk_HFPERCLKGPIO] = clk_register_gate(NULL, "HFPERCLK.GPIO",
+	hws[clk_HFPERCLKGPIO] = clk_hw_register_gate(NULL, "HFPERCLK.GPIO",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 13, 0, NULL);
-	clk[clk_HFPERCLKVCMP] = clk_register_gate(NULL, "HFPERCLK.VCMP",
+	hws[clk_HFPERCLKVCMP] = clk_hw_register_gate(NULL, "HFPERCLK.VCMP",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 14, 0, NULL);
-	clk[clk_HFPERCLKPRS] = clk_register_gate(NULL, "HFPERCLK.PRS",
+	hws[clk_HFPERCLKPRS] = clk_hw_register_gate(NULL, "HFPERCLK.PRS",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 15, 0, NULL);
-	clk[clk_HFPERCLKADC0] = clk_register_gate(NULL, "HFPERCLK.ADC0",
+	hws[clk_HFPERCLKADC0] = clk_hw_register_gate(NULL, "HFPERCLK.ADC0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 16, 0, NULL);
-	clk[clk_HFPERCLKDAC0] = clk_register_gate(NULL, "HFPERCLK.DAC0",
+	hws[clk_HFPERCLKDAC0] = clk_hw_register_gate(NULL, "HFPERCLK.DAC0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 17, 0, NULL);
 
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data);
 }
 CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
-- 
2.7.4
