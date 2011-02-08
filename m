From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:48 +0100
Subject: [PATCH 3/9] plat-nomadik: implement suspend/resume for GPIO
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |   51 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5b5fd1e..46f1af8 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -44,6 +44,7 @@ struct nmk_gpio_chip {
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;
+	u32 backup[10];
 };
 
 static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
@@ -792,14 +793,60 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int nmk_gpio_pm(struct platform_device *dev, bool suspend)
+{
+	struct nmk_gpio_chip *nmk_chip = platform_get_drvdata(dev);
+	int i;
+	static const unsigned int regs[] = {
+		NMK_GPIO_DAT,
+		NMK_GPIO_PDIS,
+		NMK_GPIO_DIR,
+		NMK_GPIO_AFSLA,
+		NMK_GPIO_AFSLB,
+		NMK_GPIO_SLPC,
+		NMK_GPIO_RIMSC,
+		NMK_GPIO_FIMSC,
+		NMK_GPIO_RWIMSC,
+		NMK_GPIO_FWIMSC,
+	};
+
+	BUILD_BUG_ON(ARRAY_SIZE(nmk_chip->backup) != ARRAY_SIZE(regs));
+
+	/* XXX: is this sufficient? what about pull-up/down configuration? */
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		if (suspend)
+			nmk_chip->backup[i] = readl(nmk_chip->addr + regs[i]);
+		else
+			writel(nmk_chip->backup[i], nmk_chip->addr + regs[i]);
+	}
+
+	return 0;
+}
+
+static int nmk_gpio_suspend(struct platform_device *dev, pm_message_t state)
+{
+	return nmk_gpio_pm(dev, true);
+}
+
+static int nmk_gpio_resume(struct platform_device *dev)
+{
+	return nmk_gpio_pm(dev, false);
+}
+#else
+#define nmk_gpio_suspend	NULL
+#define nmk_gpio_resume		NULL
+#endif
+
 static struct platform_driver nmk_gpio_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "gpio",
 		},
 	.probe = nmk_gpio_probe,
-	.suspend = NULL, /* to be done */
-	.resume = NULL,
+	.suspend = nmk_gpio_suspend,
+	.resume = nmk_gpio_resume,
 };
 
 static int __init nmk_gpio_init(void)
-- 
1.7.3.2
