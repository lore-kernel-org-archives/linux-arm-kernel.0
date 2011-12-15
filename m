From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:04 +0100
Subject: [PATCH 2/6] ARM: at91/gpio: add irqdomain to gpio interrupts
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <56e135f94dc4d88ab6d586f13e406977c4f4bb35.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/gpio.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 74d6783..7ffb893 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
@@ -32,6 +33,7 @@ struct at91_gpio_chip {
 	int			id;		/* ID of register bank */
 	void __iomem		*regbase;	/* Base of register bank */
 	struct clk		*clock;		/* associated clock */
+	struct irq_domain	domain;		/* associated irq domain */
 };
 
 #define to_at91_gpio_chip(c) container_of(c, struct at91_gpio_chip, chip)
@@ -483,6 +485,24 @@ postcore_initcall(at91_gpio_debugfs_init);
 /*--------------------------------------------------------------------------*/
 
 /*
+ * irqdomain initialization: pile up irqdomains on top of AIC range
+ */
+static void __init at91_gpio_irqdomain(struct at91_gpio_chip *at91_gpio)
+{
+	struct irq_domain	*gpio_irq_d = &at91_gpio->domain;
+	int			ret;
+
+	ret = irq_alloc_descs(-1, 0, at91_gpio->chip.ngpio, 0);
+	if (ret < 0)
+		panic("at91_gpio.%d: error %d: couldn't allocate IRQ numbers.\n",
+			at91_gpio->id, ret);
+	gpio_irq_d->irq_base = ret;
+	gpio_irq_d->nr_irq = at91_gpio->chip.ngpio;
+	gpio_irq_d->ops = &irq_domain_simple_ops;
+	irq_domain_add(gpio_irq_d);
+}
+
+/*
  * This lock class tells lockdep that GPIO irqs are in a different
  * category than their parents, so it won't report false recursion.
  */
@@ -493,19 +513,22 @@ static struct lock_class_key gpio_lock_class;
  */
 void __init at91_gpio_irq_setup(void)
 {
-	unsigned		pioc, irq = gpio_to_irq(0);
+	unsigned		pioc;
+	int			irq = 0;
 	struct at91_gpio_chip	*this, *prev;
 
 	for (pioc = 0, this = gpio_chip, prev = NULL;
 			pioc++ < gpio_banks;
 			prev = this, this++) {
 		unsigned	id = this->id;
-		unsigned	i;
+		int		hwirq;
 
 		__raw_writel(~0, this->regbase + PIO_IDR);
 
-		for (i = 0, irq = gpio_to_irq(this->chip.base); i < 32;
-		     i++, irq++) {
+		/* setup irq domain for this GPIO controller */
+		at91_gpio_irqdomain(this);
+
+		irq_domain_for_each_irq((&this->domain), hwirq, irq) {
 			irq_set_lockdep_class(irq, &gpio_lock_class);
 
 			/*
@@ -527,7 +550,8 @@ void __init at91_gpio_irq_setup(void)
 		irq_set_chip_data(id, this);
 		irq_set_chained_handler(id, gpio_irq_handler);
 	}
-	pr_info("AT91: %d gpio irqs in %d banks\n", irq - gpio_to_irq(0), gpio_banks);
+	pr_info("AT91: %d gpio irqs in %d banks\n",
+		irq - irq_domain_to_irq(&gpio_chip[0].domain, 0), gpio_banks);
 }
 
 /* gpiolib support */
-- 
1.7.5.4
