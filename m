From: avictor.za@gmail.com (Andrew Victor)
Date: Thu, 28 Apr 2011 18:56:32 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110428131538.GA10594@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
Message-ID: <1304009792.3081.8.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> > And that's another reason to say no to this.  Please stop inventing new
> > ways to do things unless you're prepared to provide it as a replacement
> > for all the (ARM) platforms we have in the kernel.
> Personally I do not change the current arm way
> 
> I init the timer during system_timer->init
> 
> I just the the early device their to pass the resources
> but if switch all arm timer this way is fine to you I'm ready to do the whole
> update

Well, attached is a simpler way of passing the base-address to the timer
drivers.  It will solve the timer issues with a single kernel supporting
multiple AT91 processors.

I think it would be cleaner still if the "struct sys_timer" could
include a register-base-address field.  Russell?


Regards,
  Andrew Victor



diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at572d940hf.c linux-2.6/arch/arm/mach-at91/at572d940hf.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at572d940hf.c	2011-04-28 18:31:36.006648045 +0200
+++ linux-2.6/arch/arm/mach-at91/at572d940hf.c	2011-04-28 18:00:06.017315300 +0200
@@ -307,6 +307,8 @@
 	/* Map peripherals */
 	iotable_init(at572d940hf_io_desc, ARRAY_SIZE(at572d940hf_io_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91cap9.c linux-2.6/arch/arm/mach-at91/at91cap9.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91cap9.c	2011-04-28 18:31:36.006648045 +0200
+++ linux-2.6/arch/arm/mach-at91/at91cap9.c	2011-04-28 17:59:55.389976086 +0200
@@ -308,6 +308,8 @@
 	/* Map peripherals */
 	iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91rm9200.c linux-2.6/arch/arm/mach-at91/at91rm9200.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91rm9200.c	2011-04-28 18:31:36.006648045 +0200
+++ linux-2.6/arch/arm/mach-at91/at91rm9200.c	2011-04-28 17:41:09.092190177 +0200
@@ -262,8 +262,8 @@
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
 	 */
-	at91_sys_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
-	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+	at91_sys_write(AT91_ST + AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
+	at91_sys_write(AT91_ST + AT91_ST_CR, AT91_ST_WDRST);
 }
 
 
@@ -275,6 +275,8 @@
 	/* Map peripherals */
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_ST;
+
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91rm9200_time.c linux-2.6/arch/arm/mach-at91/at91rm9200_time.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91rm9200_time.c	2011-04-27 12:28:25.985090424 +0200
+++ linux-2.6/arch/arm/mach-at91/at91rm9200_time.c	2011-04-28 17:41:30.238868208 +0200
@@ -28,9 +28,12 @@
 
 #include <mach/at91_st.h>
 
+#include "generic.h"
+
 static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
+void __iomem *at91_timer_base;	/* base address */
 
 /*
  * The ST_CRTR is updated asynchronously to the master clock ... but
@@ -41,9 +44,9 @@
 {
 	unsigned long x1, x2;
 
-	x1 = at91_sys_read(AT91_ST_CRTR);
+	x1 = __raw_readl(at91_timer_base + AT91_ST_CRTR);
 	do {
-		x2 = at91_sys_read(AT91_ST_CRTR);
+		x2 = __raw_readl(at91_timer_base + AT91_ST_CRTR);
 		if (x1 == x2)
 			break;
 		x1 = x2;
@@ -56,7 +59,7 @@
  */
 static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 {
-	u32	sr = at91_sys_read(AT91_ST_SR) & irqmask;
+	u32 sr = __raw_readl(at91_timer_base + AT91_ST_SR) & irqmask;
 
 	/*
 	 * irqs should be disabled here, but as the irq is shared they are only
@@ -108,22 +111,22 @@
 clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
 	/* Disable and flush pending timer interrupts */
-	at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
-	(void) at91_sys_read(AT91_ST_SR);
+	__raw_writel(AT91_ST_PITS | AT91_ST_ALMS, at91_timer_base + AT91_ST_IDR);
+	(void) __raw_readl(at91_timer_base + AT91_ST_SR);
 
 	last_crtr = read_CRTR();
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		at91_sys_write(AT91_ST_PIMR, LATCH);
+		__raw_writel(LATCH, at91_timer_base + AT91_ST_PIMR);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
 		 * before 32 seconds have passed
 		 */
 		irqmask = AT91_ST_ALMS;
-		at91_sys_write(AT91_ST_RTAR, last_crtr);
+		__raw_writel(last_crtr, at91_timer_base + AT91_ST_RTAR);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -131,7 +134,7 @@
 		irqmask = 0;
 		break;
 	}
-	at91_sys_write(AT91_ST_IER, irqmask);
+	__raw_writel(irqmask, at91_timer_base + AT91_ST_IER);
 }
 
 static int
@@ -154,12 +157,12 @@
 	alm = read_CRTR();
 
 	/* Cancel any pending alarm; flush any pending IRQ */
-	at91_sys_write(AT91_ST_RTAR, alm);
-	(void) at91_sys_read(AT91_ST_SR);
+	__raw_writel(alm, at91_timer_base + AT91_ST_RTAR);
+	(void) __raw_readl(at91_timer_base + AT91_ST_SR);
 
 	/* Schedule alarm by writing RTAR. */
 	alm += delta;
-	at91_sys_write(AT91_ST_RTAR, alm);
+	__raw_writel(alm, at91_timer_base + AT91_ST_RTAR);
 
 	return status;
 }
@@ -179,9 +182,9 @@
 void __init at91rm9200_timer_init(void)
 {
 	/* Disable all timer interrupts, and clear any pending ones */
-	at91_sys_write(AT91_ST_IDR,
-		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
-	(void) at91_sys_read(AT91_ST_SR);
+	__raw_writel(AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS,
+		at91_timer_base + AT91_ST_IDR);
+	(void) __raw_readl(at91_timer_base + AT91_ST_SR);
 
 	/* Make IRQs happen for the system timer */
 	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
@@ -190,7 +193,7 @@
 	 * directly for the clocksource and all clockevents, after adjusting
 	 * its prescaler from the 1 Hz default.
 	 */
-	at91_sys_write(AT91_ST_RTMR, 1);
+	__raw_writel(1, at91_timer_base + AT91_ST_RTMR);
 
 	/* Setup timer clockevent, with minimum of two ticks (important!!) */
 	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam9260.c linux-2.6/arch/arm/mach-at91/at91sam9260.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam9260.c	2011-04-28 18:31:36.010647848 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam9260.c	2011-04-28 18:00:38.823275695 +0200
@@ -307,6 +307,7 @@
 	at91sam9xe_sram_desc->virtual = AT91_IO_VIRT_BASE - sram_size;
 	at91sam9xe_sram_desc->length = sram_size;
 
+	/* Map peripherals */
 	iotable_init(at91sam9xe_sram_desc, ARRAY_SIZE(at91sam9xe_sram_desc));
 }
 
@@ -322,6 +323,8 @@
 	else
 		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam9261.c linux-2.6/arch/arm/mach-at91/at91sam9261.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam9261.c	2011-04-28 18:31:36.010647848 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam9261.c	2011-04-28 17:59:00.081415501 +0200
@@ -277,6 +277,7 @@
 	else
 		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
 
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam9263.c linux-2.6/arch/arm/mach-at91/at91sam9263.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam9263.c	2011-04-28 18:31:36.010647848 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam9263.c	2011-04-28 17:59:04.173161020 +0200
@@ -284,6 +284,8 @@
 	/* Map peripherals */
 	iotable_init(at91sam9263_io_desc, ARRAY_SIZE(at91sam9263_io_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam926x_time.c linux-2.6/arch/arm/mach-at91/at91sam926x_time.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam926x_time.c	2011-04-27 12:28:26.033087705 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam926x_time.c	2011-04-28 17:48:50.659369273 +0200
@@ -23,6 +23,7 @@
 #define PIT_CPIV(x)	((x) & AT91_PIT_CPIV)
 #define PIT_PICNT(x)	(((x) & AT91_PIT_PICNT) >> 20)
 
+void __iomem *at91_timer_base;	/* base address */
 static u32 pit_cycle;		/* write-once */
 static u32 pit_cnt;		/* access only w/system irq blocked */
 
@@ -39,7 +40,7 @@
 
 	raw_local_irq_save(flags);
 	elapsed = pit_cnt;
-	t = at91_sys_read(AT91_PIT_PIIR);
+	t = __raw_readl(at91_timer_base + AT91_PIT_PIIR);
 	raw_local_irq_restore(flags);
 
 	elapsed += PIT_PICNT(t) * pit_cycle;
@@ -64,9 +65,9 @@
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* update clocksource counter */
-		pit_cnt += pit_cycle * PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
-				| AT91_PIT_PITIEN);
+		pit_cnt += pit_cycle * PIT_PICNT(__raw_readl(at91_timer_base + AT91_PIT_PIVR));
+		__raw_writel((pit_cycle - 1) | AT91_PIT_PITEN | AT91_PIT_PITIEN,
+			at91_timer_base + AT91_PIT_MR);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		BUG();
@@ -74,7 +75,7 @@
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
 		/* disable irq, leaving the clocksource active */
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+		__raw_writel((pit_cycle - 1) | AT91_PIT_PITEN, at91_timer_base + AT91_PIT_MR);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
@@ -103,11 +104,11 @@
 
 	/* The PIT interrupt may be disabled, and is shared */
 	if ((pit_clkevt.mode == CLOCK_EVT_MODE_PERIODIC)
-			&& (at91_sys_read(AT91_PIT_SR) & AT91_PIT_PITS)) {
+			&& (__raw_readl(at91_timer_base + AT91_PIT_SR) & AT91_PIT_PITS)) {
 		unsigned nr_ticks;
 
 		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
+		nr_ticks = PIT_PICNT(__raw_readl(at91_timer_base + AT91_PIT_PIVR));
 		do {
 			pit_cnt += pit_cycle;
 			pit_clkevt.event_handler(&pit_clkevt);
@@ -129,14 +130,14 @@
 static void at91sam926x_pit_reset(void)
 {
 	/* Disable timer and irqs */
-	at91_sys_write(AT91_PIT_MR, 0);
+	__raw_writel(0, at91_timer_base + AT91_PIT_MR);
 
 	/* Clear any pending interrupts, wait for PIT to stop counting */
-	while (PIT_CPIV(at91_sys_read(AT91_PIT_PIVR)) != 0)
+	while (PIT_CPIV(__raw_readl(at91_timer_base + AT91_PIT_PIVR)) != 0)
 		cpu_relax();
 
 	/* Start PIT but don't enable IRQ */
-	at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+	__raw_writel((pit_cycle - 1) | AT91_PIT_PITEN, at91_timer_base + AT91_PIT_MR);
 }
 
 /*
@@ -178,7 +179,7 @@
 static void at91sam926x_pit_suspend(void)
 {
 	/* Disable timer */
-	at91_sys_write(AT91_PIT_MR, 0);
+	__raw_writel(0, at91_timer_base + AT91_PIT_MR);
 }
 
 struct sys_timer at91sam926x_timer = {
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam9g45.c linux-2.6/arch/arm/mach-at91/at91sam9g45.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam9g45.c	2011-04-28 18:31:36.010647848 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam9g45.c	2011-04-28 17:59:07.880930428 +0200
@@ -311,6 +311,8 @@
 	/* Map peripherals */
 	iotable_init(at91sam9g45_io_desc, ARRAY_SIZE(at91sam9g45_io_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/at91sam9rl.c linux-2.6/arch/arm/mach-at91/at91sam9rl.c
--- linux-2.6.38.at91/arch/arm/mach-at91/at91sam9rl.c	2011-04-28 18:31:36.014647647 +0200
+++ linux-2.6/arch/arm/mach-at91/at91sam9rl.c	2011-04-28 17:59:45.146613009 +0200
@@ -276,6 +276,8 @@
 	/* Map SRAM */
 	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
 
+	at91_timer_base = (void __iomem *)AT91_VA_BASE_SYS + AT91_PIT;
+
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/generic.h linux-2.6/arch/arm/mach-at91/generic.h
--- linux-2.6.38.at91/arch/arm/mach-at91/generic.h	2011-04-28 18:31:36.014647647 +0200
+++ linux-2.6/arch/arm/mach-at91/generic.h	2011-04-28 17:40:01.404422677 +0200
@@ -64,3 +64,5 @@
 
 extern void (*at91_arch_reset)(void);
 extern int at91_extern_irq;
+
+extern void __iomem *at91_timer_base;	/* base address of system timer */
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/include/mach/at91_pit.h linux-2.6/arch/arm/mach-at91/include/mach/at91_pit.h
--- linux-2.6.38.at91/arch/arm/mach-at91/include/mach/at91_pit.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6/arch/arm/mach-at91/include/mach/at91_pit.h	2011-04-28 17:43:52.102003644 +0200
@@ -16,16 +16,16 @@
 #ifndef AT91_PIT_H
 #define AT91_PIT_H
 
-#define AT91_PIT_MR		(AT91_PIT + 0x00)	/* Mode Register */
+#define AT91_PIT_MR		0x00	/* Mode Register */
 #define		AT91_PIT_PITIEN		(1 << 25)		/* Timer Interrupt Enable */
 #define		AT91_PIT_PITEN		(1 << 24)		/* Timer Enabled */
 #define		AT91_PIT_PIV		(0xfffff)		/* Periodic Interval Value */
 
-#define AT91_PIT_SR		(AT91_PIT + 0x04)	/* Status Register */
+#define AT91_PIT_SR		0x04	/* Status Register */
 #define		AT91_PIT_PITS		(1 << 0)		/* Timer Status */
 
-#define AT91_PIT_PIVR		(AT91_PIT + 0x08)	/* Periodic Interval Value Register */
-#define AT91_PIT_PIIR		(AT91_PIT + 0x0c)	/* Periodic Interval Image Register */
+#define AT91_PIT_PIVR		0x08	/* Periodic Interval Value Register */
+#define AT91_PIT_PIIR		0x0c	/* Periodic Interval Image Register */
 #define		AT91_PIT_PICNT		(0xfff << 20)		/* Interval Counter */
 #define		AT91_PIT_CPIV		(0xfffff)		/* Inverval Value */
 
diff -urN -x CVS linux-2.6.38.at91/arch/arm/mach-at91/include/mach/at91_st.h linux-2.6/arch/arm/mach-at91/include/mach/at91_st.h
--- linux-2.6.38.at91/arch/arm/mach-at91/include/mach/at91_st.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6/arch/arm/mach-at91/include/mach/at91_st.h	2011-04-28 17:13:35.329073653 +0200
@@ -16,34 +16,34 @@
 #ifndef AT91_ST_H
 #define AT91_ST_H
 
-#define	AT91_ST_CR		(AT91_ST + 0x00)	/* Control Register */
+#define	AT91_ST_CR		0x00	/* Control Register */
 #define 	AT91_ST_WDRST		(1 << 0)		/* Watchdog Timer Restart */
 
-#define	AT91_ST_PIMR		(AT91_ST + 0x04)	/* Period Interval Mode Register */
+#define	AT91_ST_PIMR		0x04	/* Period Interval Mode Register */
 #define		AT91_ST_PIV		(0xffff <<  0)		/* Period Interval Value */
 
-#define	AT91_ST_WDMR		(AT91_ST + 0x08)	/* Watchdog Mode Register */
+#define	AT91_ST_WDMR		0x08	/* Watchdog Mode Register */
 #define		AT91_ST_WDV		(0xffff <<  0)		/* Watchdog Counter Value */
 #define		AT91_ST_RSTEN		(1	<< 16)		/* Reset Enable */
 #define		AT91_ST_EXTEN		(1	<< 17)		/* External Signal Assertion Enable */
 
-#define	AT91_ST_RTMR		(AT91_ST + 0x0c)	/* Real-time Mode Register */
+#define	AT91_ST_RTMR		0x0c	/* Real-time Mode Register */
 #define		AT91_ST_RTPRES		(0xffff <<  0)		/* Real-time Prescalar Value */
 
-#define	AT91_ST_SR		(AT91_ST + 0x10)	/* Status Register */
+#define	AT91_ST_SR		0x10	/* Status Register */
 #define		AT91_ST_PITS		(1 << 0)		/* Period Interval Timer Status */
 #define		AT91_ST_WDOVF		(1 << 1) 		/* Watchdog Overflow */
 #define		AT91_ST_RTTINC		(1 << 2) 		/* Real-time Timer Increment */
 #define		AT91_ST_ALMS		(1 << 3) 		/* Alarm Status */
 
-#define	AT91_ST_IER		(AT91_ST + 0x14)	/* Interrupt Enable Register */
-#define	AT91_ST_IDR		(AT91_ST + 0x18)	/* Interrupt Disable Register */
-#define	AT91_ST_IMR		(AT91_ST + 0x1c)	/* Interrupt Mask Register */
+#define	AT91_ST_IER		0x14	/* Interrupt Enable Register */
+#define	AT91_ST_IDR		0x18	/* Interrupt Disable Register */
+#define	AT91_ST_IMR		0x1c	/* Interrupt Mask Register */
 
-#define	AT91_ST_RTAR		(AT91_ST + 0x20)	/* Real-time Alarm Register */
+#define	AT91_ST_RTAR		0x20	/* Real-time Alarm Register */
 #define		AT91_ST_ALMV		(0xfffff << 0)		/* Alarm Value */
 
-#define	AT91_ST_CRTR		(AT91_ST + 0x24)	/* Current Real-time Register */
+#define	AT91_ST_CRTR		0x24	/* Current Real-time Register */
 #define		AT91_ST_CRTV		(0xfffff << 0)		/* Current Real-Time Value */
 
 #endif
diff -urN -x CVS linux-2.6.38.at91/drivers/watchdog/at91rm9200_wdt.c linux-2.6/drivers/watchdog/at91rm9200_wdt.c
--- linux-2.6.38.at91/drivers/watchdog/at91rm9200_wdt.c	2010-12-24 16:53:22.211689101 +0200
+++ linux-2.6/drivers/watchdog/at91rm9200_wdt.c	2011-04-28 17:15:04.291102469 +0200
@@ -51,7 +51,7 @@
  */
 static inline void at91_wdt_stop(void)
 {
-	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN);
+	at91_sys_write(AT91_ST + AT91_ST_WDMR, AT91_ST_EXTEN);
 }
 
 /*
@@ -59,9 +59,9 @@
  */
 static inline void at91_wdt_start(void)
 {
-	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN |
+	at91_sys_write(AT91_ST + AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN |
 				(((65536 * wdt_time) >> 8) & AT91_ST_WDV));
-	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+	at91_sys_write(AT91_ST + AT91_ST_CR, AT91_ST_WDRST);
 }
 
 /*
@@ -69,7 +69,7 @@
  */
 static inline void at91_wdt_reload(void)
 {
-	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+	at91_sys_write(AT91_ST + AT91_ST_CR, AT91_ST_WDRST);
 }
 
 /* ......................................................................... */
