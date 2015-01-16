From: yvo@apm.com (Y Vo)
Date: Fri, 16 Jan 2015 14:34:19 +0700
Subject: [PATCH v3 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <1421393661-4311-1-git-send-email-yvo@apm.com>
References: <1421393661-4311-1-git-send-email-yvo@apm.com>
Message-ID: <1421393661-4311-2-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for standby GPIO controller of APM X-Gene SoCs on arm64.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/Kconfig         |    8 ++
 drivers/gpio/Makefile        |    1 +
 drivers/gpio/gpio-xgene-sb.c |  162 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/gpio-xgene-sb.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1eff81c..4fec748 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -366,6 +366,14 @@ config GPIO_XGENE
 	  the generic flash controller's address and data pins. Say yes
 	  here to enable the GFC GPIO functionality.
 
+config GPIO_XGENE_SB
+	tristate "APM X-Gene GPIO standby controller support"
+	depends on ARCH_XGENE && OF_GPIO
+	select GPIO_GENERIC
+	help
+	  This driver supports the GPIO block within the APM X-Gene
+	  Standby Domain. Say yes here to enable the GPIO functionality.
+
 config GPIO_XILINX
 	tristate "Xilinx GPIO support"
 	depends on OF_GPIO && (PPC_OF || MICROBLAZE || ARCH_ZYNQ || ARCH_X86)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 81755f1..3031b19 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
 obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
 obj-$(CONFIG_GPIO_XGENE)	+= gpio-xgene.o
+obj-$(CONFIG_GPIO_XGENE_SB)	+= gpio-xgene-sb.o
 obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
 obj-$(CONFIG_GPIO_XTENSA)	+= gpio-xtensa.o
 obj-$(CONFIG_GPIO_ZEVIO)	+= gpio-zevio.o
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
new file mode 100644
index 0000000..44393c4
--- /dev/null
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -0,0 +1,162 @@
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
+#include <linux/gpio/driver.h>
+#include <linux/basic_mmio_gpio.h>
+
+#define XGENE_MAX_GPIO_DS		22
+#define XGENE_MAX_GPIO_DS_IRQ		6
+
+#define GPIO_MASK(x)			(1U << ((x) % 32))
+
+#define MPA_GPIO_INT_LVL		0x0290
+#define MPA_GPIO_OE_ADDR		0x029c
+#define MPA_GPIO_OUT_ADDR		0x02a0
+#define MPA_GPIO_IN_ADDR 		0x02a4
+#define MPA_GPIO_SEL_LO 		0x0294
+
+/**
+ * struct xgene_gpio_sb - GPIO-Standby private data structure.
+ * @bgc:			memory-mapped GPIO controllers.
+ * @irq:			Mapping GPIO pins and interrupt number
+ * nirq:			Number of GPIO pins that supports interrupt
+ */
+struct xgene_gpio_sb {
+	struct bgpio_chip	bgc;
+	u32 *irq;
+	u32 nirq;
+};
+
+static inline struct xgene_gpio_sb *to_xgene_gpio_sb(struct gpio_chip *gc)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+
+	return container_of(bgc, struct xgene_gpio_sb, bgc);
+}
+
+static void xgene_gpio_set_bit(struct bgpio_chip *bgc, void __iomem *reg, u32 gpio, int val)
+{
+	u32 data;
+
+	data = bgc->read_reg(reg);
+	if (val)
+		data |= GPIO_MASK(gpio);
+	else
+		data &= ~GPIO_MASK(gpio);
+	bgc->write_reg(reg, data);
+}
+
+static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
+{
+	struct xgene_gpio_sb *priv = to_xgene_gpio_sb(gc);
+
+	if (priv->irq[gpio])
+		return priv->irq[gpio];
+
+	return -ENXIO;
+}
+
+static int xgene_gpio_sb_probe(struct platform_device *pdev)
+{
+	struct xgene_gpio_sb *priv;
+	u32 ret, i;
+	u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
+	struct resource *res;
+	void __iomem *regs;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (!regs)
+		return PTR_ERR(regs);
+
+	ret = bgpio_init(&priv->bgc, &pdev->dev, 4,
+			regs + MPA_GPIO_IN_ADDR,
+			regs + MPA_GPIO_OUT_ADDR, NULL,
+			regs + MPA_GPIO_OE_ADDR, NULL, 0);
+        if (ret)
+                return ret;
+
+	priv->bgc.gc.to_irq = apm_gpio_sb_to_irq;
+	priv->bgc.gc.ngpio = XGENE_MAX_GPIO_DS;
+
+	priv->nirq = XGENE_MAX_GPIO_DS_IRQ;
+
+	priv->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
+				   GFP_KERNEL);
+	if (!priv->irq)
+		return -ENOMEM;
+	memset(priv->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);
+
+	for (i = 0; i < priv->nirq; i++) {
+		priv->irq[default_lines[i]] = platform_get_irq(pdev, i);
+		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_SEL_LO,
+                                   default_lines[i] * 2, 1);
+		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_INT_LVL, i, 1);
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = gpiochip_add(&priv->bgc.gc);
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
+	struct xgene_gpio_sb *priv = platform_get_drvdata(pdev);
+
+	return bgpio_remove(&priv->bgc);
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
1.7.1
