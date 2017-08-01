From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 1 Aug 2017 22:04:17 +0800
Subject: [PATCH V2 1/1] gpio: gpio-vf610: add imx7ulp support
Message-ID: <1501596257-20825-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
on MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the
RGPIO2P has an extra Port Data Direction Register (PDDR) used
to configure the individual port pins for input or output.

We introduce a bool have_paddr with fsl_gpio_soc_data data
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
ChangeLog:
v1->v2:
 * remove flags and use bool have_paddr instead
---
 drivers/gpio/gpio-vf610.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 521fbe3..cbe9e06 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -30,10 +30,16 @@
 
 #define VF610_GPIO_PER_PORT		32
 
+struct fsl_gpio_soc_data {
+	/* SoCs has a Port Data Direction Register (PDDR) */
+	bool have_paddr;
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
@@ -43,6 +49,7 @@ struct vf610_gpio_port {
 #define GPIO_PCOR		0x08
 #define GPIO_PTOR		0x0c
 #define GPIO_PDIR		0x10
+#define GPIO_PDDR		0x14
 
 #define PORT_PCR(n)		((n) * 0x4)
 #define PORT_PCR_IRQC_OFFSET	16
@@ -61,8 +68,13 @@ struct vf610_gpio_port {
 
 static struct irq_chip vf610_gpio_irq_chip;
 
+static const struct fsl_gpio_soc_data imx_data = {
+	.have_paddr = true,
+};
+
 static const struct of_device_id vf610_gpio_dt_ids[] = {
-	{ .compatible = "fsl,vf610-gpio" },
+	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
+	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
 	{ /* sentinel */ }
 };
 
@@ -79,8 +91,18 @@ static inline u32 vf610_gpio_readl(void __iomem *reg)
 static int vf610_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct vf610_gpio_port *port = gpiochip_get_data(gc);
-
-	return !!(vf610_gpio_readl(port->gpio_base + GPIO_PDIR) & BIT(gpio));
+	unsigned long mask = BIT(gpio);
+	void __iomem *addr;
+
+	if (port->sdata && port->sdata->have_paddr) {
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
@@ -96,12 +118,28 @@ static void vf610_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
+	struct vf610_gpio_port *port = gpiochip_get_data(chip);
+	unsigned long mask = BIT(gpio);
+	u32 val;
+
+	if (port->sdata && port->sdata->have_paddr) {
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
+	if (port->sdata && port->sdata->have_paddr)
+		vf610_gpio_writel(mask, port->gpio_base + GPIO_PDDR);
+
 	vf610_gpio_set(chip, gpio, value);
 
 	return pinctrl_gpio_direction_output(chip->base + gpio);
@@ -216,6 +254,8 @@ static struct irq_chip vf610_gpio_irq_chip = {
 
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id = of_match_device(vf610_gpio_dt_ids,
+							   &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct vf610_gpio_port *port;
@@ -227,6 +267,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	port->sdata = of_id->data;
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(port->base))
-- 
2.7.4
