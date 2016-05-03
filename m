From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  3 May 2016 17:26:53 +0200
Subject: [PATCH 1/2] pinctrl: nomadik: hide nmk_gpio_get_mode when unused
Message-ID: <1462289221-861102-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nmk_gpio_get_mode is only used in one place, and that is conditionally
compiled if DEBUG_FS is enabled. A recent cleanup has marked the
definition 'static', which now leads to a warning:

drivers/pinctrl/nomadik/pinctrl-nomadik.c:614:12: error: 'nmk_gpio_get_mode' defined but not used [-Werror=unused-function]
 static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
            ^~~~~~~~~~~~~~~~~

Moving the function itself inside the #ifdef shuts it up again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5e81e0a0913c ("pinctrl: nomadik: use BIT() with offsets consequently")
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index e5c71acd9506..ccbfc325c778 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -611,20 +611,6 @@ static int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev,
 	return NMK_GPIO_ALT_C;
 }
 
-static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
-{
-	u32 afunc, bfunc;
-
-	clk_enable(nmk_chip->clk);
-
-	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
-	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & BIT(offset);
-
-	clk_disable(nmk_chip->clk);
-
-	return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0);
-}
-
 /* IRQ functions */
 
 static void nmk_gpio_irq_ack(struct irq_data *d)
@@ -929,6 +915,19 @@ static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
 }
 
 #ifdef CONFIG_DEBUG_FS
+static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
+{
+	u32 afunc, bfunc;
+
+	clk_enable(nmk_chip->clk);
+
+	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
+	bfunc = readl(nmk_chip->addr + NMK_GPIO_AFSLB) & BIT(offset);
+
+	clk_disable(nmk_chip->clk);
+
+	return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0);
+}
 
 #include <linux/seq_file.h>
 
-- 
2.7.0
