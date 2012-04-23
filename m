From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 23 Apr 2012 11:14:19 +0200
Subject: [PATCH 2/9] gpio/nomadik: cache [rf]w?imsc
Message-ID: <1335172459-27542-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Cache two more registers in the GPIO controller.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Reviewed-by: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-nomadik.c |   42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index f1ebd05..45a0e0a 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -58,6 +58,8 @@ struct nmk_gpio_chip {
 	u32 real_wake;
 	u32 rwimsc;
 	u32 fwimsc;
+	u32 rimsc;
+	u32 fimsc;
 	u32 pull_up;
 };
 
@@ -149,8 +151,8 @@ static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
 				     unsigned offset, int gpio_mode,
 				     bool glitch)
 {
-	u32 rwimsc = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
-	u32 fwimsc = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
+	u32 rwimsc = nmk_chip->rwimsc;
+	u32 fwimsc = nmk_chip->fwimsc;
 
 	if (glitch && nmk_chip->set_ioforce) {
 		u32 bit = BIT(offset);
@@ -555,27 +557,38 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 				  int gpio, enum nmk_gpio_irq_type which,
 				  bool enable)
 {
-	u32 rimsc = which == WAKE ? NMK_GPIO_RWIMSC : NMK_GPIO_RIMSC;
-	u32 fimsc = which == WAKE ? NMK_GPIO_FWIMSC : NMK_GPIO_FIMSC;
 	u32 bitmask = nmk_gpio_get_bitmask(gpio);
-	u32 reg;
+	u32 *rimscval;
+	u32 *fimscval;
+	u32 rimscreg;
+	u32 fimscreg;
+
+	if (which == NORMAL) {
+		rimscreg = NMK_GPIO_RIMSC;
+		fimscreg = NMK_GPIO_FIMSC;
+		rimscval = &nmk_chip->rimsc;
+		fimscval = &nmk_chip->fimsc;
+	} else  {
+		rimscreg = NMK_GPIO_RWIMSC;
+		fimscreg = NMK_GPIO_FWIMSC;
+		rimscval = &nmk_chip->rwimsc;
+		fimscval = &nmk_chip->fwimsc;
+	}
 
 	/* we must individually set/clear the two edges */
 	if (nmk_chip->edge_rising & bitmask) {
-		reg = readl(nmk_chip->addr + rimsc);
 		if (enable)
-			reg |= bitmask;
+			*rimscval |= bitmask;
 		else
-			reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + rimsc);
+			*rimscval &= ~bitmask;
+		writel(*rimscval, nmk_chip->addr + rimscreg);
 	}
 	if (nmk_chip->edge_falling & bitmask) {
-		reg = readl(nmk_chip->addr + fimsc);
 		if (enable)
-			reg |= bitmask;
+			*fimscval |= bitmask;
 		else
-			reg &= ~bitmask;
-		writel(reg, nmk_chip->addr + fimsc);
+			*fimscval &= ~bitmask;
+		writel(*fimscval, nmk_chip->addr + fimscreg);
 	}
 }
 
@@ -1011,9 +1024,6 @@ void nmk_gpio_wakeups_suspend(void)
 
 		clk_enable(chip->clk);
 
-		chip->rwimsc = readl(chip->addr + NMK_GPIO_RWIMSC);
-		chip->fwimsc = readl(chip->addr + NMK_GPIO_FWIMSC);
-
 		writel(chip->rwimsc & chip->real_wake,
 		       chip->addr + NMK_GPIO_RWIMSC);
 		writel(chip->fwimsc & chip->real_wake,
-- 
1.7.9.2
