From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 28 Jul 2018 00:15:27 +0530
Subject: [PATCH 9/9] clk: actions: Add Actions Semi S900 SoC Reset Management
 Unit support
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180727184527.13287-10-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Management Unit (RMU) support for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-s900.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
index bb7ee872d316..4d38b1265cc3 100644
--- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -19,8 +19,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 #define CMU_COREPLL		(0x0000)
 #define CMU_DEVPLL		(0x0004)
@@ -684,20 +686,100 @@ static struct clk_hw_onecell_data s900_hw_clks = {
 	.num	= CLK_NR_CLKS,
 };
 
+static struct owl_reset_map s900_resets[] = {
+	[RESET_DMAC]		= { CMU_DEVRST0, BIT(0) },
+	[RESET_SRAMI]		= { CMU_DEVRST0, BIT(1) },
+	[RESET_DDR_CTL_PHY]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_NANDC0]		= { CMU_DEVRST0, BIT(3) },
+	[RESET_SD0]		= { CMU_DEVRST0, BIT(4) },
+	[RESET_SD1]		= { CMU_DEVRST0, BIT(5) },
+	[RESET_PCM1]		= { CMU_DEVRST0, BIT(6) },
+	[RESET_DE]		= { CMU_DEVRST0, BIT(7) },
+	[RESET_LVDS]		= { CMU_DEVRST0, BIT(8) },
+	[RESET_SD2]		= { CMU_DEVRST0, BIT(9) },
+	[RESET_DSI]		= { CMU_DEVRST0, BIT(10) },
+	[RESET_CSI0]		= { CMU_DEVRST0, BIT(11) },
+	[RESET_BISP_AXI]	= { CMU_DEVRST0, BIT(12) },
+	[RESET_CSI1]		= { CMU_DEVRST0, BIT(13) },
+	[RESET_GPIO]		= { CMU_DEVRST0, BIT(15) },
+	[RESET_EDP]		= { CMU_DEVRST0, BIT(16) },
+	[RESET_AUDIO]		= { CMU_DEVRST0, BIT(17) },
+	[RESET_PCM0]		= { CMU_DEVRST0, BIT(18) },
+	[RESET_HDE]		= { CMU_DEVRST0, BIT(21) },
+	[RESET_GPU3D_PA]	= { CMU_DEVRST0, BIT(22) },
+	[RESET_IMX]		= { CMU_DEVRST0, BIT(23) },
+	[RESET_SE]		= { CMU_DEVRST0, BIT(24) },
+	[RESET_NANDC1]		= { CMU_DEVRST0, BIT(25) },
+	[RESET_SD3]		= { CMU_DEVRST0, BIT(26) },
+	[RESET_GIC]		= { CMU_DEVRST0, BIT(27) },
+	[RESET_GPU3D_PB]	= { CMU_DEVRST0, BIT(28) },
+	[RESET_DDR_CTL_PHY_AXI]	= { CMU_DEVRST0, BIT(29) },
+	[RESET_CMU_DDR]		= { CMU_DEVRST0, BIT(30) },
+	[RESET_DMM]		= { CMU_DEVRST0, BIT(31) },
+	[RESET_USB2HUB]		= { CMU_DEVRST1, BIT(0) },
+	[RESET_USB2HSIC]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_HDMI]		= { CMU_DEVRST1, BIT(2) },
+	[RESET_HDCP2TX]		= { CMU_DEVRST1, BIT(3) },
+	[RESET_UART6]		= { CMU_DEVRST1, BIT(4) },
+	[RESET_UART0]		= { CMU_DEVRST1, BIT(5) },
+	[RESET_UART1]		= { CMU_DEVRST1, BIT(6) },
+	[RESET_UART2]		= { CMU_DEVRST1, BIT(7) },
+	[RESET_SPI0]		= { CMU_DEVRST1, BIT(8) },
+	[RESET_SPI1]		= { CMU_DEVRST1, BIT(9) },
+	[RESET_SPI2]		= { CMU_DEVRST1, BIT(10) },
+	[RESET_SPI3]		= { CMU_DEVRST1, BIT(11) },
+	[RESET_I2C0]		= { CMU_DEVRST1, BIT(12) },
+	[RESET_I2C1]		= { CMU_DEVRST1, BIT(13) },
+	[RESET_USB3]		= { CMU_DEVRST1, BIT(14) },
+	[RESET_UART3]		= { CMU_DEVRST1, BIT(15) },
+	[RESET_UART4]		= { CMU_DEVRST1, BIT(16) },
+	[RESET_UART5]		= { CMU_DEVRST1, BIT(17) },
+	[RESET_I2C2]		= { CMU_DEVRST1, BIT(18) },
+	[RESET_I2C3]		= { CMU_DEVRST1, BIT(19) },
+	[RESET_ETHERNET]	= { CMU_DEVRST1, BIT(20) },
+	[RESET_CHIPID]		= { CMU_DEVRST1, BIT(21) },
+	[RESET_I2C4]		= { CMU_DEVRST1, BIT(22) },
+	[RESET_I2C5]		= { CMU_DEVRST1, BIT(23) },
+	[RESET_CPU_SCNT]	= { CMU_DEVRST1, BIT(30) }
+};
+
 static struct owl_clk_desc s900_clk_desc = {
 	.clks	    = s900_clks,
 	.num_clks   = ARRAY_SIZE(s900_clks),
 
 	.hw_clks    = &s900_hw_clks,
+
+	.resets     = s900_resets,
+	.num_resets = ARRAY_SIZE(s900_resets),
 };
 
 static int s900_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s900_clk_desc;
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
