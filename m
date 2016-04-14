From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:44 +0930
Subject: [PATCH 4/9] clocksource/moxart: Generalise timer for use on other socs
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-5-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The moxart timer IP is shared with another soc made by Aspeed.
Generalise the registers that differ so the same driver can be used for
both.

As we now depend on CLKSRC_MMIO, create a Kconfig symbol for the driver
so we can express this dependency.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/timer/moxa,moxart-timer.txt           |  4 +-
 drivers/clocksource/Kconfig                        |  6 ++
 drivers/clocksource/Makefile                       |  2 +-
 drivers/clocksource/moxart_timer.c                 | 90 +++++++++++++++++-----
 4 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
index da2d510cae47..4569757142f8 100644
--- a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
+++ b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
@@ -2,7 +2,9 @@ MOXA ART timer
 
 Required properties:
 
-- compatible : Must be "moxa,moxart-timer"
+- compatible : Must be one of
+     - "moxa,moxart-timer"
+     - "aspeed,ast2400-timer"
 - reg : Should contain registers location and length
 - interrupts : Should contain the timer interrupt number
 - clocks : Should contain phandle for the clock that drives the counter
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c346be650892..b14ac4db6961 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -411,4 +411,10 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config MOXART_TIMER
+	def_bool ARCH_MOXART || ARCH_ASPEED
+	depends on ARM && OF
+	select CLKSRC_OF
+	select CLKSRC_MMIO
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dc2b8997f6e6..14fe8172c174 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
-obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
+obj-$(CONFIG_MOXART_TIMER)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index 19857af651c1..47ecef0725bd 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -36,45 +36,66 @@
 #define TIMER_INTR_MASK		0x38
 
 /*
- * TIMER_CR flags:
+ * Moxart TIMER_CR flags:
  *
  * TIMEREG_CR_*_CLOCK	0: PCLK, 1: EXT1CLK
  * TIMEREG_CR_*_INT	overflow interrupt enable bit
  */
-#define TIMEREG_CR_1_ENABLE	BIT(0)
-#define TIMEREG_CR_1_CLOCK	BIT(1)
-#define TIMEREG_CR_1_INT	BIT(2)
-#define TIMEREG_CR_2_ENABLE	BIT(3)
-#define TIMEREG_CR_2_CLOCK	BIT(4)
-#define TIMEREG_CR_2_INT	BIT(5)
-#define TIMEREG_CR_3_ENABLE	BIT(6)
-#define TIMEREG_CR_3_CLOCK	BIT(7)
-#define TIMEREG_CR_3_INT	BIT(8)
-#define TIMEREG_CR_COUNT_UP	BIT(9)
-
-#define TIMER1_ENABLE		(TIMEREG_CR_2_ENABLE | TIMEREG_CR_1_ENABLE)
-#define TIMER1_DISABLE		(TIMEREG_CR_2_ENABLE)
+#define MOXART_CR_1_ENABLE	BIT(0)
+#define MOXART_CR_1_CLOCK	BIT(1)
+#define MOXART_CR_1_INT		BIT(2)
+#define MOXART_CR_2_ENABLE	BIT(3)
+#define MOXART_CR_2_CLOCK	BIT(4)
+#define MOXART_CR_2_INT		BIT(5)
+#define MOXART_CR_3_ENABLE	BIT(6)
+#define MOXART_CR_3_CLOCK	BIT(7)
+#define MOXART_CR_3_INT		BIT(8)
+#define MOXART_CR_COUNT_UP	BIT(9)
+
+#define MOXART_TIMER1_ENABLE	(MOXART_CR_2_ENABLE | MOXART_CR_1_ENABLE)
+#define MOXART_TIMER1_DISABLE	(MOXART_CR_2_ENABLE)
+
+/*
+ * The ASpeed variant of the IP block has a different layout
+ * for the control register
+ */
+#define ASPEED_CR_1_ENABLE	BIT(0)
+#define ASPEED_CR_1_CLOCK	BIT(1)
+#define ASPEED_CR_1_INT		BIT(2)
+#define ASPEED_CR_2_ENABLE	BIT(4)
+#define ASPEED_CR_2_CLOCK	BIT(5)
+#define ASPEED_CR_2_INT		BIT(6)
+#define ASPEED_CR_3_ENABLE	BIT(8)
+#define ASPEED_CR_3_CLOCK	BIT(9)
+#define ASPEED_CR_3_INT		BIT(10)
+
+#define ASPEED_TIMER1_ENABLE	(ASPEED_CR_2_ENABLE | ASPEED_CR_1_ENABLE)
+#define ASPEED_TIMER1_DISABLE	(ASPEED_CR_2_ENABLE)
 
 static void __iomem *base;
 static unsigned int clock_count_per_tick;
+static unsigned int t1_disable_val, t1_enable_val;
 
 static int moxart_shutdown(struct clock_event_device *evt)
 {
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	writel(t1_disable_val, base + TIMER_CR);
 	return 0;
 }
 
 static int moxart_set_oneshot(struct clock_event_device *evt)
 {
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	writel(t1_disable_val, base + TIMER_CR);
 	writel(~0, base + TIMER1_BASE + REG_LOAD);
 	return 0;
 }
 
 static int moxart_set_periodic(struct clock_event_device *evt)
 {
+	writel(t1_disable_val, base + TIMER_CR);
 	writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
-	writel(TIMER1_ENABLE, base + TIMER_CR);
+	writel(0, base + TIMER1_BASE + REG_MATCH1);
+	writel(t1_enable_val, base + TIMER_CR);
+
 	return 0;
 }
 
@@ -83,12 +104,12 @@ static int moxart_clkevt_next_event(unsigned long cycles,
 {
 	u32 u;
 
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	writel(t1_disable_val, base + TIMER_CR);
 
 	u = readl(base + TIMER1_BASE + REG_COUNT) - cycles;
 	writel(u, base + TIMER1_BASE + REG_MATCH1);
 
-	writel(TIMER1_ENABLE, base + TIMER_CR);
+	writel(t1_enable_val, base + TIMER_CR);
 
 	return 0;
 }
@@ -119,7 +140,7 @@ static struct irqaction moxart_timer_irq = {
 	.dev_id		= &moxart_clockevent,
 };
 
-static void __init moxart_timer_init(struct device_node *node)
+static void __init __moxart_timer_init(struct device_node *node)
 {
 	int ret, irq;
 	unsigned long pclk;
@@ -150,8 +171,19 @@ static void __init moxart_timer_init(struct device_node *node)
 
 	clock_count_per_tick = DIV_ROUND_CLOSEST(pclk, HZ);
 
+	/* Clear match registers */
+	writel(0, base + TIMER1_BASE + REG_MATCH1);
+	writel(0, base + TIMER1_BASE + REG_MATCH2);
+	writel(0, base + TIMER2_BASE + REG_MATCH1);
+	writel(0, base + TIMER2_BASE + REG_MATCH2);
+
+	/* Start timer 2 rolling as our main wall clock source, keep timer 1
+	 * disabled
+	 */
+	writel(0, base + TIMER_CR);
 	writel(~0, base + TIMER2_BASE + REG_LOAD);
-	writel(TIMEREG_CR_2_ENABLE, base + TIMER_CR);
+	writel(t1_disable_val, base + TIMER_CR);
+
 
 	moxart_clockevent.cpumask = cpumask_of(0);
 	moxart_clockevent.irq = irq;
@@ -165,4 +197,20 @@ static void __init moxart_timer_init(struct device_node *node)
 	clockevents_config_and_register(&moxart_clockevent, pclk,
 					0x4, 0xfffffffe);
 }
+
+static void __init moxart_timer_init(struct device_node *node)
+{
+	t1_enable_val = MOXART_TIMER1_ENABLE;
+	t1_disable_val = MOXART_TIMER1_DISABLE;
+	__moxart_timer_init(node);
+}
+
+static void __init aspeed_timer_init(struct device_node *node)
+{
+	t1_enable_val = ASPEED_TIMER1_ENABLE;
+	t1_disable_val = ASPEED_TIMER1_DISABLE;
+	__moxart_timer_init(node);
+}
+
 CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);
+CLOCKSOURCE_OF_DECLARE(aspeed, "aspeed,ast2400-timer", aspeed_timer_init);
-- 
2.7.4
