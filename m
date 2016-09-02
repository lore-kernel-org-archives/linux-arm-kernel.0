From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Sep 2016 18:00:57 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <CACRpkdbNn0VXf7bHcfAq2qe2WpiZUxO-HRvikh4nv-svgJf+pg@mail.gmail.com>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <CACRpkdZJy9gZwH9__qXAf6nURN7xV6CbOaGC-JL6X5rDHN55VQ@mail.gmail.com>
 <20160830214253.GP1041@n2100.armlinux.org.uk>
 <CACRpkdbNn0VXf7bHcfAq2qe2WpiZUxO-HRvikh4nv-svgJf+pg@mail.gmail.com>
Message-ID: <20160902170057.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

There's a change I'd like to merge into patch 5 - overall it looks
like the below, and allows us to use gpio-reg with the PXA mainstone
MST_PCMCIA[01] registers.  Some of these GPIO signals have hardware
interrupts associated with them, but not all.

Do you approve?

Thanks.

8<====
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] gpio: gpio-reg: add irq mapping for gpio-reg users

Add support for mapping gpio-reg gpios to interrupts.  This may be a
non-linear mapping - some gpios in the register may not even have
corresponding interrupts associated with them, so we need to pass an
array.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/lubbock.c     |  2 +-
 arch/arm/mach-sa1100/assabet.c  |  2 +-
 arch/arm/mach-sa1100/neponset.c |  2 +-
 drivers/gpio/gpio-reg.c         | 25 +++++++++++++++++++++++--
 include/linux/gpio/gpio-reg.h   |  3 ++-
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 1f7bfabfa4eb..cd401546cea8 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -477,7 +477,7 @@ static void __init lubbock_init(void)
 
 	lubbock_misc_wr_gc = gpio_reg_init(NULL, (void *)&LUB_MISC_WR,
 					   -1, 16, "lubbock", 0, LUB_MISC_WR,
-					   NULL);
+					   NULL, NULL, NULL);
 	if (IS_ERR(lubbock_misc_wr_gc)) {
 		pr_err("Lubbock: unable to register lubbock GPIOs: %ld\n",
 		       PTR_ERR(lubbock_misc_wr_gc));
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 51950454afac..e086c609551c 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -120,7 +120,7 @@ static int __init assabet_init_gpio(void __iomem *reg, u32 def_val)
 	writel_relaxed(def_val, reg);
 
 	gc = gpio_reg_init(NULL, reg, -1, 32, "assabet", 0xff000000, def_val,
-			   assabet_names);
+			   assabet_names, NULL, NULL);
 
 	if (IS_ERR(gc))
 		return PTR_ERR(gc);
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 5abc04fb196d..b16de1f0d5d0 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -240,7 +240,7 @@ static int neponset_init_gpio(struct gpio_chip **gcp,
 	struct gpio_chip *gc;
 
 	gc = gpio_reg_init(dev, reg, -1, num, label, in ? 0xffffffff : 0,
-			   readl_relaxed(reg), names);
+			   readl_relaxed(reg), names, NULL, NULL);
 	if (IS_ERR(gc))
 		return PTR_ERR(gc);
 
diff --git a/drivers/gpio/gpio-reg.c b/drivers/gpio/gpio-reg.c
index 561e28b4d3aa..39175d373871 100644
--- a/drivers/gpio/gpio-reg.c
+++ b/drivers/gpio/gpio-reg.c
@@ -19,6 +19,8 @@ struct gpio_reg {
 	u32 direction;
 	u32 out;
 	void __iomem *reg;
+	struct irq_domain *irqdomain;
+	const int *irqs;
 };
 
 #define to_gpio_reg(x) container_of(x, struct gpio_reg, gc)
@@ -96,6 +98,17 @@ static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
+static int gpio_reg_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+	int irq = r->irqs[offset];
+
+	if (irq >= 0 && r->irqdomain)
+		irq = irq_find_mapping(r->irqdomain, irq);
+
+	return irq;
+}
+
 /**
  * gpio_reg_init - add a fixed in/out register as gpio
  * @dev: optional struct device associated with this register
@@ -104,7 +117,12 @@ static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
  * @label: GPIO chip label
  * @direction: bitmask of fixed direction, one per GPIO signal, 1 = in
  * @def_out: initial GPIO output value
- * @names: array of %num strings describing each GPIO signal
+ * @names: array of %num strings describing each GPIO signal or %NULL
+ * @irqdom: irq domain or %NULL
+ * @irqs: array of %num ints describing the interrupt mapping for each
+ *        GPIO signal, or %NULL.  If @irqdom is %NULL, then this
+ *        describes the Linux interrupt number, otherwise it describes
+ *        the hardware interrupt number in the specified irq domain.
  *
  * Add a single-register GPIO device containing up to 32 GPIO signals,
  * where each GPIO has a fixed input or output configuration.  Only
@@ -114,7 +132,7 @@ static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
  */
 struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
 	int base, int num, const char *label, u32 direction, u32 def_out,
-	const char *const *names)
+	const char *const *names, struct irq_domain *irqdom, const int *irqs)
 {
 	struct gpio_reg *r;
 	int ret;
@@ -136,12 +154,15 @@ struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
 	r->gc.set = gpio_reg_set;
 	r->gc.get = gpio_reg_get;
 	r->gc.set_multiple = gpio_reg_set_multiple;
+	if (irqs)
+		r->gc.to_irq = gpio_reg_to_irq;
 	r->gc.base = base;
 	r->gc.ngpio = num;
 	r->gc.names = names;
 	r->direction = direction;
 	r->out = def_out;
 	r->reg = reg;
+	r->irqs = irqs;
 
 	if (dev)
 		ret = devm_gpiochip_add_data(dev, &r->gc, r);
diff --git a/include/linux/gpio/gpio-reg.h b/include/linux/gpio/gpio-reg.h
index 0352bec7319a..90e0b9060e6d 100644
--- a/include/linux/gpio/gpio-reg.h
+++ b/include/linux/gpio/gpio-reg.h
@@ -2,10 +2,11 @@
 #define GPIO_REG_H
 
 struct device;
+struct irq_domain;
 
 struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
 	int base, int num, const char *label, u32 direction, u32 def_out,
-	const char *const *names);
+	const char *const *names, struct irq_domain *irqdom, const int *irqs);
 
 int gpio_reg_resume(struct gpio_chip *gc);
 
-- 
2.1.0


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
