From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:55 -0800
Subject: [PATCH 14/18] gpio: vf610: add support for WKPU unit
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-15-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WKPU unit support within the VF610 GPIO driver. The WKPU unit allows
some GPIO to be the wakeup source from lowest power modes LPSTOPx.
The relationship between the GPIO banks and the WKPU GPIO numbering
can be derived from the device tree property fsl,gpio-wakeup.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/gpio/gpio-vf610.txt        |   6 +
 drivers/gpio/gpio-vf610.c                          | 151 +++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
index 436cc99..985ddfd 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
@@ -22,6 +22,12 @@ Required properties for GPIO node:
       4 = active high level-sensitive.
       8 = active low level-sensitive.
 
+Option properties:
+- fsl,gpio-wakeup : map GPIOs to WKPU unit, 3 argument cells per phandle
+      cell 1: First GPIO (relative to the GPIO block)
+      cell 2: First GPIO of the WKPU unit
+      cell 3: Number of consecutive GPIO's
+
 Note: Each GPIO port should have an alias correctly numbered in "aliases"
 node.
 
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 1a022be..650a41a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -36,6 +36,8 @@ struct vf610_gpio_port {
 	void __iomem *base;
 	void __iomem *gpio_base;
 	u8 irqc[VF610_GPIO_PER_PORT];
+	struct platform_device *pdev_wkpu;
+	s8 fsl_wakeup[VF610_GPIO_PER_PORT];
 	int irq;
 	u32 state;
 };
@@ -61,6 +63,14 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
+#define WKPU_WISR		0x14
+#define WKPU_IRER		0x18
+#define WKPU_WRER		0x1c
+#define WKPU_WIREER		0x28
+#define WKPU_WIFEER		0x2c
+#define WKPU_WIFER		0x30
+#define WKPU_WIPUER		0x34
+
 static struct irq_chip vf610_gpio_irq_chip;
 
 static const struct of_device_id vf610_gpio_dt_ids[] = {
@@ -68,6 +78,11 @@ static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ /* sentinel */ }
 };
 
+static const struct of_device_id vf610_wkpu_dt_ids[] = {
+	{ .compatible = "fsl,vf610-wkpu" },
+	{ /* sentinel */ }
+};
+
 static inline void vf610_gpio_writel(u32 val, void __iomem *reg)
 {
 	writel_relaxed(val, reg);
@@ -143,8 +158,26 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
 {
 	struct vf610_gpio_port *port =
 		gpiochip_get_data(irq_data_get_irq_chip_data(d));
+	s8 wkpu_gpio = port->fsl_wakeup[d->hwirq];
 	u8 irqc;
 
+	if (wkpu_gpio >= 0) {
+		void __iomem *base = platform_get_drvdata(port->pdev_wkpu);
+		u32 wireer, wifeer;
+		u32 mask = 1 << wkpu_gpio;
+
+		wireer = vf610_gpio_readl(base + WKPU_WIREER) & ~mask;
+		wifeer = vf610_gpio_readl(base + WKPU_WIFEER) & ~mask;
+
+		if (type & IRQ_TYPE_EDGE_RISING)
+			wireer |= mask;
+		if (type & IRQ_TYPE_EDGE_FALLING)
+			wifeer |= mask;
+
+		vf610_gpio_writel(wireer, base + WKPU_WIREER);
+		vf610_gpio_writel(wifeer, base + WKPU_WIFEER);
+	}
+
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		irqc = PORT_INT_RISING_EDGE;
@@ -198,6 +231,29 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
 {
 	struct vf610_gpio_port *port =
 		gpiochip_get_data(irq_data_get_irq_chip_data(d));
+	s8 wkpu_gpio = port->fsl_wakeup[d->hwirq];
+
+	if (wkpu_gpio >= 0) {
+		void __iomem *base = NULL;
+		u32 wrer, irer;
+
+		base = platform_get_drvdata(port->pdev_wkpu);
+
+		/* WKPU wakeup flag for LPSTOPx modes...  */
+		wrer = vf610_gpio_readl(base + WKPU_WRER);
+		irer = vf610_gpio_readl(base + WKPU_IRER);
+
+		if (enable) {
+			wrer |= 1 << wkpu_gpio;
+			irer |= 1 << wkpu_gpio;
+		} else {
+			wrer &= ~(1 << wkpu_gpio);
+			irer &= ~(1 << wkpu_gpio);
+		}
+
+		vf610_gpio_writel(wrer, base + WKPU_WRER);
+		vf610_gpio_writel(irer, base + WKPU_IRER);
+	}
 
 	if (enable)
 		enable_irq_wake(port->irq);
@@ -250,6 +306,43 @@ static const struct dev_pm_ops vf610_gpio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(vf610_gpio_suspend, vf610_gpio_resume)
 };
 
+static int vf610_gpio_wkpu(struct device_node *np, struct vf610_gpio_port *port)
+{
+	struct platform_device *pdev = NULL;
+	struct of_phandle_args arg;
+	int i, ret;
+
+	for (i = 0; i < VF610_GPIO_PER_PORT; i++)
+		port->fsl_wakeup[i] = -1;
+
+	for (i = 0;; i++) {
+		int gpioid, wakeupid, cnt;
+
+		ret = of_parse_phandle_with_fixed_args(np, "fsl,gpio-wakeup",
+							3, i, &arg);
+
+		if (ret == -ENOENT)
+			break;
+
+		if (!pdev)
+			pdev = of_find_device_by_node(arg.np);
+		of_node_put(arg.np);
+		if (!pdev)
+			return -EPROBE_DEFER;
+
+		gpioid = arg.args[0];
+		wakeupid = arg.args[1];
+		cnt = arg.args[2];
+
+		while (cnt-- && gpioid < VF610_GPIO_PER_PORT)
+			port->fsl_wakeup[gpioid++] = wakeupid++;
+	}
+
+	port->pdev_wkpu = pdev;
+
+	return 0;
+}
+
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -277,6 +370,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (port->irq < 0)
 		return port->irq;
 
+	ret = vf610_gpio_wkpu(np, port);
+	if (ret < 0)
+		return ret;
+
 	gc = &port->gc;
 	gc->of_node = np;
 	gc->parent = dev;
@@ -327,6 +424,60 @@ static int __init gpio_vf610_init(void)
 }
 device_initcall(gpio_vf610_init);
 
+static irqreturn_t vf610_wkpu_irq(int irq, void *data)
+{
+	void __iomem *base = data;
+	u32 wisr;
+
+	wisr = vf610_gpio_readl(base + WKPU_WISR);
+	vf610_gpio_writel(wisr, base + WKPU_WISR);
+	pr_debug("%s, WKPU interrupt received, flags %08x\n", __func__, wisr);
+
+	return 0;
+}
+
+static int vf610_wkpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *iores;
+	void __iomem *base;
+	int irq, err;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, iores);
+
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_irq(dev, irq, vf610_wkpu_irq, 0, "wkpu-vf610", base);
+	if (err) {
+		dev_err(dev, "Error requesting IRQ!\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, base);
+
+	return 0;
+}
+
+static struct platform_driver vf610_wkpu_driver = {
+	.driver		= {
+		.name	= "wkpu-vf610",
+		.of_match_table = vf610_wkpu_dt_ids,
+	},
+	.probe		= vf610_wkpu_probe,
+};
+
+static int __init vf610_wkpu_init(void)
+{
+	return platform_driver_register(&vf610_wkpu_driver);
+}
+device_initcall(vf610_wkpu_init);
+
 MODULE_AUTHOR("Stefan Agner <stefan@agner.ch>");
 MODULE_DESCRIPTION("Freescale VF610 GPIO");
 MODULE_LICENSE("GPL v2");
-- 
2.7.2
