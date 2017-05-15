From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 14:28:26 +0800
Subject: [PATCH 2/2] gpio: gpio-vf610: add imx7ulp support
In-Reply-To: <1494829706-5661-1-git-send-email-aisheng.dong@nxp.com>
References: <1494829706-5661-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494829706-5661-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
on MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the
RGPIO2P has an extra Port Data Direction Register (PDDR) used
to configure the individual port pins for input or output.

We introduce a FSL_GPIO_HAVE_PDDR with fsl_gpio_soc_data data
to distinguish this differences. And we support getting the output
status by checking the GPIO direction in PDDR.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 521fbe3..a439d27 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -30,10 +30,15 @@
 
 #define VF610_GPIO_PER_PORT		32
 
+struct fsl_gpio_soc_data {
+	u32 flags;
+};
+
 struct vf610_gpio_port {
 	struct gpio_chip gc;
 	void __iomem *base;
 	void __iomem *gpio_base;
+	const struct fsl_gpio_soc_data *sdata;
 	u8 irqc[VF610_GPIO_PER_PORT];
 	int irq;
 };
@@ -43,6 +48,7 @@ struct vf610_gpio_port {
 #define GPIO_PCOR		0x08
 #define GPIO_PTOR		0x0c
 #define GPIO_PDIR		0x10
+#define GPIO_PDDR		0x14
 
 #define PORT_PCR(n)		((n) * 0x4)
 #define PORT_PCR_IRQC_OFFSET	16
@@ -59,10 +65,18 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
+/* SoC has a Port Data Direction Register (PDDR) */
+#define FSL_GPIO_HAVE_PDDR	BIT(0)
+
 static struct irq_chip vf610_gpio_irq_chip;
 
+static const struct fsl_gpio_soc_data imx_data = {
+	.flags = FSL_GPIO_HAVE_PDDR,
+};
+
 static const struct of_device_id vf610_gpio_dt_ids[] = {
-	{ .compatible = "fsl,vf610-gpio" },
+	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
+	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
 	{ /* sentinel */ }
 };
 
@@ -79,8 +93,18 @@ static inline u32 vf610_gpio_readl(void __iomem *reg)
 static int vf610_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct vf610_gpio_port *port = gpiochip_get_data(gc);
-
-	return !!(vf610_gpio_readl(port->gpio_base + GPIO_PDIR) & BIT(gpio));
+	unsigned long mask = BIT(gpio);
+	void __iomem *addr;
+
+	if (port->sdata && port->sdata->flags & FSL_GPIO_HAVE_PDDR) {
+		mask &= vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
+		addr = mask ? port->gpio_base + GPIO_PDOR :
+			      port->gpio_base + GPIO_PDIR;
+		return !!(vf610_gpio_readl(addr) & BIT(gpio));
+	} else {
+		return !!(vf610_gpio_readl(port->gpio_base + GPIO_PDIR)
+					   & BIT(gpio));
+	}
 }
 
 static void vf610_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
@@ -96,12 +120,28 @@ static void vf610_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
+	struct vf610_gpio_port *port = gpiochip_get_data(chip);
+	unsigned long mask = BIT(gpio);
+	u32 val;
+
+	if (port->sdata && port->sdata->flags & FSL_GPIO_HAVE_PDDR) {
+		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
+		val &= ~mask;
+		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
+	}
+
 	return pinctrl_gpio_direction_input(chip->base + gpio);
 }
 
 static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 				       int value)
 {
+	struct vf610_gpio_port *port = gpiochip_get_data(chip);
+	unsigned long mask = BIT(gpio);
+
+	if (port->sdata && port->sdata->flags & FSL_GPIO_HAVE_PDDR)
+		vf610_gpio_writel(mask, port->gpio_base + GPIO_PDDR);
+
 	vf610_gpio_set(chip, gpio, value);
 
 	return pinctrl_gpio_direction_output(chip->base + gpio);
@@ -216,6 +256,8 @@ static struct irq_chip vf610_gpio_irq_chip = {
 
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id = of_match_device(vf610_gpio_dt_ids,
+							   &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct vf610_gpio_port *port;
@@ -227,6 +269,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	port->sdata = of_id->data;
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(port->base))
-- 
2.7.4
