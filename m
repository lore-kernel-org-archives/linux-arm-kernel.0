From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:07:42 +0100
Subject: [PATCH] pinctrl: nomadik: fix warnings from unexported functions
Message-ID: <1465402062-26122-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are five functions in the driver that are defined but
only used locally. Since these are not used in the current
kernel, delete them to avoid the following warnings:

drivers/pinctrl/nomadik/pinctrl-nomadik.c:1036:6: warning: symbol 'nmk_gpio_clocks_enable' was not declared. Should it be static?
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1050:6: warning: symbol 'nmk_gpio_clocks_disable' was not declared. Should it be static?
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1073:6: warning: symbol 'nmk_gpio_wakeups_suspend' was not declared. Should it be static?
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1094:6: warning: symbol 'nmk_gpio_wakeups_resume' was not declared. Should it be static?
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1120:6: warning: symbol 'nmk_gpio_read_pull' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-gpio at vger.kernel.org
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 96 -------------------------------
 1 file changed, 96 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 38facef..35f6218 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1033,102 +1033,6 @@ static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
 #define nmk_gpio_dbg_show	NULL
 #endif
 
-void nmk_gpio_clocks_enable(void)
-{
-	int i;
-
-	for (i = 0; i < NUM_BANKS; i++) {
-		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
-
-		if (!chip)
-			continue;
-
-		clk_enable(chip->clk);
-	}
-}
-
-void nmk_gpio_clocks_disable(void)
-{
-	int i;
-
-	for (i = 0; i < NUM_BANKS; i++) {
-		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
-
-		if (!chip)
-			continue;
-
-		clk_disable(chip->clk);
-	}
-}
-
-/*
- * Called from the suspend/resume path to only keep the real wakeup interrupts
- * (those that have had set_irq_wake() called on them) as wakeup interrupts,
- * and not the rest of the interrupts which we needed to have as wakeups for
- * cpuidle.
- *
- * PM ops are not used since this needs to be done at the end, after all the
- * other drivers are done with their suspend callbacks.
- */
-void nmk_gpio_wakeups_suspend(void)
-{
-	int i;
-
-	for (i = 0; i < NUM_BANKS; i++) {
-		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
-
-		if (!chip)
-			break;
-
-		clk_enable(chip->clk);
-
-		writel(chip->rwimsc & chip->real_wake,
-		       chip->addr + NMK_GPIO_RWIMSC);
-		writel(chip->fwimsc & chip->real_wake,
-		       chip->addr + NMK_GPIO_FWIMSC);
-
-		clk_disable(chip->clk);
-	}
-}
-
-void nmk_gpio_wakeups_resume(void)
-{
-	int i;
-
-	for (i = 0; i < NUM_BANKS; i++) {
-		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
-
-		if (!chip)
-			break;
-
-		clk_enable(chip->clk);
-
-		writel(chip->rwimsc, chip->addr + NMK_GPIO_RWIMSC);
-		writel(chip->fwimsc, chip->addr + NMK_GPIO_FWIMSC);
-
-		clk_disable(chip->clk);
-	}
-}
-
-/*
- * Read the pull up/pull down status.
- * A bit set in 'pull_up' means that pull up
- * is selected if pull is enabled in PDIS register.
- * Note: only pull up/down set via this driver can
- * be detected due to HW limitations.
- */
-void nmk_gpio_read_pull(int gpio_bank, u32 *pull_up)
-{
-	if (gpio_bank < NUM_BANKS) {
-		struct nmk_gpio_chip *chip = nmk_gpio_chips[gpio_bank];
-
-		if (!chip)
-			return;
-
-		*pull_up = chip->pull_up;
-	}
-}
-
 /*
  * We will allocate memory for the state container using devm* allocators
  * binding to the first device reaching this point, it doesn't matter if
-- 
2.8.1
