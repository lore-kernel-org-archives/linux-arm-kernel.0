From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:15 -0700
Subject: [PATCH 24/34] Davinci: gpio - structs and functions renamed
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-25-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Renamed gpio types to something more sensible:
	struct gpio_controller	--> struct davinci_gpio_regs
	struct davinci_gpio	--> struct davinci_gpio_controller
	gpio2controller()	--> gpio2regs()
	irq2controller()	--> irq2regs()

This change also moves davinci_gpio_controller definition to gpio.h.
Eventually, the gpio registers structure will be moved to gpio.c and no longer
a common cross-soc definition.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/gpio.c              |   50 +++++++++++++----------------
 arch/arm/mach-davinci/include/mach/gpio.h |   14 ++++++--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index 93f7c68..c77683c 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -22,28 +22,22 @@
 
 static DEFINE_SPINLOCK(gpio_lock);
 
-struct davinci_gpio {
-	struct gpio_chip	chip;
-	struct gpio_controller	__iomem *regs;
-	int			irq_base;
-};
-
 #define chip2controller(chip)	\
-	container_of(chip, struct davinci_gpio, chip)
+	container_of(chip, struct davinci_gpio_controller, chip)
 
-static struct davinci_gpio chips[DIV_ROUND_UP(DAVINCI_N_GPIO, 32)];
+static struct davinci_gpio_controller chips[DIV_ROUND_UP(DAVINCI_N_GPIO, 32)];
 
 /* create a non-inlined version */
-static struct gpio_controller __iomem __init *gpio2controller(unsigned gpio)
+static struct davinci_gpio_regs __iomem __init *gpio2regs(unsigned gpio)
 {
 	return __gpio_to_controller(gpio);
 }
 
-static inline struct gpio_controller __iomem *irq2controller(int irq)
+static inline struct davinci_gpio_regs __iomem *irq2regs(int irq)
 {
-	struct gpio_controller __iomem *g;
+	struct davinci_gpio_regs __iomem *g;
 
-	g = (__force struct gpio_controller __iomem *)get_irq_chip_data(irq);
+	g = (__force struct davinci_gpio_regs __iomem *)get_irq_chip_data(irq);
 
 	return g;
 }
@@ -60,8 +54,8 @@ static int __init davinci_gpio_irq_setup(void);
 static inline int __davinci_direction(struct gpio_chip *chip,
 			unsigned offset, bool out, int value)
 {
-	struct davinci_gpio *d = chip2controller(chip);
-	struct gpio_controller __iomem *g = d->regs;
+	struct davinci_gpio_controller *d = chip2controller(chip);
+	struct davinci_gpio_regs __iomem *g = d->regs;
 	u32 temp;
 	u32 mask = 1 << offset;
 
@@ -99,8 +93,8 @@ davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
  */
 static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct davinci_gpio *d = chip2controller(chip);
-	struct gpio_controller __iomem *g = d->regs;
+	struct davinci_gpio_controller *d = chip2controller(chip);
+	struct davinci_gpio_regs __iomem *g = d->regs;
 
 	return (1 << offset) & __raw_readl(&g->in_data);
 }
@@ -111,8 +105,8 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 static void
 davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct davinci_gpio *d = chip2controller(chip);
-	struct gpio_controller __iomem *g = d->regs;
+	struct davinci_gpio_controller *d = chip2controller(chip);
+	struct davinci_gpio_regs __iomem *g = d->regs;
 
 	__raw_writel((1 << offset), value ? &g->set_data : &g->clr_data);
 }
@@ -150,7 +144,7 @@ static int __init davinci_gpio_setup(void)
 		if (chips[i].chip.ngpio > 32)
 			chips[i].chip.ngpio = 32;
 
-		chips[i].regs = gpio2controller(base);
+		chips[i].regs = gpio2regs(base);
 
 		gpiochip_add(&chips[i].chip);
 	}
@@ -174,7 +168,7 @@ pure_initcall(davinci_gpio_setup);
 
 static void gpio_irq_disable(unsigned irq)
 {
-	struct gpio_controller __iomem *g = irq2controller(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	__raw_writel(mask, &g->clr_falling);
@@ -183,7 +177,7 @@ static void gpio_irq_disable(unsigned irq)
 
 static void gpio_irq_enable(unsigned irq)
 {
-	struct gpio_controller __iomem *g = irq2controller(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
 	u32 mask = (u32) get_irq_data(irq);
 	unsigned status = irq_desc[irq].status;
 
@@ -199,7 +193,7 @@ static void gpio_irq_enable(unsigned irq)
 
 static int gpio_irq_type(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller __iomem *g = irq2controller(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -228,7 +222,7 @@ static struct irq_chip gpio_irqchip = {
 static void
 gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct gpio_controller __iomem *g = irq2controller(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
 	u32 mask = 0xffff;
 
 	/* we only care about one bank */
@@ -266,7 +260,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 
 static int gpio_to_irq_banked(struct gpio_chip *chip, unsigned offset)
 {
-	struct davinci_gpio *d = chip2controller(chip);
+	struct davinci_gpio_controller *d = chip2controller(chip);
 
 	if (d->irq_base >= 0)
 		return d->irq_base + offset;
@@ -289,7 +283,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_irq_type_unbanked(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller __iomem *g = irq2controller(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -318,7 +312,7 @@ static int __init davinci_gpio_irq_setup(void)
 	u32		binten = 0;
 	unsigned	ngpio, bank_irq;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct gpio_controller	__iomem *g;
+	struct davinci_gpio_regs	__iomem *g;
 
 	ngpio = soc_info->gpio_num;
 
@@ -367,7 +361,7 @@ static int __init davinci_gpio_irq_setup(void)
 		gpio_irqchip_unbanked.set_type = gpio_irq_type_unbanked;
 
 		/* default trigger: both edges */
-		g = gpio2controller(0);
+		g = gpio2regs(0);
 		__raw_writel(~0, &g->set_falling);
 		__raw_writel(~0, &g->set_rising);
 
@@ -392,7 +386,7 @@ static int __init davinci_gpio_irq_setup(void)
 		unsigned		i;
 
 		/* disabled by default, enabled only as needed */
-		g = gpio2controller(gpio);
+		g = gpio2regs(gpio);
 		__raw_writel(~0, &g->clr_falling);
 		__raw_writel(~0, &g->clr_rising);
 
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index 0099e6e..bdab001 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -45,7 +45,7 @@
 /* Convert GPIO signal to GPIO pin number */
 #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
 
-struct gpio_controller {
+struct davinci_gpio_regs {
 	u32	dir;
 	u32	out_data;
 	u32	set_data;
@@ -58,6 +58,12 @@ struct gpio_controller {
 	u32	intstat;
 };
 
+struct davinci_gpio_controller {
+	struct davinci_gpio_regs __iomem *regs;
+	struct gpio_chip	chip;
+	int			irq_base;
+};
+
 /* The __gpio_to_controller() and __gpio_mask() functions inline to constants
  * with constant parameters; or in outlined code they execute at runtime.
  *
@@ -67,7 +73,7 @@ struct gpio_controller {
  *
  * These are NOT part of the cross-platform GPIO interface
  */
-static inline struct gpio_controller __iomem *
+static inline struct davinci_gpio_regs __iomem *
 __gpio_to_controller(unsigned gpio)
 {
 	void __iomem *ptr;
@@ -102,7 +108,7 @@ static inline u32 __gpio_mask(unsigned gpio)
 static inline void gpio_set_value(unsigned gpio, int value)
 {
 	if (__builtin_constant_p(value) && gpio < DAVINCI_N_GPIO) {
-		struct gpio_controller	__iomem *g;
+		struct davinci_gpio_regs	__iomem *g;
 		u32			mask;
 
 		g = __gpio_to_controller(gpio);
@@ -128,7 +134,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
  */
 static inline int gpio_get_value(unsigned gpio)
 {
-	struct gpio_controller	__iomem *g;
+	struct davinci_gpio_regs	__iomem *g;
 
 	if (!__builtin_constant_p(gpio) || gpio >= DAVINCI_N_GPIO)
 		return __gpio_get_value(gpio);
-- 
1.7.0.2
