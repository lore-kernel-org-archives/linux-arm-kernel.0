From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:18 +0100
Subject: [PATCH 46/54] ARM: tegra: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134118.GU15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-tegra/gpio.c |   38 +++++++++++++++++++-------------------
 arch/arm/mach-tegra/irq.c  |   36 ++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index 0775265..bd06620 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -142,31 +142,31 @@ static struct gpio_chip tegra_gpio_chip = {
 	.ngpio			= TEGRA_NR_GPIOS,
 };
 
-static void tegra_gpio_irq_ack(unsigned int irq)
+static void tegra_gpio_irq_ack(struct irq_data *d)
 {
-	int gpio = irq - INT_GPIO_BASE;
+	int gpio = d->irq - INT_GPIO_BASE;
 
 	__raw_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
 }
 
-static void tegra_gpio_irq_mask(unsigned int irq)
+static void tegra_gpio_irq_mask(struct irq_data *d)
 {
-	int gpio = irq - INT_GPIO_BASE;
+	int gpio = d->irq - INT_GPIO_BASE;
 
 	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 0);
 }
 
-static void tegra_gpio_irq_unmask(unsigned int irq)
+static void tegra_gpio_irq_unmask(struct irq_data *d)
 {
-	int gpio = irq - INT_GPIO_BASE;
+	int gpio = d->irq - INT_GPIO_BASE;
 
 	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 1);
 }
 
-static int tegra_gpio_irq_set_type(unsigned int irq, unsigned int type)
+static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	int gpio = irq - INT_GPIO_BASE;
-	struct tegra_gpio_bank *bank = get_irq_chip_data(irq);
+	int gpio = d->irq - INT_GPIO_BASE;
+	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	int port = GPIO_PORT(gpio);
 	int lvl_type;
 	int val;
@@ -221,7 +221,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	int pin;
 	int unmasked = 0;
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = get_irq_data(irq);
 
@@ -240,7 +240,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 */
 			if (lvl & (0x100 << pin)) {
 				unmasked = 1;
-				desc->chip->unmask(irq);
+				desc->irq_data.chip->irq_unmask(&desc->irq_data);
 			}
 
 			generic_handle_irq(gpio_to_irq(gpio + pin));
@@ -248,7 +248,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 
 	if (!unmasked)
-		desc->chip->unmask(irq);
+		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 
 }
 
@@ -316,21 +316,21 @@ void tegra_gpio_suspend(void)
 	local_irq_restore(flags);
 }
 
-static int tegra_gpio_wake_enable(unsigned int irq, unsigned int enable)
+static int tegra_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
-	struct tegra_gpio_bank *bank = get_irq_chip_data(irq);
+	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	return set_irq_wake(bank->irq, enable);
 }
 #endif
 
 static struct irq_chip tegra_gpio_irq_chip = {
 	.name		= "GPIO",
-	.ack		= tegra_gpio_irq_ack,
-	.mask		= tegra_gpio_irq_mask,
-	.unmask		= tegra_gpio_irq_unmask,
-	.set_type	= tegra_gpio_irq_set_type,
+	.irq_ack	= tegra_gpio_irq_ack,
+	.irq_mask	= tegra_gpio_irq_mask,
+	.irq_unmask	= tegra_gpio_irq_unmask,
+	.irq_set_type	= tegra_gpio_irq_set_type,
 #ifdef CONFIG_PM
-	.set_wake	= tegra_gpio_wake_enable,
+	.irq_set_wake	= tegra_gpio_wake_enable,
 #endif
 };
 
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 50a8dfb..ef8d10b 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -46,30 +46,30 @@
 #define ICTLR_COP_IER_CLR	0x38
 #define ICTLR_COP_IEP_CLASS	0x3c
 
-static void (*gic_mask_irq)(unsigned int irq);
-static void (*gic_unmask_irq)(unsigned int irq);
+static void (*gic_mask_irq)(struct irq_data *d);
+static void (*gic_unmask_irq)(struct irq_data *d);
 
 #define irq_to_ictlr(irq) (((irq)-32) >> 5)
 static void __iomem *tegra_ictlr_base = IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE);
 #define ictlr_to_virt(ictlr) (tegra_ictlr_base + (ictlr)*0x100)
 
-static void tegra_mask(unsigned int irq)
+static void tegra_mask(struct irq_data *d)
 {
-	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(irq));
-	gic_mask_irq(irq);
-	writel(1<<(irq&31), addr+ICTLR_CPU_IER_CLR);
+	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(d->irq));
+	gic_mask_irq(d);
+	writel(1<<(d->irq&31), addr+ICTLR_CPU_IER_CLR);
 }
 
-static void tegra_unmask(unsigned int irq)
+static void tegra_unmask(struct irq_data *d)
 {
-	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(irq));
-	gic_unmask_irq(irq);
-	writel(1<<(irq&31), addr+ICTLR_CPU_IER_SET);
+	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(d->irq));
+	gic_unmask_irq(d);
+	writel(1<<(d->irq&31), addr+ICTLR_CPU_IER_SET);
 }
 
 #ifdef CONFIG_PM
 
-static int tegra_set_wake(unsigned int irq, unsigned int on)
+static int tegra_set_wake(struct irq_data *d, unsigned int on)
 {
 	return 0;
 }
@@ -77,10 +77,10 @@ static int tegra_set_wake(unsigned int irq, unsigned int on)
 
 static struct irq_chip tegra_irq = {
 	.name		= "PPI",
-	.mask		= tegra_mask,
-	.unmask		= tegra_unmask,
+	.irq_mask	= tegra_mask,
+	.irq_unmask	= tegra_unmask,
 #ifdef CONFIG_PM
-	.set_wake	= tegra_set_wake,
+	.irq_set_wake	= tegra_set_wake,
 #endif
 };
 
@@ -98,11 +98,11 @@ void __init tegra_init_irq(void)
 	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
 
 	gic = get_irq_chip(29);
-	gic_unmask_irq = gic->unmask;
-	gic_mask_irq = gic->mask;
-	tegra_irq.ack = gic->ack;
+	gic_unmask_irq = gic->irq_unmask;
+	gic_mask_irq = gic->irq_mask;
+	tegra_irq.irq_ack = gic->irq_ack;
 #ifdef CONFIG_SMP
-	tegra_irq.set_affinity = gic->set_affinity;
+	tegra_irq.irq_set_affinity = gic->irq_set_affinity;
 #endif
 
 	for (i = INT_PRI_BASE; i < INT_GPIO_BASE; i++) {
-- 
1.7.1
