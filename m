From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:14 +0530
Subject: [PATCH v2 09/10] reset: Add Actions Semi S700 SoC Reset Management
 Unit support
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-10-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Management Unit (RMU) support for Actions Semi S700 SoC
of the Owl family series. RMU belongs to the Owl SoCs system-controller
which also includes CMU (Clock Management Unit).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/reset-owl.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/reset/reset-owl.c b/drivers/reset/reset-owl.c
index c4f07691fb36..2e761c64f81b 100644
--- a/drivers/reset/reset-owl.c
+++ b/drivers/reset/reset-owl.c
@@ -12,6 +12,7 @@
 #include <linux/reset-controller.h>
 
 #include <dt-bindings/reset/actions,s900-rmu.h>
+#include <dt-bindings/reset/actions,s700-rmu.h>
 
 #define CMU_DEVRST0 0x00a8
 #define CMU_DEVRST1 0x00ac
@@ -84,11 +85,42 @@ static const struct owl_reset_map s900_resets[] = {
 	[S900_RESET_I2C3]		= { CMU_DEVRST1, BIT(19) },
 };
 
+static const struct owl_reset_map s700_resets[] = {
+	[S700_RESET_DE]      = { CMU_DEVRST0, BIT(0) },
+	[S700_RESET_LCD0]    = { CMU_DEVRST0, BIT(1) },
+	[S700_RESET_DSI]     = { CMU_DEVRST0, BIT(2) },
+	[S700_RESET_CSI]     = { CMU_DEVRST0, BIT(13) },
+	[S700_RESET_SI]      = { CMU_DEVRST0, BIT(14) },
+	[S700_RESET_I2C0]    = { CMU_DEVRST1, BIT(0) },
+	[S700_RESET_I2C1]    = { CMU_DEVRST1, BIT(1) },
+	[S700_RESET_I2C2]    = { CMU_DEVRST1, BIT(2) },
+	[S700_RESET_I2C3]    = { CMU_DEVRST1, BIT(3) },
+	[S700_RESET_SPI0]    = { CMU_DEVRST1, BIT(4) },
+	[S700_RESET_SPI1]    = { CMU_DEVRST1, BIT(5) },
+	[S700_RESET_SPI2]    = { CMU_DEVRST1, BIT(6) },
+	[S700_RESET_SPI3]    = { CMU_DEVRST1, BIT(7) },
+	[S700_RESET_UART0]   = { CMU_DEVRST1, BIT(8) },
+	[S700_RESET_UART1]   = { CMU_DEVRST1, BIT(9) },
+	[S700_RESET_UART2]   = { CMU_DEVRST1, BIT(10) },
+	[S700_RESET_UART3]   = { CMU_DEVRST1, BIT(11) },
+	[S700_RESET_UART4]   = { CMU_DEVRST1, BIT(12) },
+	[S700_RESET_UART5]   = { CMU_DEVRST1, BIT(13) },
+	[S700_RESET_UART6]   = { CMU_DEVRST1, BIT(14) },
+	[S700_RESET_KEY]     = { CMU_DEVRST1, BIT(24) },
+	[S700_RESET_GPIO]    = { CMU_DEVRST1, BIT(25) },
+	[S700_RESET_AUDIO]   = { CMU_DEVRST1, BIT(29) },
+};
+
 static const struct owl_reset_hw s900_reset_hw = {
 	.resets = s900_resets,
 	.num_resets = ARRAY_SIZE(s900_resets),
 };
 
+static const struct owl_reset_hw s700_reset_hw = {
+	.resets = s700_resets,
+	.num_resets = ARRAY_SIZE(s700_resets),
+};
+
 static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct owl_reset, rcdev);
@@ -179,6 +211,7 @@ static int owl_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id owl_reset_of_match[] = {
 	{ .compatible = "actions,s900-rmu", .data = &s900_reset_hw },
+	{ .compatible = "actions,s700-rmu", .data = &s700_reset_hw },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1
