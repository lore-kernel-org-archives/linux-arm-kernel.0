From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 31 Dec 2015 17:17:26 +0000
Subject: [RFC PATCH] drivers: pinctrl: add driver for Allwinner A64 SoC
Message-ID: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the Allwinner A64 user manual and on the previous sunxi
pinctrl drivers this introduces the pin multiplex assignments for
the ARMv8 Allwinner A64 SoC.
Port A is apparently used for the fixed function DRAM controller, so
the ports start at B here (the manual mentions "n from 1 to 7", so
not starting at 0).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

---
Hi,

this work is based on an Allwinner A64 manual that was sent to me via
email by the pine64.com guys. I am not sure about the status of the
manual linked on the linux-sunxi wiki, though, but I am trying to
clarify this.
As I am not really knowledgable about the details of the pinctrl
subsystem, please correct me in case there are any stupidities in
this drop. I couldn't make out all the mappings between Allwinner's
peripherals naming and the corresponding Linux lingo, so if someone
with more experience in this could have a look it would be much
appreciated.
Due to the lack of hardware at the moment this is only compile-tested
(for arm and arm64).

Cheers,
Andre.

 arch/arm64/Kconfig.platforms        |   6 +
 drivers/pinctrl/sunxi/Kconfig       |   4 +
 drivers/pinctrl/sunxi/Makefile      |   1 +
 drivers/pinctrl/sunxi/pinctrl-a64.c | 606 ++++++++++++++++++++++++++++++++++++
 4 files changed, 617 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-a64.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4043c35..4dbec84 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,11 @@
 menu "Platform selection"
 
+config ARCH_SUNXI
+	bool "Allwinner sunxi 64-bit SoC Family"
+	select PINCTRL_A64
+	help
+	  This enables support for Allwinner sunxi based SoCs like the A64.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	help
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index e68fd95..ac47b5d 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -55,4 +55,8 @@ config PINCTRL_SUN9I_A80
 	def_bool MACH_SUN9I
 	select PINCTRL_SUNXI_COMMON
 
+config PINCTRL_A64
+	bool
+	select PINCTRL_SUNXI_COMMON
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index e080290..130e7bc 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
+obj-$(CONFIG_PINCTRL_A64)		+= pinctrl-a64.o
 obj-$(CONFIG_PINCTRL_SUN8I_A83T)	+= pinctrl-sun8i-a83t.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-a64.c b/drivers/pinctrl/sunxi/pinctrl-a64.c
new file mode 100644
index 0000000..00746d0
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-a64.c
@@ -0,0 +1,606 @@
+/*
+ * Allwinner A64 SoCs pinctrl driver.
+ *
+ * Copyright (C) 2016 - ARM Ltd.
+ * Author: Andre Przywara <andre.przywara@arm.com>
+ *
+ * Based on pinctrl-sun7i-a20.c, which is:
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
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin a64_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS0 */
+		  SUNXI_FUNCTION_IRQ(0x6, 0)),		/* EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK0 */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* VCCEN */
+		  SUNXI_FUNCTION_IRQ(0x6, 1)),		/* EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO0 */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPEN */
+		  SUNXI_FUNCTION_IRQ(0x6, 2)),		/* EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2s0"),		/* MCLK */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI0 */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* VPPPP */
+		  SUNXI_FUNCTION_IRQ(0x6, 3)),		/* EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif2"),		/* SYNC */
+		  SUNXI_FUNCTION(0x3, "ac97"),		/* SYNC */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ(0x6, 4)),		/* EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif2"),		/* BCLK */
+		  SUNXI_FUNCTION(0x3, "ac97"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* DATA */
+		  SUNXI_FUNCTION_IRQ(0x6, 5)),		/* EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif2"),		/* DOUT */
+		  SUNXI_FUNCTION(0x3, "ac97"),		/* DOUT */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* RST */
+		  SUNXI_FUNCTION_IRQ(0x6, 6)),		/* EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif2"),		/* DIN */
+		  SUNXI_FUNCTION(0x3, "ac97"),		/* DIN */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* DET */
+		  SUNXI_FUNCTION_IRQ(0x6, 7)),		/* EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x4, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ(0x6, 8)),		/* EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x4, "uart0"),		/* RX */
+		  SUNXI_FUNCTION_IRQ(0x6, 9)),		/* EINT9 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NWE */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NALE */
+		  SUNXI_FUNCTION(0x3, "mmc2"),		/* DS */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCLE */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* SCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE1 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* NCE0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NRE# */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NRB0 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* CMD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0")),	/* NRB1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ0 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ1 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ2 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ3 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ4 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ5 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ6 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQ7 */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* NDQS */
+		  SUNXI_FUNCTION(0x3, "mmc2")),		/* RST */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* DE */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
+		  SUNXI_FUNCTION(0x3, "uart4"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* HSYNC */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
+		  SUNXI_FUNCTION(0x3, "uart4"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* VSYNC */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
+		  SUNXI_FUNCTION(0x3, "uart4"),		/* RTS */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
+		  SUNXI_FUNCTION(0x3, "uart4"),		/* CTS */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
+		  SUNXI_FUNCTION(0x4, "emac"),		/* ERXD3 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
+		  SUNXI_FUNCTION(0x4, "emac"),		/* ERXD2 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ERXD1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ERXD0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP0 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ERXCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN0 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ERXCTL */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP1 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ENULL */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN1 */
+		  SUNXI_FUNCTION(0x4, "emac"),		/* ETXD3 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP2 */
+		  SUNXI_FUNCTION(0x4, "emac"),		/* ETXD2 */
+		  SUNXI_FUNCTION(0x5, "ccir")),		/* D7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN2 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ETXD1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VPC */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ETXD0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VNC */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ETXCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP3 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ETXCTL */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN3 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* ECLKIN */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "emac")),		/* EMDC */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x4, "emac")),		/* EMDIO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* PCK */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* CK */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* ERR */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* SYNC */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* DVLD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D4 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D5 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D6 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0"),		/* D7 */
+		  SUNXI_FUNCTION(0x4, "ts0")),		/* D7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0")),		/* SCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi0")),		/* SDA */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "pll"),		/* LOCK_DBG */
+		  SUNXI_FUNCTION(0x3, "i2c2")),		/* SCK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "i2c2")),		/* SDA */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x3, "jtag")),		/* MSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x3, "jtag")),		/* DI1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "uart0")),	/* TX */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x3, "jtag")),		/* DO1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "uart0")),	/* RX */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "jtag")),		/* CK1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ(0x6, 0)),		/* EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CMD */
+		  SUNXI_FUNCTION_IRQ(0x6, 1)),		/* EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D0 */
+		  SUNXI_FUNCTION_IRQ(0x6, 2)),		/* EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D1 */
+		  SUNXI_FUNCTION_IRQ(0x6, 3)),		/* EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D2 */
+		  SUNXI_FUNCTION_IRQ(0x6, 4)),		/* EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D3 */
+		  SUNXI_FUNCTION_IRQ(0x6, 5)),		/* EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
+		  SUNXI_FUNCTION_IRQ(0x6, 6)),		/* EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
+		  SUNXI_FUNCTION_IRQ(0x6, 7)),		/* EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION_IRQ(0x6, 8)),		/* EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION_IRQ(0x6, 9)),		/* EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif3"),		/* SYNC */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* SYNC */
+		  SUNXI_FUNCTION_IRQ(0x6, 10)),		/* EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif3"),		/* BCLK */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ(0x6, 11)),		/* EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif3"),		/* DOUT */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* DOUT */
+		  SUNXI_FUNCTION_IRQ(0x6, 12)),		/* EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "aif3"),		/* DIN */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* DIN */
+		  SUNXI_FUNCTION_IRQ(0x6, 13)),		/* EINT13 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ(0x6, 0)),		/* EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ(0x6, 1)),		/* EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ(0x6, 2)),		/* EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ(0x6, 3)),		/* EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION_IRQ(0x6, 4)),		/* EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION_IRQ(0x6, 5)),		/* EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION_IRQ(0x6, 6)),		/* EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION_IRQ(0x6, 7)),		/* EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "owa"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ(0x6, 8)),		/* EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ(0x6, 9)),		/* EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mic"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ(0x6, 10)),		/* EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mic"),		/* DATA */
+		  SUNXI_FUNCTION_IRQ(0x6, 11)),		/* EINT11 */
+};
+
+static const struct sunxi_pinctrl_desc a64_pinctrl_data = {
+	.pins = a64_pins,
+	.npins = ARRAY_SIZE(a64_pins),
+	.irq_banks = 1,
+};
+
+static int a64_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &a64_pinctrl_data);
+}
+
+static const struct of_device_id a64_pinctrl_match[] = {
+	{ .compatible = "allwinner,a64-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, a64_pinctrl_match);
+
+static struct platform_driver a64_pinctrl_driver = {
+	.probe	= a64_pinctrl_probe,
+	.driver	= {
+		.name		= "a64-pinctrl",
+		.of_match_table	= a64_pinctrl_match,
+	},
+};
+module_platform_driver(a64_pinctrl_driver);
+
+MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
+MODULE_DESCRIPTION("Allwinner A64 pinctrl driver");
+MODULE_LICENSE("GPL");
-- 
1.8.4
