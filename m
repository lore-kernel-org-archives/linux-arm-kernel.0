From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:13 +0530
Subject: [PATCH 1/7] nomadik-gpio: add function to configure pullup/pulldown
Message-ID: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c              |   48 +++++++++++++++++++++++++++++
 arch/arm/plat-nomadik/include/plat/gpio.h |    8 +++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5a6ef25..2045998 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -46,6 +46,54 @@ struct nmk_gpio_chip {
 	u32 edge_falling;
 };
 
+static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
+				unsigned offset, enum nmk_gpio_pull pull)
+{
+	u32 bit = 1 << offset;
+	u32 pdis;
+
+	pdis = readl(nmk_chip->addr + NMK_GPIO_PDIS);
+	if (pull == NMK_GPIO_PULL_NONE)
+		pdis |= bit;
+	else
+		pdis &= ~bit;
+	writel(pdis, nmk_chip->addr + NMK_GPIO_PDIS);
+
+	if (pull == NMK_GPIO_PULL_UP)
+		writel(bit, nmk_chip->addr + NMK_GPIO_DATS);
+	else if (pull == NMK_GPIO_PULL_DOWN)
+		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
+}
+
+/**
+ * nmk_gpio_set_pull() - enable/disable pull up/down on a gpio
+ * @gpio: pin number
+ * @pull: one of NMK_GPIO_PULL_DOWN, NMK_GPIO_PULL_UP, and NMK_GPIO_PULL_NONE
+ *
+ * Enables/disables pull up/down on a specified pin.  This only takes effect if
+ * the pin is configured as an input (either explicitly or by the alternate
+ * function).
+ *
+ * NOTE: If enabling the pull up/down, the caller must ensure that the GPIO is
+ * configured as an input.  Otherwise, due to the way the controller registers
+ * work, this function will change the value output on the pin.
+ */
+int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull)
+{
+	struct nmk_gpio_chip *nmk_chip;
+	unsigned long flags;
+
+	nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	if (!nmk_chip)
+		return -EINVAL;
+
+	spin_lock_irqsave(&nmk_chip->lock, flags);
+	__nmk_gpio_set_pull(nmk_chip, gpio - nmk_chip->chip.base, pull);
+	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	return 0;
+}
+
 /* Mode functions */
 int nmk_gpio_set_mode(int gpio, int gpio_mode)
 {
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 4200811..1d97e96 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -55,6 +55,14 @@
 #define NMK_GPIO_ALT_B	2
 #define NMK_GPIO_ALT_C	(NMK_GPIO_ALT_A | NMK_GPIO_ALT_B)
 
+/* Pull up/down values */
+enum nmk_gpio_pull {
+	NMK_GPIO_PULL_NONE,
+	NMK_GPIO_PULL_UP,
+	NMK_GPIO_PULL_DOWN,
+};
+
+extern int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull);
 extern int nmk_gpio_set_mode(int gpio, int gpio_mode);
 extern int nmk_gpio_get_mode(int gpio);
 
-- 
1.7.0
