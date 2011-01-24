From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:22 -0800
Subject: [PATCH v2 17/28] ARM: tegra: gpio: Add support for waking from suspend
In-Reply-To: <1295834493-5019-1-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
Message-ID: <1295834493-5019-18-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/gpio.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index 132dcd6..5d14ccc 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -212,6 +212,9 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__set_irq_handler_unlocked(d->irq, handle_edge_irq);
 
+	if (tegra_get_suspend_mode() == TEGRA_SUSPEND_LP0)
+		tegra_set_lp0_wake_type(d->irq, type);
+
 	return 0;
 }
 
@@ -319,8 +322,17 @@ void tegra_gpio_suspend(void)
 
 static int tegra_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
+	int ret;
 	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	return set_irq_wake(bank->irq, enable);
+
+	ret = tegra_set_lp1_wake(bank->irq, enable);
+	if (ret)
+		return ret;
+
+	if (tegra_get_suspend_mode() == TEGRA_SUSPEND_LP0)
+		return tegra_set_lp0_wake(d->irq, enable);
+
+	return 0;
 }
 #endif
 
-- 
1.7.3.1
