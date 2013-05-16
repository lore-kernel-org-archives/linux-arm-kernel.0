From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 16 May 2013 14:20:23 +0800
Subject: [PATCH v3 1/2] pinctrl: add MVF600 pinctrl driver
Message-ID: <1368685224-17915-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds Freescale Vybrid Family MVF600 pin controller
driver to IMX iomuxc common driver framework.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
v3:
  clean up code.
  update binding document according recommendation.

 .../bindings/pinctrl/fsl,mvf600-pinctrl.txt        |  41 +++
 drivers/pinctrl/Kconfig                            |   8 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-mvf600.c                   | 338 +++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-mvf600.c

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
new file mode 100644
index 0000000..a4d04d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
@@ -0,0 +1,41 @@
+Freescale Vybrid IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,mvf600-iomuxc"
+- fsl,pins: two integers array, represents a group of pins mux and config
+  setting. The format is fsl,pins = < PIN_FUNC_ID >, PIN_FUNC_ID is a pin
+  working on a specific function, CONFIG is the pad setting value such as
+  pull-up, speed, ode for this pin. Please refer to Vybrid MVF600 datasheet
+  for the valid pad config settings.
+
+CONFIG bits definition:
+PAD_CTL_SPEED_LOW		(1 << 12)
+PAD_CTL_SPEED_MED		(2 << 12)
+PAD_CTL_SPEED_HIGH		(3 << 12)
+PAD_CTL_SRE_FAST		(1 << 11)
+PAD_CTL_SRE_SLOW		(0 << 11)
+PAD_CTL_ODE			(1 << 10)
+PAD_CTL_HYS			(1 << 9)
+PAD_CTL_DSE_DISABLE		(0 << 6)
+PAD_CTL_DSE_150ohm		(1 << 6)
+PAD_CTL_DSE_75ohm		(2 << 6)
+PAD_CTL_DSE_50ohm		(3 << 6)
+PAD_CTL_DSE_37ohm		(4 << 6)
+PAD_CTL_DSE_30ohm		(5 << 6)
+PAD_CTL_DSE_25ohm		(6 << 6)
+PAD_CTL_DSE_20ohm		(7 << 6)
+PAD_CTL_PUS_100K_DOWN		(0 << 4)
+PAD_CTL_PUS_47K_UP		(1 << 4)
+PAD_CTL_PUS_100K_UP		(2 << 4)
+PAD_CTL_PUS_22K_UP		(3 << 4)
+PAD_CTL_PKE			(1 << 3)
+PAD_CTL_PUE			(1 << 2)
+PAD_CTL_OBE_ENABLE		(1 << 1)
+PAD_CTL_IBE_ENABLE		(1 << 0)
+PAD_CTL_OBE_IBE_ENABLE		(3 << 0)
+
+Please refer to mvf600-pinfunc.h in device tree source folder
+for all available PIN_FUNC_ID for Vybrid.
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8f66924..5cb3987 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -108,6 +108,14 @@ config PINCTRL_IMX6SL
 	help
 	  Say Y here to enable the imx6sl pinctrl driver
 
+config PINCTRL_MVF600
+	bool "Freescale Vybrid MVF600 pinctrl driver"
+	depends on OF
+	depends on SOC_MVF600
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the Freescale Vybrid MVF600 pinctrl driver
+
 config PINCTRL_LANTIQ
 	bool
 	depends on LANTIQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 34c4ae6..dfec292 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_PINCTRL_EXYNOS5440)	+= pinctrl-exynos5440.o
 obj-$(CONFIG_PINCTRL_S3C64XX)	+= pinctrl-s3c64xx.o
 obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
 obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
+obj-$(CONFIG_PINCTRL_MVF600)	+= pinctrl-mvf600.o
 
 obj-$(CONFIG_PLAT_ORION)        += mvebu/
 obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
diff --git a/drivers/pinctrl/pinctrl-mvf600.c b/drivers/pinctrl/pinctrl-mvf600.c
new file mode 100644
index 0000000..6e2bcc0
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mvf600.c
@@ -0,0 +1,338 @@
+/*
+ * MVF600 pinctrl driver based on imx pinmux and pinconf core
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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
+enum mvf600_pads {
+	MVF600_PAD_PTA6 = 0,
+	MVF600_PAD_PTA8 = 1,
+	MVF600_PAD_PTA9 = 2,
+	MVF600_PAD_PTA10 = 3,
+	MVF600_PAD_PTA11 = 4,
+	MVF600_PAD_PTA12 = 5,
+	MVF600_PAD_PTA16 = 6,
+	MVF600_PAD_PTA17 = 7,
+	MVF600_PAD_PTA18 = 8,
+	MVF600_PAD_PTA19 = 9,
+	MVF600_PAD_PTA20 = 10,
+	MVF600_PAD_PTA21 = 11,
+	MVF600_PAD_PTA22 = 12,
+	MVF600_PAD_PTA23 = 13,
+	MVF600_PAD_PTA24 = 14,
+	MVF600_PAD_PTA25 = 15,
+	MVF600_PAD_PTA26 = 16,
+	MVF600_PAD_PTA27 = 17,
+	MVF600_PAD_PTA28 = 18,
+	MVF600_PAD_PTA29 = 19,
+	MVF600_PAD_PTA30 = 20,
+	MVF600_PAD_PTA31 = 21,
+	MVF600_PAD_PTB0 = 22,
+	MVF600_PAD_PTB1 = 23,
+	MVF600_PAD_PTB2 = 24,
+	MVF600_PAD_PTB3 = 25,
+	MVF600_PAD_PTB4 = 26,
+	MVF600_PAD_PTB5 = 27,
+	MVF600_PAD_PTB6 = 28,
+	MVF600_PAD_PTB7 = 29,
+	MVF600_PAD_PTB8 = 30,
+	MVF600_PAD_PTB9 = 31,
+	MVF600_PAD_PTB10 = 32,
+	MVF600_PAD_PTB11 = 33,
+	MVF600_PAD_PTB12 = 34,
+	MVF600_PAD_PTB13 = 35,
+	MVF600_PAD_PTB14 = 36,
+	MVF600_PAD_PTB15 = 37,
+	MVF600_PAD_PTB16 = 38,
+	MVF600_PAD_PTB17 = 39,
+	MVF600_PAD_PTB18 = 40,
+	MVF600_PAD_PTB19 = 41,
+	MVF600_PAD_PTB20 = 42,
+	MVF600_PAD_PTB21 = 43,
+	MVF600_PAD_PTB22 = 44,
+	MVF600_PAD_PTC0 = 45,
+	MVF600_PAD_PTC1 = 46,
+	MVF600_PAD_PTC2 = 47,
+	MVF600_PAD_PTC3 = 48,
+	MVF600_PAD_PTC4 = 49,
+	MVF600_PAD_PTC5 = 50,
+	MVF600_PAD_PTC6 = 51,
+	MVF600_PAD_PTC7 = 52,
+	MVF600_PAD_PTC8 = 53,
+	MVF600_PAD_PTC9 = 54,
+	MVF600_PAD_PTC10 = 55,
+	MVF600_PAD_PTC11 = 56,
+	MVF600_PAD_PTC12 = 57,
+	MVF600_PAD_PTC13 = 58,
+	MVF600_PAD_PTC14 = 59,
+	MVF600_PAD_PTC15 = 60,
+	MVF600_PAD_PTC16 = 61,
+	MVF600_PAD_PTC17 = 62,
+	MVF600_PAD_PTD31 = 63,
+	MVF600_PAD_PTD30 = 64,
+	MVF600_PAD_PTD29 = 65,
+	MVF600_PAD_PTD28 = 66,
+	MVF600_PAD_PTD27 = 67,
+	MVF600_PAD_PTD26 = 68,
+	MVF600_PAD_PTD25 = 69,
+	MVF600_PAD_PTD24 = 70,
+	MVF600_PAD_PTD23 = 71,
+	MVF600_PAD_PTD22 = 72,
+	MVF600_PAD_PTD21 = 73,
+	MVF600_PAD_PTD20 = 74,
+	MVF600_PAD_PTD19 = 75,
+	MVF600_PAD_PTD18 = 76,
+	MVF600_PAD_PTD17 = 77,
+	MVF600_PAD_PTD16 = 78,
+	MVF600_PAD_PTD0 = 79,
+	MVF600_PAD_PTD1 = 80,
+	MVF600_PAD_PTD2 = 81,
+	MVF600_PAD_PTD3 = 82,
+	MVF600_PAD_PTD4 = 83,
+	MVF600_PAD_PTD5 = 84,
+	MVF600_PAD_PTD6 = 85,
+	MVF600_PAD_PTD7 = 86,
+	MVF600_PAD_PTD8 = 87,
+	MVF600_PAD_PTD9 = 88,
+	MVF600_PAD_PTD10 = 89,
+	MVF600_PAD_PTD11 = 90,
+	MVF600_PAD_PTD12 = 91,
+	MVF600_PAD_PTD13 = 92,
+	MVF600_PAD_PTB23 = 93,
+	MVF600_PAD_PTB24 = 94,
+	MVF600_PAD_PTB25 = 95,
+	MVF600_PAD_PTB26 = 96,
+	MVF600_PAD_PTB27 = 97,
+	MVF600_PAD_PTB28 = 98,
+	MVF600_PAD_PTC26 = 99,
+	MVF600_PAD_PTC27 = 100,
+	MVF600_PAD_PTC28 = 101,
+	MVF600_PAD_PTC29 = 102,
+	MVF600_PAD_PTC30 = 103,
+	MVF600_PAD_PTC31 = 104,
+	MVF600_PAD_PTE0 = 105,
+	MVF600_PAD_PTE1 = 106,
+	MVF600_PAD_PTE2 = 107,
+	MVF600_PAD_PTE3 = 108,
+	MVF600_PAD_PTE4 = 109,
+	MVF600_PAD_PTE5 = 110,
+	MVF600_PAD_PTE6 = 111,
+	MVF600_PAD_PTE7 = 112,
+	MVF600_PAD_PTE8 = 113,
+	MVF600_PAD_PTE9 = 114,
+	MVF600_PAD_PTE10 = 115,
+	MVF600_PAD_PTE11 = 116,
+	MVF600_PAD_PTE12 = 117,
+	MVF600_PAD_PTE13 = 118,
+	MVF600_PAD_PTE14 = 119,
+	MVF600_PAD_PTE15 = 120,
+	MVF600_PAD_PTE16 = 121,
+	MVF600_PAD_PTE17 = 122,
+	MVF600_PAD_PTE18 = 123,
+	MVF600_PAD_PTE19 = 124,
+	MVF600_PAD_PTE20 = 125,
+	MVF600_PAD_PTE21 = 126,
+	MVF600_PAD_PTE22 = 127,
+	MVF600_PAD_PTE23 = 128,
+	MVF600_PAD_PTE24 = 129,
+	MVF600_PAD_PTE25 = 130,
+	MVF600_PAD_PTE26 = 131,
+	MVF600_PAD_PTE27 = 132,
+	MVF600_PAD_PTE28 = 133,
+	MVF600_PAD_PTA7 = 134,
+	};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc mvf600_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA6),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA8),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA9),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA10),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA11),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA12),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA16),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA17),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA18),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA19),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA20),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA21),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA22),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA23),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA24),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA25),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA26),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA27),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA28),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA29),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA30),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA31),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB0),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB1),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB2),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB3),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB4),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB5),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB6),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB7),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB8),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB9),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB10),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB11),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB12),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB13),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB14),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB15),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB16),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB17),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB18),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB19),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB20),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB21),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB22),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC0),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC1),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC2),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC3),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC4),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC5),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC6),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC7),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC8),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC9),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC10),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC11),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC12),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC13),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC14),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC15),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC16),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC17),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD31),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD30),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD29),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD28),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD27),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD26),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD25),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD24),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD23),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD22),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD21),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD20),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD19),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD18),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD17),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD16),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD0),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD1),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD2),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD3),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD4),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD5),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD6),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD7),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD8),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD9),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD10),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD11),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD12),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTD13),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB23),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB24),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB25),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB26),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB27),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTB28),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC26),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC27),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC28),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC29),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC30),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTC31),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE0),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE1),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE2),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE3),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE4),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE5),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE6),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE7),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE8),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE9),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE10),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE11),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE12),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE13),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE14),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE15),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE16),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE17),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE18),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE19),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE20),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE21),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE22),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE23),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE24),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE25),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE26),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE27),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTE28),
+	IMX_PINCTRL_PIN(MVF600_PAD_PTA7),
+};
+
+static struct imx_pinctrl_soc_info mvf600_pinctrl_info = {
+	.pins = mvf600_pinctrl_pads,
+	.npins = ARRAY_SIZE(mvf600_pinctrl_pads),
+	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
+};
+
+static struct of_device_id mvf600_pinctrl_of_match[] = {
+	{ .compatible = "fsl,mvf600-iomuxc", },
+	{ /* sentinel */ }
+};
+
+static int mvf600_pinctrl_probe(struct platform_device *pdev)
+{
+	return imx_pinctrl_probe(pdev, &mvf600_pinctrl_info);
+}
+
+static struct platform_driver mvf600_pinctrl_driver = {
+	.driver = {
+		.name = "mvf600-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mvf600_pinctrl_of_match),
+	},
+	.probe = mvf600_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+};
+
+static int __init mvf600_pinctrl_init(void)
+{
+	return platform_driver_register(&mvf600_pinctrl_driver);
+}
+arch_initcall(mvf600_pinctrl_init);
+
+static void __exit mvf600_pinctrl_exit(void)
+{
+	platform_driver_unregister(&mvf600_pinctrl_driver);
+}
+module_exit(mvf600_pinctrl_exit);
+
+MODULE_DESCRIPTION("Freescale MVF600 pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.0
