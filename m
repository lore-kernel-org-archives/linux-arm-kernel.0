From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:50 +0100
Subject: [PATCH 5/9] plat-nomadik: pull-up/down settings for GPIO resume
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-6-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Suspend/resume didn't take care of pull-up and pull-down
settings and writing back the DAT register at resume can
change pull up/down settings, depending on pin input value.
Output values are now also restored.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/Kconfig |    6 +++
 arch/arm/plat-nomadik/gpio.c  |   78 ++++++++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 187f4e8..ad25c96 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -25,4 +25,10 @@ config NOMADIK_GPIO
 	help
 	  Support for the Nomadik GPIO controller.
 
+config NOMADIK_GPIO_PM
+	bool
+	depends on NOMADIK_GPIO && PM
+	help
+	  Support PM for the Nomadik GPIO controller.
+
 endif
diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 971e5d3..71682a8 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -30,11 +30,23 @@
 /*
  * The GPIO module in the Nomadik family of Systems-on-Chip is an
  * AMBA device, managing 32 pins and alternate functions.  The logic block
- * is currently only used in the Nomadik.
+ * is currently used in the Nomadik and ux500.
  *
  * Symbols in this file are called "nmk_gpio" for "nomadik gpio"
  */
 
+static const u32 backup_regs[] = {
+	NMK_GPIO_PDIS,
+	NMK_GPIO_DIR,
+	NMK_GPIO_AFSLA,
+	NMK_GPIO_AFSLB,
+	NMK_GPIO_SLPC,
+	NMK_GPIO_RIMSC,
+	NMK_GPIO_FIMSC,
+	NMK_GPIO_RWIMSC,
+	NMK_GPIO_FWIMSC,
+};
+
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
@@ -47,7 +59,9 @@ struct nmk_gpio_chip {
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;
-	u32 backup[10];
+	u32 backup[ARRAY_SIZE(backup_regs)];
+	/* Bitmap, 1 = pull up, 0 = pull down */
+	u32 pull;
 };
 
 static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
@@ -93,10 +107,13 @@ static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 		pdis &= ~bit;
 	writel(pdis, nmk_chip->addr + NMK_GPIO_PDIS);
 
-	if (pull == NMK_GPIO_PULL_UP)
+	if (pull == NMK_GPIO_PULL_UP) {
+		nmk_chip->pull |= bit;
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATS);
-	else if (pull == NMK_GPIO_PULL_DOWN)
+	} else if (pull == NMK_GPIO_PULL_DOWN) {
+		nmk_chip->pull &= ~bit;
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
+	}
 }
 
 static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
@@ -317,6 +334,15 @@ int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull)
 }
 
 /* Mode functions */
+/**
+ * nmk_gpio_set_mode() - set the mux mode of a gpio pin
+ * @gpio: pin number
+ * @gpio_mode: one of NMK_GPIO_ALT_GPIO, NMK_GPIO_ALT_A,
+ *	       NMK_GPIO_ALT_B, and NMK_GPIO_ALT_C
+ *
+ * Sets the mode of the specified pin to one of the alternate functions or
+ * plain GPIO.
+ */
 int nmk_gpio_set_mode(int gpio, int gpio_mode)
 {
 	struct nmk_gpio_chip *nmk_chip;
@@ -832,35 +858,39 @@ out:
 	return ret;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_NOMADIK_GPIO_PM
 static int nmk_gpio_pm(struct platform_device *dev, bool suspend)
 {
 	struct nmk_gpio_chip *nmk_chip = platform_get_drvdata(dev);
 	int i;
-	static const unsigned int regs[] = {
-		NMK_GPIO_DAT,
-		NMK_GPIO_PDIS,
-		NMK_GPIO_DIR,
-		NMK_GPIO_AFSLA,
-		NMK_GPIO_AFSLB,
-		NMK_GPIO_SLPC,
-		NMK_GPIO_RIMSC,
-		NMK_GPIO_FIMSC,
-		NMK_GPIO_RWIMSC,
-		NMK_GPIO_FWIMSC,
-	};
+	u32 dir;
+	u32 dat;
 
-	BUILD_BUG_ON(ARRAY_SIZE(nmk_chip->backup) != ARRAY_SIZE(regs));
-
-	/* XXX: is this sufficient? what about pull-up/down configuration? */
-
-	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+	for (i = 0; i < ARRAY_SIZE(backup_regs); i++) {
 		if (suspend)
-			nmk_chip->backup[i] = readl(nmk_chip->addr + regs[i]);
+			nmk_chip->backup[i] = readl(nmk_chip->addr +
+						    backup_regs[i]);
 		else
-			writel(nmk_chip->backup[i], nmk_chip->addr + regs[i]);
+			writel(nmk_chip->backup[i],
+			       nmk_chip->addr + backup_regs[i]);
 	}
 
+	if (!suspend) {
+		/*
+		 * Restore pull-up and pull-down on inputs and
+		 * outputs.
+		 */
+		dir = readl(nmk_chip->addr + NMK_GPIO_DIR);
+		dat = readl(nmk_chip->addr + NMK_GPIO_DAT);
+
+		writel((nmk_chip->pull & ~dir) |
+		       (dat & dir),
+		       nmk_chip->addr + NMK_GPIO_DATS);
+
+		writel((~nmk_chip->pull & ~dir) |
+		       (~dat & dir),
+		       nmk_chip->addr + NMK_GPIO_DATC);
+	}
 	return 0;
 }
 
-- 
1.7.3.2
