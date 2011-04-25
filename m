From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:19 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to specify the resources per soc

as the 5series use a different start address for the pit

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c           |    6 +
 arch/arm/mach-at91/at91cap9.c              |    6 +
 arch/arm/mach-at91/at91sam9260.c           |    6 +
 arch/arm/mach-at91/at91sam9261.c           |    6 +
 arch/arm/mach-at91/at91sam9263.c           |    6 +
 arch/arm/mach-at91/at91sam926x_time.c      |  277 +++++++++++++++++++++-------
 arch/arm/mach-at91/at91sam9g45.c           |    6 +
 arch/arm/mach-at91/at91sam9rl.c            |    6 +
 arch/arm/mach-at91/board-afeb-9260v1.c     |    2 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c  |    2 +-
 arch/arm/mach-at91/board-cam60.c           |    2 +-
 arch/arm/mach-at91/board-cap9adk.c         |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c        |    2 +-
 arch/arm/mach-at91/board-flexibity.c       |    2 +-
 arch/arm/mach-at91/board-foxg20.c          |    2 +-
 arch/arm/mach-at91/board-gsia18s.c         |    2 +-
 arch/arm/mach-at91/board-neocore926.c      |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c    |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c       |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c      |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c       |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c    |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c        |    2 +-
 arch/arm/mach-at91/board-snapper9260.c     |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c       |    4 +-
 arch/arm/mach-at91/board-usb-a926x.c       |    4 +-
 arch/arm/mach-at91/devices.c               |    4 +-
 arch/arm/mach-at91/generic.h               |    2 +-
 arch/arm/mach-at91/include/mach/at91_pit.h |    8 +-
 arch/arm/mach-at91/soc.c                   |   42 +++++
 arch/arm/mach-at91/soc.h                   |    1 +
 34 files changed, 327 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index b788861..66405af 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -417,6 +417,11 @@ static unsigned int at572d940hf_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
+struct at91_dev_resource at572d940hf_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at572d940hf_soc = {
 	.name = "at572d940hf",
 	.default_irq_priority = at572d940hf_default_irq_priority,
@@ -425,4 +430,5 @@ struct at91_soc __initdata at572d940hf_soc = {
 		.resource = at572d940hf_pios,
 		.num_resources = ARRAY_SIZE(at572d940hf_pios),
 	},
+	.pit = &at572d940hf_pit,
 };
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index f60ec74..dd5e858 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -420,6 +420,11 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
+struct at91_dev_resource at91cap9_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91cap9_soc = {
 	.name = "at91cap9",
 	.default_irq_priority = at91cap9_default_irq_priority,
@@ -428,4 +433,5 @@ struct at91_soc __initdata at91cap9_soc = {
 		.resource = at91cap9_pios,
 		.num_resources = ARRAY_SIZE(at91cap9_pios),
 	},
+	.pit = &at91cap9_pit,
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 4859231..0567556b 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -409,6 +409,11 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
+struct at91_dev_resource at91sam9260_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91sam9260_soc = {
 	.name = "at91sam9260",
 	.default_irq_priority = at91sam9260_default_irq_priority,
@@ -417,4 +422,5 @@ struct at91_soc __initdata at91sam9260_soc = {
 		.resource = at91sam9260_pios,
 		.num_resources = ARRAY_SIZE(at91sam9260_pios),
 	},
+	.pit = &at91sam9260_pit,
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 5a3f68b..603c6fe 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -375,6 +375,11 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
+struct at91_dev_resource at91sam9261_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91sam9261_soc = {
 	.name = "at91sam9261",
 	.default_irq_priority = at91sam9261_default_irq_priority,
@@ -383,4 +388,5 @@ struct at91_soc __initdata at91sam9261_soc = {
 		.resource = at91sam9261_pios,
 		.num_resources = ARRAY_SIZE(at91sam9261_pios),
 	},
+	.pit = &at91sam9261_pit,
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 9a0b3b4..e7ff884 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -384,6 +384,11 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
+struct at91_dev_resource at91sam9263_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91sam9263_soc = {
 	.name = "at91sam9263",
 	.default_irq_priority = at91sam9263_default_irq_priority,
@@ -392,4 +397,5 @@ struct at91_soc __initdata at91sam9263_soc = {
 		.resource = at91sam9263_pios,
 		.num_resources = ARRAY_SIZE(at91sam9263_pios),
 	},
+	.pit = &at91sam9263_pit,
 };
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 4ba8549..82ddaa7 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -4,69 +4,96 @@
  * Copyright (C) 2005-2006 M. Amine SAYA, ATMEL Rousset, France
  * Revision	 2005 M. Nicolas Diremdjian, ATMEL Rousset, France
  * Converted to ClockSource/ClockEvents by David Brownell.
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
-
-#include <asm/mach/time.h>
+#include <linux/slab.h>
 
 #include <mach/at91_pit.h>
 
+struct at91_pit_data {
+	void __iomem *mapbase;
+	u32 pit_cycle;		/* write-once */
+	u32 pit_cnt;		/* access only w/system irq blocked */
+	struct clock_event_device ced;
+	struct clocksource cs;
+	struct irqaction irqaction;
+	struct platform_device *pdev;
+};
 
 #define PIT_CPIV(x)	((x) & AT91_PIT_CPIV)
 #define PIT_PICNT(x)	(((x) & AT91_PIT_PICNT) >> 20)
 
-static u32 pit_cycle;		/* write-once */
-static u32 pit_cnt;		/* access only w/system irq blocked */
+static inline unsigned int at91_pit_read(struct at91_pit_data *data,
+					 unsigned int reg_offset)
+{
+	return __raw_readl(data->mapbase + reg_offset);
+}
+
+static inline void at91_pit_write(struct at91_pit_data *data,
+			unsigned int reg_offset, unsigned long value)
+{
+	__raw_writel(value, data->mapbase + reg_offset);
+}
 
+static struct at91_pit_data *cs_to_at91_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct at91_pit_data, cs);
+}
+
+static struct at91_pit_data *ced_to_at91_pit(struct clock_event_device *ced)
+{
+	return container_of(ced, struct at91_pit_data, ced);
+}
 
 /*
  * Clocksource:  just a monotonic counter of MCK/16 cycles.
  * We don't care whether or not PIT irqs are enabled.
  */
-static cycle_t read_pit_clk(struct clocksource *cs)
+static cycle_t at91_pit_clocksource_read(struct clocksource *cs)
 {
+	struct at91_pit_data *data = cs_to_at91_pit(cs);
 	unsigned long flags;
 	u32 elapsed;
 	u32 t;
 
 	raw_local_irq_save(flags);
-	elapsed = pit_cnt;
-	t = at91_sys_read(AT91_PIT_PIIR);
+	elapsed = data->pit_cnt;
+	t = at91_pit_read(data, AT91_PIT_PIIR);
 	raw_local_irq_restore(flags);
 
-	elapsed += PIT_PICNT(t) * pit_cycle;
+	elapsed += PIT_PICNT(t) * data->pit_cycle;
 	elapsed += PIT_CPIV(t);
 	return elapsed;
 }
 
-static struct clocksource pit_clk = {
-	.name		= "pit",
-	.rating		= 175,
-	.read		= read_pit_clk,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 
 /*
  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
  */
-static void
-pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+static void at91_pit_clock_event_mode(enum clock_event_mode mode,
+				      struct clock_event_device *dev)
 {
+	struct at91_pit_data *data = ced_to_at91_pit(dev);
+	u32 tmp;
+
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* update clocksource counter */
-		pit_cnt += pit_cycle * PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
-				| AT91_PIT_PITIEN);
+		tmp = PIT_PICNT(at91_pit_read(data, AT91_PIT_PIVR));
+		data->pit_cnt += data->pit_cycle * tmp;
+		at91_pit_write(data, AT91_PIT_MR, (data->pit_cycle - 1)
+				| AT91_PIT_PITEN | AT91_PIT_PITIEN);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		BUG();
@@ -74,27 +101,22 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
 		/* disable irq, leaving the clocksource active */
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+		at91_pit_write(data, AT91_PIT_MR,
+				(data->pit_cycle - 1) | AT91_PIT_PITEN);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
 }
 
-static struct clock_event_device pit_clkevt = {
-	.name		= "pit",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.shift		= 32,
-	.rating		= 100,
-	.set_mode	= pit_clkevt_mode,
-};
-
 
 /*
  * IRQ handler for the timer.
  */
-static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
+static irqreturn_t at91_pit_interrupt(int irq, void *dev_id)
 {
+	struct at91_pit_data *data = (struct at91_pit_data*)dev_id;
+
 	/*
 	 * irqs should be disabled here, but as the irq is shared they are only
 	 * guaranteed to be off if the timer irq is registered first.
@@ -102,15 +124,15 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 	WARN_ON_ONCE(!irqs_disabled());
 
 	/* The PIT interrupt may be disabled, and is shared */
-	if ((pit_clkevt.mode == CLOCK_EVT_MODE_PERIODIC)
-			&& (at91_sys_read(AT91_PIT_SR) & AT91_PIT_PITS)) {
+	if ((data->ced.mode == CLOCK_EVT_MODE_PERIODIC)
+			&& (at91_pit_read(data, AT91_PIT_SR) & AT91_PIT_PITS)) {
 		unsigned nr_ticks;
 
 		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
+		nr_ticks = PIT_PICNT(at91_pit_read(data, AT91_PIT_PIVR));
 		do {
-			pit_cnt += pit_cycle;
-			pit_clkevt.event_handler(&pit_clkevt);
+			data->pit_cnt += data->pit_cycle;
+			data->ced.event_handler(&data->ced);
 			nr_ticks--;
 		} while (nr_ticks);
 
@@ -120,69 +142,192 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction at91sam926x_pit_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= at91sam926x_pit_interrupt
-};
+static void at91_pit_stop(struct at91_pit_data *data)
+{
+	/* Disable timer and irqs */
+	at91_pit_write(data, AT91_PIT_MR, 0);
+}
 
-static void at91sam926x_pit_reset(void)
+static void at91_pit_reset(struct at91_pit_data *data)
 {
 	/* Disable timer and irqs */
-	at91_sys_write(AT91_PIT_MR, 0);
+	at91_pit_stop(data);
 
 	/* Clear any pending interrupts, wait for PIT to stop counting */
-	while (PIT_CPIV(at91_sys_read(AT91_PIT_PIVR)) != 0)
+	while (PIT_CPIV(at91_pit_read(data, AT91_PIT_PIVR)) != 0)
 		cpu_relax();
 
 	/* Start PIT but don't enable IRQ */
-	at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+	at91_pit_write(data, AT91_PIT_MR, (data->pit_cycle - 1) | AT91_PIT_PITEN);
 }
 
-/*
- * Set up both clocksource and clockevent support.
- */
-static void __init at91sam926x_pit_init(void)
+static int at91_pit_clocksource_enable(struct clocksource *cs)
+{
+	struct at91_pit_data *data = cs_to_at91_pit(cs);
+
+	at91_pit_reset(data);
+
+	return 0;
+}
+
+static void at91_pit_clocksource_resume(struct clocksource *cs)
+{
+	struct at91_pit_data *data = cs_to_at91_pit(cs);
+
+	at91_pit_reset(data);
+}
+
+static void at91_pit_clocksource_disable(struct clocksource *cs)
+{
+	struct at91_pit_data *data = cs_to_at91_pit(cs);
+
+	at91_pit_stop(data);
+}
+
+static void at91_pit_register_clockevent(struct at91_pit_data *data,
+					 unsigned long pit_rate)
+{
+	struct clock_event_device *ced = &data->ced;
+
+	memset(ced, 0, sizeof(*ced));
+
+	ced->name = "pit";
+	ced->features = CLOCK_EVT_FEAT_PERIODIC;
+	ced->shift = 32;
+	ced->rating = 100;
+	ced->set_mode = at91_pit_clock_event_mode;
+	ced->cpumask = cpumask_of(0);
+	ced->mult = div_sc(pit_rate, NSEC_PER_SEC, ced->shift);
+
+	dev_info(&data->pdev->dev, "used for clock events\n");
+
+	clockevents_register_device(ced);
+}
+
+static int at91_pit_register_clocksource(struct at91_pit_data *data,
+					 unsigned long pit_rate)
+{
+	struct clocksource *cs = &data->cs;
+	unsigned bits;
+
+	cs->name = "pit";
+	cs->rating = 175;
+	cs->shift = 20;
+	cs->read = at91_pit_clocksource_read;
+	cs->enable = at91_pit_clocksource_enable;
+	cs->disable = at91_pit_clocksource_disable;
+	cs->suspend = at91_pit_clocksource_disable;
+	cs->resume = at91_pit_clocksource_resume;
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	cs->mult = clocksource_hz2mult(pit_rate, cs->shift);
+	bits = 12 /* PICNT */ + ilog2(data->pit_cycle) /* PIV */;
+	cs->mask = CLOCKSOURCE_MASK(bits);
+
+	dev_info(&data->pdev->dev, "used as clock source\n");
+
+	clocksource_register_hz(cs, pit_rate);
+
+	return 0;
+}
+
+static int at91_pit_setup(struct at91_pit_data *data,
+			  struct platform_device *pdev)
 {
 	unsigned long	pit_rate;
-	unsigned	bits;
+	struct resource	*res;
+	int		irq;
+	int		ret = -ENXIO;
+
+	memset(data, 0, sizeof(struct at91_pit_data));
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
+	data->irqaction.handler = at91_pit_interrupt;
+	data->irqaction.dev_id = data;
+	data->irqaction.flags = IRQF_SHARED | IRQF_DISABLED |
+				IRQF_TIMER  | IRQF_IRQPOLL;
 
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
 	 * 1/HZ period (instead of a compile-time constant LATCH).
 	 */
 	pit_rate = clk_get_rate(clk_get(NULL, "mck")) / 16;
-	pit_cycle = (pit_rate + HZ/2) / HZ;
-	WARN_ON(((pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
+	data->pit_cycle = (pit_rate + HZ/2) / HZ;
+	WARN_ON(((data->pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
 
 	/* Initialize and enable the timer */
-	at91sam926x_pit_reset();
+	at91_pit_reset(data);
 
 	/*
 	 * Register clocksource.  The high order bits of PIV are unused,
 	 * so this isn't a 32-bit counter unless we get clockevent irqs.
 	 */
-	bits = 12 /* PICNT */ + ilog2(pit_cycle) /* PIV */;
-	pit_clk.mask = CLOCKSOURCE_MASK(bits);
-	clocksource_register_hz(&pit_clk, pit_rate);
+	at91_pit_register_clocksource(data, pit_rate);
 
 	/* Set up irq handler */
-	setup_irq(AT91_ID_SYS, &at91sam926x_pit_irq);
+	setup_irq(irq, &data->irqaction);
 
 	/* Set up and register clockevents */
-	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
-	pit_clkevt.cpumask = cpumask_of(0);
-	clockevents_register_device(&pit_clkevt);
+	at91_pit_register_clockevent(data, pit_rate);
+
+	return 0;
+
+err0:
+	return ret;
+}
+
+static int __devinit at91_pit_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct at91_pit_data *data;
+
+	if (!is_early_platform_device(pdev)) {
+		pr_info("at91_pit.%d: call via non early plaform\n", pdev->id);
+		return 0;
+	}
+
+	data = kmalloc(sizeof(struct at91_pit_data), GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	ret = at91_pit_setup(data, pdev);
+
+	if (ret)
+		kfree(data);
+
+	return ret;
 }
 
-static void at91sam926x_pit_suspend(void)
+static int __devexit at91_pit_remove(struct platform_device *pdev)
 {
-	/* Disable timer */
-	at91_sys_write(AT91_PIT_MR, 0);
+	return -EBUSY; /* cannot unregister clockevent and clocksource */
 }
 
-struct sys_timer at91sam926x_timer = {
-	.init		= at91sam926x_pit_init,
-	.suspend	= at91sam926x_pit_suspend,
-	.resume		= at91sam926x_pit_reset,
+static struct platform_driver at91_pit_device_driver = {
+	.probe		= at91_pit_probe,
+	.remove		= __devexit_p(at91_pit_remove),
+	.driver		= {
+		.name	= "at91_pit",
+	}
 };
+
+early_platform_init("earlytimer", &at91_pit_device_driver);
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 0fee23f..077eecf 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -402,6 +402,11 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
+struct at91_dev_resource at91sam9g45_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91sam9g45_soc = {
 	.name = "at91sam9g45",
 	.default_irq_priority = at91sam9g45_default_irq_priority,
@@ -410,4 +415,5 @@ struct at91_soc __initdata at91sam9g45_soc = {
 		.resource = at91sam9g45_pios,
 		.num_resources = ARRAY_SIZE(at91sam9g45_pios),
 	},
+	.pit = &at91sam9g45_pit,
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index ec62ca01..7623617 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -368,6 +368,11 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
+struct at91_dev_resource at91sam9rl_pit __initdata = {
+	.mmio_base	= AT91_PIT,
+	.irq		= AT91_ID_SYS,
+};
+
 struct at91_soc __initdata at91sam9rl_soc = {
 	.name = "at91sam9rl",
 	.default_irq_priority = at91sam9rl_default_irq_priority,
@@ -376,4 +381,5 @@ struct at91_soc __initdata at91sam9rl_soc = {
 		.resource = at91sam9rl_pios,
 		.num_resources = ARRAY_SIZE(at91sam9rl_pios),
 	},
+	.pit = &at91sam9rl_pit,
 };
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 3103bb1..71304fe 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -219,7 +219,7 @@ static void __init afeb9260_board_init(void)
 MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= afeb9260_map_io,
 	.init_irq	= afeb9260_init_irq,
 	.init_machine	= afeb9260_board_init,
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 1d24493..61d11af 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -316,7 +316,7 @@ static void __init eb_board_init(void)
 MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	/* Maintainer: Atmel <costa.antonior@gmail.com> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= eb_map_io,
 	.init_irq	= eb_init_irq,
 	.init_machine	= eb_board_init,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index d3a65e2..5d65fe5 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -199,7 +199,7 @@ static void __init cam60_board_init(void)
 MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= cam60_map_io,
 	.init_irq	= cam60_init_irq,
 	.init_machine	= cam60_board_init,
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 8f0a53e..939a2a6 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -397,7 +397,7 @@ static void __init cap9adk_board_init(void)
 MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= cap9adk_map_io,
 	.init_irq	= cap9adk_init_irq,
 	.init_machine	= cap9adk_board_init,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 544995c..625f485 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -376,7 +376,7 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 #endif
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= cpu9krea_map_io,
 	.init_irq	= cpu9krea_init_irq,
 	.init_machine	= cpu9krea_board_init,
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 15cf7ab..478ae2f 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -155,7 +155,7 @@ static void __init flexibity_board_init(void)
 MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= flexibity_map_io,
 	.init_irq	= flexibity_init_irq,
 	.init_machine	= flexibity_board_init,
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 53032d4..51de65f 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -267,7 +267,7 @@ static void __init foxg20_board_init(void)
 MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= foxg20_map_io,
 	.init_irq	= foxg20_init_irq,
 	.init_machine	= foxg20_board_init,
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 41f7164..8d40325 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -577,7 +577,7 @@ static void __init gsia18s_board_init(void)
 
 MACHINE_START(GSIA18S, "GS_IA18_S")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= gsia18s_map_io,
 	.init_irq	= init_irq,
 	.init_machine	= gsia18s_board_init,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 2d1dec2..b313b7e 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -388,7 +388,7 @@ static void __init neocore926_board_init(void)
 MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= neocore926_map_io,
 	.init_irq	= neocore926_init_irq,
 	.init_machine	= neocore926_board_init,
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index aa0a660..b577569 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -223,7 +223,7 @@ static void __init pcontrol_g20_board_init(void)
 MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= pcontrol_g20_map_io,
 	.init_irq	= init_irq,
 	.init_machine	= pcontrol_g20_board_init,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index e26fa6e..b131aab 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -269,7 +269,7 @@ static void __init ek_board_init(void)
 MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index e4e19aa..2b569e6 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -213,7 +213,7 @@ static void __init ek_board_init(void)
 MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 2307a1c..e27951f 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -354,7 +354,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index e1c4274..9160999 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -621,7 +621,7 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 #endif
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 43c421d..1dfb4ad 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -452,7 +452,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 5a5df34..aff0782 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -404,7 +404,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
@@ -413,7 +413,7 @@ MACHINE_END
 MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index fef316a..9aa68d7 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -422,7 +422,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 535c975..4020808 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -330,7 +330,7 @@ static void __init ek_board_init(void)
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index a5d5d89..b5a8bd8 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -179,7 +179,7 @@ static void __init snapper9260_board_init(void)
 
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= snapper9260_map_io,
 	.init_irq	= snapper9260_init_irq,
 	.init_machine	= snapper9260_board_init,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 1b435c3..1c92df0 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -299,7 +299,7 @@ static void __init stamp9g20evb_board_init(void)
 MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= portuxg20_map_io,
 	.init_irq	= init_irq,
 	.init_machine	= portuxg20_board_init,
@@ -308,7 +308,7 @@ MACHINE_END
 MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= stamp9g20evb_map_io,
 	.init_irq	= init_irq,
 	.init_machine	= stamp9g20evb_board_init,
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index a1cb555..349e31a 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -280,7 +280,7 @@ static void __init ek_board_init(void)
 MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
@@ -289,7 +289,7 @@ MACHINE_END
 MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
-	.timer		= &at91sam926x_timer,
+	.timer		= &at91_timer,
 	.map_io		= ek_map_io,
 	.init_irq	= ek_init_irq,
 	.init_machine	= ek_board_init,
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 03ded48..b11154d 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -8,8 +8,8 @@
  *
  */
 
-#include <linux/platform_device.h>
 
-#include "devices.h"
+
+#include "soc.h"
 
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index b2c7c3a..1cfe696 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -23,7 +23,7 @@ extern void __init at91_aic_init(unsigned int priority[]);
  /* Timer */
 struct sys_timer;
 extern struct sys_timer at91rm9200_timer;
-extern struct sys_timer at91sam926x_timer;
+extern struct sys_timer at91_timer;
 extern struct sys_timer at91x40_timer;
 
  /* Clocks */
diff --git a/arch/arm/mach-at91/include/mach/at91_pit.h b/arch/arm/mach-at91/include/mach/at91_pit.h
index 974d0bd..380ef93 100644
--- a/arch/arm/mach-at91/include/mach/at91_pit.h
+++ b/arch/arm/mach-at91/include/mach/at91_pit.h
@@ -16,16 +16,16 @@
 #ifndef AT91_PIT_H
 #define AT91_PIT_H
 
-#define AT91_PIT_MR		(AT91_PIT + 0x00)	/* Mode Register */
+#define AT91_PIT_MR		(0x00)			/* Mode Register */
 #define		AT91_PIT_PITIEN		(1 << 25)		/* Timer Interrupt Enable */
 #define		AT91_PIT_PITEN		(1 << 24)		/* Timer Enabled */
 #define		AT91_PIT_PIV		(0xfffff)		/* Periodic Interval Value */
 
-#define AT91_PIT_SR		(AT91_PIT + 0x04)	/* Status Register */
+#define AT91_PIT_SR		(0x04)			/* Status Register */
 #define		AT91_PIT_PITS		(1 << 0)		/* Timer Status */
 
-#define AT91_PIT_PIVR		(AT91_PIT + 0x08)	/* Periodic Interval Value Register */
-#define AT91_PIT_PIIR		(AT91_PIT + 0x0c)	/* Periodic Interval Image Register */
+#define AT91_PIT_PIVR		(0x08)			/* Periodic Interval Value Register */
+#define AT91_PIT_PIIR		(0x0c)			/* Periodic Interval Image Register */
 #define		AT91_PIT_PICNT		(0xfff << 20)		/* Interval Counter */
 #define		AT91_PIT_CPIV		(0xfffff)		/* Inverval Value */
 
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
index 0e8604c..7b44be2 100644
--- a/arch/arm/mach-at91/soc.c
+++ b/arch/arm/mach-at91/soc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 #include <mach/hardware.h>
 #include <mach/cpu.h>
@@ -212,3 +213,44 @@ static void __init at91_add_gpio(void)
 	early_platform_driver_register_all("early_at91_gpio");
 	early_platform_driver_probe("early_at91_gpio", nb , 0);
 }
+
+/*
+ * Set up both clocksource and clockevent support.
+ */
+static struct resource pit_resources[] = {
+	[0] = RES_MEM(SZ_16),
+	[1] = RES_IRQ(),
+};
+
+static struct platform_device at91_pit_device = {
+	.name		= "at91_pit",
+	.id		= 0,
+	.resource	= pit_resources,
+	.num_resources	= ARRAY_SIZE(pit_resources),
+};
+
+static void __init at91_timer_init(void)
+{
+	struct at91_dev_resource *res;
+	struct platform_device *pdev;
+	struct resource *r;
+
+	BUG_ON(!current_soc.pit);
+
+	if (current_soc.pit) {
+		r = pit_resources;
+		res = current_soc.pit;
+		pdev = &at91_pit_device;
+	}
+
+	set_resource_mem(&r[0], res->mmio_base);
+	set_resource_irq(&r[1], res->irq);
+
+	early_platform_add_devices(&pdev, 1);
+	early_platform_driver_register_all("earlytimer");
+	early_platform_driver_probe("earlytimer", 1 , 0);
+}
+
+struct sys_timer at91_timer = {
+	.init		= at91_timer_init,
+};
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index bf90d48..8df07a2 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -13,6 +13,7 @@ struct at91_soc {
 	unsigned int *default_irq_priority;
 
 	struct at91_dev_resource_array gpio;
+	struct at91_dev_resource *pit;
 
 	void (*init)(unsigned long main_clock);
 };
-- 
1.7.4.1
