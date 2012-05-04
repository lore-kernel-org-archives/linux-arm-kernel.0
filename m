From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 23:45:27 +0800
Subject: [PATCH 2/4] gpio/mxs: get rid of the use of cpu_is_xxx
In-Reply-To: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
References: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336146329-3821-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It removes the use of cpu_is_xxx from gpio-mxs driver and instead use
platform_device_id to identify the device.  Accordingly, mxs platform
code is changed to register gpio device with different names, and
the registeration are done in soc specific initialization functions
now, so postcore_initcall(mxs_add_mxs_gpio) gets removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c |   24 +-------
 arch/arm/mach-mxs/include/mach/common.h       |    5 +-
 arch/arm/mach-mxs/mm.c                        |   10 +++
 drivers/gpio/gpio-mxs.c                       |   74 +++++++++++++++++-------
 4 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-gpio-mxs.c b/arch/arm/mach-mxs/devices/platform-gpio-mxs.c
index ed0885e..cd99f19 100644
--- a/arch/arm/mach-mxs/devices/platform-gpio-mxs.c
+++ b/arch/arm/mach-mxs/devices/platform-gpio-mxs.c
@@ -14,7 +14,7 @@
 #include <mach/devices-common.h>
 
 struct platform_device *__init mxs_add_gpio(
-	int id, resource_size_t iobase, int irq)
+	char *name, int id, resource_size_t iobase, int irq)
 {
 	struct resource res[] = {
 		{
@@ -29,25 +29,5 @@ struct platform_device *__init mxs_add_gpio(
 	};
 
 	return platform_device_register_resndata(&mxs_apbh_bus,
-			"gpio-mxs", id, res, ARRAY_SIZE(res), NULL, 0);
+			name, id, res, ARRAY_SIZE(res), NULL, 0);
 }
-
-static int __init mxs_add_mxs_gpio(void)
-{
-	if (cpu_is_mx23()) {
-		mxs_add_gpio(0, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO0);
-		mxs_add_gpio(1, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO1);
-		mxs_add_gpio(2, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO2);
-	}
-
-	if (cpu_is_mx28()) {
-		mxs_add_gpio(0, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO0);
-		mxs_add_gpio(1, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO1);
-		mxs_add_gpio(2, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO2);
-		mxs_add_gpio(3, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO3);
-		mxs_add_gpio(4, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO4);
-	}
-
-	return 0;
-}
-postcore_initcall(mxs_add_mxs_gpio);
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index b212553..cc4a417 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -20,13 +20,11 @@ extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
 extern void mx23_soc_init(void);
-extern int mx23_register_gpios(void);
 extern int mx23_clocks_init(void);
 extern void mx23_map_io(void);
 extern void mx23_init_irq(void);
 
 extern void mx28_soc_init(void);
-extern int mx28_register_gpios(void);
 extern int mx28_clocks_init(void);
 extern void mx28_map_io(void);
 extern void mx28_init_irq(void);
@@ -37,4 +35,7 @@ extern int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask);
 
 extern struct platform_device *mxs_add_dma(const char *devid,
 						resource_size_t base);
+extern struct platform_device *mxs_add_gpio(char *name, int id,
+					    resource_size_t iobase, int irq);
+
 #endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
index 6a1acad..478696e 100644
--- a/arch/arm/mach-mxs/mm.c
+++ b/arch/arm/mach-mxs/mm.c
@@ -66,10 +66,20 @@ void __init mx23_soc_init(void)
 {
 	mxs_add_dma("imx23-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
 	mxs_add_dma("imx23-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
+
+	mxs_add_gpio("imx23-gpio", 0, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO0);
+	mxs_add_gpio("imx23-gpio", 1, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO1);
+	mxs_add_gpio("imx23-gpio", 2, MX23_PINCTRL_BASE_ADDR, MX23_INT_GPIO2);
 }
 
 void __init mx28_soc_init(void)
 {
 	mxs_add_dma("imx28-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
 	mxs_add_dma("imx28-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
+
+	mxs_add_gpio("imx28-gpio", 0, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO0);
+	mxs_add_gpio("imx28-gpio", 1, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO1);
+	mxs_add_gpio("imx28-gpio", 2, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO2);
+	mxs_add_gpio("imx28-gpio", 3, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO3);
+	mxs_add_gpio("imx28-gpio", 4, MX28_PINCTRL_BASE_ADDR, MX28_INT_GPIO4);
 }
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 95a11db..38ae56f 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -29,19 +29,18 @@
 #include <linux/slab.h>
 #include <linux/basic_mmio_gpio.h>
 #include <linux/module.h>
-#include <mach/mxs.h>
 
 #define MXS_SET		0x4
 #define MXS_CLR		0x8
 
-#define PINCTRL_DOUT(n)		((cpu_is_mx23() ? 0x0500 : 0x0700) + (n) * 0x10)
-#define PINCTRL_DIN(n)		((cpu_is_mx23() ? 0x0600 : 0x0900) + (n) * 0x10)
-#define PINCTRL_DOE(n)		((cpu_is_mx23() ? 0x0700 : 0x0b00) + (n) * 0x10)
-#define PINCTRL_PIN2IRQ(n)	((cpu_is_mx23() ? 0x0800 : 0x1000) + (n) * 0x10)
-#define PINCTRL_IRQEN(n)	((cpu_is_mx23() ? 0x0900 : 0x1100) + (n) * 0x10)
-#define PINCTRL_IRQLEV(n)	((cpu_is_mx23() ? 0x0a00 : 0x1200) + (n) * 0x10)
-#define PINCTRL_IRQPOL(n)	((cpu_is_mx23() ? 0x0b00 : 0x1300) + (n) * 0x10)
-#define PINCTRL_IRQSTAT(n)	((cpu_is_mx23() ? 0x0c00 : 0x1400) + (n) * 0x10)
+#define PINCTRL_DOUT(p)		((is_imx23_gpio(p) ? 0x0500 : 0x0700) + (p->id) * 0x10)
+#define PINCTRL_DIN(p)		((is_imx23_gpio(p) ? 0x0600 : 0x0900) + (p->id) * 0x10)
+#define PINCTRL_DOE(p)		((is_imx23_gpio(p) ? 0x0700 : 0x0b00) + (p->id) * 0x10)
+#define PINCTRL_PIN2IRQ(p)	((is_imx23_gpio(p) ? 0x0800 : 0x1000) + (p->id) * 0x10)
+#define PINCTRL_IRQEN(p)	((is_imx23_gpio(p) ? 0x0900 : 0x1100) + (p->id) * 0x10)
+#define PINCTRL_IRQLEV(p)	((is_imx23_gpio(p) ? 0x0a00 : 0x1200) + (p->id) * 0x10)
+#define PINCTRL_IRQPOL(p)	((is_imx23_gpio(p) ? 0x0b00 : 0x1300) + (p->id) * 0x10)
+#define PINCTRL_IRQSTAT(p)	((is_imx23_gpio(p) ? 0x0c00 : 0x1400) + (p->id) * 0x10)
 
 #define GPIO_INT_FALL_EDGE	0x0
 #define GPIO_INT_LOW_LEV	0x1
@@ -52,14 +51,30 @@
 
 #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
 
+enum mxs_gpio_id {
+	IMX23_GPIO,
+	IMX28_GPIO,
+};
+
 struct mxs_gpio_port {
 	void __iomem *base;
 	int id;
 	int irq;
 	int virtual_irq_start;
 	struct bgpio_chip bgc;
+	enum mxs_gpio_id devid;
 };
 
+static inline int is_imx23_gpio(struct mxs_gpio_port *port)
+{
+	return port->devid == IMX23_GPIO;
+}
+
+static inline int is_imx28_gpio(struct mxs_gpio_port *port)
+{
+	return port->devid == IMX28_GPIO;
+}
+
 /* Note: This driver assumes 32 GPIOs are handled in one register */
 
 static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
@@ -89,21 +104,21 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	}
 
 	/* set level or edge */
-	pin_addr = port->base + PINCTRL_IRQLEV(port->id);
+	pin_addr = port->base + PINCTRL_IRQLEV(port);
 	if (edge & GPIO_INT_LEV_MASK)
 		writel(pin_mask, pin_addr + MXS_SET);
 	else
 		writel(pin_mask, pin_addr + MXS_CLR);
 
 	/* set polarity */
-	pin_addr = port->base + PINCTRL_IRQPOL(port->id);
+	pin_addr = port->base + PINCTRL_IRQPOL(port);
 	if (edge & GPIO_INT_POL_MASK)
 		writel(pin_mask, pin_addr + MXS_SET);
 	else
 		writel(pin_mask, pin_addr + MXS_CLR);
 
 	writel(1 << (gpio & 0x1f),
-	       port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR);
+	       port->base + PINCTRL_IRQSTAT(port) + MXS_CLR);
 
 	return 0;
 }
@@ -117,8 +132,8 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	irq_stat = readl(port->base + PINCTRL_IRQSTAT(port->id)) &
-			readl(port->base + PINCTRL_IRQEN(port->id));
+	irq_stat = readl(port->base + PINCTRL_IRQSTAT(port)) &
+			readl(port->base + PINCTRL_IRQEN(port));
 
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
@@ -164,8 +179,8 @@ static void __init mxs_gpio_init_gc(struct mxs_gpio_port *port)
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 	ct->chip.irq_set_type = mxs_gpio_set_irq_type;
 	ct->chip.irq_set_wake = mxs_gpio_set_wake_irq;
-	ct->regs.ack = PINCTRL_IRQSTAT(port->id) + MXS_CLR;
-	ct->regs.mask = PINCTRL_IRQEN(port->id);
+	ct->regs.ack = PINCTRL_IRQSTAT(port) + MXS_CLR;
+	ct->regs.mask = PINCTRL_IRQEN(port);
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
@@ -179,6 +194,19 @@ static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	return port->virtual_irq_start + offset;
 }
 
+static struct platform_device_id mxs_gpio_ids[] = {
+	{
+		.name = "imx23-gpio",
+		.driver_data = IMX23_GPIO,
+	}, {
+		.name = "imx28-gpio",
+		.driver_data = IMX28_GPIO,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mxs_gpio_ids);
+
 static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 {
 	static void __iomem *base;
@@ -191,6 +219,7 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->id = pdev->id;
+	port->devid = pdev->id_entry->driver_data;
 	port->virtual_irq_start = MXS_GPIO_IRQ_START + port->id * 32;
 
 	port->irq = platform_get_irq(pdev, 0);
@@ -213,11 +242,11 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 	 * select the pin interrupt functionality but initially
 	 * disable the interrupts
 	 */
-	writel(~0U, port->base + PINCTRL_PIN2IRQ(port->id));
-	writel(0, port->base + PINCTRL_IRQEN(port->id));
+	writel(~0U, port->base + PINCTRL_PIN2IRQ(port));
+	writel(0, port->base + PINCTRL_IRQEN(port));
 
 	/* clear address has to be used to clear IRQSTAT bits */
-	writel(~0U, port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR);
+	writel(~0U, port->base + PINCTRL_IRQSTAT(port) + MXS_CLR);
 
 	/* gpio-mxs can be a generic irq chip */
 	mxs_gpio_init_gc(port);
@@ -227,9 +256,9 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 	irq_set_handler_data(port->irq, port);
 
 	err = bgpio_init(&port->bgc, &pdev->dev, 4,
-			 port->base + PINCTRL_DIN(port->id),
-			 port->base + PINCTRL_DOUT(port->id), NULL,
-			 port->base + PINCTRL_DOE(port->id), NULL, false);
+			 port->base + PINCTRL_DIN(port),
+			 port->base + PINCTRL_DOUT(port), NULL,
+			 port->base + PINCTRL_DOE(port), NULL, false);
 	if (err)
 		return err;
 
@@ -251,6 +280,7 @@ static struct platform_driver mxs_gpio_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= mxs_gpio_probe,
+	.id_table	= mxs_gpio_ids,
 };
 
 static int __init mxs_gpio_init(void)
-- 
1.7.5.4
