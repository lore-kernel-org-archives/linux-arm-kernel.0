From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:56 -0600
Subject: [PATCH 03/11] gpio: tegra: fix register address calculations for
 Tegra30
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra20 and Tegra30 share the same register layout within registers, but
the addresses of the registers is a little different. Fix the driver to
cope with this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |   55 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 32de670..7d05a34 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -22,7 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/irqdomain.h>
@@ -37,7 +37,8 @@
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
 #define GPIO_BIT(x)		((x) & 0x7)
 
-#define GPIO_REG(x)		(GPIO_BANK(x) * 0x80 + GPIO_PORT(x) * 4)
+#define GPIO_REG(x)		(GPIO_BANK(x) * tegra_gpio_bank_stride + \
+					GPIO_PORT(x) * 4)
 
 #define GPIO_CNF(x)		(GPIO_REG(x) + 0x00)
 #define GPIO_OE(x)		(GPIO_REG(x) + 0x10)
@@ -48,12 +49,12 @@
 #define GPIO_INT_LVL(x)		(GPIO_REG(x) + 0x60)
 #define GPIO_INT_CLR(x)		(GPIO_REG(x) + 0x70)
 
-#define GPIO_MSK_CNF(x)		(GPIO_REG(x) + 0x800)
-#define GPIO_MSK_OE(x)		(GPIO_REG(x) + 0x810)
-#define GPIO_MSK_OUT(x)		(GPIO_REG(x) + 0X820)
-#define GPIO_MSK_INT_STA(x)	(GPIO_REG(x) + 0x840)
-#define GPIO_MSK_INT_ENB(x)	(GPIO_REG(x) + 0x850)
-#define GPIO_MSK_INT_LVL(x)	(GPIO_REG(x) + 0x860)
+#define GPIO_MSK_CNF(x)		(GPIO_REG(x) + tegra_gpio_upper_offset + 0x00)
+#define GPIO_MSK_OE(x)		(GPIO_REG(x) + tegra_gpio_upper_offset + 0x10)
+#define GPIO_MSK_OUT(x)		(GPIO_REG(x) + tegra_gpio_upper_offset + 0X20)
+#define GPIO_MSK_INT_STA(x)	(GPIO_REG(x) + tegra_gpio_upper_offset + 0x40)
+#define GPIO_MSK_INT_ENB(x)	(GPIO_REG(x) + tegra_gpio_upper_offset + 0x50)
+#define GPIO_MSK_INT_LVL(x)	(GPIO_REG(x) + tegra_gpio_upper_offset + 0x60)
 
 #define GPIO_INT_LVL_MASK		0x010101
 #define GPIO_INT_LVL_EDGE_RISING	0x000101
@@ -78,6 +79,8 @@ struct tegra_gpio_bank {
 static struct irq_domain *irq_domain;
 static void __iomem *regs;
 static u32 tegra_gpio_bank_count;
+static u32 tegra_gpio_bank_stride;
+static u32 tegra_gpio_upper_offset;
 static struct tegra_gpio_bank *tegra_gpio_banks;
 
 static inline void tegra_gpio_writel(u32 val, u32 reg)
@@ -333,6 +336,26 @@ static struct irq_chip tegra_gpio_irq_chip = {
 #endif
 };
 
+struct tegra_gpio_soc_config {
+	u32 bank_stride;
+	u32 upper_offset;
+};
+
+static struct tegra_gpio_soc_config tegra20_gpio_config = {
+	.bank_stride = 0x80,
+	.upper_offset = 0x800,
+};
+
+static struct tegra_gpio_soc_config tegra30_gpio_config = {
+	.bank_stride = 0x100,
+	.upper_offset = 0x80,
+};
+
+static struct of_device_id tegra_gpio_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra30-gpio", .data = &tegra30_gpio_config },
+	{ .compatible = "nvidia,tegra20-gpio", .data = &tegra20_gpio_config },
+	{ },
+};
 
 /* This lock class tells lockdep that GPIO irqs are in a different
  * category than their parents, so it won't report false recursion.
@@ -341,6 +364,8 @@ static struct lock_class_key gpio_lock_class;
 
 static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
+	struct tegra_gpio_soc_config *config;
 	int irq_base;
 	struct resource *res;
 	struct tegra_gpio_bank *bank;
@@ -348,6 +373,15 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	int i;
 	int j;
 
+	match = of_match_device(tegra_gpio_of_match, &pdev->dev);
+	if (match)
+		config = (struct tegra_gpio_soc_config *)match->data;
+	else
+		config = &tegra20_gpio_config;
+
+	tegra_gpio_bank_stride = config->bank_stride;
+	tegra_gpio_upper_offset = config->upper_offset;
+
 	for (;;) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, tegra_gpio_bank_count);
 		if (!res)
@@ -441,11 +475,6 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tegra_gpio_of_match[] __devinitdata = {
-	{ .compatible = "nvidia,tegra20-gpio", },
-	{ },
-};
-
 static struct platform_driver tegra_gpio_driver = {
 	.driver		= {
 		.name	= "tegra-gpio",
-- 
1.7.0.4
