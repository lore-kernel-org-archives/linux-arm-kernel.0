From: swarren@nvidia.com (Stephen Warren)
Date: Wed,  4 Jan 2012 11:39:37 -0700
Subject: [PATCH 5/6] gpio: tegra: Dynamically allocate IRQ base, and support DT
In-Reply-To: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325702378-20863-5-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the driver to dynamically allocate the base IRQ number, and
create an IRQ domain for itself. The use of an IRQ domain ensures that
any device tree node interrupts properties are correctly parsed.

Describe interrupt-related properties in the device tree binding docs,
and the contents of "child" node interrupts property.

Update tegra*.dtsi to specify the required interrupt-related properties.

Finally, remove the definition of TEGRA_GPIO_TO_IRQ; this macro no longer
gives correct results since the IRQ numbers for GPIOs are dynamically
allocated.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch depends on:
http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
devel-stable c87fb57346fc7653ace98769f148e0dcd88ac1ee
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |   12 +++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |    2 +
 arch/arm/boot/dts/tegra30.dtsi                     |    2 +
 arch/arm/mach-tegra/include/mach/gpio-tegra.h      |    2 -
 drivers/gpio/gpio-tegra.c                          |   25 ++++++++++++++-----
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
index 50b363c..d114e19 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -8,6 +8,16 @@ Required properties:
   second cell is used to specify optional parameters:
   - bit 0 specifies polarity (0 for normal, 1 for inverted)
 - gpio-controller : Marks the device node as a GPIO controller.
+- #interrupt-cells : Should be 2.
+  The first cell is the GPIO number.
+  The second cell is used to specify flags:
+    bits[3:0] trigger type and level flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
+      Valid combinations are 1, 2, 3, 4, 8.
+- interrupt-controller : Marks the device node as an interrupt controller.
 
 Example:
 
@@ -23,4 +33,6 @@ gpio: gpio at 6000d000 {
 		       0 89 0x04 >;
 	#gpio-cells = <2>;
 	gpio-controller;
+	#interrupt-cells = <2>;
+	interrupt-controller;
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 3da7afd..0cdc4a6 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -75,6 +75,8 @@
 			       0 89 0x04 >;
 		#gpio-cells = <2>;
 		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
 	};
 
 	pinmux: pinmux at 70000000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 2b3f6cd..83024c0 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -65,6 +65,8 @@
 			       0 125 0x04 >;
 		#gpio-cells = <2>;
 		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
 	};
 
 	serial at 70006000 {
diff --git a/arch/arm/mach-tegra/include/mach/gpio-tegra.h b/arch/arm/mach-tegra/include/mach/gpio-tegra.h
index 87d37fd..6140820 100644
--- a/arch/arm/mach-tegra/include/mach/gpio-tegra.h
+++ b/arch/arm/mach-tegra/include/mach/gpio-tegra.h
@@ -25,8 +25,6 @@
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
 
-#define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
-
 struct tegra_gpio_table {
 	int	gpio;	/* GPIO number */
 	bool	enable;	/* Enable for GPIO at init? */
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 61044c8..c877a33 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mach/irq.h>
 
@@ -74,7 +75,7 @@ struct tegra_gpio_bank {
 #endif
 };
 
-
+static struct irq_domain irq_domain;
 static void __iomem *regs;
 static struct tegra_gpio_bank tegra_gpio_banks[7];
 
@@ -139,7 +140,7 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 
 static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return TEGRA_GPIO_TO_IRQ(offset);
+	return irq_domain_to_irq(&irq_domain, offset);
 }
 
 static struct gpio_chip tegra_gpio_chip = {
@@ -155,28 +156,28 @@ static struct gpio_chip tegra_gpio_chip = {
 
 static void tegra_gpio_irq_ack(struct irq_data *d)
 {
-	int gpio = d->irq - INT_GPIO_BASE;
+	int gpio = d->hwirq;
 
 	tegra_gpio_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
 }
 
 static void tegra_gpio_irq_mask(struct irq_data *d)
 {
-	int gpio = d->irq - INT_GPIO_BASE;
+	int gpio = d->hwirq;
 
 	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 0);
 }
 
 static void tegra_gpio_irq_unmask(struct irq_data *d)
 {
-	int gpio = d->irq - INT_GPIO_BASE;
+	int gpio = d->hwirq;
 
 	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 1);
 }
 
 static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	int gpio = d->irq - INT_GPIO_BASE;
+	int gpio = d->hwirq;
 	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	int port = GPIO_PORT(gpio);
 	int lvl_type;
@@ -343,6 +344,16 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	int i;
 	int j;
 
+	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
+	if (irq_domain.irq_base < 0) {
+		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
+		return -ENODEV;
+	}
+	irq_domain.nr_irq = TEGRA_NR_GPIOS;
+	irq_domain.ops = &irq_domain_simple_ops;
+	irq_domain.of_node = pdev->dev.of_node;
+	irq_domain_add(&irq_domain);
+
 	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
 		if (!res) {
@@ -388,7 +399,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	gpiochip_add(&tegra_gpio_chip);
 
 	for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {
-		int irq = TEGRA_GPIO_TO_IRQ(gpio);
+		int irq = irq_domain_to_irq(&irq_domain, gpio);
 		/* No validity check; all Tegra GPIOs are valid IRQs */
 
 		bank = &tegra_gpio_banks[GPIO_BANK(gpio)];
-- 
1.7.0.4
