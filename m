From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 24 Aug 2010 21:13:49 +0530
Subject: [PATCH 2/2] nomadik-gpio: allow control of sleep mode direction and
	pull up
In-Reply-To: <1282664629-22975-1-git-send-email-rabin.vincent@stericsson.com>
References: <1282664629-22975-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1282664629-22975-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DB8500v2 allows control of direction and pull up/down configuration in
sleep mode, instead of switching the pin to input with pull up/down
enabled.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c                |   42 ++++++++++++++++++++-------
 arch/arm/plat-nomadik/include/plat/pincfg.h |   31 +++++++++++++++++++-
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 014da39..7afc7e8 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -102,6 +102,22 @@ static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
 	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRC);
 }
 
+static void __nmk_gpio_set_output(struct nmk_gpio_chip *nmk_chip,
+				  unsigned offset, int val)
+{
+	if (val)
+		writel(1 << offset, nmk_chip->addr + NMK_GPIO_DATS);
+	else
+		writel(1 << offset, nmk_chip->addr + NMK_GPIO_DATC);
+}
+
+static void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
+				  unsigned offset, int val)
+{
+	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRS);
+	__nmk_gpio_set_output(nmk_chip, offset, val);
+}
+
 static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 			     pin_cfg_t cfg)
 {
@@ -126,12 +142,21 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 	int pull = PIN_PULL(cfg);
 	int af = PIN_ALT(cfg);
 	int slpm = PIN_SLPM(cfg);
+	int output = PIN_DIR(cfg);
+	int val = PIN_VAL(cfg);
 
-	dev_dbg(nmk_chip->chip.dev, "pin %d: af %s, pull %s, slpm %s\n",
-		pin, afnames[af], pullnames[pull], slpmnames[slpm]);
+	dev_dbg(nmk_chip->chip.dev, "pin %d: af %s, pull %s, slpm %s (%s%s)\n",
+		pin, afnames[af], pullnames[pull], slpmnames[slpm],
+		output ? "output " : "input",
+		output ? (val ? "high" : "low") : "");
+
+	if (output)
+		__nmk_gpio_make_output(nmk_chip, offset, val);
+	else {
+		__nmk_gpio_make_input(nmk_chip, offset);
+		__nmk_gpio_set_pull(nmk_chip, offset, pull);
+	}
 
-	__nmk_gpio_make_input(nmk_chip, offset);
-	__nmk_gpio_set_pull(nmk_chip, offset, pull);
 	__nmk_gpio_set_slpm(nmk_chip, offset, slpm);
 	__nmk_gpio_set_mode(nmk_chip, offset, af);
 }
@@ -519,12 +544,8 @@ static void nmk_gpio_set_output(struct gpio_chip *chip, unsigned offset,
 {
 	struct nmk_gpio_chip *nmk_chip =
 		container_of(chip, struct nmk_gpio_chip, chip);
-	u32 bit = 1 << offset;
 
-	if (val)
-		writel(bit, nmk_chip->addr + NMK_GPIO_DATS);
-	else
-		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
+	__nmk_gpio_set_output(nmk_chip, offset, val);
 }
 
 static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
@@ -533,8 +554,7 @@ static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
 	struct nmk_gpio_chip *nmk_chip =
 		container_of(chip, struct nmk_gpio_chip, chip);
 
-	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRS);
-	nmk_gpio_set_output(chip, offset, val);
+	__nmk_gpio_make_output(nmk_chip, offset, val);
 
 	return 0;
 }
diff --git a/arch/arm/plat-nomadik/include/plat/pincfg.h b/arch/arm/plat-nomadik/include/plat/pincfg.h
index 432a201..8c5ae3f 100644
--- a/arch/arm/plat-nomadik/include/plat/pincfg.h
+++ b/arch/arm/plat-nomadik/include/plat/pincfg.h
@@ -19,12 +19,16 @@
  *	bit  9..10 - Alternate Function Selection
  *	bit 11..12 - Pull up/down state
  *	bit     13 - Sleep mode behaviour
+ *	bit     14 - (sleep mode) Direction
+ *	bit     15 - (sleep mode) Value (if output)
  *
  * to facilitate the definition, the following macros are provided
  *
  * PIN_CFG_DEFAULT - default config (0):
  *		     pull up/down = disabled
  *		     sleep mode = input/wakeup
+ *		     (sleep mode) direction = input
+ *		     (sleep mode) value = low
  *
  * PIN_CFG	   - default config with alternate function
  * PIN_CFG_PULL	   - default config with alternate function and pull up/down
@@ -53,12 +57,37 @@ typedef unsigned long pin_cfg_t;
 #define PIN_SLPM_SHIFT		13
 #define PIN_SLPM_MASK		(0x1 << PIN_SLPM_SHIFT)
 #define PIN_SLPM(x)		(((x) & PIN_SLPM_MASK) >> PIN_SLPM_SHIFT)
-#define PIN_SLPM_INPUT		(NMK_GPIO_SLPM_INPUT << PIN_SLPM_SHIFT)
+#define PIN_SLPM_MAKE_INPUT	(NMK_GPIO_SLPM_INPUT << PIN_SLPM_SHIFT)
 #define PIN_SLPM_NOCHANGE	(NMK_GPIO_SLPM_NOCHANGE << PIN_SLPM_SHIFT)
 /* These two replace the above in DB8500v2+ */
 #define PIN_SLPM_WAKEUP_ENABLE	(NMK_GPIO_SLPM_WAKEUP_ENABLE << PIN_SLPM_SHIFT)
 #define PIN_SLPM_WAKEUP_DISABLE	(NMK_GPIO_SLPM_WAKEUP_DISABLE << PIN_SLPM_SHIFT)
 
+#define PIN_DIR_SHIFT		14
+#define PIN_DIR_MASK		(0x1 << PIN_DIR_SHIFT)
+#define PIN_DIR(x)		(((x) & PIN_DIR_MASK) >> PIN_DIR_SHIFT)
+#define PIN_DIR_INPUT		(0 << PIN_DIR_SHIFT)
+#define PIN_DIR_OUTPUT		(1 << PIN_DIR_SHIFT)
+
+#define PIN_VAL_SHIFT		15
+#define PIN_VAL_MASK		(0x1 << PIN_VAL_SHIFT)
+#define PIN_VAL(x)		(((x) & PIN_VAL_MASK) >> PIN_VAL_SHIFT)
+#define PIN_VAL_LOW		(0 << PIN_VAL_SHIFT)
+#define PIN_VAL_HIGH		(1 << PIN_VAL_SHIFT)
+
+/* Shortcuts.  Use these instead of separate DIR and VAL.  */
+#define PIN_INPUT		PIN_DIR_INPUT
+#define PIN_OUTPUT_LOW		(PIN_DIR_OUTPUT | PIN_VAL_LOW)
+#define PIN_OUTPUT_HIGH		(PIN_DIR_OUTPUT | PIN_VAL_HIGH)
+
+/*
+ * These are the same as the ones above, but should make more sense to the
+ * reader when seen along with a setting a pin to AF mode.
+ */
+#define PIN_SLPM_INPUT		PIN_INPUT
+#define PIN_SLPM_OUTPUT_LOW	PIN_OUTPUT_LOW
+#define PIN_SLPM_OUTPUT_HIGH	PIN_OUTPUT_HIGH
+
 #define PIN_CFG_DEFAULT		(PIN_PULL_NONE | PIN_SLPM_INPUT)
 
 #define PIN_CFG(num, alt)		\
-- 
1.7.2.dirty
