From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:09:03 -0800
Subject: [PATCH 16/21] ARM: tegra: gpio: Add support for waking from suspend
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-17-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@google.com>

Signed-off-by: Colin Cross <ccross@google.com>
---
 arch/arm/mach-tegra/gpio.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index 1bf92e5..0187aaa 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -212,6 +212,9 @@ static int tegra_gpio_irq_set_type(unsigned int irq, unsigned int type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__set_irq_handler_unlocked(irq, handle_edge_irq);
 
+	if (tegra_get_suspend_mode() == TEGRA_SUSPEND_LP0)
+		tegra_set_lp0_wake_type(irq, type);
+
 	return 0;
 }
 
@@ -319,8 +322,17 @@ void tegra_gpio_suspend(void)
 
 static int tegra_gpio_wake_enable(unsigned int irq, unsigned int enable)
 {
+	int ret;
 	struct tegra_gpio_bank *bank = get_irq_chip_data(irq);
-	return set_irq_wake(bank->irq, enable);
+
+	ret = tegra_set_lp1_wake(bank->irq, enable);
+	if (ret)
+		return ret;
+
+	if (tegra_get_suspend_mode() == TEGRA_SUSPEND_LP0)
+		return tegra_set_lp0_wake(irq, enable);
+
+	return 0;
 }
 #endif
 
-- 
1.7.3.1
