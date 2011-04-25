From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:20 +0200
Subject: [PATCH 10/14] at91: switch st timer to early platform devices
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to specify the resources per soc
and have only one time init for all boards except x40

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c       |    6 +
 arch/arm/mach-at91/at91rm9200_time.c  |  271 +++++++++++++++++++++++---------
 arch/arm/mach-at91/board-1arm.c       |    2 +-
 arch/arm/mach-at91/board-carmeva.c    |    2 +-
 arch/arm/mach-at91/board-cpuat91.c    |    2 +-
 arch/arm/mach-at91/board-csb337.c     |    2 +-
 arch/arm/mach-at91/board-csb637.c     |    2 +-
 arch/arm/mach-at91/board-eb9200.c     |    2 +-
 arch/arm/mach-at91/board-ecbat91.c    |    2 +-
 arch/arm/mach-at91/board-eco920.c     |    2 +-
 arch/arm/mach-at91/board-kafa.c       |    2 +-
 arch/arm/mach-at91/board-kb9202.c     |    2 +-
 arch/arm/mach-at91/board-picotux200.c |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c   |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c   |    2 +-
 arch/arm/mach-at91/board-yl-9200.c    |    2 +-
 arch/arm/mach-at91/generic.h          |    2 +-
 arch/arm/mach-at91/soc.c              |   21 +++-
 arch/arm/mach-at91/soc.h              |    1 +
 19 files changed, 237 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index e80d544..7b9d3a4 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -378,6 +378,11 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0	/* Advanced Interrupt Controller (IRQ6) */
 };
 
+struct at91_dev_resource at91rm9200_st __initdata = {
+	.mmio_base	= AT91_ST,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91rm9200_soc = {
 	.name = "at91rm9200",
 	.default_irq_priority = at91rm9200_default_irq_priority,
@@ -386,4 +391,5 @@ struct at91_soc __initdata at91rm9200_soc = {
 		.resource = at91rm9200_pios,
 		.num_resources = ARRAY_SIZE(at91rm9200_pios),
 	},
+	.st = &at91rm9200_st,
 };
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 1dd69c8..538ee40 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -1,8 +1,9 @@
 /*
  * linux/arch/arm/mach-at91/at91rm9200_time.c
  *
- *  Copyright (C) 2003 SAN People
- *  Copyright (C) 2003 ATMEL
+ * Copyright (C) 2003 SAN People
+ * Copyright (C) 2003 ATMEL
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -20,30 +21,58 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clockchips.h>
-
-#include <asm/mach/time.h>
+#include <linux/slab.h>
 
 #include <mach/at91_st.h>
 
-static unsigned long last_crtr;
-static u32 irqmask;
-static struct clock_event_device clkevt;
+struct at91_st_data {
+	void __iomem *mapbase;
+	unsigned long last_crtr;
+	u32 irqmask;
+	struct clock_event_device ced;
+	struct clocksource cs;
+	struct irqaction irqaction;
+	struct platform_device *pdev;
+};
+
+static inline unsigned int at91_st_read(struct at91_st_data *data,
+					 unsigned int reg_offset)
+{
+	return __raw_readl(data->mapbase + reg_offset);
+}
+
+static inline void at91_st_write(struct at91_st_data *data,
+			unsigned int reg_offset, unsigned long value)
+{
+	__raw_writel(value, data->mapbase + reg_offset);
+}
+
+static struct at91_st_data *cs_to_at91_st(struct clocksource *cs)
+{
+	return container_of(cs, struct at91_st_data, cs);
+}
+
+static struct at91_st_data *ced_to_at91_st(struct clock_event_device *ced)
+{
+	return container_of(ced, struct at91_st_data, ced);
+}
 
 /*
  * The ST_CRTR is updated asynchronously to the master clock ... but
  * the updates as seen by the CPU don't seem to be strictly monotonic.
  * Waiting until we read the same value twice avoids glitching.
  */
-static inline unsigned long read_CRTR(void)
+static inline unsigned long read_CRTR(struct at91_st_data *data)
 {
 	unsigned long x1, x2;
 
-	x1 = at91_sys_read(AT91_ST_CRTR);
+	x1 = at91_st_read(data, AT91_ST_CRTR);
 	do {
-		x2 = at91_sys_read(AT91_ST_CRTR);
+		x2 = at91_st_read(data, AT91_ST_CRTR);
 		if (x1 == x2)
 			break;
 		x1 = x2;
@@ -54,9 +83,13 @@ static inline unsigned long read_CRTR(void)
 /*
  * IRQ handler for the timer.
  */
-static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t at91_st_interrupt(int irq, void *dev_id)
 {
-	u32	sr = at91_sys_read(AT91_ST_SR) & irqmask;
+	struct at91_st_data *data = (struct at91_st_data*)dev_id;
+	struct clock_event_device *ced = &data->ced;
+	u32 sr;
+
+	sr = at91_st_read(data, AT91_ST_SR) & data->irqmask;
 
 	/*
 	 * irqs should be disabled here, but as the irq is shared they are only
@@ -66,17 +99,17 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 
 	/* simulate "oneshot" timer with alarm */
 	if (sr & AT91_ST_ALMS) {
-		clkevt.event_handler(&clkevt);
+		ced->event_handler(ced);
 		return IRQ_HANDLED;
 	}
 
 	/* periodic mode should handle delayed ticks */
 	if (sr & AT91_ST_PITS) {
-		u32	crtr = read_CRTR();
+		u32	crtr = read_CRTR(data);
 
-		while (((crtr - last_crtr) & AT91_ST_CRTV) >= LATCH) {
-			last_crtr += LATCH;
-			clkevt.event_handler(&clkevt);
+		while (((crtr - data->last_crtr) & AT91_ST_CRTV) >= LATCH) {
+			data->last_crtr += LATCH;
+			ced->event_handler(ced);
 		}
 		return IRQ_HANDLED;
 	}
@@ -85,60 +118,51 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction at91rm9200_timer_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= at91rm9200_timer_interrupt
-};
-
-static cycle_t read_clk32k(struct clocksource *cs)
+static cycle_t at91_st_clocksource_read(struct clocksource *cs)
 {
-	return read_CRTR();
-}
+	struct at91_st_data *data = cs_to_at91_st(cs);
 
-static struct clocksource clk32k = {
-	.name		= "32k_counter",
-	.rating		= 150,
-	.read		= read_clk32k,
-	.mask		= CLOCKSOURCE_MASK(20),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
+	return read_CRTR(data);
+}
 
-static void
-clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+static void at91_st_clock_event_mode(enum clock_event_mode mode,
+				      struct clock_event_device *dev)
 {
+	struct at91_st_data *data = ced_to_at91_st(dev);
+
 	/* Disable and flush pending timer interrupts */
 	at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
-	(void) at91_sys_read(AT91_ST_SR);
+	(void) at91_st_read(data, AT91_ST_SR);
 
-	last_crtr = read_CRTR();
+	data->last_crtr = read_CRTR(data);
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
-		irqmask = AT91_ST_PITS;
-		at91_sys_write(AT91_ST_PIMR, LATCH);
+		data->irqmask = AT91_ST_PITS;
+		at91_st_write(data, AT91_ST_PIMR, LATCH);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
 		 * before 32 seconds have passed
 		 */
-		irqmask = AT91_ST_ALMS;
-		at91_sys_write(AT91_ST_RTAR, last_crtr);
+		data->irqmask = AT91_ST_ALMS;
+		at91_st_write(data, AT91_ST_RTAR, data->last_crtr);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_RESUME:
-		irqmask = 0;
+		data->irqmask = 0;
 		break;
 	}
-	at91_sys_write(AT91_ST_IER, irqmask);
+	at91_st_write(data, AT91_ST_IER, data->irqmask);
 }
 
-static int
-clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
+static int at91_st_clock_event_next(unsigned long delta,
+				   struct clock_event_device *ced)
 {
-	u32		alm;
-	int		status = 0;
+	struct at91_st_data *data = ced_to_at91_st(ced);
+	u32 alm;
+	int status = 0;
 
 	BUG_ON(delta < 2);
 
@@ -151,59 +175,154 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 	 * with the value then held in CRTR ... which would mean the match
 	 * wouldn't trigger until 32 seconds later, after CRTR wraps.
 	 */
-	alm = read_CRTR();
+	alm = read_CRTR(data);
 
 	/* Cancel any pending alarm; flush any pending IRQ */
-	at91_sys_write(AT91_ST_RTAR, alm);
-	(void) at91_sys_read(AT91_ST_SR);
+	at91_st_write(data, AT91_ST_RTAR, alm);
+	(void) at91_st_read(data, AT91_ST_SR);
 
 	/* Schedule alarm by writing RTAR. */
 	alm += delta;
-	at91_sys_write(AT91_ST_RTAR, alm);
+	at91_st_write(data, AT91_ST_RTAR, alm);
 
 	return status;
 }
 
-static struct clock_event_device clkevt = {
-	.name		= "at91_tick",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.shift		= 32,
-	.rating		= 150,
-	.set_next_event	= clkevt32k_next_event,
-	.set_mode	= clkevt32k_mode,
-};
+static void at91_st_register_clockevent(struct at91_st_data *data)
+{
+	struct clock_event_device *ced = &data->ced;
 
-/*
- * ST (system timer) module supports both clockevents and clocksource.
- */
-void __init at91rm9200_timer_init(void)
+	memset(ced, 0, sizeof(*ced));
+
+	ced->name = "at91_tick";
+	ced->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	ced->shift = 32;
+	ced->rating = 150;
+	ced->set_next_event = at91_st_clock_event_next;
+	ced->set_mode = at91_st_clock_event_mode;
+	ced->mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, ced->shift);
+	ced->max_delta_ns = clockevent_delta2ns(AT91_ST_ALMV, ced);
+	ced->min_delta_ns = clockevent_delta2ns(2, ced) + 1;
+	ced->cpumask = cpumask_of(0);
+
+	dev_info(&data->pdev->dev, "used for clock events\n");
+
+	clockevents_register_device(ced);
+}
+
+static int at91_st_register_clocksource(struct at91_st_data *data)
 {
+	struct clocksource *cs = &data->cs;
+
+	cs->name = "32k_counter";
+	cs->rating = 150;
+	cs->read = at91_st_clocksource_read;
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask = CLOCKSOURCE_MASK(20);
+
+	dev_info(&data->pdev->dev, "used as clock source\n");
+
+	clocksource_register_hz(cs, AT91_SLOW_CLOCK);
+
+	return 0;
+}
+
+static int at91_st_setup(struct at91_st_data *data,
+			  struct platform_device *pdev)
+{
+	struct resource	*res;
+	int		irq;
+	int		ret = -ENXIO;
+
+	memset(data, 0, sizeof(struct at91_st_data));
+	data->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		goto err0;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		goto err0;
+	}
+
+	/* map memory, let mapbase point to our channel */
+	data->mapbase = (void * __iomem)(res->start + AT91_VA_BASE_SYS);
+
+	/* request irq using setup_irq() (too early for request_irq()) */
+	data->irqaction.name = "at91_tick";
+	data->irqaction.handler = at91_st_interrupt;
+	data->irqaction.dev_id = data;
+	data->irqaction.flags = IRQF_SHARED | IRQF_DISABLED |
+				IRQF_TIMER  | IRQF_IRQPOLL;
+
 	/* Disable all timer interrupts, and clear any pending ones */
 	at91_sys_write(AT91_ST_IDR,
 		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
 	(void) at91_sys_read(AT91_ST_SR);
 
-	/* Make IRQs happen for the system timer */
-	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
-
 	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
 	 * directly for the clocksource and all clockevents, after adjusting
 	 * its prescaler from the 1 Hz default.
 	 */
 	at91_sys_write(AT91_ST_RTMR, 1);
 
-	/* Setup timer clockevent, with minimum of two ticks (important!!) */
-	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
-	clkevt.max_delta_ns = clockevent_delta2ns(AT91_ST_ALMV, &clkevt);
-	clkevt.min_delta_ns = clockevent_delta2ns(2, &clkevt) + 1;
-	clkevt.cpumask = cpumask_of(0);
-	clockevents_register_device(&clkevt);
+	/*
+	 * Register clocksource.  The high order bits of PIV are unused,
+	 * so this isn't a 32-bit counter unless we get clockevent irqs.
+	 */
+	at91_st_register_clocksource(data);
+
+	/* Set up irq handler */
+	setup_irq(irq, &data->irqaction);
 
-	/* register clocksource */
-	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
+	/* Set up and register clockevents */
+	at91_st_register_clockevent(data);
+
+	return 0;
+
+err0:
+	return ret;
+}
+
+static int __devinit at91_st_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct at91_st_data *data;
+
+	if (!is_early_platform_device(pdev)) {
+		pr_info("at91_st.%d: call via non early plaform\n", pdev->id);
+		return 0;
+	}
+
+	data = kmalloc(sizeof(struct at91_st_data), GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	ret = at91_st_setup(data, pdev);
+
+	if (ret)
+		kfree(data);
+
+	return ret;
 }
 
-struct sys_timer at91rm9200_timer = {
-	.init		= at91rm9200_timer_init,
+static int __devexit at91_st_remove(struct platform_device *pdev)
+{
+	return -EBUSY; /* cannot unregister clockevent and clocksource */
+}
+
+static struct platform_driver at91_st_device_driver = {
+	.probe		= at91_st_probe,
+	.remove		= __devexit_p(at91_st_remove),
+	.driver		= {
+		.name	= "at91_st",
+	}
 };
 
+early_platform_init("earlytimer", &at91_st_device_driver);
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index ba08329..b487dff 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -97,7 +97,7 @@ static void __init onearm_board_init(void)
 MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= onearm_map_io,
 	.init_irq	= onearm_init_irq,
 	.init_machine	= onearm_board_init,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index cb888cf..d2178fd 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -163,7 +163,7 @@ static void __init carmeva_board_init(void)
 MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= carmeva_map_io,
 	.init_irq	= carmeva_init_irq,
 	.init_machine	= carmeva_board_init,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 33ddbfa..1afdad4 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -180,7 +180,7 @@ static void __init cpuat91_board_init(void)
 MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= cpuat91_map_io,
 	.init_irq	= cpuat91_init_irq,
 	.init_machine	= cpuat91_board_init,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 354e85e..1a61446 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -258,7 +258,7 @@ static void __init csb337_board_init(void)
 MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= csb337_map_io,
 	.init_irq	= csb337_init_irq,
 	.init_machine	= csb337_board_init,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 9bff91f..efe7c39 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -139,7 +139,7 @@ static void __init csb637_board_init(void)
 MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= csb637_map_io,
 	.init_irq	= csb637_init_irq,
 	.init_machine	= csb637_board_init,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 8101ef0..9643bf5 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -121,7 +121,7 @@ static void __init eb9200_board_init(void)
 
 MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= eb9200_map_io,
 	.init_irq	= eb9200_init_irq,
 	.init_machine	= eb9200_board_init,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 7fb26f9..5a1537a 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -173,7 +173,7 @@ static void __init ecb_at91board_init(void)
 MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= ecb_at91map_io,
 	.init_irq	= ecb_at91init_irq,
 	.init_machine	= ecb_at91board_init,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 9c979bb..efd160d 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -135,7 +135,7 @@ static void __init eco920_board_init(void)
 MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= eco920_map_io,
 	.init_irq	= eco920_init_irq,
 	.init_machine	= eco920_board_init,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index cf7e7a0..b20bd84 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -99,7 +99,7 @@ static void __init kafa_board_init(void)
 MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= kafa_map_io,
 	.init_irq	= kafa_init_irq,
 	.init_machine	= kafa_board_init,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index a56cdee..570b00d 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -140,7 +140,7 @@ static void __init kb9202_board_init(void)
 MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= kb9202_map_io,
 	.init_irq	= kb9202_init_irq,
 	.init_machine	= kb9202_board_init,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 3267b95..5184964 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -124,7 +124,7 @@ static void __init picotux200_board_init(void)
 MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= picotux200_map_io,
 	.init_irq	= picotux200_init_irq,
 	.init_machine	= picotux200_board_init,
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index c14f2c2..d715327 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -228,7 +228,7 @@ static void __init dk_board_init(void)
 MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= dk_map_io,
 	.init_irq	= dk_init_irq,
 	.init_machine	= dk_board_init,
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index ffd69c0..755929c 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -194,7 +194,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index e9ca130..16bb91d 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -599,7 +599,7 @@ static void __init yl9200_board_init(void)
 MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91rm9200_timer,
+	.timer		= &at91_timer,
 	.map_io		= yl9200_map_io,
 	.init_irq	= yl9200_init_irq,
 	.init_machine	= yl9200_board_init,
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 1cfe696..eb01942 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -22,7 +22,7 @@ extern void __init at91_aic_init(unsigned int priority[]);
 
  /* Timer */
 struct sys_timer;
-extern struct sys_timer at91rm9200_timer;
+extern struct sys_timer at91_timer;
 extern struct sys_timer at91_timer;
 extern struct sys_timer at91x40_timer;
 
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index 7b44be2..1b05997 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -229,18 +229,37 @@ static struct platform_device at91_pit_device = {
 	.num_resources	= ARRAY_SIZE(pit_resources),
 };
 
+/*
+ * ST (system timer) module supports both clockevents and clocksource.
+ */
+static struct resource st_resources[] = {
+	[0] = RES_MEM(SZ_256),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_st_device = {
+	.name		= "at91_st",
+	.id		= 0,
+	.resource	= st_resources,
+	.num_resources	= ARRAY_SIZE(st_resources),
+};
+
 static void __init at91_timer_init(void)
 {
 	struct at91_dev_resource *res;
 	struct platform_device *pdev;
 	struct resource *r;
 
-	BUG_ON(!current_soc.pit);
+	BUG_ON(!current_soc.pit && !current_soc.st);
 
 	if (current_soc.pit) {
 		r = pit_resources;
 		res = current_soc.pit;
 		pdev = &at91_pit_device;
+	} else {
+		r = st_resources;
+		res = current_soc.st;
+		pdev = &at91_st_device;
 	}
 
 	set_resource_mem(&r[0], res->mmio_base);
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 8df07a2..a60ac0a 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -14,6 +14,7 @@ struct at91_soc {
 
 	struct at91_dev_resource_array gpio;
 	struct at91_dev_resource *pit;
+	struct at91_dev_resource *st;
 
 	void (*init)(unsigned long main_clock);
 };
-- 
1.7.4.1
