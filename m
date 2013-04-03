From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:44 +0800
Subject: [PATCH V6 1/9] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the gpio wakeup source handling for the Tegra platform. It
was be done by enabling the irq for the gpio in the gpio controller and
enabling the bank irq of the gpio in the Tegra legacy irq controller when
the system going to suspend.

Based on the work by:
Varun Wadekar <vwadekar@nvidia.com>

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
V6:
* no change
V5:
* no change
V4:
* no change
V3:
* no change
V2:
* no change
---
 drivers/gpio/gpio-tegra.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index a78a81f..2f1b265 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -72,6 +72,7 @@ struct tegra_gpio_bank {
 	u32 oe[4];
 	u32 int_enb[4];
 	u32 int_lvl[4];
+	u32 wake_enb[4];
 #endif
 };
 
@@ -333,15 +334,31 @@ static int tegra_gpio_suspend(struct device *dev)
 			bank->oe[p] = tegra_gpio_readl(GPIO_OE(gpio));
 			bank->int_enb[p] = tegra_gpio_readl(GPIO_INT_ENB(gpio));
 			bank->int_lvl[p] = tegra_gpio_readl(GPIO_INT_LVL(gpio));
+
+			/* Enable gpio irq for wake up source */
+			tegra_gpio_writel(bank->wake_enb[p],
+					  GPIO_INT_ENB(gpio));
 		}
 	}
 	local_irq_restore(flags);
 	return 0;
 }
 
-static int tegra_gpio_wake_enable(struct irq_data *d, unsigned int enable)
+static int tegra_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
 {
 	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int gpio = d->hwirq;
+	u32 port, bit, mask;
+
+	port = GPIO_PORT(gpio);
+	bit = GPIO_BIT(gpio);
+	mask = BIT(bit);
+
+	if (enable)
+		bank->wake_enb[port] |= mask;
+	else
+		bank->wake_enb[port] &= ~mask;
+
 	return irq_set_irq_wake(bank->irq, enable);
 }
 #endif
@@ -353,7 +370,7 @@ static struct irq_chip tegra_gpio_irq_chip = {
 	.irq_unmask	= tegra_gpio_irq_unmask,
 	.irq_set_type	= tegra_gpio_irq_set_type,
 #ifdef CONFIG_PM_SLEEP
-	.irq_set_wake	= tegra_gpio_wake_enable,
+	.irq_set_wake	= tegra_gpio_irq_set_wake,
 #endif
 };
 
-- 
1.8.2
