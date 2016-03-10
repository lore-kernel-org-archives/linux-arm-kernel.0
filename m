From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:53 -0800
Subject: [PATCH 12/18] gpio: vf610: add system PM suspend/resume
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-13-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the state of the GPIO module (which contains the GPIO output
state) in memory during suspend. The driver already maintains an
interrupt configuration in memory, hence we can use this
configuration to restore the port control register (PCR).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpio/gpio-vf610.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 6284bdb..1a022be 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -37,6 +37,7 @@ struct vf610_gpio_port {
 	void __iomem *gpio_base;
 	u8 irqc[VF610_GPIO_PER_PORT];
 	int irq;
+	u32 state;
 };
 
 #define GPIO_PDOR		0x00
@@ -215,6 +216,40 @@ static struct irq_chip vf610_gpio_irq_chip = {
 	.irq_set_wake	= vf610_gpio_irq_set_wake,
 };
 
+static int __maybe_unused vf610_gpio_suspend(struct device *dev)
+{
+	struct vf610_gpio_port *port = dev_get_drvdata(dev);
+
+	port->state = vf610_gpio_readl(port->gpio_base + GPIO_PDOR);
+
+	/*
+	 * There is no need to store Port state since we maintain the state
+	 * alread in the irqc array
+	 */
+
+	return 0;
+}
+
+static int __maybe_unused vf610_gpio_resume(struct device *dev)
+{
+	struct vf610_gpio_port *port = dev_get_drvdata(dev);
+	int i;
+
+	vf610_gpio_writel(port->state, port->gpio_base + GPIO_PDOR);
+
+	for (i = 0; i < port->gc.ngpio; i++) {
+		u32 irqc = port->irqc[i] << PORT_PCR_IRQC_OFFSET;
+
+		vf610_gpio_writel(irqc, port->base + PORT_PCR(i));
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops vf610_gpio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(vf610_gpio_suspend, vf610_gpio_resume)
+};
+
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -272,6 +307,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	}
 	gpiochip_set_chained_irqchip(gc, &vf610_gpio_irq_chip, port->irq,
 				     vf610_gpio_irq_handler);
+	platform_set_drvdata(pdev, port);
 
 	return 0;
 }
@@ -279,6 +315,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 static struct platform_driver vf610_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-vf610",
+		.pm = &vf610_gpio_pm_ops,
 		.of_match_table = vf610_gpio_dt_ids,
 	},
 	.probe		= vf610_gpio_probe,
-- 
2.7.2
