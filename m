From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:31 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction GPIO
 driver
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simple, generic, single register fixed-direction GPIO driver.
This is able to support a single register where a fixed number of
bits are used for input and a fixed number of bits used for output.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpio/Kconfig     |   6 ++
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-reg.c  | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio-reg.h |  12 ++++
 4 files changed, 158 insertions(+)
 create mode 100644 drivers/gpio/gpio-reg.c
 create mode 100644 include/linux/gpio-reg.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 98dd47a30fc7..49bd8b89712e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -365,6 +365,12 @@ config GPIO_RCAR
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
 
+config GPIO_REG
+	bool
+	help
+	  A 32-bit single register GPIO fixed in/out implementation.  This
+	  can be used to represent any register as a set of GPIO signals.
+
 config GPIO_SPEAR_SPICS
 	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
 	depends on PLAT_SPEAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 2a035ed8f168..3fc904fcc595 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
+obj-$(CONFIG_GPIO_REG)		+= gpio-reg.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
diff --git a/drivers/gpio/gpio-reg.c b/drivers/gpio/gpio-reg.c
new file mode 100644
index 000000000000..fc7e0a395f9f
--- /dev/null
+++ b/drivers/gpio/gpio-reg.c
@@ -0,0 +1,139 @@
+#include <linux/gpio/driver.h>
+#include <linux/gpio-reg.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct gpio_reg {
+	struct gpio_chip gc;
+	spinlock_t lock;
+	u32 direction;
+	u32 out;
+	void __iomem *reg;
+};
+
+#define to_gpio_reg(x) container_of(x, struct gpio_reg, gc)
+
+static int gpio_reg_get_direction(struct gpio_chip *gc, unsigned offset)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+
+	return r->direction & BIT(offset) ? 1 : 0;
+}
+
+static int gpio_reg_direction_output(struct gpio_chip *gc, unsigned offset,
+	int value)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+
+	if (r->direction & BIT(offset))
+		return -ENOTSUPP;
+
+	gc->set(gc, offset, value);
+	return 0;
+}
+
+static int gpio_reg_direction_input(struct gpio_chip *gc, unsigned offset)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+
+	return r->direction & BIT(offset) ? 0 : -ENOTSUPP;
+}
+
+static void gpio_reg_set(struct gpio_chip *gc, unsigned offset, int value)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+	unsigned long flags;
+	u32 val, mask = BIT(offset);
+
+	spin_lock_irqsave(&r->lock, flags);
+	val = r->out;
+	if (value)
+		val |= mask;
+	else
+		val &= ~mask;
+	r->out = val;
+	writel_relaxed(val, r->reg);
+	spin_unlock_irqrestore(&r->lock, flags);
+}
+
+static int gpio_reg_get(struct gpio_chip *gc, unsigned offset)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+	u32 val, mask = BIT(offset);
+
+	if (r->direction & mask) {
+		/*
+		 * double-read the value, some registers latch after the
+		 * first read.
+		 */
+		readl_relaxed(r->reg);
+		val = readl_relaxed(r->reg);
+	} else {
+		val = r->out;
+	}
+	return !!(val & mask);
+}
+
+static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+	r->out = (r->out & ~*mask) | *bits;
+	writel_relaxed(r->out, r->reg);
+	spin_unlock_irqrestore(&r->lock, flags);
+}
+
+struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
+	int base, int num, const char *label, u32 direction, u32 def_out,
+	const char *const *names)
+{
+	struct gpio_reg *r;
+	int ret;
+
+	if (dev)
+		r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
+	else
+		r = kzalloc(sizeof(*r), GFP_KERNEL);
+
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&r->lock);
+
+	r->gc.label = label;
+	r->gc.get_direction = gpio_reg_get_direction;
+	r->gc.direction_input = gpio_reg_direction_input;
+	r->gc.direction_output = gpio_reg_direction_output;
+	r->gc.set = gpio_reg_set;
+	r->gc.get = gpio_reg_get;
+	r->gc.set_multiple = gpio_reg_set_multiple;
+	r->gc.base = base;
+	r->gc.ngpio = num;
+	r->gc.names = names;
+	r->direction = direction;
+	r->out = def_out;
+	r->reg = reg;
+
+	if (dev)
+		ret = devm_gpiochip_add_data(dev, &r->gc, r);
+	else
+		ret = gpiochip_add_data(&r->gc, r);
+
+	return ret ? ERR_PTR(ret) : &r->gc;
+}
+
+int gpio_reg_resume(struct gpio_chip *gc)
+{
+	struct gpio_reg *r = to_gpio_reg(gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+	writel_relaxed(r->out, r->reg);
+	spin_unlock_irqrestore(&r->lock, flags);
+
+	return 0;
+}
diff --git a/include/linux/gpio-reg.h b/include/linux/gpio-reg.h
new file mode 100644
index 000000000000..0352bec7319a
--- /dev/null
+++ b/include/linux/gpio-reg.h
@@ -0,0 +1,12 @@
+#ifndef GPIO_REG_H
+#define GPIO_REG_H
+
+struct device;
+
+struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
+	int base, int num, const char *label, u32 direction, u32 def_out,
+	const char *const *names);
+
+int gpio_reg_resume(struct gpio_chip *gc);
+
+#endif
-- 
2.1.0
