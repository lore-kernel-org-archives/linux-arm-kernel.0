From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:35:06 +0200
Subject: [PATCH 4/7] ARM: nomadik: convert to generic clock
Message-ID: <1339018506-29126-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove more custom stuff by simply converting the Nomadik machine
to use generic clocks and move the driver to drivers/clk.

Cc: Mike Turquette <mturquette@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                          |    2 +-
 arch/arm/mach-nomadik/Makefile            |    2 -
 arch/arm/mach-nomadik/clock.c             |   75 -----------------------------
 arch/arm/mach-nomadik/clock.h             |   15 ------
 arch/arm/mach-nomadik/cpu-8815.c          |    4 +-
 drivers/clk/Makefile                      |    1 +
 drivers/clk/clk-nomadik.c                 |   47 ++++++++++++++++++
 include/linux/platform_data/clk-nomadik.h |    2 +
 8 files changed, 53 insertions(+), 95 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/clock.c
 delete mode 100644 arch/arm/mach-nomadik/clock.h
 create mode 100644 drivers/clk/clk-nomadik.c
 create mode 100644 include/linux/platform_data/clk-nomadik.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b649c59..e58bda6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -912,7 +912,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CPU_ARM926T
-	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select PINCTRL
 	select MIGHT_HAVE_CACHE_L2X0
diff --git a/arch/arm/mach-nomadik/Makefile b/arch/arm/mach-nomadik/Makefile
index a6bbd1a..a42c9a3 100644
--- a/arch/arm/mach-nomadik/Makefile
+++ b/arch/arm/mach-nomadik/Makefile
@@ -7,8 +7,6 @@
 
 # Object file lists.
 
-obj-y			+= clock.o
-
 # Cpu revision
 obj-$(CONFIG_NOMADIK_8815) += cpu-8815.o
 
diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
deleted file mode 100644
index 48a59f2..0000000
--- a/arch/arm/mach-nomadik/clock.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- *  linux/arch/arm/mach-nomadik/clock.c
- *
- *  Copyright (C) 2009 Alessandro Rubini
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include "clock.h"
-
-/*
- * The nomadik board uses generic clocks, but the serial pl011 file
- * calls clk_enable(), clk_disable(), clk_get_rate(), so we provide them
- */
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-/* enable and disable do nothing */
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-static struct clk clk_24 = {
-	.rate = 2400000,
-};
-
-static struct clk clk_48 = {
-	.rate = 48 * 1000 * 1000,
-};
-
-/*
- * Catch-all default clock to satisfy drivers using the clk API.  We don't
- * model the actual hardware clocks yet.
- */
-static struct clk clk_default;
-
-#define CLK(_clk, dev)				\
-	{					\
-		.clk		= _clk,		\
-		.dev_id		= dev,		\
-	}
-
-static struct clk_lookup lookups[] = {
-	{
-		.con_id		= "apb_pclk",
-		.clk		= &clk_default,
-	},
-	CLK(&clk_24, "mtu0"),
-	CLK(&clk_24, "mtu1"),
-	CLK(&clk_48, "uart0"),
-	CLK(&clk_48, "uart1"),
-	CLK(&clk_default, "gpio.0"),
-	CLK(&clk_default, "gpio.1"),
-	CLK(&clk_default, "gpio.2"),
-	CLK(&clk_default, "gpio.3"),
-	CLK(&clk_default, "rng"),
-};
-
-int __init clk_init(void)
-{
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-	return 0;
-}
diff --git a/arch/arm/mach-nomadik/clock.h b/arch/arm/mach-nomadik/clock.h
deleted file mode 100644
index 78da2e7..0000000
--- a/arch/arm/mach-nomadik/clock.h
+++ /dev/null
@@ -1,15 +0,0 @@
-
-/*
- *  linux/arch/arm/mach-nomadik/clock.h
- *
- *  Copyright (C) 2009 Alessandro Rubini
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-struct clk {
-	unsigned long		rate;
-};
-
-int __init clk_init(void);
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 88511fe..6fd8e46 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_data/clk-nomadik.h>
 
 #include <plat/gpio-nomadik.h>
 #include <mach/hardware.h>
@@ -35,7 +36,6 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include "clock.h"
 #include "cpu-8815.h"
 
 /* The 8815 has 4 GPIO blocks, let's register them immediately */
@@ -123,7 +123,7 @@ void __init cpu8815_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
-	clk_init();
+	nomadik_clk_init();
 }
 
 /*
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b9a5158..26b6b92 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 				   clk-mux.o clk-divider.o clk-fixed-factor.o
 # SoCs specific
+obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
new file mode 100644
index 0000000..517a8ff
--- /dev/null
+++ b/drivers/clk/clk-nomadik.c
@@ -0,0 +1,47 @@
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+
+/*
+ * The Nomadik clock tree is described in the STN8815A12 DB V4.2
+ * reference manual for the chip, page 94 ff.
+ */
+
+void __init nomadik_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
+	clk_register_clkdev(clk, "apb_pclk", NULL);
+	clk_register_clkdev(clk, NULL, "gpio.0");
+	clk_register_clkdev(clk, NULL, "gpio.1");
+	clk_register_clkdev(clk, NULL, "gpio.2");
+	clk_register_clkdev(clk, NULL, "gpio.3");
+	clk_register_clkdev(clk, NULL, "rng");
+
+	/*
+	 * The 2.4 MHz TIMCLK reference clock is active at boot time, this is
+	 * actually the MXTALCLK @19.2 MHz divided by 8. This clock is used
+	 * by the timers and watchdog. See page 105 ff.
+	 */
+	clk = clk_register_fixed_rate(NULL, "TIMCLK", NULL, CLK_IS_ROOT,
+				      2400000);
+	clk_register_clkdev(clk, NULL, "mtu0");
+	clk_register_clkdev(clk, NULL, "mtu1");
+
+	/*
+	 * At boot time, PLL2 is set to generate a set of fixed clocks,
+	 * one of them is CLK48, the 48 MHz clock, routed to the UART, MMC/SD
+	 * I2C, IrDA, USB and SSP blocks.
+	 */
+	clk = clk_register_fixed_rate(NULL, "CLK48", NULL, CLK_IS_ROOT,
+				      48000000);
+	clk_register_clkdev(clk, NULL, "uart0");
+	clk_register_clkdev(clk, NULL, "uart1");
+	clk_register_clkdev(clk, NULL, "mmci");
+	clk_register_clkdev(clk, NULL, "ssp");
+	clk_register_clkdev(clk, NULL, "nmk-i2c.0");
+	clk_register_clkdev(clk, NULL, "nmk-i2c.1");
+}
diff --git a/include/linux/platform_data/clk-nomadik.h b/include/linux/platform_data/clk-nomadik.h
new file mode 100644
index 0000000..5713c87
--- /dev/null
+++ b/include/linux/platform_data/clk-nomadik.h
@@ -0,0 +1,2 @@
+/* Minimal platform data header */
+void nomadik_clk_init(void);
-- 
1.7.7.6
