From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Thu, 4 Jun 2015 17:40:32 +0530
Subject: [PATCH v2] gpio: Added GPIO support to Zynq Ultrascale+ MPSoC
Message-ID: <1433419832-40678-1-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support to Zynq Ultrascale+ MPSoC on the existing zynq gpio driver.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 Chnages in v2:
	1.Added device tree bingings for Zynq Ultrascale+ MPSoC
	2.Changed the commit message and subject from ZynqMP to
	  Zynq Ultrascale+ MPSoC
---
 .../devicetree/bindings/gpio/gpio-zynq.txt         |    2 +-
 drivers/gpio/Kconfig                               |    2 +-
 drivers/gpio/gpio-zynq.c                           |  191 +++++++++++++-------
 3 files changed, 127 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.txt b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
index 986371a..db4c6a6 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
@@ -6,7 +6,7 @@ Required properties:
 			  - First cell is the GPIO line number
 			  - Second cell is used to specify optional
 			    parameters (unused)
-- compatible		: Should be "xlnx,zynq-gpio-1.0"
+- compatible		: Should be "xlnx,zynq-gpio-1.0" or "xlnx,zynqmp-gpio-1.0"
 - clocks		: Clock specifier (see clock bindings for details)
 - gpio-controller	: Marks the device node as a GPIO controller.
 - interrupts		: Interrupt specifier (see interrupt bindings for
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index caefe80..eef3a74 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -505,7 +505,7 @@ config GPIO_ZEVIO
 
 config GPIO_ZYNQ
 	tristate "Xilinx Zynq GPIO support"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support Xilinx Zynq GPIO controller.
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 184c4b1..d9d26aa 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -18,34 +18,47 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #define DRIVER_NAME "zynq-gpio"
 
 /* Maximum banks */
 #define ZYNQ_GPIO_MAX_BANK	4
+#define ZYNQMP_GPIO_MAX_BANK	6
 
 #define ZYNQ_GPIO_BANK0_NGPIO	32
 #define ZYNQ_GPIO_BANK1_NGPIO	22
 #define ZYNQ_GPIO_BANK2_NGPIO	32
 #define ZYNQ_GPIO_BANK3_NGPIO	32
 
-#define ZYNQ_GPIO_NR_GPIOS	(ZYNQ_GPIO_BANK0_NGPIO + \
-				 ZYNQ_GPIO_BANK1_NGPIO + \
-				 ZYNQ_GPIO_BANK2_NGPIO + \
-				 ZYNQ_GPIO_BANK3_NGPIO)
-
-#define ZYNQ_GPIO_BANK0_PIN_MIN	0
-#define ZYNQ_GPIO_BANK0_PIN_MAX	(ZYNQ_GPIO_BANK0_PIN_MIN + \
-					ZYNQ_GPIO_BANK0_NGPIO - 1)
-#define ZYNQ_GPIO_BANK1_PIN_MIN	(ZYNQ_GPIO_BANK0_PIN_MAX + 1)
-#define ZYNQ_GPIO_BANK1_PIN_MAX	(ZYNQ_GPIO_BANK1_PIN_MIN + \
-					ZYNQ_GPIO_BANK1_NGPIO - 1)
-#define ZYNQ_GPIO_BANK2_PIN_MIN	(ZYNQ_GPIO_BANK1_PIN_MAX + 1)
-#define ZYNQ_GPIO_BANK2_PIN_MAX	(ZYNQ_GPIO_BANK2_PIN_MIN + \
-					ZYNQ_GPIO_BANK2_NGPIO - 1)
-#define ZYNQ_GPIO_BANK3_PIN_MIN	(ZYNQ_GPIO_BANK2_PIN_MAX + 1)
-#define ZYNQ_GPIO_BANK3_PIN_MAX	(ZYNQ_GPIO_BANK3_PIN_MIN + \
-					ZYNQ_GPIO_BANK3_NGPIO - 1)
+#define ZYNQMP_GPIO_BANK0_NGPIO 26
+#define ZYNQMP_GPIO_BANK1_NGPIO 26
+#define ZYNQMP_GPIO_BANK2_NGPIO 26
+#define ZYNQMP_GPIO_BANK3_NGPIO 32
+#define ZYNQMP_GPIO_BANK4_NGPIO 32
+#define ZYNQMP_GPIO_BANK5_NGPIO 32
+
+#define	ZYNQ_GPIO_NR_GPIOS	118
+#define	ZYNQMP_GPIO_NR_GPIOS	174
+
+#define ZYNQ_GPIO_BANK0_PIN_MIN(str)	0
+#define ZYNQ_GPIO_BANK0_PIN_MAX(str)	(ZYNQ_GPIO_BANK0_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK0_NGPIO - 1)
+#define ZYNQ_GPIO_BANK1_PIN_MIN(str)	(ZYNQ_GPIO_BANK0_PIN_MAX(str) + 1)
+#define ZYNQ_GPIO_BANK1_PIN_MAX(str)	(ZYNQ_GPIO_BANK1_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK1_NGPIO - 1)
+#define ZYNQ_GPIO_BANK2_PIN_MIN(str)	(ZYNQ_GPIO_BANK1_PIN_MAX(str) + 1)
+#define ZYNQ_GPIO_BANK2_PIN_MAX(str)	(ZYNQ_GPIO_BANK2_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK2_NGPIO - 1)
+#define ZYNQ_GPIO_BANK3_PIN_MIN(str)	(ZYNQ_GPIO_BANK2_PIN_MAX(str) + 1)
+#define ZYNQ_GPIO_BANK3_PIN_MAX(str)	(ZYNQ_GPIO_BANK3_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK3_NGPIO - 1)
+#define ZYNQ_GPIO_BANK4_PIN_MIN(str)	(ZYNQ_GPIO_BANK3_PIN_MAX(str) + 1)
+#define ZYNQ_GPIO_BANK4_PIN_MAX(str)	(ZYNQ_GPIO_BANK4_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK4_NGPIO - 1)
+#define ZYNQ_GPIO_BANK5_PIN_MIN(str)	(ZYNQ_GPIO_BANK4_PIN_MAX(str) + 1)
+#define ZYNQ_GPIO_BANK5_PIN_MAX(str)	(ZYNQ_GPIO_BANK5_PIN_MIN(str) + \
+					ZYNQ##str##_GPIO_BANK5_NGPIO - 1)
 
 
 /* Register offsets for the GPIO device */
@@ -89,12 +102,30 @@
  * @base_addr:	base address of the GPIO device
  * @clk:	clock resource for this controller
  * @irq:	interrupt for the GPIO device
+ * @p_data:	pointer to platform data
  */
 struct zynq_gpio {
 	struct gpio_chip chip;
 	void __iomem *base_addr;
 	struct clk *clk;
 	int irq;
+	const struct zynq_platform_data *p_data;
+};
+
+/**
+ * struct zynq_platform_data -  zynq gpio platform data structure
+ * @label:	string to store in gpio->label
+ * @ngpio:	max number of gpio pins
+ * @max_bank:	maximum number of gpio banks
+ * @bank_min:	this array represents bank's min pin
+ * @bank_max:	this array represents bank's max pin
+*/
+struct zynq_platform_data {
+	const char *label;
+	u16 ngpio;
+	int max_bank;
+	int bank_min[ZYNQMP_GPIO_MAX_BANK];
+	int bank_max[ZYNQMP_GPIO_MAX_BANK];
 };
 
 static struct irq_chip zynq_gpio_level_irqchip;
@@ -112,39 +143,26 @@ static struct irq_chip zynq_gpio_edge_irqchip;
  */
 static inline void zynq_gpio_get_bank_pin(unsigned int pin_num,
 					  unsigned int *bank_num,
-					  unsigned int *bank_pin_num)
+					  unsigned int *bank_pin_num,
+					  struct zynq_gpio *gpio)
 {
-	switch (pin_num) {
-	case ZYNQ_GPIO_BANK0_PIN_MIN ... ZYNQ_GPIO_BANK0_PIN_MAX:
-		*bank_num = 0;
-		*bank_pin_num = pin_num;
-		break;
-	case ZYNQ_GPIO_BANK1_PIN_MIN ... ZYNQ_GPIO_BANK1_PIN_MAX:
-		*bank_num = 1;
-		*bank_pin_num = pin_num - ZYNQ_GPIO_BANK1_PIN_MIN;
-		break;
-	case ZYNQ_GPIO_BANK2_PIN_MIN ... ZYNQ_GPIO_BANK2_PIN_MAX:
-		*bank_num = 2;
-		*bank_pin_num = pin_num - ZYNQ_GPIO_BANK2_PIN_MIN;
-		break;
-	case ZYNQ_GPIO_BANK3_PIN_MIN ... ZYNQ_GPIO_BANK3_PIN_MAX:
-		*bank_num = 3;
-		*bank_pin_num = pin_num - ZYNQ_GPIO_BANK3_PIN_MIN;
-		break;
-	default:
-		WARN(true, "invalid GPIO pin number: %u", pin_num);
-		*bank_num = 0;
-		*bank_pin_num = 0;
-		break;
+	int bank;
+
+	for (bank = 0; bank < gpio->p_data->max_bank; bank++) {
+		if ((pin_num >= gpio->p_data->bank_min[bank]) &&
+			(pin_num <= gpio->p_data->bank_max[bank])) {
+				*bank_num = bank;
+				*bank_pin_num = pin_num -
+						gpio->p_data->bank_min[bank];
+				return;
+		}
 	}
-}
 
-static const unsigned int zynq_gpio_bank_offset[] = {
-	ZYNQ_GPIO_BANK0_PIN_MIN,
-	ZYNQ_GPIO_BANK1_PIN_MIN,
-	ZYNQ_GPIO_BANK2_PIN_MIN,
-	ZYNQ_GPIO_BANK3_PIN_MIN,
-};
+	/* default */
+	WARN(true, "invalid GPIO pin number: %u", pin_num);
+	*bank_num = 0;
+	*bank_pin_num = 0;
+}
 
 /**
  * zynq_gpio_get_value - Get the state of the specified pin of GPIO device
@@ -161,7 +179,7 @@ static int zynq_gpio_get_value(struct gpio_chip *chip, unsigned int pin)
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = container_of(chip, struct zynq_gpio, chip);
 
-	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
 	data = readl_relaxed(gpio->base_addr +
 			     ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
@@ -185,7 +203,7 @@ static void zynq_gpio_set_value(struct gpio_chip *chip, unsigned int pin,
 	unsigned int reg_offset, bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = container_of(chip, struct zynq_gpio, chip);
 
-	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
 	if (bank_pin_num >= ZYNQ_GPIO_MID_PIN_NUM) {
 		/* only 16 data bits in bit maskable reg */
@@ -222,7 +240,7 @@ static int zynq_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = container_of(chip, struct zynq_gpio, chip);
 
-	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
 	/* bank 0 pins 7 and 8 are special and cannot be used as inputs */
 	if (bank_num == 0 && (bank_pin_num == 7 || bank_pin_num == 8))
@@ -255,7 +273,7 @@ static int zynq_gpio_dir_out(struct gpio_chip *chip, unsigned int pin,
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = container_of(chip, struct zynq_gpio, chip);
 
-	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
 	/* set the GPIO pin as output */
 	reg = readl_relaxed(gpio->base_addr + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
@@ -286,7 +304,7 @@ static void zynq_gpio_irq_mask(struct irq_data *irq_data)
 	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(irq_data);
 
 	device_pin_num = irq_data->hwirq;
-	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 	writel_relaxed(BIT(bank_pin_num),
 		       gpio->base_addr + ZYNQ_GPIO_INTDIS_OFFSET(bank_num));
 }
@@ -306,7 +324,7 @@ static void zynq_gpio_irq_unmask(struct irq_data *irq_data)
 	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(irq_data);
 
 	device_pin_num = irq_data->hwirq;
-	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 	writel_relaxed(BIT(bank_pin_num),
 		       gpio->base_addr + ZYNQ_GPIO_INTEN_OFFSET(bank_num));
 }
@@ -325,7 +343,7 @@ static void zynq_gpio_irq_ack(struct irq_data *irq_data)
 	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(irq_data);
 
 	device_pin_num = irq_data->hwirq;
-	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 	writel_relaxed(BIT(bank_pin_num),
 		       gpio->base_addr + ZYNQ_GPIO_INTSTS_OFFSET(bank_num));
 }
@@ -375,7 +393,7 @@ static int zynq_gpio_set_irq_type(struct irq_data *irq_data, unsigned int type)
 	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(irq_data);
 
 	device_pin_num = irq_data->hwirq;
-	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+	zynq_gpio_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num, gpio);
 
 	int_type = readl_relaxed(gpio->base_addr +
 				 ZYNQ_GPIO_INTTYPE_OFFSET(bank_num));
@@ -470,7 +488,7 @@ static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
 				      unsigned int bank_num,
 				      unsigned long pending)
 {
-	unsigned int bank_offset = zynq_gpio_bank_offset[bank_num];
+	unsigned int bank_offset = gpio->p_data->bank_min[bank_num];
 	struct irq_domain *irqdomain = gpio->chip.irqdomain;
 	int offset;
 
@@ -505,7 +523,7 @@ static void zynq_gpio_irqhandler(unsigned int irq, struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 
-	for (bank_num = 0; bank_num < ZYNQ_GPIO_MAX_BANK; bank_num++) {
+	for (bank_num = 0; bank_num < gpio->p_data->max_bank; bank_num++) {
 		int_sts = readl_relaxed(gpio->base_addr +
 					ZYNQ_GPIO_INTSTS_OFFSET(bank_num));
 		int_enb = readl_relaxed(gpio->base_addr +
@@ -582,6 +600,46 @@ static const struct dev_pm_ops zynq_gpio_dev_pm_ops = {
 			zynq_gpio_runtime_resume, NULL)
 };
 
+static const struct zynq_platform_data zynqmp_gpio_def = {
+	.label = "zynqmp_gpio",
+	.ngpio = ZYNQMP_GPIO_NR_GPIOS,
+	.max_bank = ZYNQMP_GPIO_MAX_BANK,
+	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(MP),
+	.bank_max[0] = ZYNQ_GPIO_BANK0_PIN_MAX(MP),
+	.bank_min[1] = ZYNQ_GPIO_BANK1_PIN_MIN(MP),
+	.bank_max[1] = ZYNQ_GPIO_BANK1_PIN_MAX(MP),
+	.bank_min[2] = ZYNQ_GPIO_BANK2_PIN_MIN(MP),
+	.bank_max[2] = ZYNQ_GPIO_BANK2_PIN_MAX(MP),
+	.bank_min[3] = ZYNQ_GPIO_BANK3_PIN_MIN(MP),
+	.bank_max[3] = ZYNQ_GPIO_BANK3_PIN_MAX(MP),
+	.bank_min[4] = ZYNQ_GPIO_BANK4_PIN_MIN(MP),
+	.bank_max[4] = ZYNQ_GPIO_BANK4_PIN_MAX(MP),
+	.bank_min[5] = ZYNQ_GPIO_BANK5_PIN_MIN(MP),
+	.bank_max[5] = ZYNQ_GPIO_BANK5_PIN_MAX(MP),
+};
+
+static const struct zynq_platform_data zynq_gpio_def = {
+	.label = "zynq_gpio",
+	.ngpio = ZYNQ_GPIO_NR_GPIOS,
+	.max_bank = ZYNQ_GPIO_MAX_BANK,
+	.bank_min[0] = ZYNQ_GPIO_BANK0_PIN_MIN(),
+	.bank_max[0] = ZYNQ_GPIO_BANK0_PIN_MAX(),
+	.bank_min[1] = ZYNQ_GPIO_BANK1_PIN_MIN(),
+	.bank_max[1] = ZYNQ_GPIO_BANK1_PIN_MAX(),
+	.bank_min[2] = ZYNQ_GPIO_BANK2_PIN_MIN(),
+	.bank_max[2] = ZYNQ_GPIO_BANK2_PIN_MAX(),
+	.bank_min[3] = ZYNQ_GPIO_BANK3_PIN_MIN(),
+	.bank_max[3] = ZYNQ_GPIO_BANK3_PIN_MAX(),
+};
+
+static const struct of_device_id zynq_gpio_of_match[] = {
+	{ .compatible = "xlnx,zynq-gpio-1.0", .data = (void *)&zynq_gpio_def },
+	{ .compatible = "xlnx,zynqmp-gpio-1.0",
+					.data = (void *)&zynqmp_gpio_def },
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, zynq_gpio_of_match);
+
 /**
  * zynq_gpio_probe - Initialization method for a zynq_gpio device
  * @pdev:	platform device instance
@@ -599,11 +657,18 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
 	struct resource *res;
+	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
+	match = of_match_node(zynq_gpio_of_match, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "of_match_node() failed\n");
+		return -EINVAL;
+	}
+	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -619,7 +684,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 
 	/* configure the gpio chip */
 	chip = &gpio->chip;
-	chip->label = "zynq_gpio";
+	chip->label = gpio->p_data->label;
 	chip->owner = THIS_MODULE;
 	chip->dev = &pdev->dev;
 	chip->get = zynq_gpio_get_value;
@@ -629,7 +694,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->direction_input = zynq_gpio_dir_in;
 	chip->direction_output = zynq_gpio_dir_out;
 	chip->base = -1;
-	chip->ngpio = ZYNQ_GPIO_NR_GPIOS;
+	chip->ngpio = gpio->p_data->ngpio;
 
 	/* Enable GPIO clock */
 	gpio->clk = devm_clk_get(&pdev->dev, NULL);
@@ -651,7 +716,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* disable interrupts for all banks */
-	for (bank_num = 0; bank_num < ZYNQ_GPIO_MAX_BANK; bank_num++)
+	for (bank_num = 0; bank_num < gpio->p_data->max_bank; bank_num++)
 		writel_relaxed(ZYNQ_GPIO_IXR_DISABLE_ALL, gpio->base_addr +
 			       ZYNQ_GPIO_INTDIS_OFFSET(bank_num));
 
@@ -695,12 +760,6 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id zynq_gpio_of_match[] = {
-	{ .compatible = "xlnx,zynq-gpio-1.0", },
-	{ /* end of table */ }
-};
-MODULE_DEVICE_TABLE(of, zynq_gpio_of_match);
-
 static struct platform_driver zynq_gpio_driver = {
 	.driver	= {
 		.name = DRIVER_NAME,
-- 
1.7.4
