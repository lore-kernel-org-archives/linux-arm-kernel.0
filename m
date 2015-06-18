From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 17 Jun 2015 18:00:42 -0700
Subject: [PATCH v3 3/4] gpio: brcmstb: Add interrupt and wakeup source support
In-Reply-To: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1434589243-502-4-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uses the gpiolib irqchip helpers.  For this to work, the irq setup
function is called once per bank instead of once per device.  Note
that all known uses of this block have a BCM7120 L2 interrupt
controller as a parent.  Supports interrupts for all GPIOs.

In the IRQ handler, we check for raised IRQs for invalid GPIOs and
warn (ratelimited) if they're encountered.

Also, several drivers (e.g. gpio-keys) allow for GPIOs to be
configured as wakeup sources, and this GPIO controller supports that
through a separate interrupt path.

The de-facto standard DT property "wakeup-source" is checked, since
that indicates whether the GPIO controller hardware can wake.  Uses
the IRQCHIP_MASK_ON_SUSPEND irq_chip flag because UPG GIO doesn't have
any of its own wakeup source configuration.

Aside regarding gpiolib irqchip helpers: It wasn't obvious (to me)
that you can have multiple chained irqchips and associated IRQ domains
for a single parent IRQ, and as long as the xlate function is written
correctly, a GPIO IRQ request end up checking the correct domain and
will get associated with the correct IRQ.  What helps make this clear
is to read
  drivers/gpio/gpiolib-of.c:
   - of_gpiochip_find_and_xlate()
   - of_get_named_gpiod_flags()
  drivers/gpio/gpiolib.c:
   - gpiochip_find()

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
v3:
- combine commits to add interrupt support and allow GPIOs to be wakeup sources
- change to use the gpiolib irqchip helpers, reducing unnecessary code
  duplication.

 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-brcmstb.c | 263 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 258 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5f79b7f..f723c7e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -131,6 +131,7 @@ config GPIO_BRCMSTB
 	default y if ARCH_BRCMSTB
 	depends on OF_GPIO && (ARCH_BRCMSTB || COMPILE_TEST)
 	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 4630a81..141509b 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -17,6 +17,9 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/basic_mmio_gpio.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/interrupt.h>
 
 #define GIO_BANK_SIZE           0x20
 #define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
@@ -34,14 +37,17 @@ struct brcmstb_gpio_bank {
 	struct bgpio_chip bgc;
 	struct brcmstb_gpio_priv *parent_priv;
 	u32 width;
+	struct irq_chip irq_chip;
 };
 
 struct brcmstb_gpio_priv {
 	struct list_head bank_list;
 	void __iomem *reg_base;
-	int num_banks;
 	struct platform_device *pdev;
+	int parent_irq;
 	int gpio_base;
+	bool can_wake;
+	int parent_wake_irq;
 };
 
 #define MAX_GPIO_PER_BANK           32
@@ -63,6 +69,184 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
 	return bank->parent_priv;
 }
 
+static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
+		unsigned int offset, bool enable)
+{
+	struct bgpio_chip *bgc = &bank->bgc;
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = bgc->pin2mask(bgc, offset);
+	u32 imask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bgc->lock, flags);
+	imask = bgc->read_reg(priv->reg_base + GIO_MASK(bank->id));
+	if (enable)
+		imask |= mask;
+	else
+		imask &= ~mask;
+	bgc->write_reg(priv->reg_base + GIO_MASK(bank->id), imask);
+	spin_unlock_irqrestore(&bgc->lock, flags);
+}
+
+/* -------------------- IRQ chip functions -------------------- */
+
+static void brcmstb_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_bank *bank = brcmstb_gpio_gc_to_bank(gc);
+
+	brcmstb_gpio_set_imask(bank, d->hwirq, false);
+}
+
+static void brcmstb_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_bank *bank = brcmstb_gpio_gc_to_bank(gc);
+
+	brcmstb_gpio_set_imask(bank, d->hwirq, true);
+}
+
+static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_bank *bank = brcmstb_gpio_gc_to_bank(gc);
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = BIT(d->hwirq);
+	u32 edge_insensitive, iedge_insensitive;
+	u32 edge_config, iedge_config;
+	u32 level, ilevel;
+	unsigned long flags;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		level = 0;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		level = mask;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		level = 0;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		level = 0;
+		edge_config = mask;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		level = 0;
+		edge_config = 0;  /* don't care, but want known value */
+		edge_insensitive = mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bank->bgc.lock, flags);
+
+	iedge_config = bank->bgc.read_reg(priv->reg_base +
+			GIO_EC(bank->id)) & ~mask;
+	iedge_insensitive = bank->bgc.read_reg(priv->reg_base +
+			GIO_EI(bank->id)) & ~mask;
+	ilevel = bank->bgc.read_reg(priv->reg_base +
+			GIO_LEVEL(bank->id)) & ~mask;
+
+	bank->bgc.write_reg(priv->reg_base + GIO_EC(bank->id),
+			iedge_config | edge_config);
+	bank->bgc.write_reg(priv->reg_base + GIO_EI(bank->id),
+			iedge_insensitive | edge_insensitive);
+	bank->bgc.write_reg(priv->reg_base + GIO_LEVEL(bank->id),
+			ilevel | level);
+
+	spin_unlock_irqrestore(&bank->bgc.lock, flags);
+	return 0;
+}
+
+static int brcmstb_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	int ret = 0;
+
+	/*
+	 * Only enable wake IRQ once for however many hwirqs can wake
+	 * since they all use the same wake IRQ.  Mask will be set
+	 * up appropriately thanks to IRQCHIP_MASK_ON_SUSPEND flag.
+	 */
+	if (enable)
+		ret = enable_irq_wake(priv->parent_wake_irq);
+	else
+		ret = disable_irq_wake(priv->parent_wake_irq);
+	if (ret)
+		dev_err(&priv->pdev->dev, "failed to %s wake-up interrupt\n",
+				enable ? "enable" : "disable");
+	return ret;
+}
+
+static irqreturn_t brcmstb_gpio_wake_irq_handler(int irq, void *data)
+{
+	struct brcmstb_gpio_priv *priv = data;
+
+	if (!priv || irq != priv->parent_wake_irq)
+		return IRQ_NONE;
+	pm_wakeup_event(&priv->pdev->dev, 0);
+	return IRQ_HANDLED;
+}
+
+static void brcmstb_gpio_irq_bank_handler(int irq,
+		struct brcmstb_gpio_bank *bank)
+{
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	struct irq_domain *irq_domain = bank->bgc.gc.irqdomain;
+	void __iomem *reg_base = priv->reg_base;
+	unsigned long status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->bgc.lock, flags);
+	while ((status = bank->bgc.read_reg(reg_base + GIO_STAT(bank->id)) &
+			 bank->bgc.read_reg(reg_base + GIO_MASK(bank->id)))) {
+		int bit;
+
+		for_each_set_bit(bit, &status, 32) {
+			u32 stat = bank->bgc.read_reg(reg_base +
+						      GIO_STAT(bank->id));
+			if (bit >= bank->width)
+				dev_warn(&priv->pdev->dev,
+					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
+					 bank->id, bit);
+			bank->bgc.write_reg(reg_base + GIO_STAT(bank->id),
+					    stat | BIT(bit));
+			generic_handle_irq(irq_find_mapping(irq_domain, bit));
+		}
+	}
+	spin_unlock_irqrestore(&bank->bgc.lock, flags);
+}
+
+/* Each UPG GIO block has one IRQ for all banks */
+static void brcmstb_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct list_head *pos;
+
+	/* Interrupts weren't properly cleared during probe */
+	BUG_ON(!priv || !chip);
+
+	chained_irq_enter(chip, desc);
+	list_for_each(pos, &priv->bank_list) {
+		struct brcmstb_gpio_bank *bank =
+			list_entry(pos, struct brcmstb_gpio_bank, node);
+		brcmstb_gpio_irq_bank_handler(irq, bank);
+	}
+	chained_irq_exit(chip, desc);
+}
+
 /* Make sure that the number of banks matches up between properties */
 static int brcmstb_gpio_sanity_check_banks(struct device *dev,
 		struct device_node *np, struct resource *res)
@@ -100,7 +284,7 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 		bank = list_entry(pos, struct brcmstb_gpio_bank, node);
 		ret = bgpio_remove(&bank->bgc);
 		if (ret)
-			dev_err(&pdev->dev, "gpiochip_remove fail in cleanup");
+			dev_err(&pdev->dev, "gpiochip_remove fail in cleanup\n");
 	}
 	return ret;
 }
@@ -121,7 +305,7 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 		return -EINVAL;
 
 	offset = gpiospec->args[0] - (gc->base - priv->gpio_base);
-	if (offset >= gc->ngpio)
+	if (offset >= gc->ngpio || offset < 0)
 		return -EINVAL;
 
 	if (unlikely(offset >= bank->width)) {
@@ -136,6 +320,55 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 	return offset;
 }
 
+/* Before calling, must have bank->parent_irq set and gpiochip registered */
+static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
+		struct brcmstb_gpio_bank *bank)
+{
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	bank->irq_chip.name = dev_name(dev);
+	bank->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
+	bank->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
+	bank->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
+
+	/* Ensures that all non-wakeup IRQs are disabled at suspend */
+	bank->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP) && !priv->can_wake &&
+			of_property_read_bool(np, "wakeup-source")) {
+		priv->parent_wake_irq = platform_get_irq(pdev, 1);
+		if (priv->parent_wake_irq < 0) {
+			dev_warn(dev,
+				"Couldn't get wake IRQ - GPIOs will not be able to wake from sleep");
+		} else {
+			int err = devm_request_irq(dev, priv->parent_wake_irq,
+					brcmstb_gpio_wake_irq_handler, 0,
+					"brcmstb-gpio-wake", priv);
+
+			if (err < 0) {
+				dev_err(dev, "Couldn't request wake IRQ");
+				return err;
+			}
+
+			device_set_wakeup_capable(dev, true);
+			device_wakeup_enable(dev);
+			priv->can_wake = true;
+		}
+	}
+
+	if (priv->can_wake)
+		bank->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
+
+	gpiochip_irqchip_add(&bank->bgc.gc, &bank->irq_chip, 0,
+			handle_simple_irq, IRQ_TYPE_NONE);
+	gpiochip_set_chained_irqchip(&bank->bgc.gc, &bank->irq_chip,
+			priv->parent_irq, brcmstb_gpio_irq_handler);
+
+	return 0;
+}
+
 static int brcmstb_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -146,6 +379,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	struct property *prop;
 	const __be32 *p;
 	u32 bank_width;
+	int num_banks = 0;
 	int err;
 	static int gpio_base;
 
@@ -164,6 +398,16 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
 
+	if (of_property_read_bool(np, "interrupt-controller")) {
+		priv->parent_irq = platform_get_irq(pdev, 0);
+		if (priv->parent_irq < 0) {
+			dev_err(dev, "Couldn't get IRQ");
+			return -ENOENT;
+		}
+	} else {
+		priv->parent_irq = -ENOENT;
+	}
+
 	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
 		return -EINVAL;
 
@@ -180,7 +424,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		}
 
 		bank->parent_priv = priv;
-		bank->id = priv->num_banks;
+		bank->id = num_banks;
 		if (bank_width <= 0 || bank_width > MAX_GPIO_PER_BANK) {
 			dev_err(dev, "Invalid bank width %d\n", bank_width);
 			goto fail;
@@ -219,17 +463,24 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			goto fail;
 		}
 		gpio_base += gc->ngpio;
+
+		if (priv->parent_irq >= 0) {
+			err = brcmstb_gpio_irq_setup(pdev, bank);
+			if (err)
+				goto fail;
+		}
+
 		dev_dbg(dev, "bank=%d, base=%d, ngpio=%d, width=%d\n", bank->id,
 			gc->base, gc->ngpio, bank->width);
 
 		/* Everything looks good, so add bank to list */
 		list_add(&bank->node, &priv->bank_list);
 
-		priv->num_banks++;
+		num_banks++;
 	}
 
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
-			priv->num_banks, priv->gpio_base, gpio_base - 1);
+			num_banks, priv->gpio_base, gpio_base - 1);
 
 	return 0;
 
-- 
1.9.1
