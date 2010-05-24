From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:15 +0530
Subject: [PATCH 3/7] nomadik-gpio: refactor nmk_gpio_set_mode
In-Reply-To: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
References: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1274707639-28285-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract out a portion of nmk_gpio_set_mode() that can be called with the
lock already held.  This will be used from the pincfg API.

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 9f1aba8..286ab42 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -46,6 +46,22 @@ struct nmk_gpio_chip {
 	u32 edge_falling;
 };
 
+static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
+				unsigned offset, int gpio_mode)
+{
+	u32 bit = 1 << offset;
+	u32 afunc, bfunc;
+
+	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & ~bit;
+	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & ~bit;
+	if (gpio_mode & NMK_GPIO_ALT_A)
+		afunc |= bit;
+	if (gpio_mode & NMK_GPIO_ALT_B)
+		bfunc |= bit;
+	writel(afunc, nmk_chip->addr + NMK_GPIO_AFSLA);
+	writel(bfunc, nmk_chip->addr + NMK_GPIO_AFSLB);
+}
+
 static void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, enum nmk_gpio_slpm mode)
 {
@@ -139,23 +155,13 @@ int nmk_gpio_set_mode(int gpio, int gpio_mode)
 {
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
-	u32 afunc, bfunc, bit;
 
 	nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
 	if (!nmk_chip)
 		return -EINVAL;
 
-	bit = 1 << (gpio - nmk_chip->chip.base);
-
 	spin_lock_irqsave(&nmk_chip->lock, flags);
-	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & ~bit;
-	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & ~bit;
-	if (gpio_mode & NMK_GPIO_ALT_A)
-		afunc |= bit;
-	if (gpio_mode & NMK_GPIO_ALT_B)
-		bfunc |= bit;
-	writel(afunc, nmk_chip->addr + NMK_GPIO_AFSLA);
-	writel(bfunc, nmk_chip->addr + NMK_GPIO_AFSLB);
+	__nmk_gpio_set_mode(nmk_chip, gpio - nmk_chip->chip.base, gpio_mode);
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
 
 	return 0;
-- 
1.7.0
