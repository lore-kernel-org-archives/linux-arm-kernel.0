From: yvo@apm.com (Y Vo)
Date: Wed, 17 Dec 2014 12:10:48 +0700
Subject: [PATCH v2 RESEND 1/3] gpio: Add APM X-Gene standby GPIO controller
 driver
In-Reply-To: <1418793050-26927-1-git-send-email-yvo@apm.com>
References: <1418793050-26927-1-git-send-email-yvo@apm.com>
Message-ID: <1418793050-26927-2-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene standby GPIO controller driver.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/Kconfig         |   7 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-xgene-sb.c | 217 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/gpio/gpio-xgene-sb.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0959ca9..aa53682 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -342,6 +342,13 @@ config GPIO_XGENE
 	  the generic flash controller's address and data pins. Say yes
 	  here to enable the GFC GPIO functionality.
 
+config GPIO_XGENE_SB
+	tristate "APM X-Gene GPIO standby controller support"
+	depends on ARCH_XGENE && OF_GPIO
+	help
+	  This driver supports the GPIO block within the APM X-Gene
+	  Standby Domain. Say yes here to enable the GPIO functionality.
+
 config GPIO_XILINX
 	bool "Xilinx GPIO support"
 	depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index e5d346c..edf8d8f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
 obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
 obj-$(CONFIG_GPIO_XGENE)	+= gpio-xgene.o
+obj-$(CONFIG_GPIO_XGENE_SB)	+= gpio-xgene-sb.o
 obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
 obj-$(CONFIG_GPIO_XTENSA)	+= gpio-xtensa.o
 obj-$(CONFIG_GPIO_ZEVIO)	+= gpio-zevio.o
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
new file mode 100644
index 0000000..1248448
--- /dev/null
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -0,0 +1,217 @@
+/*
+ * AppliedMicro X-Gene SoC GPIO-Standby Driver
+ *
+ * Copyright (c) 2014, Applied Micro Circuits Corporation
+ * Author: 	Tin Huynh <tnhuynh@apm.com>.
+ * 		Y Vo <yvo@apm.com>.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/of_irq.h>
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/string.h>
+#include <linux/of_address.h>
+
+#define XGENE_MAX_GPIO_DS		22
+#define XGENE_MAX_GPIO_DS_IRQ		6
+
+#define GPIO_MASK(x)			(1U << ((x) % 32))
+#define GPIO_DIR_IN			0
+#define GPIO_DIR_OUT			1
+
+#define MPA_GPIO_INT_LVL		0x0290
+#define MPA_GPIO_OE_ADDR		0x029c
+#define MPA_GPIO_OUT_ADDR		0x02a0
+#define MPA_GPIO_IN_ADDR		0x02a4
+#define MPA_GPIO_SEL_LO			0x0294
+#define MPA_GPIO_SEL_HIGH		0x029c
+
+struct xgene_gpio_sb {
+	struct of_mm_gpio_chip mm;
+	u32 *irq;
+	u32 nirq;
+	spinlock_t lock; /* mutual exclusion */
+};
+
+static inline struct xgene_gpio_sb *to_xgene_gpio_sb(struct of_mm_gpio_chip *mm)
+{
+	return container_of(mm, struct xgene_gpio_sb, mm);
+}
+
+static void xgene_gpio_set_bit(void __iomem *reg, u32 gpio, int val)
+{
+	u32 data;
+
+	data = ioread32(reg);
+	if (val)
+		data |= GPIO_MASK(gpio);
+	else
+		data &= ~GPIO_MASK(gpio);
+	iowrite32(data, reg);
+}
+
+static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	u32 data;
+
+	data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
+
+	return (data &  GPIO_MASK(gpio)) ? 1 : 0;
+}
+
+static void xgene_gpio_sb_set(struct gpio_chip *gc, u32 gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgene_gpio_sb *bank = to_xgene_gpio_sb(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	xgene_gpio_set_bit(mm_gc->regs + MPA_GPIO_OUT_ADDR, gpio, val);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+static int xgene_gpio_sb_dir_out(struct gpio_chip *gc, u32 gpio,
+				 int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgene_gpio_sb *bank = to_xgene_gpio_sb(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	xgene_gpio_set_bit(mm_gc->regs + MPA_GPIO_OE_ADDR, gpio, GPIO_DIR_OUT);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static int xgene_gpio_sb_dir_in(struct gpio_chip *gc, u32 gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgene_gpio_sb *bank = to_xgene_gpio_sb(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	xgene_gpio_set_bit(mm_gc->regs + MPA_GPIO_OE_ADDR, gpio, GPIO_DIR_IN);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
+
+	if (chip->irq[gpio])
+		return chip->irq[gpio];
+
+	return -ENXIO;
+}
+
+static int xgene_gpio_sb_probe(struct platform_device *pdev)
+{
+	struct of_mm_gpio_chip *mm;
+	struct xgene_gpio_sb *apm_gc;
+	u32 ret, i;
+	u32 default_pins[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
+	struct resource *res;
+
+	apm_gc = devm_kzalloc(&pdev->dev, sizeof(*apm_gc), GFP_KERNEL);
+	if (!apm_gc)
+		return -ENOMEM;
+
+	mm = &apm_gc->mm;
+	mm->gc.direction_input = xgene_gpio_sb_dir_in;
+	mm->gc.direction_output = xgene_gpio_sb_dir_out;
+	mm->gc.get = xgene_gpio_sb_get;
+	mm->gc.set = xgene_gpio_sb_set;
+	mm->gc.to_irq = apm_gpio_sb_to_irq;
+	mm->gc.base = -1;
+	mm->gc.label = dev_name(&pdev->dev);
+	platform_set_drvdata(pdev, mm);
+
+	mm->gc.ngpio = XGENE_MAX_GPIO_DS;
+	apm_gc->nirq = XGENE_MAX_GPIO_DS_IRQ;
+
+	apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
+				   GFP_KERNEL);
+	if (!apm_gc->irq)
+		return -ENOMEM;
+	memset(apm_gc->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mm->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (!mm->regs)
+		return PTR_ERR(mm->regs);
+
+	for (i = 0; i < apm_gc->nirq; i++) {
+		apm_gc->irq[default_pins[i]] = platform_get_irq(pdev, i);
+		xgene_gpio_set_bit(mm->regs + MPA_GPIO_SEL_LO,
+				   default_pins[i] * 2, 1);
+		xgene_gpio_set_bit(mm->regs + MPA_GPIO_INT_LVL, i, 1);
+	}
+	mm->gc.of_node = pdev->dev.of_node;
+	ret = gpiochip_add(&mm->gc);
+	if (ret)
+		dev_err(&pdev->dev, "failed to register X-Gene GPIO Standby driver\n");
+	else
+		dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
+
+	return ret;
+}
+
+static int xgene_gpio_sb_remove(struct platform_device *pdev)
+{
+	struct of_mm_gpio_chip *mm = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&mm->gc);
+
+	return 0;
+}
+
+static const struct of_device_id xgene_gpio_sb_of_match[] = {
+	{.compatible = "apm,xgene-gpio-sb", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
+
+static struct platform_driver xgene_gpio_sb_driver = {
+	.driver = {
+		   .name = "xgene-gpio-sb",
+		   .of_match_table = xgene_gpio_sb_of_match,
+		   },
+	.probe = xgene_gpio_sb_probe,
+	.remove = xgene_gpio_sb_remove,
+};
+
+module_platform_driver(xgene_gpio_sb_driver);
+
+MODULE_AUTHOR("AppliedMicro");
+MODULE_DESCRIPTION("APM X-Gene GPIO Standby driver");
+MODULE_LICENSE("GPL");
-- 
2.2.0
