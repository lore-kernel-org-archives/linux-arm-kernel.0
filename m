From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:14 +0530
Subject: [PATCH 2/7] nomadik-gpio: add function to configure sleep mode
	behaviour
In-Reply-To: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
References: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1274707639-28285-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c              |   40 +++++++++++++++++++++++++++++
 arch/arm/plat-nomadik/include/plat/gpio.h |    7 +++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 2045998..9f1aba8 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -46,6 +46,20 @@ struct nmk_gpio_chip {
 	u32 edge_falling;
 };
 
+static void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip,
+				unsigned offset, enum nmk_gpio_slpm mode)
+{
+	u32 bit = 1 << offset;
+	u32 slpm;
+
+	slpm = readl(nmk_chip->addr + NMK_GPIO_SLPC);
+	if (mode == NMK_GPIO_SLPM_NOCHANGE)
+		slpm |= bit;
+	else
+		slpm &= ~bit;
+	writel(slpm, nmk_chip->addr + NMK_GPIO_SLPC);
+}
+
 static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 				unsigned offset, enum nmk_gpio_pull pull)
 {
@@ -66,6 +80,32 @@ static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 }
 
 /**
+ * nmk_gpio_set_slpm() - configure the sleep mode of a pin
+ * @gpio: pin number
+ * @mode: NMK_GPIO_SLPM_INPUT or NMK_GPIO_SLPM_NOCHANGE,
+ *
+ * Sets the sleep mode of a pin.  If @mode is NMK_GPIO_SLPM_INPUT, the pin is
+ * changed to an input (with pullup/down enabled) in sleep and deep sleep.  If
+ * @mode is NMK_GPIO_SLPM_NOCHANGE, the pin remains in the state it was it
+ * configured even when in sleep and deep sleep.
+ */
+int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode)
+{
+	struct nmk_gpio_chip *nmk_chip;
+	unsigned long flags;
+
+	nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	if (!nmk_chip)
+		return -EINVAL;
+
+	spin_lock_irqsave(&nmk_chip->lock, flags);
+	__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base, mode);
+	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	return 0;
+}
+
+/**
  * nmk_gpio_set_pull() - enable/disable pull up/down on a gpio
  * @gpio: pin number
  * @pull: one of NMK_GPIO_PULL_DOWN, NMK_GPIO_PULL_UP, and NMK_GPIO_PULL_NONE
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 1d97e96..aba3551 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -62,6 +62,13 @@ enum nmk_gpio_pull {
 	NMK_GPIO_PULL_DOWN,
 };
 
+/* Sleep mode */
+enum nmk_gpio_slpm {
+	NMK_GPIO_SLPM_INPUT,
+	NMK_GPIO_SLPM_NOCHANGE,
+};
+
+extern int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode);
 extern int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull);
 extern int nmk_gpio_set_mode(int gpio, int gpio_mode);
 extern int nmk_gpio_get_mode(int gpio);
-- 
1.7.0
