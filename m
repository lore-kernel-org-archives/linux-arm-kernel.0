From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 12 May 2017 20:38:05 +0800
Subject: [PATCH 4/5] pinctrl: imx: add imx7ulp driver
In-Reply-To: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494592686-30967-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.

This patch adds the IOMUXC1 support for A7.
It only supports generic pin config.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pinctrl/freescale/Kconfig           |   7 +
 drivers/pinctrl/freescale/Makefile          |   1 +
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c | 358 ++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx7ulp.c

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 0b266b2..4dbc576 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -103,6 +103,13 @@ config PINCTRL_IMX7D
 	help
 	  Say Y here to enable the imx7d pinctrl driver
 
+config PINCTRL_IMX7ULP
+	bool "IMX7ULP pinctrl driver"
+	depends on SOC_IMX7ULP
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx7ulp pinctrl driver
+
 config PINCTRL_VF610
 	bool "Freescale Vybrid VF610 pinctrl driver"
 	depends on SOC_VF610
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index d44c9e2..525a5ff 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PINCTRL_IMX6SL)	+= pinctrl-imx6sl.o
 obj-$(CONFIG_PINCTRL_IMX6SX)	+= pinctrl-imx6sx.o
 obj-$(CONFIG_PINCTRL_IMX6UL)	+= pinctrl-imx6ul.o
 obj-$(CONFIG_PINCTRL_IMX7D)	+= pinctrl-imx7d.o
+obj-$(CONFIG_PINCTRL_IMX7ULP)	+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_VF610)	+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
new file mode 100644
index 0000000..dead416
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -0,0 +1,358 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2017 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-imx.h"
+
+enum imx7ulp_pads {
+	ULP1_PAD_PTC0 = 0,
+	ULP1_PAD_PTC1,
+	ULP1_PAD_PTC2,
+	ULP1_PAD_PTC3,
+	ULP1_PAD_PTC4,
+	ULP1_PAD_PTC5,
+	ULP1_PAD_PTC6,
+	ULP1_PAD_PTC7,
+	ULP1_PAD_PTC8,
+	ULP1_PAD_PTC9,
+	ULP1_PAD_PTC10,
+	ULP1_PAD_PTC11,
+	ULP1_PAD_PTC12,
+	ULP1_PAD_PTC13,
+	ULP1_PAD_PTC14,
+	ULP1_PAD_PTC15,
+	ULP1_PAD_PTC16,
+	ULP1_PAD_PTC17,
+	ULP1_PAD_PTC18,
+	ULP1_PAD_PTC19,
+	ULP1_PAD_RESERVE0,
+	ULP1_PAD_RESERVE1,
+	ULP1_PAD_RESERVE2,
+	ULP1_PAD_RESERVE3,
+	ULP1_PAD_RESERVE4,
+	ULP1_PAD_RESERVE5,
+	ULP1_PAD_RESERVE6,
+	ULP1_PAD_RESERVE7,
+	ULP1_PAD_RESERVE8,
+	ULP1_PAD_RESERVE9,
+	ULP1_PAD_RESERVE10,
+	ULP1_PAD_RESERVE11,
+	ULP1_PAD_PTD0,
+	ULP1_PAD_PTD1,
+	ULP1_PAD_PTD2,
+	ULP1_PAD_PTD3,
+	ULP1_PAD_PTD4,
+	ULP1_PAD_PTD5,
+	ULP1_PAD_PTD6,
+	ULP1_PAD_PTD7,
+	ULP1_PAD_PTD8,
+	ULP1_PAD_PTD9,
+	ULP1_PAD_PTD10,
+	ULP1_PAD_PTD11,
+	ULP1_PAD_RESERVE12,
+	ULP1_PAD_RESERVE13,
+	ULP1_PAD_RESERVE14,
+	ULP1_PAD_RESERVE15,
+	ULP1_PAD_RESERVE16,
+	ULP1_PAD_RESERVE17,
+	ULP1_PAD_RESERVE18,
+	ULP1_PAD_RESERVE19,
+	ULP1_PAD_RESERVE20,
+	ULP1_PAD_RESERVE21,
+	ULP1_PAD_RESERVE22,
+	ULP1_PAD_RESERVE23,
+	ULP1_PAD_RESERVE24,
+	ULP1_PAD_RESERVE25,
+	ULP1_PAD_RESERVE26,
+	ULP1_PAD_RESERVE27,
+	ULP1_PAD_RESERVE28,
+	ULP1_PAD_RESERVE29,
+	ULP1_PAD_RESERVE30,
+	ULP1_PAD_RESERVE31,
+	ULP1_PAD_PTE0,
+	ULP1_PAD_PTE1,
+	ULP1_PAD_PTE2,
+	ULP1_PAD_PTE3,
+	ULP1_PAD_PTE4,
+	ULP1_PAD_PTE5,
+	ULP1_PAD_PTE6,
+	ULP1_PAD_PTE7,
+	ULP1_PAD_PTE8,
+	ULP1_PAD_PTE9,
+	ULP1_PAD_PTE10,
+	ULP1_PAD_PTE11,
+	ULP1_PAD_PTE12,
+	ULP1_PAD_PTE13,
+	ULP1_PAD_PTE14,
+	ULP1_PAD_PTE15,
+	ULP1_PAD_RESERVE32,
+	ULP1_PAD_RESERVE33,
+	ULP1_PAD_RESERVE34,
+	ULP1_PAD_RESERVE35,
+	ULP1_PAD_RESERVE36,
+	ULP1_PAD_RESERVE37,
+	ULP1_PAD_RESERVE38,
+	ULP1_PAD_RESERVE39,
+	ULP1_PAD_RESERVE40,
+	ULP1_PAD_RESERVE41,
+	ULP1_PAD_RESERVE42,
+	ULP1_PAD_RESERVE43,
+	ULP1_PAD_RESERVE44,
+	ULP1_PAD_RESERVE45,
+	ULP1_PAD_RESERVE46,
+	ULP1_PAD_RESERVE47,
+	ULP1_PAD_PTF0,
+	ULP1_PAD_PTF1,
+	ULP1_PAD_PTF2,
+	ULP1_PAD_PTF3,
+	ULP1_PAD_PTF4,
+	ULP1_PAD_PTF5,
+	ULP1_PAD_PTF6,
+	ULP1_PAD_PTF7,
+	ULP1_PAD_PTF8,
+	ULP1_PAD_PTF9,
+	ULP1_PAD_PTF10,
+	ULP1_PAD_PTF11,
+	ULP1_PAD_PTF12,
+	ULP1_PAD_PTF13,
+	ULP1_PAD_PTF14,
+	ULP1_PAD_PTF15,
+	ULP1_PAD_PTF16,
+	ULP1_PAD_PTF17,
+	ULP1_PAD_PTF18,
+	ULP1_PAD_PTF19,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc imx7ulp_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC0),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC1),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC2),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC3),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC4),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC5),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC6),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC7),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC8),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC9),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC10),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC11),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC12),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC13),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC14),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC15),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC16),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC17),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC18),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTC19),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE0),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE1),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE2),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE3),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE4),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE5),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE6),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE7),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE8),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE9),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE10),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE11),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD0),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD1),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD2),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD3),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD4),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD5),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD6),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD7),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD8),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD9),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD10),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTD11),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE12),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE13),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE14),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE15),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE16),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE17),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE18),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE19),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE20),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE21),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE22),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE23),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE24),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE25),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE26),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE27),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE28),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE29),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE30),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE31),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE0),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE1),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE2),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE3),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE4),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE5),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE6),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE7),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE8),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE9),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE10),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE11),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE12),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE13),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE14),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTE15),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE32),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE33),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE34),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE35),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE36),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE37),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE38),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE39),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE40),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE41),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE42),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE43),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE44),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE45),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE46),
+	IMX_PINCTRL_PIN(ULP1_PAD_RESERVE47),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF0),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF1),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF2),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF3),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF4),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF5),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF6),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF7),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF8),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF9),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF10),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF11),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF12),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF13),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF14),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF15),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF16),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF17),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF18),
+	IMX_PINCTRL_PIN(ULP1_PAD_PTF19),
+};
+
+#define BM_LK_ENABLED		BIT(15)
+#define BM_PULL_ENABLED		BIT(1)
+
+enum imx7ulp_pinconf_param {
+	PIN_CONFIG_NXP_OUTPUT_BUFFER_ENABLE = PIN_CONFIG_END + 1,
+	PIN_CONFIG_NXP_INPUT_BUFFER_ENABLE,
+};
+
+static const struct pinconf_generic_params imx7ulp_cfg_params[] = {
+	{
+		.property = "nxp,output-buffer-enable",
+		.param = PIN_CONFIG_NXP_OUTPUT_BUFFER_ENABLE,
+		.default_value = 1,
+	}, {
+		.property = "nxp,input-buffer-enable",
+		.param = PIN_CONFIG_NXP_INPUT_BUFFER_ENABLE,
+		.default_value = 1,
+	},
+};
+
+struct imx_cfg_params_decode imx7ulp_cfg_decodes[] = {
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_NXP_OUTPUT_BUFFER_ENABLE,	BIT(17), 17),
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_NXP_INPUT_BUFFER_ENABLE,	BIT(16), 16),
+
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_STRENGTH, 		BIT(6), 6),
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_DRIVE_PUSH_PULL,		BIT(5), 5),
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_SLEW_RATE,			BIT(2), 2),
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_BIAS_DISABLE,			BIT(1), 1),
+	IMX_CFG_PARAMS_DECODE(PIN_CONFIG_BIAS_PULL_UP,			BIT(0), 0),
+
+	IMX_CFG_PARAMS_DECODE_INVERT(PIN_CONFIG_DRIVE_OPEN_DRAIN,	BIT(5), 5),
+	IMX_CFG_PARAMS_DECODE_INVERT(PIN_CONFIG_BIAS_PULL_DOWN,		BIT(0), 0),
+};
+
+static void imx7ulp_cfg_params_fixup(unsigned long *configs,
+				    unsigned int num_configs,
+				    u32 *raw_config)
+{
+	enum pin_config_param param;
+	u32 param_val;
+	int i;
+
+	/* lock field disabled */
+	*raw_config &= ~BM_LK_ENABLED;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		param_val = pinconf_to_config_argument(configs[i]);
+
+		if ((param == PIN_CONFIG_BIAS_PULL_UP) ||
+		    (param == PIN_CONFIG_BIAS_PULL_DOWN)) {
+			/* pull enabled */
+			*raw_config |= BM_PULL_ENABLED;
+
+			return;
+		}
+	}
+}
+
+static struct imx_pinctrl_soc_info imx7ulp_pinctrl_info = {
+	.pins = imx7ulp_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx7ulp_pinctrl_pads),
+	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
+	.mux_mask = 0xf00,
+	.mux_shift = 8,
+	.generic_pinconf = true,
+	.custom_params = imx7ulp_cfg_params,
+	.num_custom_params = ARRAY_SIZE(imx7ulp_cfg_params),
+	.decodes = imx7ulp_cfg_decodes,
+	.num_decodes = ARRAY_SIZE(imx7ulp_cfg_decodes),
+	.fixup = imx7ulp_cfg_params_fixup,
+};
+
+static const struct of_device_id imx7ulp_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imx7ulp-iomuxc1", },
+	{ /* sentinel */ }
+};
+
+static int imx7ulp_pinctrl_probe(struct platform_device *pdev)
+{
+	return imx_pinctrl_probe(pdev, &imx7ulp_pinctrl_info);
+}
+
+static struct platform_driver imx7ulp_pinctrl_driver = {
+	.driver = {
+		.name = "imx7ulp-pinctrl",
+		.of_match_table = of_match_ptr(imx7ulp_pinctrl_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = imx7ulp_pinctrl_probe,
+};
+
+static int __init imx7ulp_pinctrl_init(void)
+{
+	return platform_driver_register(&imx7ulp_pinctrl_driver);
+}
+arch_initcall(imx7ulp_pinctrl_init);
-- 
2.7.4
