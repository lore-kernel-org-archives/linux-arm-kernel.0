From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:14 -0700
Subject: [PATCH 23/34] Davinci: gpio - minor cleanup
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-24-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

macroized repeated container_of()s to improve readability.
unified direction in/out functions.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/gpio.c |   50 ++++++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index 5476ad1..93f7c68 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -28,6 +28,9 @@ struct davinci_gpio {
 	int			irq_base;
 };
 
+#define chip2controller(chip)	\
+	container_of(chip, struct davinci_gpio, chip)
+
 static struct davinci_gpio chips[DIV_ROUND_UP(DAVINCI_N_GPIO, 32)];
 
 /* create a non-inlined version */
@@ -54,21 +57,39 @@ static int __init davinci_gpio_irq_setup(void);
  * needed, and enable the GPIO clock.
  */
 
-static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
+static inline int __davinci_direction(struct gpio_chip *chip,
+			unsigned offset, bool out, int value)
 {
-	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
+	struct davinci_gpio *d = chip2controller(chip);
 	struct gpio_controller __iomem *g = d->regs;
 	u32 temp;
+	u32 mask = 1 << offset;
 
 	spin_lock(&gpio_lock);
 	temp = __raw_readl(&g->dir);
-	temp |= (1 << offset);
+	if (out) {
+		temp &= ~mask;
+		__raw_writel(mask, value ? &g->set_data : &g->clr_data);
+	} else {
+		temp |= mask;
+	}
 	__raw_writel(temp, &g->dir);
 	spin_unlock(&gpio_lock);
 
 	return 0;
 }
 
+static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	return __davinci_direction(chip, offset, false, 0);
+}
+
+static int
+davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
+{
+	return __davinci_direction(chip, offset, true, value);
+}
+
 /*
  * Read the pin's value (works even if it's set up as output);
  * returns zero/nonzero.
@@ -78,36 +99,19 @@ static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
  */
 static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
+	struct davinci_gpio *d = chip2controller(chip);
 	struct gpio_controller __iomem *g = d->regs;
 
 	return (1 << offset) & __raw_readl(&g->in_data);
 }
 
-static int
-davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
-{
-	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
-	struct gpio_controller __iomem *g = d->regs;
-	u32 temp;
-	u32 mask = 1 << offset;
-
-	spin_lock(&gpio_lock);
-	temp = __raw_readl(&g->dir);
-	temp &= ~mask;
-	__raw_writel(mask, value ? &g->set_data : &g->clr_data);
-	__raw_writel(temp, &g->dir);
-	spin_unlock(&gpio_lock);
-	return 0;
-}
-
 /*
  * Assuming the pin is muxed as a gpio output, set its output value.
  */
 static void
 davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
+	struct davinci_gpio *d = chip2controller(chip);
 	struct gpio_controller __iomem *g = d->regs;
 
 	__raw_writel((1 << offset), value ? &g->set_data : &g->clr_data);
@@ -262,7 +266,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 
 static int gpio_to_irq_banked(struct gpio_chip *chip, unsigned offset)
 {
-	struct davinci_gpio *d = container_of(chip, struct davinci_gpio, chip);
+	struct davinci_gpio *d = chip2controller(chip);
 
 	if (d->irq_base >= 0)
 		return d->irq_base + offset;
-- 
1.7.0.2
