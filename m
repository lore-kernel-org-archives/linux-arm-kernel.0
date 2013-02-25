From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:32 +0800
Subject: [PATCH v5 03/12] gpio: pxa: rename function name
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename __gpio_is_occupied() & __gpio_is_inverted() to
pxa_gpio_is_occupied() & pxa_gpio_is_inverted().

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index ad54392..9519ab9 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -126,7 +126,7 @@ static inline int gpio_is_mmp_type(int type)
 /* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
-static inline int __gpio_is_inverted(int gpio)
+static inline int pxa_gpio_is_inverted(int gpio)
 {
 	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
 		return 1;
@@ -139,7 +139,7 @@ static inline int __gpio_is_inverted(int gpio)
  * is attributed as "occupied" here (I know this terminology isn't
  * accurate, you are welcome to propose a better one :-)
  */
-static inline int __gpio_is_occupied(unsigned gpio)
+static inline int pxa_gpio_is_occupied(unsigned gpio)
 {
 	struct pxa_gpio_chip *chip;
 	void __iomem *base;
@@ -158,7 +158,7 @@ static inline int __gpio_is_occupied(unsigned gpio)
 		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
 		dir = gpdr & GPIO_bit(gpio);
 
-		if (__gpio_is_inverted(gpio))
+		if (pxa_gpio_is_inverted(gpio))
 			ret = (af != 1) || (dir == 0);
 		else
 			ret = (af != 0) || (dir != 0);
@@ -189,7 +189,7 @@ static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	value = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(gc->base + offset))
+	if (pxa_gpio_is_inverted(gc->base + offset))
 		value |= mask;
 	else
 		value &= ~mask;
@@ -211,7 +211,7 @@ static int pxa_gpio_direction_output(struct gpio_chip *gc,
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	tmp = readl_relaxed(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(gc->base + offset))
+	if (pxa_gpio_is_inverted(gc->base + offset))
 		tmp &= ~mask;
 	else
 		tmp |= mask;
@@ -322,7 +322,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
 			return 0;
 
-		if (__gpio_is_occupied(gpio))
+		if (pxa_gpio_is_occupied(gpio))
 			return 0;
 
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
@@ -330,7 +330,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
 
-	if (__gpio_is_inverted(gpio))
+	if (pxa_gpio_is_inverted(gpio))
 		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
 	else
 		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
-- 
1.7.10.4
