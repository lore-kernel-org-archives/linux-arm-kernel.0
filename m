From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:16 +0530
Subject: [PATCH 4/7] nomadik-gpio: add pin configuration API
In-Reply-To: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
References: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1274707639-28285-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pin configuration API to all pin-related configuration to be
specified with a single macro and groups of pins to be configured
at one go.  Based on the PXA MFP implementation.

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c                |   96 +++++++++++++++++++++++++++
 arch/arm/plat-nomadik/include/plat/pincfg.h |   72 ++++++++++++++++++++
 2 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-nomadik/include/plat/pincfg.h

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 286ab42..983a2e8 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 
+#include <plat/pincfg.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 
@@ -95,6 +96,101 @@ static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 		writel(bit, nmk_chip->addr + NMK_GPIO_DATC);
 }
 
+static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
+				  unsigned offset)
+{
+	writel(1 << offset, nmk_chip->addr + NMK_GPIO_DIRC);
+}
+
+static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
+			     pin_cfg_t cfg)
+{
+	static const char *afnames[] = {
+		[NMK_GPIO_ALT_GPIO]	= "GPIO",
+		[NMK_GPIO_ALT_A]	= "A",
+		[NMK_GPIO_ALT_B]	= "B",
+		[NMK_GPIO_ALT_C]	= "C"
+	};
+	static const char *pullnames[] = {
+		[NMK_GPIO_PULL_NONE]	= "none",
+		[NMK_GPIO_PULL_UP]	= "up",
+		[NMK_GPIO_PULL_DOWN]	= "down",
+		[3] /* illegal */	= "??"
+	};
+	static const char *slpmnames[] = {
+		[NMK_GPIO_SLPM_INPUT]		= "input",
+		[NMK_GPIO_SLPM_NOCHANGE]	= "no-change",
+	};
+
+	int pin = PIN_NUM(cfg);
+	int pull = PIN_PULL(cfg);
+	int af = PIN_ALT(cfg);
+	int slpm = PIN_SLPM(cfg);
+
+	dev_dbg(nmk_chip->chip.dev, "pin %d: af %s, pull %s, slpm %s\n",
+		pin, afnames[af], pullnames[pull], slpmnames[slpm]);
+
+	__nmk_gpio_make_input(nmk_chip, offset);
+	__nmk_gpio_set_pull(nmk_chip, offset, pull);
+	__nmk_gpio_set_slpm(nmk_chip, offset, slpm);
+	__nmk_gpio_set_mode(nmk_chip, offset, af);
+}
+
+/**
+ * nmk_config_pin - configure a pin's mux attributes
+ * @cfg: pin confguration
+ *
+ * Configures a pin's mode (alternate function or GPIO), its pull up status,
+ * and its sleep mode based on the specified configuration.  The @cfg is
+ * usually one of the SoC specific macros defined in mach/<soc>-pins.h.  These
+ * are constructed using, and can be further enhanced with, the macros in
+ * plat/pincfg.h.
+ *
+ * If a pin's mode is set to GPIO, it is configured as an input to avoid
+ * side-effects.  The gpio can be manipulated later using standard GPIO API
+ * calls.
+ */
+int nmk_config_pin(pin_cfg_t cfg)
+{
+	struct nmk_gpio_chip *nmk_chip;
+	int gpio = PIN_NUM(cfg);
+	unsigned long flags;
+
+	nmk_chip = get_irq_chip_data(NOMADIK_GPIO_TO_IRQ(gpio));
+	if (!nmk_chip)
+		return -EINVAL;
+
+	spin_lock_irqsave(&nmk_chip->lock, flags);
+	__nmk_config_pin(nmk_chip, gpio - nmk_chip->chip.base, cfg);
+	spin_unlock_irqrestore(&nmk_chip->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(nmk_config_pin);
+
+/**
+ * nmk_config_pins - configure several pins at once
+ * @cfgs: array of pin configurations
+ * @num: number of elments in the array
+ *
+ * Configures several pins using nmk_config_pin().  Refer to that function for
+ * further information.
+ */
+int nmk_config_pins(pin_cfg_t *cfgs, int num)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		int ret = nmk_config_pin(cfgs[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(nmk_config_pins);
+
 /**
  * nmk_gpio_set_slpm() - configure the sleep mode of a pin
  * @gpio: pin number
diff --git a/arch/arm/plat-nomadik/include/plat/pincfg.h b/arch/arm/plat-nomadik/include/plat/pincfg.h
new file mode 100644
index 0000000..7eed11c
--- /dev/null
+++ b/arch/arm/plat-nomadik/include/plat/pincfg.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License, version 2
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ *
+ * Based on arch/arm/mach-pxa/include/mach/mfp.h:
+ *   Copyright (C) 2007 Marvell International Ltd.
+ *   eric miao <eric.miao@marvell.com>
+ */
+
+#ifndef __PLAT_PINCFG_H
+#define __PLAT_PINCFG_H
+
+/*
+ * pin configurations are represented by 32-bit integers:
+ *
+ *	bit  0.. 8 - Pin Number (512 Pins Maximum)
+ *	bit  9..10 - Alternate Function Selection
+ *	bit 11..12 - Pull up/down state
+ *	bit     13 - Sleep mode behaviour
+ *
+ * to facilitate the definition, the following macros are provided
+ *
+ * PIN_CFG_DEFAULT - default config (0):
+ *		     pull up/down = disabled
+ *		     sleep mode = input
+ *
+ * PIN_CFG	   - default config with alternate function
+ * PIN_CFG_PULL	   - default config with alternate function and pull up/down
+ */
+
+typedef unsigned long pin_cfg_t;
+
+#define PIN_NUM_MASK		0x1ff
+#define PIN_NUM(x)		((x) & PIN_NUM_MASK)
+
+#define PIN_ALT_SHIFT		9
+#define PIN_ALT_MASK		(0x3 << PIN_ALT_SHIFT)
+#define PIN_ALT(x)		(((x) & PIN_ALT_MASK) >> PIN_ALT_SHIFT)
+#define PIN_GPIO		(NMK_GPIO_ALT_GPIO << PIN_ALT_SHIFT)
+#define PIN_ALT_A		(NMK_GPIO_ALT_A << PIN_ALT_SHIFT)
+#define PIN_ALT_B		(NMK_GPIO_ALT_B << PIN_ALT_SHIFT)
+#define PIN_ALT_C		(NMK_GPIO_ALT_C << PIN_ALT_SHIFT)
+
+#define PIN_PULL_SHIFT		11
+#define PIN_PULL_MASK		(0x3 << PIN_PULL_SHIFT)
+#define PIN_PULL(x)		(((x) & PIN_PULL_MASK) >> PIN_PULL_SHIFT)
+#define PIN_PULL_NONE		(NMK_GPIO_PULL_NONE << PIN_PULL_SHIFT)
+#define PIN_PULL_UP		(NMK_GPIO_PULL_UP << PIN_PULL_SHIFT)
+#define PIN_PULL_DOWN		(NMK_GPIO_PULL_DOWN << PIN_PULL_SHIFT)
+
+#define PIN_SLPM_SHIFT		13
+#define PIN_SLPM_MASK		(0x1 << PIN_SLPM_SHIFT)
+#define PIN_SLPM(x)		(((x) & PIN_SLPM_MASK) >> PIN_SLPM_SHIFT)
+#define PIN_SLPM_INPUT		(NMK_GPIO_SLPM_INPUT << PIN_SLPM_SHIFT)
+#define PIN_SLPM_NOCHANGE	(NMK_GPIO_SLPM_NOCHANGE << PIN_SLPM_SHIFT)
+
+#define PIN_CFG_DEFAULT		(PIN_PULL_NONE | PIN_SLPM_INPUT)
+
+#define PIN_CFG(num, alt)		\
+	(PIN_CFG_DEFAULT |\
+	 (PIN_NUM(num) | PIN_##alt))
+
+#define PIN_CFG_PULL(num, alt, pull)	\
+	((PIN_CFG_DEFAULT & ~PIN_PULL_MASK) |\
+	 (PIN_NUM(num) | PIN_##alt | PIN_PULL_##pull))
+
+extern int nmk_config_pin(pin_cfg_t cfg);
+extern int nmk_config_pins(pin_cfg_t *cfgs, int num);
+
+#endif
-- 
1.7.0
