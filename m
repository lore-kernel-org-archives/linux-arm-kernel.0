From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:04 +0100
Subject: [PATCH 01/17] ARM: at91: merge at91rm9200 files
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

There is only one board file for the rm9200 soc file left, so
it makes sense to merge the two files into one, which allows
us further cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile          |  1 -
 arch/arm/mach-at91/at91rm9200.c      | 50 ++++++++++++++++++++++++++++-----
 arch/arm/mach-at91/board-dt-rm9200.c | 54 ------------------------------------
 3 files changed, 43 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-dt-rm9200.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 8ef7d9a2e855..d89c2437ef10 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_SOC_SAMA5D3)	+= sama5d3.o
 obj-$(CONFIG_SOC_SAMA5D4)	+= sama5d4.o
 
 # AT91SAM board with device-tree
-obj-$(CONFIG_SOC_AT91RM9200) += board-dt-rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9) += board-dt-sam9.o
 
 # SAMA5 board with device-tree
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 3be1963f5c56..eaa30b1fea01 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -1,20 +1,30 @@
 /*
- * arch/arm/mach-at91/at91rm9200.c
+ *  Setup code for AT91RM9200
  *
  *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2011 Atmel,
+ *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *                2012 Joachim Eastwood <manabian@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
+ * Licensed under GPLv2 or later.
  */
-
+#include <linux/types.h>
+#include <linux/init.h>
 #include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 #include <linux/clk/at91_pmc.h>
 
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
+
 #include <mach/at91_st.h>
 #include <mach/hardware.h>
 
@@ -44,3 +54,29 @@ static void __init at91rm9200_initialize(void)
 AT91_SOC_START(at91rm9200)
 	.init = at91rm9200_initialize,
 AT91_SOC_END
+
+static void __init at91rm9200_dt_timer_init(void)
+{
+	of_clk_init(NULL);
+	at91rm9200_timer_init();
+}
+
+static void __init rm9200_dt_device_init(void)
+{
+	at91_rm9200_pm_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *at91rm9200_dt_board_compat[] __initdata = {
+	"atmel,at91rm9200",
+	NULL
+};
+
+DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
+	.init_time      = at91rm9200_dt_timer_init,
+	.map_io		= at91_map_io,
+	.init_early	= at91_dt_initialize,
+	.init_machine	= rm9200_dt_device_init,
+	.dt_compat	= at91rm9200_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
deleted file mode 100644
index 5f82a65153e1..000000000000
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *  Setup code for AT91RM9200 Evaluation Kits with Device Tree support
- *
- *  Copyright (C) 2011 Atmel,
- *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
- *                2012 Joachim Eastwood <manabian@gmail.com>
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/clk-provider.h>
-
-#include <asm/setup.h>
-#include <asm/irq.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include "generic.h"
-
-static void __init at91rm9200_dt_timer_init(void)
-{
-	of_clk_init(NULL);
-	at91rm9200_timer_init();
-}
-
-static void __init rm9200_dt_device_init(void)
-{
-	at91_rm9200_pm_init();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-
-
-static const char *at91rm9200_dt_board_compat[] __initdata = {
-	"atmel,at91rm9200",
-	NULL
-};
-
-DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
-	.init_time      = at91rm9200_dt_timer_init,
-	.map_io		= at91_map_io,
-	.init_early	= at91_dt_initialize,
-	.init_machine	= rm9200_dt_device_init,
-	.dt_compat	= at91rm9200_dt_board_compat,
-MACHINE_END
-- 
2.1.0
