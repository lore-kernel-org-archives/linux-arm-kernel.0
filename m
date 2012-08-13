From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:58:00 +0200
Subject: [PATCH 4/7] ARM: u300: merge u300.c into core.c and rid headers
Message-ID: <1344859080-29408-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This gets rid of the separate u300.c file in mach-u300 since
it can just as well live right in core.c, then we also get
rid of the broadcasted <mach/platform.h> file that is not
helping anyone. Put the interface to the system timer into
a separate header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Makefile                |  1 -
 arch/arm/mach-u300/core.c                  | 22 +++++++++++++---
 arch/arm/mach-u300/include/mach/platform.h | 20 ---------------
 arch/arm/mach-u300/timer.c                 |  2 ++
 arch/arm/mach-u300/timer.h                 |  1 +
 arch/arm/mach-u300/u300.c                  | 41 ------------------------------
 6 files changed, 21 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/platform.h
 create mode 100644 arch/arm/mach-u300/timer.h
 delete mode 100644 arch/arm/mach-u300/u300.c

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 7e47d37..5a86c58 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -7,7 +7,6 @@ obj-m		:=
 obj-n		:=
 obj-		:=
 
-obj-$(CONFIG_ARCH_U300)	          += u300.o
 obj-$(CONFIG_SPI_PL022)           += spi.o
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
 obj-$(CONFIG_I2C_STU300)          += i2c.o
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 0158189..bc23391 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -39,12 +39,15 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
 
 #include <mach/coh901318.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
 #include <mach/dma_channels.h>
 
+#include "timer.h"
 #include "spi.h"
 #include "i2c.h"
 #include "u300-gpio.h"
@@ -76,7 +79,7 @@ static struct map_desc u300_io_desc[] __initdata = {
 	},
 };
 
-void __init u300_map_io(void)
+static void __init u300_map_io(void)
 {
 	iotable_init(u300_io_desc, ARRAY_SIZE(u300_io_desc));
 	/* We enable a real big DMA buffer if need be. */
@@ -1600,7 +1603,7 @@ static struct platform_device *platform_devs[] __initdata = {
  * together so some interrupts are connected to the first one and some
  * to the second one.
  */
-void __init u300_init_irq(void)
+static void __init u300_init_irq(void)
 {
 	u32 mask[2] = {0, 0};
 	struct clk *clk;
@@ -1742,7 +1745,7 @@ static void __init u300_assign_physmem(void)
 	}
 }
 
-void __init u300_init_devices(void)
+static void __init u300_init_machine(void)
 {
 	int i;
 	u16 val;
@@ -1783,7 +1786,7 @@ void __init u300_init_devices(void)
 /* Forward declare this function from the watchdog */
 void coh901327_watchdog_reset(void);
 
-void u300_restart(char mode, const char *cmd)
+static void u300_restart(char mode, const char *cmd)
 {
 	switch (mode) {
 	case 's':
@@ -1799,3 +1802,14 @@ void u300_restart(char mode, const char *cmd)
 	/* Wait for system do die/reset. */
 	while (1);
 }
+
+MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
+	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
+	.atag_offset	= 0x100,
+	.map_io		= u300_map_io,
+	.init_irq	= u300_init_irq,
+	.handle_irq	= vic_handle_irq,
+	.timer		= &u300_timer,
+	.init_machine	= u300_init_machine,
+	.restart	= u300_restart,
+MACHINE_END
diff --git a/arch/arm/mach-u300/include/mach/platform.h b/arch/arm/mach-u300/include/mach/platform.h
deleted file mode 100644
index 096333f..0000000
--- a/arch/arm/mach-u300/include/mach/platform.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/platform.h
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Basic platform init and mapping functions.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-#ifndef __ASSEMBLY__
-
-void u300_map_io(void);
-void u300_init_irq(void);
-void u300_init_devices(void);
-void u300_restart(char, const char *);
-extern struct sys_timer u300_timer;
-
-#endif
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 56ac06d..146e815 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -26,6 +26,8 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
+#include "timer.h"
+
 /*
  * APP side special timer registers
  * This timer contains four timers which can fire an interrupt each.
diff --git a/arch/arm/mach-u300/timer.h b/arch/arm/mach-u300/timer.h
new file mode 100644
index 0000000..b5e9791
--- /dev/null
+++ b/arch/arm/mach-u300/timer.h
@@ -0,0 +1 @@
+extern struct sys_timer u300_timer;
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
deleted file mode 100644
index 4e56e8c..0000000
--- a/arch/arm/mach-u300/u300.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/u300.c
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Platform machine definition.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/memblock.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-#include <asm/hardware/vic.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/memory.h>
-
-static void __init u300_init_machine(void)
-{
-	u300_init_devices();
-}
-
-MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
-	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
-	.atag_offset	= 0x100,
-	.map_io		= u300_map_io,
-	.init_irq	= u300_init_irq,
-	.handle_irq	= vic_handle_irq,
-	.timer		= &u300_timer,
-	.init_machine	= u300_init_machine,
-	.restart	= u300_restart,
-MACHINE_END
-- 
1.7.11.3
