From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sat,  5 Mar 2016 23:42:54 +0800
Subject: [PATCH v3 01/13] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1457192586-25596-2-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has R_PIO pin controller, it's same as A23, execpt A83T
interrupt bit is 6th and A83T has one extra pin PL12.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 drivers/pinctrl/sunxi/Kconfig                      |   5 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       | 119 +++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 9213b27..f9ff10b 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -20,6 +20,7 @@ Required properties:
   "allwinner,sun9i-a80-pinctrl"
   "allwinner,sun9i-a80-r-pinctrl"
   "allwinner,sun8i-a83t-pinctrl"
+  "allwinner,sun8i-a83t-r-pinctrl"
   "allwinner,sun8i-h3-pinctrl"
 
 - reg: Should contain the register physical address and length for the
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index f8dbc8b..eeab50b 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -51,6 +51,11 @@ config PINCTRL_SUN8I_A23_R
 	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI_COMMON
 
+config PINCTRL_SUN8I_A83T_R
+	def_bool MACH_SUN8I
+	depends on RESET_CONTROLLER
+	select PINCTRL_SUNXI_COMMON
+
 config PINCTRL_SUN8I_H3
 	def_bool MACH_SUN8I
 	select PINCTRL_SUNXI_COMMON
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index ef82f22..bfd4fa0 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
 obj-$(CONFIG_PINCTRL_SUN8I_A83T)	+= pinctrl-sun8i-a83t.o
+obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
new file mode 100644
index 0000000..11787894
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
@@ -0,0 +1,119 @@
+/*
+ * Allwinner A83T SoCs special pins pinctrl driver.
+ *
+ * Copyright (C) 2016 Vishnu Patekar
+ * Vishnu Patekar <vishnupatekar0510@gmail.com>
+ *
+ * Based on pinctrl-sun8i-a23.c, which is:
+ * Copyright (C) 2014 Chen-Yu Tsai <wens@csie.org>
+ * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun8i_a83t_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "s_twi"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_twi"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PL_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PL_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PL_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_jtag"),	/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PL_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_jtag"),	/* CK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PL_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_jtag"),	/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PL_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_jtag"),	/* DI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PL_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PL_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_pwm"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PL_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PL_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_cir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PL_EINT12 */
+};
+
+static const struct sunxi_pinctrl_desc sun8i_a83t_r_pinctrl_data = {
+	.pins = sun8i_a83t_r_pins,
+	.npins = ARRAY_SIZE(sun8i_a83t_r_pins),
+	.pin_base = PL_BASE,
+	.irq_banks = 1,
+};
+
+static int sun8i_a83t_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev, &sun8i_a83t_r_pinctrl_data);
+}
+
+static const struct of_device_id sun8i_a83t_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun8i-a83t-r-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun8i_a83t_r_pinctrl_match);
+
+static struct platform_driver sun8i_a83t_r_pinctrl_driver = {
+	.probe	= sun8i_a83t_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun8i-a83t-r-pinctrl",
+		.of_match_table	= sun8i_a83t_r_pinctrl_match,
+	},
+};
+module_platform_driver(sun8i_a83t_r_pinctrl_driver);
-- 
1.9.1
