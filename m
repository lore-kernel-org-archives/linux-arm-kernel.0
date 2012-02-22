From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 22 Feb 2012 15:32:48 +0100
Subject: [PATCH v5 1/2] ARM: at91: pit add DT support
In-Reply-To: <1325866830-13259-1-git-send-email-nicolas.ferre@atmel.com>
References: <1325866830-13259-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <06c78dfd072dd03b45acbecb0380ce67de0bee70.1329920069.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Retreive registers address and IRQ from device tree entry.
Called from at91_dt_init_irq() so that timers are up-n-running
when timers initialization will occur.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
[nicolas.ferre at atmel.com: change error path and interrupts property handling]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

I have removed Rob's "Acked-by" and Jamie's "Reviewed-by" because I have changed
the way PIT is initialized. Do you want to put it back? 

v5: - of_at91sam926x_pit_init() now called from at91sam926x_pit_init()
      which is the init function of the system tick timer.
    - get out of at91sam926x_ioremap_pit() if matching node found in DT.

v4: - change of_at91sam926x_pit_init() return value usage logic as
      suggested by Rob Herring
    - irq_of_parse_and_map() returns 0 on error: change test according to 
      Grant Likely note.

v3: - use irq_of_parse_and_map() for handling irq numbers specified by DT.
      Correction proposed by Jamie Iles.

v2: - new specification of irq numbers in DT (due to modification of AIC code)
    - new error path in of_at91sam926x_pit_init()
    - fall back to built-in values if an error occurs
    - use of of_property_read_u32() to get irq property

 .../devicetree/bindings/arm/atmel-at91.txt         |    8 +++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |    6 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 ++
 arch/arm/mach-at91/at91sam926x_time.c              |   63 +++++++++++++++++++-
 arch/arm/mach-at91/at91sam9x5.c                    |    2 -
 arch/arm/mach-at91/generic.h                       |    1 +
 6 files changed, 82 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
new file mode 100644
index 0000000..380f711
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -0,0 +1,8 @@
+Atmel AT91 device tree bindings.
+================================
+
+PIT Timer required properties:
+- compatible: Should be "atmel,at91sam9260-pit"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt for the PIT which is the IRQ line
+  shared across all System Controller members.
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 325989a..04c56c4 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -57,6 +57,12 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pit: timer at fffffd30 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfffffd30 0xf>;
+				interrupts = <1 4>;
+			};
+
 			pioA: gpio at fffff400 {
 				compatible = "atmel,at91rm9200-gpio";
 				reg = <0xfffff400 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index a9dbbb5..3881cab 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -58,6 +58,12 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pit: timer at fffffd30 {
+				compatible = "atmel,at91sam9260-pit";
+				reg = <0xfffffd30 0xf>;
+				interrupts = <1 4>;
+			};
+
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index d89ead7..8e5cc37 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -14,6 +14,9 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
 
@@ -133,7 +136,8 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 static struct irqaction at91sam926x_pit_irq = {
 	.name		= "at91_tick",
 	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= at91sam926x_pit_interrupt
+	.handler	= at91sam926x_pit_interrupt,
+	.irq		= AT91_ID_SYS,
 };
 
 static void at91sam926x_pit_reset(void)
@@ -149,6 +153,49 @@ static void at91sam926x_pit_reset(void)
 	pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id pit_timer_ids[] = {
+	{ .compatible = "atmel,at91sam9260-pit" },
+	{ /* sentinel */ }
+};
+
+int __init of_at91sam926x_pit_init(void)
+{
+	struct device_node	*np;
+	int			ret;
+
+	np = of_find_matching_node(NULL, pit_timer_ids);
+	if (!np)
+		goto err;
+
+	pit_base_addr = of_iomap(np, 0);
+	if (!pit_base_addr)
+		goto node_err;
+
+	/* Get the interrupts property */
+	ret = irq_of_parse_and_map(np, 0);
+	if (!ret)
+		goto ioremap_err;
+	at91sam926x_pit_irq.irq = ret;
+
+	of_node_put(np);
+
+	return 0;
+
+ioremap_err:
+	iounmap(pit_base_addr);
+node_err:
+	of_node_put(np);
+err:
+	return -EINVAL;
+}
+#else
+int __init of_at91sam926x_pit_init(void)
+{
+	return -EINVAL;
+}
+#endif
+
 /*
  * Set up both clocksource and clockevent support.
  */
@@ -157,6 +204,9 @@ static void __init at91sam926x_pit_init(void)
 	unsigned long	pit_rate;
 	unsigned	bits;
 
+	/* For device tree enabled device: initialize here */
+	of_at91sam926x_pit_init();
+
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
 	 * 1/HZ period (instead of a compile-time constant LATCH).
@@ -177,7 +227,7 @@ static void __init at91sam926x_pit_init(void)
 	clocksource_register_hz(&pit_clk, pit_rate);
 
 	/* Set up irq handler */
-	setup_irq(AT91_ID_SYS, &at91sam926x_pit_irq);
+	setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
 
 	/* Set up and register clockevents */
 	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
@@ -193,6 +243,15 @@ static void at91sam926x_pit_suspend(void)
 
 void __init at91sam926x_ioremap_pit(u32 addr)
 {
+#if defined(CONFIG_OF)
+	struct device_node *np =
+		of_find_matching_node(NULL, pit_timer_ids);
+
+	if (np) {
+		of_node_put(np);
+		return;
+	}
+#endif
 	pit_base_addr = ioremap(addr, 16);
 
 	if (!pit_base_addr)
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 1c3444d..3e33711 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -301,8 +301,6 @@ static void __init at91sam9x5_map_io(void)
 
 static void __init at91sam9x5_ioremap_registers(void)
 {
-	if (of_at91sam926x_pit_init() < 0)
-		panic("Impossible to find PIT\n");
 }
 
 void __init at91sam9x5_initialize(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0726f42..c5d16e5 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -33,6 +33,7 @@ extern int  __init at91_aic_of_init(struct device_node *node,
  /* Timer */
 struct sys_timer;
 extern struct sys_timer at91rm9200_timer;
+extern int of_at91sam926x_pit_init(void);
 extern void at91sam926x_ioremap_pit(u32 addr);
 extern struct sys_timer at91sam926x_timer;
 extern struct sys_timer at91x40_timer;
-- 
1.7.9
