From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 11 May 2014 22:21:49 +0200
Subject: [PATCH v3 1/4] ARM: Kirkwood: Add board file for netxbig LEDs
In-Reply-To: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
References: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399839712-2416-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently no DT binding for the CPLD which controls the LEDs
on the Net 2Big and Net 5Big. So use a platform device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/Kconfig         |   7 ++
 arch/arm/mach-mvebu/Makefile        |   1 +
 arch/arm/mach-mvebu/board-netxbig.c | 191 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/board.h         |   5 +
 arch/arm/mach-mvebu/kirkwood.c      |   3 +
 5 files changed, 207 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/board-netxbig.c

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index d6b0a772a6dd..0f9a700d3b50 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -104,6 +104,13 @@ config MACH_KIRKWOOD
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Kirkwood device tree.
 
+config MACH_NETXBIG
+	bool "LaCie 2Big and 5Big Network v2"
+	depends on MACH_KIRKWOOD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie 2Big and 5Big Network v2
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2ecb828e4a8b..15580e48069a 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -14,3 +14,4 @@ endif
 
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
+obj-$(CONFIG_MACH_NETXBIG)	 += board-netxbig.o
diff --git a/arch/arm/mach-mvebu/board-netxbig.c b/arch/arm/mach-mvebu/board-netxbig.c
new file mode 100644
index 000000000000..e6f2f547b1c7
--- /dev/null
+++ b/arch/arm/mach-mvebu/board-netxbig.c
@@ -0,0 +1,191 @@
+/*
+ * arch/arm/mach-mvbu/board-netxbig.c
+ *
+ * LaCie 2Big and 5Big Network v2 board setup
+ *
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/leds-kirkwood-netxbig.h>
+#include "common.h"
+
+/*****************************************************************************
+ * GPIO extension LEDs
+ ****************************************************************************/
+
+/*
+ * The LEDs are controlled by a CPLD and can be configured through a GPIO
+ * extension bus:
+ *
+ * - address register : bit [0-2] -> GPIO [47-49]
+ * - data register    : bit [0-2] -> GPIO [44-46]
+ * - enable register  : GPIO 29
+ */
+
+static int netxbig_v2_gpio_ext_addr[] = { 47, 48, 49 };
+static int netxbig_v2_gpio_ext_data[] = { 44, 45, 46 };
+
+static struct netxbig_gpio_ext netxbig_v2_gpio_ext = {
+	.addr		= netxbig_v2_gpio_ext_addr,
+	.num_addr	= ARRAY_SIZE(netxbig_v2_gpio_ext_addr),
+	.data		= netxbig_v2_gpio_ext_data,
+	.num_data	= ARRAY_SIZE(netxbig_v2_gpio_ext_data),
+	.enable		= 29,
+};
+
+/*
+ * Address register selection:
+ *
+ * addr | register
+ * ----------------------------
+ *   0  | front LED
+ *   1  | front LED brightness
+ *   2  | SATA LED brightness
+ *   3  | SATA0 LED
+ *   4  | SATA1 LED
+ *   5  | SATA2 LED
+ *   6  | SATA3 LED
+ *   7  | SATA4 LED
+ *
+ * Data register configuration:
+ *
+ * data | LED brightness
+ * -------------------------------------------------
+ *   0  | min (off)
+ *   -  | -
+ *   7  | max
+ *
+ * data | front LED mode
+ * -------------------------------------------------
+ *   0  | fix off
+ *   1  | fix blue on
+ *   2  | fix red on
+ *   3  | blink blue on=1 sec and blue off=1 sec
+ *   4  | blink red on=1 sec and red off=1 sec
+ *   5  | blink blue on=2.5 sec and red on=0.5 sec
+ *   6  | blink blue on=1 sec and red on=1 sec
+ *   7  | blink blue on=0.5 sec and blue off=2.5 sec
+ *
+ * data | SATA LED mode
+ * -------------------------------------------------
+ *   0  | fix off
+ *   1  | SATA activity blink
+ *   2  | fix red on
+ *   3  | blink blue on=1 sec and blue off=1 sec
+ *   4  | blink red on=1 sec and red off=1 sec
+ *   5  | blink blue on=2.5 sec and red on=0.5 sec
+ *   6  | blink blue on=1 sec and red on=1 sec
+ *   7  | fix blue on
+ */
+
+static int netxbig_v2_red_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 2,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 4,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static int netxbig_v2_blue_pwr_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 1,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= 7,
+};
+
+static int netxbig_v2_blue_sata_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 7,
+	[NETXBIG_LED_SATA]	= 1,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static struct netxbig_led_timer netxbig_v2_led_timer[] = {
+	[0] = {
+		.delay_on	= 500,
+		.delay_off	= 500,
+		.mode		= NETXBIG_LED_TIMER1,
+	},
+	[1] = {
+		.delay_on	= 500,
+		.delay_off	= 1000,
+		.mode		= NETXBIG_LED_TIMER2,
+	},
+};
+
+#define NETXBIG_LED(_name, maddr, mval, baddr)			\
+	{ .name		= _name,				\
+	  .mode_addr	= maddr,				\
+	  .mode_val	= mval,					\
+	  .bright_addr	= baddr }
+
+static struct netxbig_led net2big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net2big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net2big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net2big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net2big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net2big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net2big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net2big_v2_leds_ctrl),
+};
+
+static struct netxbig_led net5big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net5big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net5big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net5big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata2", 5, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata2",  5, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata3", 6, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata3",  6, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata4", 7, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata5",  7, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net5big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net5big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net5big_v2_leds_ctrl),
+};
+
+static struct platform_device netxbig_v2_leds = {
+	.name		= "leds-netxbig",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &net2big_v2_leds_data,
+	},
+};
+
+void __init netxbig_init(void)
+{
+
+	if (of_machine_is_compatible("lacie,net5big"))
+		netxbig_v2_leds.dev.platform_data = &net5big_v2_leds_data;
+	platform_device_register(&netxbig_v2_leds);
+}
diff --git a/arch/arm/mach-mvebu/board.h b/arch/arm/mach-mvebu/board.h
index 9c7bb4386f8b..98e32cc2ef3d 100644
--- a/arch/arm/mach-mvebu/board.h
+++ b/arch/arm/mach-mvebu/board.h
@@ -13,4 +13,9 @@
 #ifndef __ARCH_MVEBU_BOARD_H
 #define __ARCH_MVEBU_BOARD_H
 
+#ifdef CONFIG_MACH_NETXBIG
+void netxbig_init(void);
+#else
+static inline void netxbig_init(void) {};
+#endif
 #endif
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 46f105913c84..6b5310828eb2 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -180,6 +180,9 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
+	if (of_machine_is_compatible("lacie,netxbig"))
+		netxbig_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
 }
 
-- 
2.0.0.rc2
