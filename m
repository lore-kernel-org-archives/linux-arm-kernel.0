From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 4 Apr 2011 14:29:58 +0200 (CEST)
Subject: [PATCH] arm: plat-mxc: Add missing lockdep annotation
Message-ID: <alpine.LFD.2.00.1104041416290.19945@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_set_wake() function of the gpio irq_chip calls
enable/disable_irq_wake() on the demultiplex interrupt. That leads to
a lockdep warning "INFO: possible recursive locking detected" because
irq_set_type() is called under irq_desc->lock and the *_irq_wake()
calls take irq_desc->lock of the demux interrupt.

Tell lockdep that the gpio irqs are in a different lock class.

Documentation/SubmitChecklist:
 15: All codepaths have been exercised with all lockdep features enabled.

That's a non-optional requirement, AFAICT.

Reported-and-tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 7a10724..6cd6d7f 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -295,6 +295,12 @@ static int mxc_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+/*
+ * This lock class tells lockdep that GPIO irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key gpio_lock_class;
+
 int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 {
 	int i, j;
@@ -311,6 +317,7 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 		__raw_writel(~0, port[i].base + GPIO_ISR);
 		for (j = port[i].virtual_irq_start;
 			j < port[i].virtual_irq_start + 32; j++) {
+			irq_set_lockdep_class(j, &gpio_lock_class);
 			irq_set_chip_and_handler(j, &gpio_irq_chip,
 						 handle_level_irq);
 			set_irq_flags(j, IRQF_VALID);
