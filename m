From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 14:43:21 -0600
Subject: [PATCH v2 1/4] gpio/tegra: Remove use of irq_to_gpio
Message-ID: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_to_gpio is being removed. Replace the only use of that API by
the ARM Tegra sub-architecture.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This series is the irq_to_gpio patches I posted last week, rebased to ToT,
plus removing Tegra's custom gpio_to_irq.

This series was tested against next-20110811 on Harmony, by playing audio
and plugging/unplugging headphones. Headphone detection relies on using a
GPIO as an IRQ, and hence on gpio_to_irq.

 drivers/gpio/gpio-tegra.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 747eb40..ecade29 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -331,6 +331,7 @@ static struct lock_class_key gpio_lock_class;
 static int __init tegra_gpio_init(void)
 {
 	struct tegra_gpio_bank *bank;
+	int gpio;
 	int i;
 	int j;
 
@@ -352,14 +353,17 @@ static int __init tegra_gpio_init(void)
 
 	gpiochip_add(&tegra_gpio_chip);
 
-	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
-		bank = &tegra_gpio_banks[GPIO_BANK(irq_to_gpio(i))];
+	for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {
+		int irq = TEGRA_GPIO_TO_IRQ(gpio);
+		/* No validity check; all Tegra GPIOs are valid IRQs */
 
-		irq_set_lockdep_class(i, &gpio_lock_class);
-		irq_set_chip_data(i, bank);
-		irq_set_chip_and_handler(i, &tegra_gpio_irq_chip,
+		bank = &tegra_gpio_banks[GPIO_BANK(gpio)];
+
+		irq_set_lockdep_class(irq, &gpio_lock_class);
+		irq_set_chip_data(irq, bank);
+		irq_set_chip_and_handler(irq, &tegra_gpio_irq_chip,
 					 handle_simple_irq);
-		set_irq_flags(i, IRQF_VALID);
+		set_irq_flags(irq, IRQF_VALID);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
-- 
1.7.0.4
