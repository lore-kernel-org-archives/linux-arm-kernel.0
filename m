From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:39 +0100
Subject: [PATCH 06/13 v2] ARM: at91: make pit register base soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c                 |    1 +
 arch/arm/mach-at91/at91sam9260.c              |    1 +
 arch/arm/mach-at91/at91sam9261.c              |    1 +
 arch/arm/mach-at91/at91sam9263.c              |    1 +
 arch/arm/mach-at91/at91sam926x_time.c         |   38 ++++++++++++++++++------
 arch/arm/mach-at91/at91sam9g45.c              |    1 +
 arch/arm/mach-at91/at91sam9rl.c               |    1 +
 arch/arm/mach-at91/generic.h                  |    1 +
 arch/arm/mach-at91/include/mach/at91_pit.h    |    8 ++--
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 15 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 3687207..abfe368 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -335,6 +335,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
 }
 
 static void __init at91cap9_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 0e54928..0030d5f 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -327,6 +327,7 @@ static void __init at91sam9260_map_io(void)
 
 static void __init at91sam9260_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
 }
 
 static void __init at91sam9260_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index dde8318..348d5ae 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -287,6 +287,7 @@ static void __init at91sam9261_map_io(void)
 
 static void __init at91sam9261_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
 }
 
 static void __init at91sam9261_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index fc442dd..09ccf73 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -305,6 +305,7 @@ static void __init at91sam9263_map_io(void)
 
 static void __init at91sam9263_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
 }
 
 static void __init at91sam9263_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 4ba8549..2426050 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -25,7 +25,17 @@
 
 static u32 pit_cycle;		/* write-once */
 static u32 pit_cnt;		/* access only w/system irq blocked */
+static void __iomem *pit_base_addr __read_mostly;
 
+static inline unsigned int pit_read(unsigned int reg_offset)
+{
+	return __raw_readl(pit_base_addr + reg_offset);
+}
+
+static inline void pit_write(unsigned int reg_offset, unsigned long value)
+{
+	__raw_writel(value, pit_base_addr + reg_offset);
+}
 
 /*
  * Clocksource:  just a monotonic counter of MCK/16 cycles.
@@ -39,7 +49,7 @@ static cycle_t read_pit_clk(struct clocksource *cs)
 
 	raw_local_irq_save(flags);
 	elapsed = pit_cnt;
-	t = at91_sys_read(AT91_PIT_PIIR);
+	t = pit_read(AT91_PIT_PIIR);
 	raw_local_irq_restore(flags);
 
 	elapsed += PIT_PICNT(t) * pit_cycle;
@@ -64,8 +74,8 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* update clocksource counter */
-		pit_cnt += pit_cycle * PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
+		pit_cnt += pit_cycle * PIT_PICNT(pit_read(AT91_PIT_PIVR));
+		pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
 				| AT91_PIT_PITIEN);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -74,7 +84,7 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
 		/* disable irq, leaving the clocksource active */
-		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+		pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
@@ -103,11 +113,11 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 
 	/* The PIT interrupt may be disabled, and is shared */
 	if ((pit_clkevt.mode == CLOCK_EVT_MODE_PERIODIC)
-			&& (at91_sys_read(AT91_PIT_SR) & AT91_PIT_PITS)) {
+			&& (pit_read(AT91_PIT_SR) & AT91_PIT_PITS)) {
 		unsigned nr_ticks;
 
 		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
+		nr_ticks = PIT_PICNT(pit_read(AT91_PIT_PIVR));
 		do {
 			pit_cnt += pit_cycle;
 			pit_clkevt.event_handler(&pit_clkevt);
@@ -129,14 +139,14 @@ static struct irqaction at91sam926x_pit_irq = {
 static void at91sam926x_pit_reset(void)
 {
 	/* Disable timer and irqs */
-	at91_sys_write(AT91_PIT_MR, 0);
+	pit_write(AT91_PIT_MR, 0);
 
 	/* Clear any pending interrupts, wait for PIT to stop counting */
-	while (PIT_CPIV(at91_sys_read(AT91_PIT_PIVR)) != 0)
+	while (PIT_CPIV(pit_read(AT91_PIT_PIVR)) != 0)
 		cpu_relax();
 
 	/* Start PIT but don't enable IRQ */
-	at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
+	pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
 }
 
 /*
@@ -178,7 +188,15 @@ static void __init at91sam926x_pit_init(void)
 static void at91sam926x_pit_suspend(void)
 {
 	/* Disable timer */
-	at91_sys_write(AT91_PIT_MR, 0);
+	pit_write(AT91_PIT_MR, 0);
+}
+
+void at91sam926x_ioremap_pit(u32 addr)
+{
+	pit_base_addr = ioremap(addr, 16);
+
+	if (!pit_base_addr)
+		panic("Impossible to ioremap PIT\n");
 }
 
 struct sys_timer at91sam926x_timer = {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 56282b2..aa8b441 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -340,6 +340,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
 }
 
 static void __init at91sam9g45_initialize(void)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 29dae9b..291fc99 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,6 +292,7 @@ static void __init at91sam9rl_map_io(void)
 
 static void __init at91sam9rl_ioremap_registers(void)
 {
+	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
 }
 
 static void __init at91sam9rl_initialize(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 11d7297..8196ecc 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -29,6 +29,7 @@ extern void __init at91_aic_init(unsigned int priority[]);
  /* Timer */
 struct sys_timer;
 extern struct sys_timer at91rm9200_timer;
+extern void at91sam926x_ioremap_pit(u32 addr);
 extern struct sys_timer at91sam926x_timer;
 extern struct sys_timer at91x40_timer;
 
diff --git a/arch/arm/mach-at91/include/mach/at91_pit.h b/arch/arm/mach-at91/include/mach/at91_pit.h
index 974d0bd..d1f80ad 100644
--- a/arch/arm/mach-at91/include/mach/at91_pit.h
+++ b/arch/arm/mach-at91/include/mach/at91_pit.h
@@ -16,16 +16,16 @@
 #ifndef AT91_PIT_H
 #define AT91_PIT_H
 
-#define AT91_PIT_MR		(AT91_PIT + 0x00)	/* Mode Register */
+#define AT91_PIT_MR		0x00			/* Mode Register */
 #define		AT91_PIT_PITIEN		(1 << 25)		/* Timer Interrupt Enable */
 #define		AT91_PIT_PITEN		(1 << 24)		/* Timer Enabled */
 #define		AT91_PIT_PIV		(0xfffff)		/* Periodic Interval Value */
 
-#define AT91_PIT_SR		(AT91_PIT + 0x04)	/* Status Register */
+#define AT91_PIT_SR		0x04			/* Status Register */
 #define		AT91_PIT_PITS		(1 << 0)		/* Timer Status */
 
-#define AT91_PIT_PIVR		(AT91_PIT + 0x08)	/* Periodic Interval Value Register */
-#define AT91_PIT_PIIR		(AT91_PIT + 0x0c)	/* Periodic Interval Image Register */
+#define AT91_PIT_PIVR		0x08			/* Periodic Interval Value Register */
+#define AT91_PIT_PIIR		0x0c			/* Periodic Interval Image Register */
 #define		AT91_PIT_PICNT		(0xfff << 20)		/* Interval Counter */
 #define		AT91_PIT_CPIV		(0xfffff)		/* Inverval Value */
 
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 1cb42a6..ad8d298 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -89,7 +89,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
 			(0xfffffd50 - AT91_BASE_SYS) :	\
@@ -102,6 +101,7 @@
 #define AT91CAP9_BASE_PIOC	0xfffff600
 #define AT91CAP9_BASE_PIOD	0xfffff800
 #define AT91CAP9_BASE_RTT	0xfffffd20
+#define AT91CAP9_BASE_PIT	0xfffffd30
 
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 6aa7ca9..b8c85dc 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -89,7 +89,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
@@ -98,6 +97,7 @@
 #define AT91SAM9260_BASE_PIOB	0xfffff600
 #define AT91SAM9260_BASE_PIOC	0xfffff800
 #define AT91SAM9260_BASE_RTT	0xfffffd20
+#define AT91SAM9260_BASE_PIT	0xfffffd30
 
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index f84b713..0dccaff 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -73,7 +73,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
@@ -81,6 +80,7 @@
 #define AT91SAM9261_BASE_PIOB	0xfffff600
 #define AT91SAM9261_BASE_PIOC	0xfffff800
 #define AT91SAM9261_BASE_RTT	0xfffffd20
+#define AT91SAM9261_BASE_PIT	0xfffffd30
 
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 938965e..735408e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -85,7 +85,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
@@ -97,6 +96,7 @@
 #define AT91SAM9263_BASE_PIOD	0xfffff800
 #define AT91SAM9263_BASE_PIOE	0xfffffa00
 #define AT91SAM9263_BASE_RTT0	0xfffffd20
+#define AT91SAM9263_BASE_PIT	0xfffffd30
 #define AT91SAM9263_BASE_RTT1	0xfffffd50
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 00638c6..ba609f3 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -95,7 +95,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
@@ -108,6 +107,7 @@
 #define AT91SAM9G45_BASE_PIOD	0xfffff800
 #define AT91SAM9G45_BASE_PIOE	0xfffffa00
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
+#define AT91SAM9G45_BASE_PIT	0xfffffd30
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 099cefc..bab09a7 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -78,7 +78,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
@@ -91,6 +90,7 @@
 #define AT91SAM9RL_BASE_PIOC	0xfffff800
 #define AT91SAM9RL_BASE_PIOD	0xfffffa00
 #define AT91SAM9RL_BASE_RTT	0xfffffd20
+#define AT91SAM9RL_BASE_PIT	0xfffffd30
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
-- 
1.7.7
