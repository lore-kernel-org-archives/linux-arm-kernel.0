From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 18 Sep 2010 08:22:54 +0200
Subject: [PATCH] at91: drop at91x40 support
Message-ID: <1284790974-11143-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as it's broken for releases and no one care about it

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Ungerer <gerg@snapgear.com>
---
 arch/arm/mach-at91/Kconfig        |   20 ---------
 arch/arm/mach-at91/Makefile       |    4 --
 arch/arm/mach-at91/at91x40.c      |   83 -------------------------------------
 arch/arm/mach-at91/at91x40_time.c |   80 -----------------------------------
 arch/arm/mach-at91/board-eb01.c   |   44 -------------------
 5 files changed, 0 insertions(+), 231 deletions(-)
 delete mode 100644 arch/arm/mach-at91/at91x40.c
 delete mode 100644 arch/arm/mach-at91/at91x40_time.c
 delete mode 100644 arch/arm/mach-at91/board-eb01.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7068649..c3307fd 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -89,10 +89,6 @@ config ARCH_AT572D940HF
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 
-config ARCH_AT91X40
-	bool "AT91x40"
-	select ARCH_USES_GETTIMEOFFSET
-
 endchoice
 
 config AT91_PMC_UNIT
@@ -432,22 +428,6 @@ endif
 
 # ----------------------------------------------------------
 
-if ARCH_AT91X40
-
-comment "AT91X40 Board Type"
-
-config MACH_AT91EB01
-	bool "Atmel AT91EB01 Evaluation Kit"
-	help
-	  Select this if you are using Atmel's AT91EB01 Evaluation Kit.
-	  It is also a popular target for simulators such as GDB's
-	  ARM simulator (commonly known as the ARMulator) and the
-	  Skyeye simulator.
-
-endif
-
-# ----------------------------------------------------------
-
 comment "AT91 Board Options"
 
 config MTD_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index ca2ac00..b6b8c9c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_d
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT572D940HF)  += at572d940hf.o at91sam926x_time.o at572d940hf_devices.o sam9_smc.o
-obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 
 # AT91RM9200 board-specific support
 obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
@@ -78,9 +77,6 @@ obj-$(CONFIG_MACH_AT91CAP9ADK)	+= board-cap9adk.o
 # AT572D940HF board-specific support
 obj-$(CONFIG_MACH_AT572D940HFEB) += board-at572d940hf_ek.o
 
-# AT91X40 board-specific support
-obj-$(CONFIG_MACH_AT91EB01)	+= board-eb01.o
-
 # Drivers
 obj-y				+= leds.o
 
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
deleted file mode 100644
index ad3ec85..0000000
--- a/arch/arm/mach-at91/at91x40.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * arch/arm/mach-at91/at91x40.c
- *
- * (C) Copyright 2007, Greg Ungerer <gerg@snapgear.com>
- * Copyright (C) 2005 SAN People
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <asm/mach/arch.h>
-#include <mach/at91x40.h>
-#include <mach/at91_st.h>
-#include <mach/timex.h>
-#include "generic.h"
-
-/*
- * Export the clock functions for the AT91X40. Some external code common
- * to all AT91 family parts relys on this, like the gpio and serial support.
- */
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-
-void clk_disable(struct clk *clk)
-{
-}
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return AT91X40_MASTER_CLOCK;
-}
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-
-void __init at91x40_initialize(unsigned long main_clock)
-{
-	at91_extern_irq = (1 << AT91X40_ID_IRQ0) | (1 << AT91X40_ID_IRQ1)
-			| (1 << AT91X40_ID_IRQ2);
-}
-
-/*
- * The default interrupt priority levels (0 = lowest, 7 = highest).
- */
-static unsigned int at91x40_default_irq_priority[NR_AIC_IRQS] __initdata = {
-	7,	/* Advanced Interrupt Controller (FIQ) */
-	0,	/* System Peripherals */
-	0,	/* USART 0 */
-	0,	/* USART 1 */
-	2,	/* Timer Counter 0 */
-	2,	/* Timer Counter 1 */
-	2,	/* Timer Counter 2 */
-	0,	/* Watchdog timer */
-	0,	/* Parallel IO Controller A */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* Reserved */
-	0,	/* External IRQ0 */
-	0,	/* External IRQ1 */
-	0,	/* External IRQ2 */
-};
-
-void __init at91x40_init_interrupts(unsigned int priority[NR_AIC_IRQS])
-{
-	if (!priority)
-		priority = at91x40_default_irq_priority;
-
-	at91_aic_init(priority);
-}
-
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
deleted file mode 100644
index dfff289..0000000
--- a/arch/arm/mach-at91/at91x40_time.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * arch/arm/mach-at91/at91x40_time.c
- *
- * (C) Copyright 2007, Greg Ungerer <gerg@snapgear.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/time.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <asm/mach/time.h>
-#include <mach/at91_tc.h>
-
-/*
- *	3 counter/timer units present.
- */
-#define	AT91_TC_CLK0BASE	0
-#define	AT91_TC_CLK1BASE	0x40
-#define	AT91_TC_CLK2BASE	0x80
-
-static unsigned long at91x40_gettimeoffset(void)
-{
-	return (at91_sys_read(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_CV) * 1000000 / (AT91X40_MASTER_CLOCK / 128));
-}
-
-static irqreturn_t at91x40_timer_interrupt(int irq, void *dev_id)
-{
-	at91_sys_read(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_SR);
-	timer_tick();
-	return IRQ_HANDLED;
-}
-
-static struct irqaction at91x40_timer_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
-	.handler	= at91x40_timer_interrupt
-};
-
-void __init at91x40_timer_init(void)
-{
-	unsigned int v;
-
-	at91_sys_write(AT91_TC + AT91_TC_BCR, 0);
-	v = at91_sys_read(AT91_TC + AT91_TC_BMR);
-	v = (v & ~AT91_TC_TC1XC1S) | AT91_TC_TC1XC1S_NONE;
-	at91_sys_write(AT91_TC + AT91_TC_BMR, v);
-
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_CCR, AT91_TC_CLKDIS);
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_CMR, (AT91_TC_TIMER_CLOCK4 | AT91_TC_CPCTRG));
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_IDR, 0xffffffff);
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_RC, (AT91X40_MASTER_CLOCK / 128) / HZ - 1);
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_IER, (1<<4));
-
-	setup_irq(AT91X40_ID_TC1, &at91x40_timer_irq);
-
-	at91_sys_write(AT91_TC + AT91_TC_CLK1BASE + AT91_TC_CCR, (AT91_TC_SWTRG | AT91_TC_CLKEN));
-}
-
-struct sys_timer at91x40_timer = {
-	.init	= at91x40_timer_init,
-	.offset	= at91x40_gettimeoffset,
-};
-
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
deleted file mode 100644
index 1f9d3cb..0000000
--- a/arch/arm/mach-at91/board-eb01.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * arch/arm/mach-at91/board-eb01.c
- *
- * (C) Copyright 2007, Greg Ungerer <gerg@snapgear.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/board.h>
-#include "generic.h"
-
-static void __init at91eb01_map_io(void)
-{
-	at91x40_initialize(40000000);
-}
-
-MACHINE_START(AT91EB01, "Atmel AT91 EB01")
-	/* Maintainer: Greg Ungerer <gerg@snapgear.com> */
-	.timer		= &at91x40_timer,
-	.init_irq	= at91x40_init_interrupts,
-	.map_io		= at91eb01_map_io,
-MACHINE_END
-
-- 
1.7.1
