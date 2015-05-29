From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 28 May 2015 19:14:05 -0700
Subject: [PATCH v2 1/6] gpio: Add GPIO support for Broadcom STB SoCs
In-Reply-To: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1432865650-4062-2-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the GPIO IP "UPG GIO" used on Broadcom STB SoCs
(BCM7XXX and some others).  Uses basic_mmio_gpio to instantiate a
gpio_chip for each bank.  The driver assumes that it handles the base
set of GPIOs on the system and that it can start its numbering sequence
from 0, so any GPIO expanders used with it must dynamically assign GPIO
numbers after this driver has finished registering its GPIOs.

Does not implement the interrupt-controller portion yet, will be done in a
future commit.

List-usage-fixed-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
v2:
- change include to use <linux/gpio/driver.h> instead of <linux/gpio.h>
- get rid of unnecessary imask member in struct bank
- rename GPIO_PER_BANK -> MAX_GPIO_PER_BANK
- always have 32 GPIOs per bank and add 'width' member in struct bank to hold
  actual number of GPIOs in use
- mark of_match table as const

 MAINTAINERS                 |   7 ++
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-brcmstb.c | 252 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 drivers/gpio/gpio-brcmstb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 198a429..1d1b6f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2290,6 +2290,13 @@ N:	bcm9583*
 N:	bcm583*
 N:	bcm113*
 
+BROADCOM BRCMSTB GPIO DRIVER
+M:	Gregory Fong <gregory.0xf0@gmail.com>
+L:	bcm-kernel-feedback-list at broadcom.com>
+S:	Supported
+F:	drivers/gpio/gpio-brcmstb.c
+F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
+
 BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
 L:	bcm-kernel-feedback-list at broadcom.com
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5faaf5f..d86de6a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -126,6 +126,14 @@ config GPIO_BCM_KONA
 	help
 	  Turn on GPIO support for Broadcom "Kona" chips.
 
+config GPIO_BRCMSTB
+	tristate "BRCMSTB GPIO support"
+	default y if ARCH_BRCMSTB
+	depends on OF_GPIO && (ARCH_BRCMSTB || COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
+
 config GPIO_CLPS711X
 	tristate "CLPS711X GPIO support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1b55fda..893bbff 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_GPIO_ALTERA)  	+= gpio-altera.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
+obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
new file mode 100644
index 0000000..7a3cb1f
--- /dev/null
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -0,0 +1,252 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/basic_mmio_gpio.h>
+
+#define GIO_BANK_SIZE           0x20
+#define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
+#define GIO_DATA(bank)          (((bank) * GIO_BANK_SIZE) + 0x04)
+#define GIO_IODIR(bank)         (((bank) * GIO_BANK_SIZE) + 0x08)
+#define GIO_EC(bank)            (((bank) * GIO_BANK_SIZE) + 0x0c)
+#define GIO_EI(bank)            (((bank) * GIO_BANK_SIZE) + 0x10)
+#define GIO_MASK(bank)          (((bank) * GIO_BANK_SIZE) + 0x14)
+#define GIO_LEVEL(bank)         (((bank) * GIO_BANK_SIZE) + 0x18)
+#define GIO_STAT(bank)          (((bank) * GIO_BANK_SIZE) + 0x1c)
+
+struct brcmstb_gpio_bank {
+	struct list_head node;
+	int id;
+	struct bgpio_chip bgc;
+	struct brcmstb_gpio_priv *parent_priv;
+	u32 width;
+};
+
+struct brcmstb_gpio_priv {
+	struct list_head bank_list;
+	void __iomem *reg_base;
+	int num_banks;
+	struct platform_device *pdev;
+	int gpio_base;
+};
+
+#define MAX_GPIO_PER_BANK           32
+#define GPIO_BANK(gpio)         ((gpio) >> 5)
+/* assumes MAX_GPIO_PER_BANK is a multiple of 2 */
+#define GPIO_BIT(gpio)          ((gpio) & (MAX_GPIO_PER_BANK - 1))
+
+static inline struct brcmstb_gpio_bank *
+brcmstb_gpio_gc_to_bank(struct gpio_chip *gc)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	return container_of(bgc, struct brcmstb_gpio_bank, bgc);
+}
+
+static inline struct brcmstb_gpio_priv *
+brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
+{
+	struct brcmstb_gpio_bank *bank = brcmstb_gpio_gc_to_bank(gc);
+	return bank->parent_priv;
+}
+
+/* Make sure that the number of banks matches up between properties */
+static int brcmstb_gpio_sanity_check_banks(struct device *dev,
+		struct device_node *np, struct resource *res)
+{
+	int res_num_banks = resource_size(res) / GIO_BANK_SIZE;
+	int num_banks =
+		of_property_count_u32_elems(np, "brcm,gpio-bank-widths");
+
+	if (res_num_banks != num_banks) {
+		dev_err(dev, "Mismatch in banks: res had %d, bank-widths had %d\n",
+				res_num_banks, num_banks);
+		return -EINVAL;
+	} else {
+		return 0;
+	}
+}
+
+static int brcmstb_gpio_remove(struct platform_device *pdev)
+{
+	struct brcmstb_gpio_priv *priv = platform_get_drvdata(pdev);
+	struct list_head *pos;
+	struct brcmstb_gpio_bank *bank;
+	int ret = 0;
+
+	list_for_each(pos, &priv->bank_list) {
+		bank = list_entry(pos, struct brcmstb_gpio_bank, node);
+		ret = bgpio_remove(&bank->bgc);
+		if (ret)
+			dev_err(&pdev->dev, "gpiochip_remove fail in cleanup");
+	}
+	return ret;
+}
+
+static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
+		const struct of_phandle_args *gpiospec, u32 *flags)
+{
+	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	struct brcmstb_gpio_bank *bank = brcmstb_gpio_gc_to_bank(gc);
+	int offset;
+
+	if (gc->of_gpio_n_cells != 2) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
+		return -EINVAL;
+
+	offset = gpiospec->args[0] - (gc->base - priv->gpio_base);
+	if (offset >= gc->ngpio)
+		return -EINVAL;
+
+	if (unlikely(offset >= bank->width)) {
+		dev_warn_ratelimited(&priv->pdev->dev,
+			"Received request for invalid GPIO offset %d\n",
+			gpiospec->args[0]);
+	}
+
+	if (flags)
+		*flags = gpiospec->args[1];
+
+	return offset;
+}
+
+static int brcmstb_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	void __iomem *reg_base;
+	struct brcmstb_gpio_priv *priv;
+	struct resource *res;
+	struct property *prop;
+	const __be32 *p;
+	u32 bank_width;
+	int err;
+	static int gpio_base;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	priv->gpio_base = gpio_base;
+	priv->reg_base = reg_base;
+	priv->pdev = pdev;
+
+	INIT_LIST_HEAD(&priv->bank_list);
+	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
+		return -EINVAL;
+
+	of_property_for_each_u32(np, "brcm,gpio-bank-widths", prop, p,
+			bank_width) {
+		struct brcmstb_gpio_bank *bank;
+		struct bgpio_chip *bgc;
+		struct gpio_chip *gc;
+
+		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
+		if (!bank) {
+			err = -ENOMEM;
+			goto fail;
+		}
+
+		bank->parent_priv = priv;
+		bank->id = priv->num_banks;
+		if (bank_width <= 0 || bank_width > MAX_GPIO_PER_BANK) {
+			dev_err(dev, "Invalid bank width %d\n", bank_width);
+			goto fail;
+		} else {
+			bank->width = bank_width;
+		}
+
+		/*
+		 * Regs are 4 bytes wide, have data reg, no set/clear regs,
+		 * and direction bits have 0 = output and 1 = input
+		 */
+		bgc = &bank->bgc;
+		err = bgpio_init(bgc, dev, 4,
+				reg_base + GIO_DATA(bank->id),
+				NULL, NULL, NULL,
+				reg_base + GIO_IODIR(bank->id), 0);
+		if (err) {
+			dev_err(dev, "bgpio_init() failed\n");
+			goto fail;
+		}
+
+		gc = &bgc->gc;
+		gc->of_node = np;
+		gc->owner = THIS_MODULE;
+		gc->label = np->full_name;
+		gc->base = gpio_base;
+		gc->of_gpio_n_cells = 2;
+		gc->of_xlate = brcmstb_gpio_of_xlate;
+		/* not all ngpio lines are valid, will use bank width later */
+		gc->ngpio = MAX_GPIO_PER_BANK;
+
+		err = gpiochip_add(gc);
+		if (err) {
+			dev_err(dev, "Could not add gpiochip for bank %d\n",
+					bank->id);
+			goto fail;
+		}
+		gpio_base += gc->ngpio;
+		dev_dbg(dev, "bank=%d, base=%d, ngpio=%d, width=%d\n", bank->id,
+			gc->base, gc->ngpio, bank->width);
+
+		/* Everything looks good, so add bank to list */
+		list_add(&bank->node, &priv->bank_list);
+
+		priv->num_banks++;
+	}
+
+	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
+			priv->num_banks, priv->gpio_base, gpio_base - 1);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+fail:
+	(void) brcmstb_gpio_remove(pdev);
+	return err;
+}
+
+static const struct of_device_id brcmstb_gpio_of_match[] = {
+	{ .compatible = "brcm,brcmstb-gpio" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, brcmstb_gpio_of_match);
+
+static struct platform_driver brcmstb_gpio_driver = {
+	.driver = {
+		.name = "brcmstb-gpio",
+		.of_match_table = brcmstb_gpio_of_match,
+	},
+	.probe = brcmstb_gpio_probe,
+	.remove = brcmstb_gpio_remove,
+};
+module_platform_driver(brcmstb_gpio_driver);
+
+MODULE_AUTHOR("Gregory Fong");
+MODULE_DESCRIPTION("Driver for Broadcom BRCMSTB SoC UPG GPIO");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
