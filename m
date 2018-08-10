From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 10 Aug 2018 15:21:12 +0530
Subject: [PATCH v3 8/9] clk: actions: Add Actions Semi S700 SoC Reset
 Management Unit support
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180810095113.25292-9-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Management Unit (RMU) support for Actions Semi S700 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-s700.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index e7cacd677275..a2f34d13fb54 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -20,8 +20,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s700-reset.h>
 
 #define CMU_COREPLL		(0x0000)
 #define CMU_DEVPLL		(0x0004)
@@ -569,20 +571,69 @@ static struct clk_hw_onecell_data s700_hw_clks = {
 		.num    = CLK_NR_CLKS,
 };
 
+static const struct owl_reset_map s700_resets[] = {
+	[RESET_DE]	= { CMU_DEVRST0, BIT(0) },
+	[RESET_LCD0]	= { CMU_DEVRST0, BIT(1) },
+	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
+	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
+	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
+	[RESET_I2C3]	= { CMU_DEVRST1, BIT(3) },
+	[RESET_SPI0]	= { CMU_DEVRST1, BIT(4) },
+	[RESET_SPI1]	= { CMU_DEVRST1, BIT(5) },
+	[RESET_SPI2]	= { CMU_DEVRST1, BIT(6) },
+	[RESET_SPI3]	= { CMU_DEVRST1, BIT(7) },
+	[RESET_UART0]	= { CMU_DEVRST1, BIT(8) },
+	[RESET_UART1]	= { CMU_DEVRST1, BIT(9) },
+	[RESET_UART2]	= { CMU_DEVRST1, BIT(10) },
+	[RESET_UART3]	= { CMU_DEVRST1, BIT(11) },
+	[RESET_UART4]	= { CMU_DEVRST1, BIT(12) },
+	[RESET_UART5]	= { CMU_DEVRST1, BIT(13) },
+	[RESET_UART6]	= { CMU_DEVRST1, BIT(14) },
+	[RESET_KEY]	= { CMU_DEVRST1, BIT(24) },
+	[RESET_GPIO]	= { CMU_DEVRST1, BIT(25) },
+	[RESET_AUDIO]	= { CMU_DEVRST1, BIT(29) },
+};
+
 static struct owl_clk_desc s700_clk_desc = {
 	.clks       = s700_clks,
 	.num_clks   = ARRAY_SIZE(s700_clks),
 
 	.hw_clks    = &s700_hw_clks,
+
+	.resets     = s700_resets,
+	.num_resets = ARRAY_SIZE(s700_resets),
 };
 
 static int s700_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s700_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
 
+	/*
+	 * FIXME: Reset controller registration should be moved to
+	 * common code, once all SoCs of Owl family supports it.
+	 */
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.ops = &owl_reset_ops;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->reset_map = desc->resets;
+	reset->regmap = desc->regmap;
+
+	ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register reset controller\n");
+
 	return owl_clk_probe(&pdev->dev, desc->hw_clks);
 }
 
-- 
2.17.1
