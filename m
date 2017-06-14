From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 14 Jun 2017 15:18:28 +0200
Subject: [RFT 2/2] pinctrl: samsung: Fix invalid register offset used for
 Exynos5433 external interrupts
In-Reply-To: <20170614131828.28683-1-krzk@kernel.org>
References: <20170614131828.28683-1-krzk@kernel.org>
Message-ID: <20170614131828.28683-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When setting the pin function for external interrupts, the driver used
wrong IO memory address base.  The pin function register is always under
pctl_base, not the eint_base.

By updating wrong register, the external interrupts for chosen GPIO
would not work at all and some other GPIO might be configured to wrong
value.

Platforms other than Exynos5433 should not be affected as eint_base
equals pctl_base in such case.

Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
Cc: <stable@vger.kernel.org>
Reported-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Tested on Odroid XU3 (so actually this particular case was not
reproduced).
Please kindly test on Exynos5433.
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 96068b40d32a..d95a746f45d7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -174,10 +174,10 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(bank->eint_base + reg_con);
+	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
 	con |= EXYNOS_EINT_FUNC << shift;
-	writel(con, bank->eint_base + reg_con);
+	writel(con, bank->pctl_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -206,10 +206,10 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	con = readl(bank->eint_base + reg_con);
+	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
 	con |= FUNC_INPUT << shift;
-	writel(con, bank->eint_base + reg_con);
+	writel(con, bank->pctl_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
-- 
2.9.3
