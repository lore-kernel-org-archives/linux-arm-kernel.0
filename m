From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 Apr 2012 13:37:24 +0200
Subject: [PATCH] arm/pxa: fix gpio wakeup setting
In-Reply-To: <CAN1soZyQPdcwRd5CtDz+iCV9h=Xq-ar=EBKyQ4ya_hE-PZLNXw@mail.gmail.com>
References: <CAN1soZyQPdcwRd5CtDz+iCV9h=Xq-ar=EBKyQ4ya_hE-PZLNXw@mail.gmail.com>
Message-ID: <1335094644-3546-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 3.3, gpio wakeup setting was broken. The call
enable_irq_wake() didn't set up the PXA gpio registers
(PWER, ...) anymore.

Fix it at least for pxa27x. The driver doesn't seem to be
used in pxa25x (weird ...), and the fix doesn't extend to
pxa3xx and pxa95x (which don't have a gpio_set_wake()
available).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa27x.c |    6 +++++-
 drivers/gpio/gpio-pxa.c    |   21 +++++++++++++++++++--
 include/linux/gpio-pxa.h   |    4 ++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6bce78e..4726c24 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -421,8 +421,11 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 	pxa_register_device(&pxa27x_device_i2c_power, info);
 }
 
+static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
+	.gpio_set_wake = gpio_set_wake,
+};
+
 static struct platform_device *devices[] __initdata = {
-	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -458,6 +461,7 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
+		pxa_register_device(&pxa_device_gpio, &pxa27x_gpio_info);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 5689ce6..fc3ace3 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -64,6 +64,7 @@ struct pxa_gpio_chip {
 	unsigned long	irq_mask;
 	unsigned long	irq_edge_rise;
 	unsigned long	irq_edge_fall;
+	int (*set_wake)(unsigned int gpio, unsigned int on);
 
 #ifdef CONFIG_PM
 	unsigned long	saved_gplr;
@@ -269,7 +270,8 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
-static int __devinit pxa_init_gpio_chip(int gpio_end)
+static int __devinit pxa_init_gpio_chip(int gpio_end,
+					int (*set_wake)(unsigned int, unsigned int))
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
 	struct pxa_gpio_chip *chips;
@@ -285,6 +287,7 @@ static int __devinit pxa_init_gpio_chip(int gpio_end)
 
 		sprintf(chips[i].label, "gpio-%d", i);
 		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
+		chips[i].set_wake = set_wake;
 
 		c->base  = gpio;
 		c->label = chips[i].label;
@@ -412,6 +415,17 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 	writel_relaxed(gfer, c->regbase + GFER_OFFSET);
 }
 
+static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
+{
+	int gpio = pxa_irq_to_gpio(d->irq);
+	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+
+	if (c->set_wake)
+		return c->set_wake(gpio, on);
+	else
+		return 0;
+}
+
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
 	int gpio = pxa_irq_to_gpio(d->irq);
@@ -427,6 +441,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_mask	= pxa_mask_muxed_gpio,
 	.irq_unmask	= pxa_unmask_muxed_gpio,
 	.irq_set_type	= pxa_gpio_irq_type,
+	.irq_set_wake	= pxa_gpio_set_wake,
 };
 
 static int pxa_gpio_nums(void)
@@ -471,6 +486,7 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 	struct pxa_gpio_chip *c;
 	struct resource *res;
 	struct clk *clk;
+	struct pxa_gpio_platform_data *info;
 	int gpio, irq, ret;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
@@ -516,7 +532,8 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize GPIO chips */
-	pxa_init_gpio_chip(pxa_last_gpio);
+	info = dev_get_platdata(&pdev->dev);
+	pxa_init_gpio_chip(pxa_last_gpio, info ? info->gpio_set_wake : NULL);
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index 05071ee..d755b28 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -13,4 +13,8 @@ extern int pxa_last_gpio;
 
 extern int pxa_irq_to_gpio(int irq);
 
+struct pxa_gpio_platform_data {
+	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
+};
+
 #endif /* __GPIO_PXA_H */
-- 
1.7.5.4
