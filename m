From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:26 -0700
Subject: [PATCH 5/9] [ARM] tegra: gpio: Add suspend and wake support
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-6-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Includes checkpatch fixes and TEGRA_NR_GPIOS changes from
Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/gpio.c              |  104 +++++++++++++++++++++++++++---
 arch/arm/mach-tegra/include/mach/gpio.h |    4 +-
 2 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index fe78fba..0775265 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -19,6 +19,7 @@
 
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -60,6 +61,13 @@ struct tegra_gpio_bank {
 	int bank;
 	int irq;
 	spinlock_t lvl_lock[4];
+#ifdef CONFIG_PM
+	u32 cnf[4];
+	u32 out[4];
+	u32 oe[4];
+	u32 int_enb[4];
+	u32 int_lvl[4];
+#endif
 };
 
 
@@ -131,7 +139,7 @@ static struct gpio_chip tegra_gpio_chip = {
 	.direction_output	= tegra_gpio_direction_output,
 	.set			= tegra_gpio_set,
 	.base			= 0,
-	.ngpio			= ARCH_NR_GPIOS,
+	.ngpio			= TEGRA_NR_GPIOS,
 };
 
 static void tegra_gpio_irq_ack(unsigned int irq)
@@ -244,6 +252,76 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 }
 
+#ifdef CONFIG_PM
+void tegra_gpio_resume(void)
+{
+	unsigned long flags;
+	int b, p, i;
+
+	local_irq_save(flags);
+
+	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
+		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
+
+		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
+			unsigned int gpio = (b<<5) | (p<<3);
+			__raw_writel(bank->cnf[p], GPIO_CNF(gpio));
+			__raw_writel(bank->out[p], GPIO_OUT(gpio));
+			__raw_writel(bank->oe[p], GPIO_OE(gpio));
+			__raw_writel(bank->int_lvl[p], GPIO_INT_LVL(gpio));
+			__raw_writel(bank->int_enb[p], GPIO_INT_ENB(gpio));
+		}
+	}
+
+	local_irq_restore(flags);
+
+	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
+		struct irq_desc *desc = irq_to_desc(i);
+		if (!desc || (desc->status & IRQ_WAKEUP))
+			continue;
+		enable_irq(i);
+	}
+}
+
+void tegra_gpio_suspend(void)
+{
+	unsigned long flags;
+	int b, p, i;
+
+	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
+		struct irq_desc *desc = irq_to_desc(i);
+		if (!desc)
+			continue;
+		if (desc->status & IRQ_WAKEUP) {
+			int gpio = i - INT_GPIO_BASE;
+			pr_debug("gpio %d.%d is wakeup\n", gpio/8, gpio&7);
+			continue;
+		}
+		disable_irq(i);
+	}
+
+	local_irq_save(flags);
+	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
+		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
+
+		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
+			unsigned int gpio = (b<<5) | (p<<3);
+			bank->cnf[p] = __raw_readl(GPIO_CNF(gpio));
+			bank->out[p] = __raw_readl(GPIO_OUT(gpio));
+			bank->oe[p] = __raw_readl(GPIO_OE(gpio));
+			bank->int_enb[p] = __raw_readl(GPIO_INT_ENB(gpio));
+			bank->int_lvl[p] = __raw_readl(GPIO_INT_LVL(gpio));
+		}
+	}
+	local_irq_restore(flags);
+}
+
+static int tegra_gpio_wake_enable(unsigned int irq, unsigned int enable)
+{
+	struct tegra_gpio_bank *bank = get_irq_chip_data(irq);
+	return set_irq_wake(bank->irq, enable);
+}
+#endif
 
 static struct irq_chip tegra_gpio_irq_chip = {
 	.name		= "GPIO",
@@ -251,6 +329,9 @@ static struct irq_chip tegra_gpio_irq_chip = {
 	.mask		= tegra_gpio_irq_mask,
 	.unmask		= tegra_gpio_irq_unmask,
 	.set_type	= tegra_gpio_irq_set_type,
+#ifdef CONFIG_PM
+	.set_wake	= tegra_gpio_wake_enable,
+#endif
 };
 
 
@@ -274,7 +355,7 @@ static int __init tegra_gpio_init(void)
 
 	gpiochip_add(&tegra_gpio_chip);
 
-	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + ARCH_NR_GPIOS); i++) {
+	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
 		bank = &tegra_gpio_banks[GPIO_BANK(irq_to_gpio(i))];
 
 		lockdep_set_class(&irq_desc[i].lock, &gpio_lock_class);
@@ -312,15 +393,16 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 	for (i = 0; i < 7; i++) {
 		for (j = 0; j < 4; j++) {
 			int gpio = tegra_gpio_compose(i, j, 0);
-			seq_printf(s, "%d:%d %02x %02x %02x %02x %02x %02x %06x\n",
-			       i, j,
-			       __raw_readl(GPIO_CNF(gpio)),
-			       __raw_readl(GPIO_OE(gpio)),
-			       __raw_readl(GPIO_OUT(gpio)),
-			       __raw_readl(GPIO_IN(gpio)),
-			       __raw_readl(GPIO_INT_STA(gpio)),
-			       __raw_readl(GPIO_INT_ENB(gpio)),
-			       __raw_readl(GPIO_INT_LVL(gpio)));
+			seq_printf(s,
+				"%d:%d %02x %02x %02x %02x %02x %02x %06x\n",
+				i, j,
+				__raw_readl(GPIO_CNF(gpio)),
+				__raw_readl(GPIO_OE(gpio)),
+				__raw_readl(GPIO_OUT(gpio)),
+				__raw_readl(GPIO_IN(gpio)),
+				__raw_readl(GPIO_INT_STA(gpio)),
+				__raw_readl(GPIO_INT_ENB(gpio)),
+				__raw_readl(GPIO_INT_LVL(gpio)));
 		}
 	}
 	return 0;
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index 540e822..e31f486 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -22,7 +22,7 @@
 
 #include <mach/irqs.h>
 
-#define ARCH_NR_GPIOS		INT_GPIO_NR
+#define TEGRA_NR_GPIOS		INT_GPIO_NR
 
 #include <asm-generic/gpio.h>
 
@@ -35,7 +35,7 @@
 
 static inline int gpio_to_irq(unsigned int gpio)
 {
-	if (gpio < ARCH_NR_GPIOS)
+	if (gpio < TEGRA_NR_GPIOS)
 		return INT_GPIO_BASE + gpio;
 	return -EINVAL;
 }
-- 
1.7.1
