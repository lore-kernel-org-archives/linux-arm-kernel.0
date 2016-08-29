From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:51 +0100
Subject: [PATCH 09/33] ARM: sa1111: implement a gpio_chip for SA1111 GPIOs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkJ-0000ma-Hv@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a gpio_chip instance for SA1111 GPIOs.  This allows us to use
gpiolib to lookup and manipulate SA1111 GPIOs.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index fb0a0a4dfea4..ac19dca4c258 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -15,6 +15,7 @@
  * from machine specific code with proper arguments when required.
  */
 #include <linux/module.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -107,6 +108,7 @@ struct sa1111 {
 	spinlock_t	lock;
 	void __iomem	*base;
 	struct sa1111_platform_data *pdata;
+	struct gpio_chip gc;
 #ifdef CONFIG_PM
 	void		*saved_state;
 #endif
@@ -509,6 +511,163 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	return 0;
 }
 
+enum {
+	SA1111_GPIO_PXDDR = (SA1111_GPIO_PADDR - SA1111_GPIO_PADDR),
+	SA1111_GPIO_PXDRR = (SA1111_GPIO_PADRR - SA1111_GPIO_PADDR),
+	SA1111_GPIO_PXDWR = (SA1111_GPIO_PADWR - SA1111_GPIO_PADDR),
+	SA1111_GPIO_PXSDR = (SA1111_GPIO_PASDR - SA1111_GPIO_PADDR),
+	SA1111_GPIO_PXSSR = (SA1111_GPIO_PASSR - SA1111_GPIO_PADDR),
+};
+
+static struct sa1111 *gc_to_sa1111(struct gpio_chip *gc)
+{
+	return container_of(gc, struct sa1111, gc);
+}
+
+static void __iomem *sa1111_gpio_map_reg(struct sa1111 *sachip, unsigned offset)
+{
+	void __iomem *reg = sachip->base + SA1111_GPIO;
+
+	if (offset < 4)
+		return reg + SA1111_GPIO_PADDR;
+	if (offset < 10)
+		return reg + SA1111_GPIO_PBDDR;
+	if (offset < 18)
+		return reg + SA1111_GPIO_PCDDR;
+	return NULL;
+}
+
+static u32 sa1111_gpio_map_bit(unsigned offset)
+{
+	if (offset < 4)
+		return BIT(offset);
+	if (offset < 10)
+		return BIT(offset - 4);
+	if (offset < 18)
+		return BIT(offset - 10);
+	return 0;
+}
+
+static void sa1111_gpio_modify(void __iomem *reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = readl_relaxed(reg);
+	val &= ~mask;
+	val |= mask & set;
+	writel_relaxed(val, reg);
+}
+
+static int sa1111_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
+	u32 mask = sa1111_gpio_map_bit(offset);
+
+	return !!(readl_relaxed(reg + SA1111_GPIO_PXDDR) & mask);
+}
+
+static int sa1111_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	unsigned long flags;
+	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
+	u32 mask = sa1111_gpio_map_bit(offset);
+
+	spin_lock_irqsave(&sachip->lock, flags);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXDDR, mask, mask);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXSDR, mask, mask);
+	spin_unlock_irqrestore(&sachip->lock, flags);
+
+	return 0;
+}
+
+static int sa1111_gpio_direction_output(struct gpio_chip *gc, unsigned offset,
+	int value)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	unsigned long flags;
+	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
+	u32 mask = sa1111_gpio_map_bit(offset);
+
+	spin_lock_irqsave(&sachip->lock, flags);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXDWR, mask, value ? mask : 0);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXSSR, mask, value ? mask : 0);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXDDR, mask, 0);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXSDR, mask, 0);
+	spin_unlock_irqrestore(&sachip->lock, flags);
+
+	return 0;
+}
+
+static int sa1111_gpio_get(struct gpio_chip *gc, unsigned offset)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
+	u32 mask = sa1111_gpio_map_bit(offset);
+
+	return !!(readl_relaxed(reg + SA1111_GPIO_PXDRR) & mask);
+}
+
+static void sa1111_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	unsigned long flags;
+	void __iomem *reg = sa1111_gpio_map_reg(sachip, offset);
+	u32 mask = sa1111_gpio_map_bit(offset);
+
+	spin_lock_irqsave(&sachip->lock, flags);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXDWR, mask, value ? mask : 0);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PXSSR, mask, value ? mask : 0);
+	spin_unlock_irqrestore(&sachip->lock, flags);
+}
+
+static void sa1111_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+	unsigned long flags;
+	void __iomem *reg = sachip->base + SA1111_GPIO;
+	u32 msk, val;
+
+	msk = *mask;
+	val = *bits;
+
+	spin_lock_irqsave(&sachip->lock, flags);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PADWR, msk & 15, val);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PASSR, msk & 15, val);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PBDWR, (msk >> 4) & 255, val >> 4);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PBSSR, (msk >> 4) & 255, val >> 4);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PCDWR, (msk >> 12) & 255, val >> 12);
+	sa1111_gpio_modify(reg + SA1111_GPIO_PCSSR, (msk >> 12) & 255, val >> 12);
+	spin_unlock_irqrestore(&sachip->lock, flags);
+}
+
+static int sa1111_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct sa1111 *sachip = gc_to_sa1111(gc);
+
+	return sachip->irq_base + offset;
+}
+
+static int sa1111_setup_gpios(struct sa1111 *sachip)
+{
+	sachip->gc.label = "sa1111";
+	sachip->gc.parent = sachip->dev;
+	sachip->gc.owner = THIS_MODULE;
+	sachip->gc.get_direction = sa1111_gpio_get_direction;
+	sachip->gc.direction_input = sa1111_gpio_direction_input;
+	sachip->gc.direction_output = sa1111_gpio_direction_output;
+	sachip->gc.get = sa1111_gpio_get;
+	sachip->gc.set = sa1111_gpio_set;
+	sachip->gc.set_multiple = sa1111_gpio_set_multiple;
+	sachip->gc.to_irq = sa1111_gpio_to_irq;
+	sachip->gc.base = -1;
+	sachip->gc.ngpio = 18;
+
+	return devm_gpiochip_add_data(sachip->dev, &sachip->gc, sachip);
+}
+
 /*
  * Bring the SA1111 out of reset.  This requires a set procedure:
  *  1. nRESET asserted (by hardware)
@@ -696,7 +855,7 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	if (!pd)
 		return -EINVAL;
 
-	sachip = kzalloc(sizeof(struct sa1111), GFP_KERNEL);
+	sachip = devm_kzalloc(me, sizeof(struct sa1111), GFP_KERNEL);
 	if (!sachip)
 		return -ENOMEM;
 
@@ -747,6 +906,11 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 */
 	sa1111_wake(sachip);
 
+	/* Setup the GPIOs - should really be done after the IRQ setup */
+	ret = sa1111_setup_gpios(sachip);
+	if (ret)
+		goto err_unmap;
+
 	/*
 	 * The interrupt controller must be initialised before any
 	 * other device to ensure that the interrupts are available.
@@ -806,7 +970,6 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
  err_clkput:
 	clk_put(sachip->clk);
  err_free:
-	kfree(sachip);
 	return ret;
 }
 
@@ -843,7 +1006,6 @@ static void __sa1111_remove(struct sa1111 *sachip)
 
 	iounmap(sachip->base);
 	clk_put(sachip->clk);
-	kfree(sachip);
 }
 
 struct sa1111_save_data {
-- 
2.1.0
