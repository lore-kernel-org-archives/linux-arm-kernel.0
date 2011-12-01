From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 30 Nov 2011 17:45:36 -0700
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and support DT
In-Reply-To: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322700336-26866-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance  the driver to dynamically allocate the base IRQ number, and
create an IRQ domain for itself. The use of an IRQ domain ensures that
any device tree node interrupts properties are correctly parsed.

Fix the DT binding documentation to describe interrupt-related properties,
and the contents of "child" node interrupts property.

Update tegra20.dtsi to specify the required interrupt-related properties.

Finally, remove the definition of TEGRA_GPIO_TO_IRQ; this macro no longer
gives correct results since the IRQ numbers for GPIOs are dynamically
allocated.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |   10 ++++++
 arch/arm/boot/dts/tegra20.dtsi                     |    2 +
 arch/arm/mach-tegra/include/mach/gpio-tegra.h      |    2 -
 drivers/gpio/gpio-tegra.c                          |   32 +++++++++++++++----
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
index eb4b530..20b991d 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -6,3 +6,13 @@ Required properties:
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
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index db6f562..e25f4a6 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -79,6 +79,8 @@
 			       0 55 0x04
 			       0 87 0x04
 			       0 89 0x04 >;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
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
index 61044c8..9fa5783 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mach/irq.h>
 
@@ -74,7 +75,8 @@ struct tegra_gpio_bank {
 #endif
 };
 
-
+static struct irq_domain irq_domain;
+static struct irq_domain_ops irq_domain_ops;
 static void __iomem *regs;
 static struct tegra_gpio_bank tegra_gpio_banks[7];
 
@@ -139,7 +141,7 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 
 static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return TEGRA_GPIO_TO_IRQ(offset);
+	return irq_domain_to_irq(&irq_domain, offset);
 }
 
 static struct gpio_chip tegra_gpio_chip = {
@@ -155,28 +157,28 @@ static struct gpio_chip tegra_gpio_chip = {
 
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
@@ -343,6 +345,22 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	int i;
 	int j;
 
+	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
+	if (irq_domain.irq_base < 0) {
+		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
+		return -ENODEV;
+	}
+	irq_domain.nr_irq = TEGRA_NR_GPIOS;
+	irq_domain.ops = &irq_domain_ops;
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		irq_domain.of_node = pdev->dev.of_node;
+		irq_domain_ops.dt_translate =
+			irq_domain_simple_ops.dt_translate;
+	}
+#endif
+	irq_domain_add(&irq_domain);
+
 	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
 		if (!res) {
@@ -388,7 +406,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	gpiochip_add(&tegra_gpio_chip);
 
 	for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {
-		int irq = TEGRA_GPIO_TO_IRQ(gpio);
+		int irq = irq_domain_to_irq(&irq_domain, gpio);
 		/* No validity check; all Tegra GPIOs are valid IRQs */
 
 		bank = &tegra_gpio_banks[GPIO_BANK(gpio)];
-- 
1.7.0.4
