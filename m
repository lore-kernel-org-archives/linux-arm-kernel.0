From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:53 +0200 (CEST)
Subject: [PATCH 5/10] LPC32XX: 005-clock.1: Allows clock input other than
 13MHz for lpc32xx
Message-ID: <mailman.21.1366231489.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cedric Berger <cedric@precidata.com>
---
The lpc32xx platform is currently compiled for a fixed 13MHz main clock
input. Unfortunately, our board use a different (12MHz) main clock.
This patch replace the #define by a variable, which can be overriden by
plaform specific code.

Index: arch/arm/mach-lpc32xx/timer.c
===================================================================
--- arch/arm/mach-lpc32xx/timer.c	(revision 1690)
+++ arch/arm/mach-lpc32xx/timer.c	(revision 1691)
@@ -31,6 +31,8 @@
 #include <mach/platform.h>
 #include "common.h"
 
+int lpc32xx_main_osc_freq = LPC32XX_MAIN_OSC_FREQ_DEFAULT;
+
 static int lpc32xx_clkevt_next_event(unsigned long delta,
     struct clock_event_device *dev)
 {
@@ -115,7 +117,7 @@
 	 * timer rates. This rate is needed to compute the tick rate.
 	 */
 	if (clk_is_sysclk_mainosc() != 0)
-		clkrate = LPC32XX_MAIN_OSC_FREQ;
+		clkrate = lpc32xx_main_osc_freq;
 	else
 		clkrate = 397 * LPC32XX_CLOCK_OSC_FREQ;
 
Index: arch/arm/mach-lpc32xx/include/mach/platform.h
===================================================================
--- arch/arm/mach-lpc32xx/include/mach/platform.h	(revision 1690)
+++ arch/arm/mach-lpc32xx/include/mach/platform.h	(revision 1691)
@@ -121,7 +121,7 @@
 /*
  * Clock and crystal information
  */
-#define LPC32XX_MAIN_OSC_FREQ			13000000
+#define LPC32XX_MAIN_OSC_FREQ_DEFAULT		13000000
 #define LPC32XX_CLOCK_OSC_FREQ			32768
 
 /*
Index: arch/arm/mach-lpc32xx/include/mach/board.h
===================================================================
--- arch/arm/mach-lpc32xx/include/mach/board.h	(revision 1690)
+++ arch/arm/mach-lpc32xx/include/mach/board.h	(revision 1691)
@@ -21,4 +21,7 @@
 
 extern u32 lpc32xx_return_iram_size(void);
 
+/* main oscillator frequency, 13MHz (default) or board-specific */
+extern int lpc32xx_main_osc_freq;
+
 #endif  /* __ASM_ARCH_BOARD_H */
Index: arch/arm/mach-lpc32xx/clock.c
===================================================================
--- arch/arm/mach-lpc32xx/clock.c	(revision 1690)
+++ arch/arm/mach-lpc32xx/clock.c	(revision 1691)
@@ -196,8 +196,8 @@
 
 static struct clk osc_main = {
 	.enable		= local_oscmain_enable,
-	.rate		= LPC32XX_MAIN_OSC_FREQ,
 	.get_rate	= local_return_parent_rate,
+	/* .rate is set in clk_init() */
 };
 
 static struct clk clk_sys;
@@ -1240,6 +1240,8 @@
 {
 	int i;
 
+	osc_main.rate = lpc32xx_main_osc_freq;
+
 	for (i = 0; i < ARRAY_SIZE(lookups); i++)
 		clkdev_add(&lookups[i]);
 
Index: drivers/tty/serial/lpc32xx_hs.c
===================================================================
--- drivers/tty/serial/lpc32xx_hs.c	(revision 1690)
+++ drivers/tty/serial/lpc32xx_hs.c	(revision 1691)
@@ -34,6 +34,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <mach/board.h>
 #include <mach/platform.h>
 #include <mach/hardware.h>
 
@@ -705,7 +706,7 @@
 	}
 
 	p->port.iotype = UPIO_MEM32;
-	p->port.uartclk = LPC32XX_MAIN_OSC_FREQ;
+	p->port.uartclk = lpc32xx_main_osc_freq;
 	p->port.regshift = 2;
 	p->port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_IOREMAP;
 	p->port.dev = &pdev->dev;
