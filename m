From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 20 Sep 2011 10:50:15 +0200
Subject: [PATCH 2/2] gpio/nomadik: use genirq core to track enablement
Message-ID: <1316508615-20351-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Currently the Nomadik GPIO driver tracks enabled/disabled interrupt
status with a local variable, switch to using the interrupt core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-nomadik.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 97e9be9..0b7ec12 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -58,7 +58,6 @@ struct nmk_gpio_chip {
 	u32 rwimsc;
 	u32 fwimsc;
 	u32 slpm;
-	u32 enabled;
 	u32 pull_up;
 };
 
@@ -605,11 +604,6 @@ static int nmk_gpio_irq_maskunmask(struct irq_data *d, bool enable)
 	if (!nmk_chip)
 		return -EINVAL;
 
-	if (enable)
-		nmk_chip->enabled |= bitmask;
-	else
-		nmk_chip->enabled &= ~bitmask;
-
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
@@ -653,7 +647,7 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
 
-	if (!(nmk_chip->enabled & bitmask))
+	if (irqd_irq_disabled(d))
 		__nmk_gpio_set_wake(nmk_chip, gpio, on);
 
 	if (on)
@@ -670,7 +664,7 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	bool enabled;
+	bool enabled = !irqd_irq_disabled(d);
 	bool wake = irqd_is_wakeup_set(d);
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
@@ -691,7 +685,6 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 
-	enabled = !!(nmk_chip->enabled & bitmask);
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, gpio, NORMAL, false);
 
-- 
1.7.3.2
