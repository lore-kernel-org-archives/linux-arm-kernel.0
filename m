From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 23:18:15 +0200
Subject: [PATCH 4/4] ARM: at91/pit: add DT support
In-Reply-To: <20111016210819.GM1459@game.jcrosoft.org>
References: <20111016210819.GM1459@game.jcrosoft.org>
Message-ID: <1318799895-5121-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi    |    6 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi    |    6 +++++
 arch/arm/mach-at91/at91sam926x_time.c |   37 +++++++++++++++++++++++++++++++-
 arch/arm/mach-at91/setup.c            |    2 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index d6afa5f..de5fbb3 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -54,6 +54,12 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pit: timer at fffffd30 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfffffd30 0xf>;
+				interrupts = <1>;
+			};
+
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e092666..c1d0ab5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -53,6 +53,12 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pit: timer at fffffd30 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfffffd30 0xf>;
+				interrupts = <1>;
+			};
+
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 20d0801..e5f8c38 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/mach/time.h>
 
@@ -133,7 +135,8 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 static struct irqaction at91sam926x_pit_irq = {
 	.name		= "at91_tick",
 	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= at91sam926x_pit_interrupt
+	.handler	= at91sam926x_pit_interrupt,
+	.irq		= AT91_ID_SYS,
 };
 
 static void at91sam926x_pit_reset(void)
@@ -149,6 +152,34 @@ static void at91sam926x_pit_reset(void)
 	pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id timer_ids[] = {
+	{ .compatible = "atmel,at91sam9260-pit" },
+};
+
+void __init of_at91sam926x_pit_init(void)
+{
+	struct device_node *np;
+	const unsigned int *intspec;
+
+	np = of_find_matching_node(NULL, timer_ids);
+	if (!np)
+		panic("unable to find compatible timer node in dtb\n");
+	pit_base_addr = of_iomap(np, 0);
+	if (!pit_base_addr)
+		panic("unable to map timer cpu registers\n");
+
+	/* Get the interrupts property */
+	intspec = of_get_property(np, "interrupts", NULL);
+	BUG_ON(!intspec);
+	at91sam926x_pit_irq.irq = be32_to_cpup(intspec);
+
+	of_node_put(np);
+}
+#else
+static void __init of_at91sam926x_pit_init(void) {}
+#endif
+
 /*
  * Set up both clocksource and clockevent support.
  */
@@ -157,6 +188,8 @@ static void __init at91sam926x_pit_init(void)
 	unsigned long	pit_rate;
 	unsigned	bits;
 
+	of_at91sam926x_pit_init();
+
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
 	 * 1/HZ period (instead of a compile-time constant LATCH).
@@ -177,7 +210,7 @@ static void __init at91sam926x_pit_init(void)
 	clocksource_register_hz(&pit_clk, pit_rate);
 
 	/* Set up irq handler */
-	setup_irq(AT91_ID_SYS, &at91sam926x_pit_irq);
+	setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
 
 	/* Set up and register clockevents */
 	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 007fd95..674b64c 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -287,7 +287,9 @@ void __init at91_map_io(void)
 
 void __init at91_initialize(unsigned long main_clock)
 {
+#ifndef CONFIG_OF
 	at91_boot_soc.map_register();
+#endif
 
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
-- 
1.7.7
