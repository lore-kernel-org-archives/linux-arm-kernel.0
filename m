From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 11 Oct 2011 16:16:14 -0600
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
Message-ID: <1318371375-4083-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3: Make regs variable static. Remove empty init of tegra_gpio_banks.

v2: Retrieve IRQ and memory addresses from resources instead of hard-
coding them. Add back initialization of tegra_gpio_chip.of_node.

Signed-off-by: Stephen Warren <swarren@nvidia.com>

gpio fixup
---
 drivers/gpio/gpio-tegra.c |  143 ++++++++++++++++++++++++++++++---------------
 1 files changed, 95 insertions(+), 48 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 6b65207..4cb59ed 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -20,10 +20,11 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
 
 #include <asm/mach/irq.h>
 
@@ -35,9 +36,7 @@
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
 #define GPIO_BIT(x)		((x) & 0x7)
 
-#define GPIO_REG(x)		(IO_TO_VIRT(TEGRA_GPIO_BASE) +	\
-				 GPIO_BANK(x) * 0x80 +		\
-				 GPIO_PORT(x) * 4)
+#define GPIO_REG(x)		(GPIO_BANK(x) * 0x80 + GPIO_PORT(x) * 4)
 
 #define GPIO_CNF(x)		(GPIO_REG(x) + 0x00)
 #define GPIO_OE(x)		(GPIO_REG(x) + 0x10)
@@ -76,15 +75,18 @@ struct tegra_gpio_bank {
 };
 
 
-static struct tegra_gpio_bank tegra_gpio_banks[] = {
-	{.bank = 0, .irq = INT_GPIO1},
-	{.bank = 1, .irq = INT_GPIO2},
-	{.bank = 2, .irq = INT_GPIO3},
-	{.bank = 3, .irq = INT_GPIO4},
-	{.bank = 4, .irq = INT_GPIO5},
-	{.bank = 5, .irq = INT_GPIO6},
-	{.bank = 6, .irq = INT_GPIO7},
-};
+static void __iomem *regs;
+static struct tegra_gpio_bank tegra_gpio_banks[7];
+
+static inline void tegra_gpio_writel(u32 val, u32 reg)
+{
+	__raw_writel(val, regs + reg);
+}
+
+static inline u32 tegra_gpio_readl(u32 reg)
+{
+	return __raw_readl(regs + reg);
+}
 
 static int tegra_gpio_compose(int bank, int port, int bit)
 {
@@ -98,7 +100,7 @@ static void tegra_gpio_mask_write(u32 reg, int gpio, int value)
 	val = 0x100 << GPIO_BIT(gpio);
 	if (value)
 		val |= 1 << GPIO_BIT(gpio);
-	__raw_writel(val, reg);
+	tegra_gpio_writel(val, reg);
 }
 
 void tegra_gpio_enable(int gpio)
@@ -118,7 +120,7 @@ static void tegra_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int tegra_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return (__raw_readl(GPIO_IN(offset)) >> GPIO_BIT(offset)) & 0x1;
+	return (tegra_gpio_readl(GPIO_IN(offset)) >> GPIO_BIT(offset)) & 0x1;
 }
 
 static int tegra_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -155,7 +157,7 @@ static void tegra_gpio_irq_ack(struct irq_data *d)
 {
 	int gpio = d->irq - INT_GPIO_BASE;
 
-	__raw_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
+	tegra_gpio_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
 }
 
 static void tegra_gpio_irq_mask(struct irq_data *d)
@@ -208,10 +210,10 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	spin_lock_irqsave(&bank->lvl_lock[port], flags);
 
-	val = __raw_readl(GPIO_INT_LVL(gpio));
+	val = tegra_gpio_readl(GPIO_INT_LVL(gpio));
 	val &= ~(GPIO_INT_LVL_MASK << GPIO_BIT(gpio));
 	val |= lvl_type << GPIO_BIT(gpio);
-	__raw_writel(val, GPIO_INT_LVL(gpio));
+	tegra_gpio_writel(val, GPIO_INT_LVL(gpio));
 
 	spin_unlock_irqrestore(&bank->lvl_lock[port], flags);
 
@@ -237,12 +239,12 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	for (port = 0; port < 4; port++) {
 		int gpio = tegra_gpio_compose(bank->bank, port, 0);
-		unsigned long sta = __raw_readl(GPIO_INT_STA(gpio)) &
-			__raw_readl(GPIO_INT_ENB(gpio));
-		u32 lvl = __raw_readl(GPIO_INT_LVL(gpio));
+		unsigned long sta = tegra_gpio_readl(GPIO_INT_STA(gpio)) &
+			tegra_gpio_readl(GPIO_INT_ENB(gpio));
+		u32 lvl = tegra_gpio_readl(GPIO_INT_LVL(gpio));
 
 		for_each_set_bit(pin, &sta, 8) {
-			__raw_writel(1 << pin, GPIO_INT_CLR(gpio));
+			tegra_gpio_writel(1 << pin, GPIO_INT_CLR(gpio));
 
 			/* if gpio is edge triggered, clear condition
 			 * before executing the hander so that we don't
@@ -276,11 +278,11 @@ void tegra_gpio_resume(void)
 
 		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
 			unsigned int gpio = (b<<5) | (p<<3);
-			__raw_writel(bank->cnf[p], GPIO_CNF(gpio));
-			__raw_writel(bank->out[p], GPIO_OUT(gpio));
-			__raw_writel(bank->oe[p], GPIO_OE(gpio));
-			__raw_writel(bank->int_lvl[p], GPIO_INT_LVL(gpio));
-			__raw_writel(bank->int_enb[p], GPIO_INT_ENB(gpio));
+			tegra_gpio_writel(bank->cnf[p], GPIO_CNF(gpio));
+			tegra_gpio_writel(bank->out[p], GPIO_OUT(gpio));
+			tegra_gpio_writel(bank->oe[p], GPIO_OE(gpio));
+			tegra_gpio_writel(bank->int_lvl[p], GPIO_INT_LVL(gpio));
+			tegra_gpio_writel(bank->int_enb[p], GPIO_INT_ENB(gpio));
 		}
 	}
 
@@ -299,11 +301,11 @@ void tegra_gpio_suspend(void)
 
 		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
 			unsigned int gpio = (b<<5) | (p<<3);
-			bank->cnf[p] = __raw_readl(GPIO_CNF(gpio));
-			bank->out[p] = __raw_readl(GPIO_OUT(gpio));
-			bank->oe[p] = __raw_readl(GPIO_OE(gpio));
-			bank->int_enb[p] = __raw_readl(GPIO_INT_ENB(gpio));
-			bank->int_lvl[p] = __raw_readl(GPIO_INT_LVL(gpio));
+			bank->cnf[p] = tegra_gpio_readl(GPIO_CNF(gpio));
+			bank->out[p] = tegra_gpio_readl(GPIO_OUT(gpio));
+			bank->oe[p] = tegra_gpio_readl(GPIO_OE(gpio));
+			bank->int_enb[p] = tegra_gpio_readl(GPIO_INT_ENB(gpio));
+			bank->int_lvl[p] = tegra_gpio_readl(GPIO_INT_LVL(gpio));
 		}
 	}
 	local_irq_restore(flags);
@@ -333,28 +335,55 @@ static struct irq_chip tegra_gpio_irq_chip = {
  */
 static struct lock_class_key gpio_lock_class;
 
-static int __init tegra_gpio_init(void)
+static int __init tegra_gpio_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct tegra_gpio_bank *bank;
 	int gpio;
 	int i;
 	int j;
 
+	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res) {
+			dev_err(&pdev->dev, "Missing IRQ resource\n");
+			return -ENODEV;
+		}
+
+		bank = &tegra_gpio_banks[i];
+		bank->bank = i;
+		bank->irq = res->start;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Missing MEM resource\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res),
+				     dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "Couldn't request MEM resource\n");
+		return -ENODEV;
+	}
+
+	regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!regs) {
+		dev_err(&pdev->dev, "Couldn't ioremap regs\n");
+		return -ENODEV;
+	}
+
 	for (i = 0; i < 7; i++) {
 		for (j = 0; j < 4; j++) {
 			int gpio = tegra_gpio_compose(i, j, 0);
-			__raw_writel(0x00, GPIO_INT_ENB(gpio));
+			tegra_gpio_writel(0x00, GPIO_INT_ENB(gpio));
 		}
 	}
 
 #ifdef CONFIG_OF_GPIO
-	/*
-	 * This isn't ideal, but it gets things hooked up until this
-	 * driver is converted into a platform_device
-	 */
-	tegra_gpio_chip.of_node = of_find_compatible_node(NULL, NULL,
-						"nvidia,tegra20-gpio");
-#endif /* CONFIG_OF_GPIO */
+	tegra_gpio_chip.of_node = pdev->dev.of_node;
+#endif
 
 	gpiochip_add(&tegra_gpio_chip);
 
@@ -384,6 +413,24 @@ static int __init tegra_gpio_init(void)
 	return 0;
 }
 
+static struct of_device_id tegra_gpio_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-gpio", },
+	{ },
+};
+
+static struct platform_driver tegra_gpio_driver = {
+	.driver		= {
+		.name	= "tegra-gpio",
+		.owner	= THIS_MODULE,
+		.of_match_table = tegra_gpio_of_match,
+	},
+	.probe		= tegra_gpio_probe,
+};
+
+static int __init tegra_gpio_init(void)
+{
+	return platform_driver_register(&tegra_gpio_driver);
+}
 postcore_initcall(tegra_gpio_init);
 
 void __init tegra_gpio_config(struct tegra_gpio_table *table, int num)
@@ -416,13 +463,13 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 			seq_printf(s,
 				"%d:%d %02x %02x %02x %02x %02x %02x %06x\n",
 				i, j,
-				__raw_readl(GPIO_CNF(gpio)),
-				__raw_readl(GPIO_OE(gpio)),
-				__raw_readl(GPIO_OUT(gpio)),
-				__raw_readl(GPIO_IN(gpio)),
-				__raw_readl(GPIO_INT_STA(gpio)),
-				__raw_readl(GPIO_INT_ENB(gpio)),
-				__raw_readl(GPIO_INT_LVL(gpio)));
+				tegra_gpio_readl(GPIO_CNF(gpio)),
+				tegra_gpio_readl(GPIO_OE(gpio)),
+				tegra_gpio_readl(GPIO_OUT(gpio)),
+				tegra_gpio_readl(GPIO_IN(gpio)),
+				tegra_gpio_readl(GPIO_INT_STA(gpio)),
+				tegra_gpio_readl(GPIO_INT_ENB(gpio)),
+				tegra_gpio_readl(GPIO_INT_LVL(gpio)));
 		}
 	}
 	return 0;
-- 
1.7.0.4
