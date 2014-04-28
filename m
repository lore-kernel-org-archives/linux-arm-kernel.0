From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:37 -0700
Subject: [PATCH 11/15] pinctrl: sunxi: Move Allwinner A31 special pins driver
 to a driver of its own
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-12-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pin description to a driver specific to be. This is one more step
toward retiring pinctrl-sunxi-pins.h that used to define all the pins for all
the Allwinner SoCs in a single header, that would have in turn result in having
these structures in the final binary as many times as the header was included.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/Makefile              |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 122 ++++++++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi-pins.h  |  74 -----------------
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       |   1 -
 4 files changed, 123 insertions(+), 75 deletions(-)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c

diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index d51890c5d34d..df22956ea680 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun4i-a10.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun5i-a10s.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun5i-a13.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun6i-a31.o
+obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun6i-a31-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
new file mode 100644
index 000000000000..b896f7ba606e
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -0,0 +1,122 @@
+/*
+ * Allwinner A31 SoCs special pins pinctrl driver.
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun6i_a31_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "s_p2wi")),	/* SCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_p2wi")),	/* SDA */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart")),	/* TX */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart")),	/* RX */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir")),		/* RX */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* MS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* CK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DI */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "1wire")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "rtc")),		/* CLKO */
+};
+
+static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
+	.pins = sun6i_a31_r_pins,
+	.npins = ARRAY_SIZE(sun6i_a31_r_pins),
+	.pin_base = PL_BASE,
+};
+
+static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &sun6i_a31_r_pinctrl_data);
+}
+
+static struct of_device_id sun6i_a31_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun6i-a31-r-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun6i_a31_r_pinctrl_match);
+
+static struct platform_driver sun6i_a31_r_pinctrl_driver = {
+	.probe	= sun6i_a31_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun6i-a31-r-pinctrl",
+		.owner		= THIS_MODULE,
+		.of_match_table	= sun6i_a31_r_pinctrl_match,
+	},
+};
+module_platform_driver(sun6i_a31_r_pinctrl_driver);
+
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon at free-electrons.com");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
+MODULE_DESCRIPTION("Allwinner A31 R_PIO pinctrl driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-pins.h b/drivers/pinctrl/sunxi/pinctrl-sunxi-pins.h
index 403f9c50ab99..13ec0172145b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi-pins.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-pins.h
@@ -15,74 +15,6 @@
 
 #include "pinctrl-sunxi.h"
 
-static const struct sunxi_desc_pin sun6i_a31_r_pins[] = {
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SCK */
-		  SUNXI_FUNCTION(0x3, "s_p2wi")),	/* SCK */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SDA */
-		  SUNXI_FUNCTION(0x3, "s_p2wi")),	/* SDA */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "s_uart")),	/* TX */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "s_uart")),	/* RX */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "s_ir")),		/* RX */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* MS */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* CK */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DO */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "s_jtag")),	/* DI */
-	/* Hole */
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "1wire")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
-	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
-		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "rtc")),		/* CLKO */
-};
-
 static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -1098,12 +1030,6 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x4, "hdmi")),		/* HSDA */
 };
 
-static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
-	.pins = sun6i_a31_r_pins,
-	.npins = ARRAY_SIZE(sun6i_a31_r_pins),
-	.pin_base = PL_BASE,
-};
-
 static const struct sunxi_pinctrl_desc sun7i_a20_pinctrl_data = {
 	.pins = sun7i_a20_pins,
 	.npins = ARRAY_SIZE(sun7i_a20_pins),
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 07e5bae93dda..c2bd108ba3b5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -674,7 +674,6 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 }
 
 static struct of_device_id sunxi_pinctrl_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-r-pinctrl", .data = (void *)&sun6i_a31_r_pinctrl_data },
 	{ .compatible = "allwinner,sun7i-a20-pinctrl", .data = (void *)&sun7i_a20_pinctrl_data },
 	{}
 };
-- 
1.9.1
