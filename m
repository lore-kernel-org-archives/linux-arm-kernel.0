From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 Jul 2012 17:35:39 +0200
Subject: [PATCH 2/2] GPIO: gpio-pxa: fix devicetree functions
In-Reply-To: <1343230539-7196-1-git-send-email-zonque@gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
Message-ID: <1343230539-7196-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide an of_xlate function for the PXA GPIO chips and make it work for
devicetree environments.

Successfully tested on a PXA3xx board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/gpio/gpio-pxa.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 6d0cb9d..f47e6b3 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -63,6 +63,7 @@ static int irq_base;
 
 #ifdef CONFIG_OF
 static struct irq_domain *domain;
+static struct device_node *pxa_gpio_of_node;
 #endif
 
 struct pxa_gpio_chip {
@@ -229,6 +230,24 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
+#ifdef CONFIG_OF_GPIO
+static int pxa_gpio_of_xlate(struct gpio_chip *gc,
+			     const struct of_phandle_args *gpiospec,
+			     u32 *flags)
+{
+	if (gpiospec->args[0] > pxa_last_gpio)
+		return -EINVAL;
+
+	if (gc != &pxa_gpio_chips[gpiospec->args[0] / 32].chip)
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[1];
+
+	return gpiospec->args[0] % 32;
+}
+#endif
+
 static int __devinit pxa_init_gpio_chip(int gpio_end,
 					int (*set_wake)(unsigned int, unsigned int))
 {
@@ -256,6 +275,11 @@ static int __devinit pxa_init_gpio_chip(int gpio_end,
 		c->get = pxa_gpio_get;
 		c->set = pxa_gpio_set;
 		c->to_irq = pxa_gpio_to_irq;
+#ifdef CONFIG_OF_GPIO
+		c->of_node = pxa_gpio_of_node;
+		c->of_xlate = pxa_gpio_of_xlate;
+		c->of_gpio_n_cells = 2;
+#endif
 
 		/* number of GPIOs on last bank may be less than 32 */
 		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
@@ -457,6 +481,7 @@ static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 const struct irq_domain_ops pxa_irq_domain_ops = {
 	.map	= pxa_irq_domain_map,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 #ifdef CONFIG_OF
@@ -497,6 +522,7 @@ static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev)
 	}
 	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
 				       &pxa_irq_domain_ops, NULL);
+	pxa_gpio_of_node = np;
 	return 0;
 err:
 	iounmap(gpio_reg_base);
-- 
1.7.10.4
