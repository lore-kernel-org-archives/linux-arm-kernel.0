From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 19 Jan 2012 11:16:35 -0700
Subject: [PATCH V2] gpio: tegra: Parameterize the number of banks
Message-ID: <1326996995-23096-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra20's GPIO controller has 7 banks, and Tegra30's controller has 8
banks. Allow the number of banks to be configured at run-time by the
device tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch depends on:
http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
devel-stable 44986ab056076e9dc9fb9f8b4729afef7fa72616

This is a replacement for:
http://patchwork.ozlabs.org/patch/134321/

v2: Determine # banks by the number of interrupt properties rather than
adding a custom property for this.
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |    8 ++-
 drivers/gpio/gpio-tegra.c                          |   42 +++++++++++++++----
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
index d114e19..023c952 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -1,9 +1,11 @@
-NVIDIA Tegra 2 GPIO controller
+NVIDIA Tegra GPIO controller
 
 Required properties:
-- compatible : "nvidia,tegra20-gpio"
+- compatible : "nvidia,tegra<chip>-gpio"
 - reg : Physical base address and length of the controller's registers.
-- interrupts : The interrupt outputs from the controller.
+- interrupts : The interrupt outputs from the controller. For Tegra20,
+  there should be 7 interrupts specified, and for Tegra30, there should
+  be 8 interrupts specified.
 - #gpio-cells : Should be two. The first cell is the pin number and the
   second cell is used to specify optional parameters:
   - bit 0 specifies polarity (0 for normal, 1 for inverted)
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index bc923c7..98f3980 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -77,7 +77,8 @@ struct tegra_gpio_bank {
 
 static struct irq_domain irq_domain;
 static void __iomem *regs;
-static struct tegra_gpio_bank tegra_gpio_banks[7];
+static u32 tegra_gpio_bank_count;
+static struct tegra_gpio_bank *tegra_gpio_banks;
 
 static inline void tegra_gpio_writel(u32 val, u32 reg)
 {
@@ -274,7 +275,7 @@ void tegra_gpio_resume(void)
 
 	local_irq_save(flags);
 
-	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
+	for (b = 0; b < tegra_gpio_bank_count; b++) {
 		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
 
 		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
@@ -297,7 +298,7 @@ void tegra_gpio_suspend(void)
 	int p;
 
 	local_irq_save(flags);
-	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
+	for (b = 0; b < tegra_gpio_bank_count; b++) {
 		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
 
 		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
@@ -338,23 +339,46 @@ static struct lock_class_key gpio_lock_class;
 
 static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 {
+	int irq_base;
 	struct resource *res;
 	struct tegra_gpio_bank *bank;
 	int gpio;
 	int i;
 	int j;
 
-	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
-	if (irq_domain.irq_base < 0) {
+	for (;;) {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, tegra_gpio_bank_count);
+		if (!res)
+			break;
+		tegra_gpio_bank_count++;
+	}
+	if (!tegra_gpio_bank_count) {
+		dev_err(&pdev->dev, "Missing IRQ resource\n");
+		return -ENODEV;
+	}
+
+	tegra_gpio_chip.ngpio = tegra_gpio_bank_count * 32;
+
+	tegra_gpio_banks = devm_kzalloc(&pdev->dev,
+			tegra_gpio_bank_count * sizeof(*tegra_gpio_banks),
+			GFP_KERNEL);
+	if (!tegra_gpio_banks) {
+		dev_err(&pdev->dev, "Couldn't allocate bank structure\n");
+		return -ENODEV;
+	}
+
+	irq_base = irq_alloc_descs(-1, 0, tegra_gpio_chip.ngpio, 0);
+	if (irq_base < 0) {
 		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
 		return -ENODEV;
 	}
-	irq_domain.nr_irq = TEGRA_NR_GPIOS;
+	irq_domain.irq_base = irq_base;
+	irq_domain.nr_irq = tegra_gpio_chip.ngpio;
 	irq_domain.ops = &irq_domain_simple_ops;
 	irq_domain.of_node = pdev->dev.of_node;
 	irq_domain_add(&irq_domain);
 
-	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
+	for (i = 0; i < tegra_gpio_bank_count; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
 		if (!res) {
 			dev_err(&pdev->dev, "Missing IRQ resource\n");
@@ -391,7 +415,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 
 	gpiochip_add(&tegra_gpio_chip);
 
-	for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {
+	for (gpio = 0; gpio < tegra_gpio_chip.ngpio; gpio++) {
 		int irq = irq_domain_to_irq(&irq_domain, gpio);
 		/* No validity check; all Tegra GPIOs are valid IRQs */
 
@@ -404,7 +428,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
+	for (i = 0; i < tegra_gpio_bank_count; i++) {
 		bank = &tegra_gpio_banks[i];
 
 		irq_set_chained_handler(bank->irq, tegra_gpio_irq_handler);
-- 
1.7.0.4
