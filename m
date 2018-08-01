From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:13 +0530
Subject: [PATCH v2 08/10] reset: Add Actions Semi S900 SoC Reset Management
 Unit support
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-9-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Management Unit (RMU) support for Actions Semi S900 SoC
of the Owl family series. RMU belongs to the Owl SoCs system-controller
which also includes CMU (Clock Management Unit).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/Kconfig     |   6 ++
 drivers/reset/Makefile    |   1 +
 drivers/reset/reset-owl.c | 192 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/reset/reset-owl.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c0b292be1b72..90627430569b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -73,6 +73,12 @@ config RESET_MESON
 	help
 	  This enables the reset driver for Amlogic Meson SoCs.
 
+config RESET_OWL
+	bool "Actions Semi Owl SoCs Reset Driver" if COMPILE_TEST
+	default ARCH_ACTIONS
+	help
+	  This enables the reset controller driver for Actions Semi Owl SoCs.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index c1261dcfe9ad..fa655319cf17 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_OWL) += reset-owl.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
diff --git a/drivers/reset/reset-owl.c b/drivers/reset/reset-owl.c
new file mode 100644
index 000000000000..c4f07691fb36
--- /dev/null
+++ b/drivers/reset/reset-owl.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/reset/actions,s900-rmu.h>
+
+#define CMU_DEVRST0 0x00a8
+#define CMU_DEVRST1 0x00ac
+
+struct owl_reset_map {
+	u32	reg;
+	u32	bit;
+};
+
+struct owl_reset_hw {
+	const struct owl_reset_map *resets;
+	u32 num_resets;
+};
+
+struct owl_reset {
+	struct reset_controller_dev	rcdev;
+	const struct owl_reset_hw	*hw;
+	struct regmap			*regmap;
+};
+
+static const struct owl_reset_map s900_resets[] = {
+	[S900_RESET_DMAC]		= { CMU_DEVRST0, BIT(0) },
+	[S900_RESET_SRAMI]		= { CMU_DEVRST0, BIT(1) },
+	[S900_RESET_DDR_CTL_PHY]	= { CMU_DEVRST0, BIT(2) },
+	[S900_RESET_NANDC0]		= { CMU_DEVRST0, BIT(3) },
+	[S900_RESET_SD0]		= { CMU_DEVRST0, BIT(4) },
+	[S900_RESET_SD1]		= { CMU_DEVRST0, BIT(5) },
+	[S900_RESET_PCM1]		= { CMU_DEVRST0, BIT(6) },
+	[S900_RESET_DE]			= { CMU_DEVRST0, BIT(7) },
+	[S900_RESET_LVDS]		= { CMU_DEVRST0, BIT(8) },
+	[S900_RESET_SD2]		= { CMU_DEVRST0, BIT(9) },
+	[S900_RESET_DSI]		= { CMU_DEVRST0, BIT(10) },
+	[S900_RESET_CSI0]		= { CMU_DEVRST0, BIT(11) },
+	[S900_RESET_BISP_AXI]		= { CMU_DEVRST0, BIT(12) },
+	[S900_RESET_CSI1]		= { CMU_DEVRST0, BIT(13) },
+	[S900_RESET_GPIO]		= { CMU_DEVRST0, BIT(15) },
+	[S900_RESET_EDP]		= { CMU_DEVRST0, BIT(16) },
+	[S900_RESET_AUDIO]		= { CMU_DEVRST0, BIT(17) },
+	[S900_RESET_PCM0]		= { CMU_DEVRST0, BIT(18) },
+	[S900_RESET_HDE]		= { CMU_DEVRST0, BIT(21) },
+	[S900_RESET_GPU3D_PA]		= { CMU_DEVRST0, BIT(22) },
+	[S900_RESET_IMX]		= { CMU_DEVRST0, BIT(23) },
+	[S900_RESET_SE]			= { CMU_DEVRST0, BIT(24) },
+	[S900_RESET_NANDC1]		= { CMU_DEVRST0, BIT(25) },
+	[S900_RESET_SD3]		= { CMU_DEVRST0, BIT(26) },
+	[S900_RESET_GIC]		= { CMU_DEVRST0, BIT(27) },
+	[S900_RESET_GPU3D_PB]		= { CMU_DEVRST0, BIT(28) },
+	[S900_RESET_DDR_CTL_PHY_AXI]	= { CMU_DEVRST0, BIT(29) },
+	[S900_RESET_CMU_DDR]		= { CMU_DEVRST0, BIT(30) },
+	[S900_RESET_DMM]		= { CMU_DEVRST0, BIT(31) },
+	[S900_RESET_USB2HUB]		= { CMU_DEVRST1, BIT(0) },
+	[S900_RESET_USB2HSIC]		= { CMU_DEVRST1, BIT(1) },
+	[S900_RESET_HDMI]		= { CMU_DEVRST1, BIT(2) },
+	[S900_RESET_HDCP2TX]		= { CMU_DEVRST1, BIT(3) },
+	[S900_RESET_UART6]		= { CMU_DEVRST1, BIT(4) },
+	[S900_RESET_UART0]		= { CMU_DEVRST1, BIT(5) },
+	[S900_RESET_UART1]		= { CMU_DEVRST1, BIT(6) },
+	[S900_RESET_UART2]		= { CMU_DEVRST1, BIT(7) },
+	[S900_RESET_SPI0]		= { CMU_DEVRST1, BIT(8) },
+	[S900_RESET_SPI1]		= { CMU_DEVRST1, BIT(9) },
+	[S900_RESET_SPI2]		= { CMU_DEVRST1, BIT(10) },
+	[S900_RESET_SPI3]		= { CMU_DEVRST1, BIT(11) },
+	[S900_RESET_I2C0]		= { CMU_DEVRST1, BIT(12) },
+	[S900_RESET_I2C1]		= { CMU_DEVRST1, BIT(13) },
+	[S900_RESET_USB3]		= { CMU_DEVRST1, BIT(14) },
+	[S900_RESET_UART3]		= { CMU_DEVRST1, BIT(15) },
+	[S900_RESET_UART4]		= { CMU_DEVRST1, BIT(16) },
+	[S900_RESET_UART5]		= { CMU_DEVRST1, BIT(17) },
+	[S900_RESET_I2C2]		= { CMU_DEVRST1, BIT(18) },
+	[S900_RESET_I2C3]		= { CMU_DEVRST1, BIT(19) },
+};
+
+static const struct owl_reset_hw s900_reset_hw = {
+	.resets = s900_resets,
+	.num_resets = ARRAY_SIZE(s900_resets),
+};
+
+static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct owl_reset, rcdev);
+}
+
+static int owl_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->hw->resets[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, 0);
+}
+
+static int owl_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->hw->resets[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, map->bit);
+}
+
+static int owl_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	owl_reset_assert(rcdev, id);
+	udelay(1);
+	owl_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
+static int owl_reset_status(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->hw->resets[id];
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(reset->regmap, map->reg, &reg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The reset control API expects 0 if reset is not asserted,
+	 * which is the opposite of what our hardware uses.
+	 */
+	return !(map->bit & reg);
+}
+
+static const struct reset_control_ops owl_reset_ops = {
+	.assert         = owl_reset_assert,
+	.deassert       = owl_reset_deassert,
+	.reset          = owl_reset_reset,
+	.status         = owl_reset_status,
+};
+
+static int owl_reset_probe(struct platform_device *pdev)
+{
+	struct owl_reset *reset;
+	struct regmap *regmap;
+	const struct owl_reset_hw *hw;
+
+	hw = of_device_get_match_data(&pdev->dev);
+	if (!hw)
+		return -EINVAL;
+
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	regmap = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "failed to get regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.ops = &owl_reset_ops;
+	reset->rcdev.nr_resets = hw->num_resets;
+	reset->hw = hw;
+	reset->regmap = regmap;
+
+	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+}
+
+static const struct of_device_id owl_reset_of_match[] = {
+	{ .compatible = "actions,s900-rmu", .data = &s900_reset_hw },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver owl_reset_driver = {
+	.probe = owl_reset_probe,
+	.driver = {
+		.name = "owl-reset",
+		.of_match_table = owl_reset_of_match,
+	},
+};
+builtin_platform_driver(owl_reset_driver);
-- 
2.17.1
