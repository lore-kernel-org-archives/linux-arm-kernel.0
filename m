From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 24 Aug 2010 21:13:48 +0530
Subject: [PATCH 1/2] nomadik-gpio: add SLPM register handing for DB8500v2
Message-ID: <1282664629-22975-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SLPM register enables/disables wakeup detection on DB8500v2.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c                |   30 ++++++++++++++++++++++++--
 arch/arm/plat-nomadik/include/plat/gpio.h   |    2 +
 arch/arm/plat-nomadik/include/plat/pincfg.h |    5 +++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 977c8f9..014da39 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -118,8 +118,8 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 		[3] /* illegal */	= "??"
 	};
 	static const char *slpmnames[] = {
-		[NMK_GPIO_SLPM_INPUT]		= "input",
-		[NMK_GPIO_SLPM_NOCHANGE]	= "no-change",
+		[NMK_GPIO_SLPM_INPUT]		= "input/wakeup",
+		[NMK_GPIO_SLPM_NOCHANGE]	= "no-change/no-wakeup",
 	};
 
 	int pin = PIN_NUM(cfg);
@@ -200,6 +200,10 @@ EXPORT_SYMBOL(nmk_config_pins);
  * changed to an input (with pullup/down enabled) in sleep and deep sleep.  If
  * @mode is NMK_GPIO_SLPM_NOCHANGE, the pin remains in the state it was
  * configured even when in sleep and deep sleep.
+ *
+ * On DB8500v2 onwards, this setting loses the previous meaning and instead
+ * indicates if wakeup detection is enabled on the pin.  Note that
+ * enable_irq_wake() will automatically enable wakeup detection.
  */
 int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode)
 {
@@ -367,7 +371,27 @@ static void nmk_gpio_irq_unmask(unsigned int irq)
 
 static int nmk_gpio_irq_set_wake(unsigned int irq, unsigned int on)
 {
-	return nmk_gpio_irq_modify(irq, WAKE, on);
+	struct nmk_gpio_chip *nmk_chip;
+	unsigned long flags;
+	int gpio;
+
+	gpio = NOMADIK_IRQ_TO_GPIO(irq);
+	nmk_chip = get_irq_chip_data(irq);
+	if (!nmk_chip)
+		return -EINVAL;
+
+	spin_lock_irqsave(&nmk_chip->lock, flags);
+#ifdef CONFIG_ARCH_U8500
+	if (cpu_is_u8500v2()) {
+		__nmk_gpio_set_slpm(nmk_chip, gpio,
+				    on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
+				       : NMK_GPIO_SLPM_WAKEUP_DISABLE);
+	}
+#endif
+	__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
+	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	return 0;
 }
 
 static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index aba3551..67b113d 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -65,7 +65,9 @@ enum nmk_gpio_pull {
 /* Sleep mode */
 enum nmk_gpio_slpm {
 	NMK_GPIO_SLPM_INPUT,
+	NMK_GPIO_SLPM_WAKEUP_ENABLE = NMK_GPIO_SLPM_INPUT,
 	NMK_GPIO_SLPM_NOCHANGE,
+	NMK_GPIO_SLPM_WAKEUP_DISABLE = NMK_GPIO_SLPM_NOCHANGE,
 };
 
 extern int nmk_gpio_set_slpm(int gpio, enum nmk_gpio_slpm mode);
diff --git a/arch/arm/plat-nomadik/include/plat/pincfg.h b/arch/arm/plat-nomadik/include/plat/pincfg.h
index 7eed11c..432a201 100644
--- a/arch/arm/plat-nomadik/include/plat/pincfg.h
+++ b/arch/arm/plat-nomadik/include/plat/pincfg.h
@@ -24,7 +24,7 @@
  *
  * PIN_CFG_DEFAULT - default config (0):
  *		     pull up/down = disabled
- *		     sleep mode = input
+ *		     sleep mode = input/wakeup
  *
  * PIN_CFG	   - default config with alternate function
  * PIN_CFG_PULL	   - default config with alternate function and pull up/down
@@ -55,6 +55,9 @@ typedef unsigned long pin_cfg_t;
 #define PIN_SLPM(x)		(((x) & PIN_SLPM_MASK) >> PIN_SLPM_SHIFT)
 #define PIN_SLPM_INPUT		(NMK_GPIO_SLPM_INPUT << PIN_SLPM_SHIFT)
 #define PIN_SLPM_NOCHANGE	(NMK_GPIO_SLPM_NOCHANGE << PIN_SLPM_SHIFT)
+/* These two replace the above in DB8500v2+ */
+#define PIN_SLPM_WAKEUP_ENABLE	(NMK_GPIO_SLPM_WAKEUP_ENABLE << PIN_SLPM_SHIFT)
+#define PIN_SLPM_WAKEUP_DISABLE	(NMK_GPIO_SLPM_WAKEUP_DISABLE << PIN_SLPM_SHIFT)
 
 #define PIN_CFG_DEFAULT		(PIN_PULL_NONE | PIN_SLPM_INPUT)
 
-- 
1.7.2.dirty
