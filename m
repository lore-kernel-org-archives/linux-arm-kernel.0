From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  3 Jun 2017 22:44:26 +0800
Subject: [PATCH 2/3] pinctrl: sunxi: Add support for A83T R_PIO
In-Reply-To: <20170603144427.22855-1-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
Message-ID: <20170603144427.22855-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_PIO on the A83T is almost the same as the one found on the A64,
except that the CIR_RX function was moved from pin PL11 to pin PL12.

Add a driver for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/Kconfig                |   4 +
 drivers/pinctrl/sunxi/Makefile               |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c | 128 +++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 624d84e6c936..31f85ca92669 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -35,6 +35,10 @@ config PINCTRL_SUN8I_A83T
 	def_bool MACH_SUN8I
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN8I_A83T_R
+	def_bool MACH_SUN8I
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN8I_A23_R
 	def_bool MACH_SUN8I
 	depends on RESET_CONTROLLER
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index efe1e64ef4f1..dc6c9619e41c 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
 obj-$(CONFIG_PINCTRL_SUN50I_A64)	+= pinctrl-sun50i-a64.o
 obj-$(CONFIG_PINCTRL_SUN50I_A64_R)	+= pinctrl-sun50i-a64-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_A83T)	+= pinctrl-sun8i-a83t.o
+obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
new file mode 100644
index 000000000000..6531cf67958e
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
@@ -0,0 +1,128 @@
+/*
+ * Allwinner A83T SoCs special pins pinctrl driver.
+ *
+ * Copyright (C) 2017 Chen-Yu Tsai
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on pinctrl-sun50i-a64-r.c
+ *
+ * Copyright (C) 2016 Icenowy Zheng
+ * Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Copyright (C) 2014 Chen-Yu Tsai
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Copyright (C) 2014 Boris Brezillon
+ * Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * Copyright (C) 2014 Maxime Ripard
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun8i_a83t_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SDA */
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
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
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
+		  SUNXI_FUNCTION(0x2, "s_cir_rx"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PL_EINT12 */
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
+	return sunxi_pinctrl_init(pdev,
+				  &sun8i_a83t_r_pinctrl_data);
+}
+
+static const struct of_device_id sun8i_a83t_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun8i-a83t-r-pinctrl", },
+	{}
+};
+
+static struct platform_driver sun8i_a83t_r_pinctrl_driver = {
+	.probe	= sun8i_a83t_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun8i-a83t-r-pinctrl",
+		.of_match_table	= sun8i_a83t_r_pinctrl_match,
+	},
+};
+builtin_platform_driver(sun8i_a83t_r_pinctrl_driver);
-- 
2.11.0
