From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Sat,  2 Nov 2013 21:09:32 +0530
Subject: [PATCH v4 3/6] gpio: davinci: use irqdomain
In-Reply-To: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
Message-ID: <1383406775-14902-4-git-send-email-prabhakar.csenng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch converts the davinci gpio driver to use irqdomain
support.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/da830.c              |    1 -
 arch/arm/mach-davinci/da850.c              |    1 -
 arch/arm/mach-davinci/dm355.c              |    1 -
 arch/arm/mach-davinci/dm365.c              |    1 -
 arch/arm/mach-davinci/dm644x.c             |    1 -
 arch/arm/mach-davinci/dm646x.c             |    1 -
 drivers/gpio/gpio-davinci.c                |   49 ++++++++++++++++++----------
 include/linux/platform_data/gpio-davinci.h |    3 +-
 8 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0813b51..fb72035 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1153,7 +1153,6 @@ static struct davinci_id da830_ids[] = {
 
 static struct davinci_gpio_platform_data da830_gpio_platform_data = {
 	.ngpio = 128,
-	.intc_irq_num = DA830_N_CP_INTC_IRQ,
 };
 
 int __init da830_register_gpio(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 352984e..4379317 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1283,7 +1283,6 @@ int __init da850_register_vpif_capture(struct vpif_capture_config
 
 static struct davinci_gpio_platform_data da850_gpio_platform_data = {
 	.ngpio = 144,
-	.intc_irq_num = DA850_N_CP_INTC_IRQ,
 };
 
 int __init da850_register_gpio(void)
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index ef9ff1f..5160aed 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -900,7 +900,6 @@ static struct resource dm355_gpio_resources[] = {
 
 static struct davinci_gpio_platform_data dm355_gpio_platform_data = {
 	.ngpio		= 104,
-	.intc_irq_num	= DAVINCI_N_AINTC_IRQ,
 };
 
 int __init dm355_gpio_register(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1511a06..4fe29fa 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -713,7 +713,6 @@ static struct resource dm365_gpio_resources[] = {
 
 static struct davinci_gpio_platform_data dm365_gpio_platform_data = {
 	.ngpio		= 104,
-	.intc_irq_num	= DAVINCI_N_AINTC_IRQ,
 	.gpio_unbanked	= 8,
 };
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 143a321..178cb68 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -786,7 +786,6 @@ static struct resource dm644_gpio_resources[] = {
 
 static struct davinci_gpio_platform_data dm644_gpio_platform_data = {
 	.ngpio		= 71,
-	.intc_irq_num	= DAVINCI_N_AINTC_IRQ,
 };
 
 int __init dm644x_gpio_register(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 2a73f29..01c576f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -763,7 +763,6 @@ static struct resource dm646x_gpio_resources[] = {
 
 static struct davinci_gpio_platform_data dm646x_gpio_platform_data = {
 	.ngpio		= 43,
-	.intc_irq_num	= DAVINCI_N_AINTC_IRQ,
 };
 
 int __init dm646x_gpio_register(void)
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 95c6df1..bcb6d8d 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 
@@ -292,7 +293,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		__raw_writel(status, &g->intstat);
 
 		/* now demux them to the right lowlevel handler */
-		n = d->irq_base;
+		n = irq_find_mapping(d->irq_domain, 0);
 		if (irq & 1) {
 			n += 16;
 			status >>= 16;
@@ -313,10 +314,7 @@ static int gpio_to_irq_banked(struct gpio_chip *chip, unsigned offset)
 {
 	struct davinci_gpio_controller *d = chip2controller(chip);
 
-	if (d->irq_base >= 0)
-		return d->irq_base + offset;
-	else
-		return -ENODEV;
+	return irq_find_mapping(d->irq_domain, offset);
 }
 
 static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
@@ -373,6 +371,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	struct davinci_gpio_controller *chips = platform_get_drvdata(pdev);
 	struct davinci_gpio_platform_data *pdata = dev->platform_data;
 	struct davinci_gpio_regs __iomem *g;
+	int gpio_irq = 0;
 
 	ngpio = pdata->ngpio;
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -402,9 +401,15 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	 */
 	for (gpio = 0, bank = 0; gpio < ngpio; bank++, gpio += 32) {
 		chips[bank].chip.to_irq = gpio_to_irq_banked;
-		chips[bank].irq_base = pdata->gpio_unbanked
-			? -EINVAL
-			: (pdata->intc_irq_num + gpio);
+		if (!pdata->gpio_unbanked) {
+			chips[bank].irq_domain =
+				irq_domain_add_linear(NULL, 32,
+						      &irq_domain_simple_ops,
+						      NULL);
+
+			if (!chips[bank].irq_domain)
+				return -ENOMEM;
+		}
 	}
 
 	/*
@@ -445,9 +450,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	 * Or, AINTC can handle IRQs for banks of 16 GPIO IRQs, which we
 	 * then chain through our own handler.
 	 */
-	for (gpio = 0, irq = gpio_to_irq(0), bank = 0;
-			gpio < ngpio;
-			bank++, bank_irq++) {
+	for (gpio = 0, irq = 0, bank = 0; gpio < ngpio; bank++, bank_irq++) {
 		unsigned		i;
 
 		/* disabled by default, enabled only as needed */
@@ -465,12 +468,22 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 		 */
 		irq_set_handler_data(bank_irq, &chips[gpio / 32]);
 
-		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
-			irq_set_chip(irq, &gpio_irqchip);
-			irq_set_chip_data(irq, (__force void *)g);
-			irq_set_handler_data(irq, (void *)__gpio_mask(gpio));
-			irq_set_handler(irq, handle_simple_irq);
-			set_irq_flags(irq, IRQF_VALID);
+		if (!(bank % 2))
+			irq = 0;
+		else
+			irq = 16;
+
+		for (i = 0; i < 16 && gpio < ngpio; i++, gpio++) {
+			int irqno =
+				irq_create_mapping(chips[gpio / 32].irq_domain,
+						   i + irq);
+
+			irq_set_chip(irqno, &gpio_irqchip);
+			irq_set_chip_data(irqno, (__force void *)g);
+			irq_set_handler_data(irqno, (void *)__gpio_mask(gpio));
+			irq_set_handler(irqno, handle_simple_irq);
+			set_irq_flags(irqno, IRQF_VALID);
+			gpio_irq++;
 		}
 
 		binten |= BIT(bank);
@@ -483,7 +496,7 @@ done:
 	 */
 	__raw_writel(binten, gpio_base + BINTEN);
 
-	printk(KERN_INFO "DaVinci: %d gpio irqs\n", irq - gpio_to_irq(0));
+	pr_info("DaVinci: %d gpio irqs\n", gpio_irq);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index 6efd202..fbe2f75 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -28,13 +28,12 @@ enum davinci_gpio_type {
 struct davinci_gpio_platform_data {
 	u32	ngpio;
 	u32	gpio_unbanked;
-	u32	intc_irq_num;
 };
 
 
 struct davinci_gpio_controller {
 	struct gpio_chip	chip;
-	int			irq_base;
+	struct irq_domain	*irq_domain;
 	/* Serialize access to GPIO registers */
 	spinlock_t		lock;
 	void __iomem		*regs;
-- 
1.7.9.5
