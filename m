From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:53:02 +0200
Subject: [RFT v2 10/10] pinctrl: samsung: Remove legacy API for handling
 external wakeup interrupts mask
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Message-ID: <20180723175302.22535-11-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the legacy, ugly API of exposing the static value of external
wakeup interrupts mask, because all arch-machine users where converted
to use generic implementation from pinctrl driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 40ef14956876..eec174a65c6f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -325,13 +325,6 @@ int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 	return ret;
 }
 
-static u32 exynos_eint_wake_mask = 0xffffffff;
-
-u32 exynos_get_eint_wake_mask(void)
-{
-	return exynos_eint_wake_mask;
-}
-
 static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -342,10 +335,9 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 	pr_info("wake %s for irq %d\n", on ? "enabled" : "disabled", irqd->irq);
 
 	if (!on)
-		exynos_eint_wake_mask |= bit;
+		our_chip->eint_wake_mask_value |= bit;
 	else
-		exynos_eint_wake_mask &= ~bit;
-	our_chip->eint_wake_mask_value = exynos_eint_wake_mask;
+		our_chip->eint_wake_mask_value &= ~bit;
 
 	return 0;
 }
-- 
2.14.1
