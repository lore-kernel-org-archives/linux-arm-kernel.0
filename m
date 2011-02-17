From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 17 Feb 2011 09:54:39 +0100
Subject: [PATCH 1/2] plat-nomadik: get rid of unused GPIO PM code
Message-ID: <1297932879-5368-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

The NOMADIK_GPIO_PM config option is disabled by default, not user visible,
and never selected by any other option: the code is therefore unused. The
GPIO registers need not be saved and restored since their values are
preserved when vAPE (on DB8500) is powered down.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/Kconfig |    6 ---
 arch/arm/plat-nomadik/gpio.c  |   76 ++---------------------------------------
 2 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index ad25c96..187f4e8 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -25,10 +25,4 @@ config NOMADIK_GPIO
 	help
 	  Support for the Nomadik GPIO controller.
 
-config NOMADIK_GPIO_PM
-	bool
-	depends on NOMADIK_GPIO && PM
-	help
-	  Support PM for the Nomadik GPIO controller.
-
 endif
diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index acc9de2..5e6653f 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -35,18 +35,6 @@
  * Symbols in this file are called "nmk_gpio" for "nomadik gpio"
  */
 
-static const u32 backup_regs[] = {
-	NMK_GPIO_PDIS,
-	NMK_GPIO_DIR,
-	NMK_GPIO_AFSLA,
-	NMK_GPIO_AFSLB,
-	NMK_GPIO_SLPC,
-	NMK_GPIO_RIMSC,
-	NMK_GPIO_FIMSC,
-	NMK_GPIO_RWIMSC,
-	NMK_GPIO_FWIMSC,
-};
-
 #define NMK_GPIO_PER_CHIP	32
 
 struct nmk_gpio_chip {
@@ -62,9 +50,6 @@ struct nmk_gpio_chip {
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;
-	u32 backup[ARRAY_SIZE(backup_regs)];
-	/* Bitmap, 1 = pull up, 0 = pull down */
-	u32 pull;
 };
 
 static struct nmk_gpio_chip *
@@ -117,13 +102,10 @@ static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 		pdis &= ~bit;
 	writel(pdis, nmk_chip->addr + NMK_GPIO_PDIS);
 
-	if (pull == NMK_GPIO_PULL_UP) {
-		nmk_chip->pull |= bit;
+	if (pull == NMK_GPIO_PULL_UP)
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATS);
-	} else if (pull == NMK_GPIO_PULL_DOWN) {
-		nmk_chip->pull &= ~bit;
+	else if (pull == NMK_GPIO_PULL_DOWN)
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
-	}
 }
 
 static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
@@ -991,64 +973,12 @@ out:
 	return ret;
 }
 
-#ifdef CONFIG_NOMADIK_GPIO_PM
-static int nmk_gpio_pm(struct platform_device *dev, bool suspend)
-{
-	struct nmk_gpio_chip *nmk_chip = platform_get_drvdata(dev);
-	int i;
-	u32 dir;
-	u32 dat;
-
-	for (i = 0; i < ARRAY_SIZE(backup_regs); i++) {
-		if (suspend)
-			nmk_chip->backup[i] = readl(nmk_chip->addr +
-						    backup_regs[i]);
-		else
-			writel(nmk_chip->backup[i],
-			       nmk_chip->addr + backup_regs[i]);
-	}
-
-	if (!suspend) {
-		/*
-		 * Restore pull-up and pull-down on inputs and
-		 * outputs.
-		 */
-		dir = readl(nmk_chip->addr + NMK_GPIO_DIR);
-		dat = readl(nmk_chip->addr + NMK_GPIO_DAT);
-
-		writel((nmk_chip->pull & ~dir) |
-		       (dat & dir),
-		       nmk_chip->addr + NMK_GPIO_DATS);
-
-		writel((~nmk_chip->pull & ~dir) |
-		       (~dat & dir),
-		       nmk_chip->addr + NMK_GPIO_DATC);
-	}
-	return 0;
-}
-
-static int nmk_gpio_suspend(struct platform_device *dev, pm_message_t state)
-{
-	return nmk_gpio_pm(dev, true);
-}
-
-static int nmk_gpio_resume(struct platform_device *dev)
-{
-	return nmk_gpio_pm(dev, false);
-}
-#else
-#define nmk_gpio_suspend	NULL
-#define nmk_gpio_resume		NULL
-#endif
-
 static struct platform_driver nmk_gpio_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "gpio",
-		},
+	},
 	.probe = nmk_gpio_probe,
-	.suspend = nmk_gpio_suspend,
-	.resume = nmk_gpio_resume,
 };
 
 static int __init nmk_gpio_init(void)
-- 
1.7.3.2
