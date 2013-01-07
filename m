From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:05 +0100
Subject: [PATCH 03/11] ARM: nomadik: move pin maps to cpu file
Message-ID: <1357599365-7426-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pinctrl maps over to the CPU file and register them
right before the pin controller itself. This way the pinmaps
will also benefit the device tree boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c | 45 -----------------------------------
 arch/arm/mach-nomadik/cpu-8815.c      | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 754bf8a..33ce566 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -24,8 +24,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
 #include <asm/hardware/vic.h>
 #include <asm/sizes.h>
@@ -298,51 +296,8 @@ static struct i2c_board_info __initdata nhk8815_i2c2_devices[] = {
 	},
 };
 
-static unsigned long out_low[] = { PIN_OUTPUT_LOW };
-static unsigned long out_high[] = { PIN_OUTPUT_HIGH };
-static unsigned long in_nopull[] = { PIN_INPUT_NOPULL };
-static unsigned long in_pullup[] = { PIN_INPUT_PULLUP };
-
-static struct pinctrl_map __initdata nhk8815_pinmap[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("uart0", "pinctrl-stn8815", "u0_a_1", "u0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl-stn8815", "u1_a_1", "u1"),
-	/* Hog in MMC/SD card mux */
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-stn8815", "mmcsd_a_1", "mmcsd"),
-	/* MCCLK */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO8_B10", out_low),
-	/* MCCMD */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO9_A10", in_pullup),
-	/* MCCMDDIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO10_C11", out_high),
-	/* MCDAT3-0 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO11_B11", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO12_A11", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO13_C12", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO14_B12", in_pullup),
-	/* MCDAT0DIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO15_A12", out_high),
-	/* MCDAT31DIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO16_C13", out_high),
-	/* MCMSFBCLK */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO24_C15", in_pullup),
-	/* CD input GPIO */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO111_H21", in_nopull),
-	/* CD bias drive */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO112_J21", out_low),
-	/* I2C0 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO62_D3", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO63_D2", in_pullup),
-	/* I2C1 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO53_L4", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO54_L3", in_pullup),
-	/* I2C2 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO73_C21", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
-};
-
 static void __init nhk8815_platform_init(void)
 {
-	pinctrl_register_mappings(nhk8815_pinmap, ARRAY_SIZE(nhk8815_pinmap));
 	cpu8815_platform_init();
 	nhk8815_onenand_init();
 	platform_add_devices(nhk8815_platform_devices,
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index f595b04..a983f47 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -27,6 +27,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-nomadik.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -89,6 +90,48 @@ void cpu8815_add_gpios(resource_size_t *base, int num, int irq,
 	}
 }
 
+static unsigned long out_low[] = { PIN_OUTPUT_LOW };
+static unsigned long out_high[] = { PIN_OUTPUT_HIGH };
+static unsigned long in_nopull[] = { PIN_INPUT_NOPULL };
+static unsigned long in_pullup[] = { PIN_INPUT_PULLUP };
+
+static struct pinctrl_map __initdata nhk8815_pinmap[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("uart0", "pinctrl-stn8815", "u0_a_1", "u0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl-stn8815", "u1_a_1", "u1"),
+	/* Hog in MMC/SD card mux */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-stn8815", "mmcsd_a_1", "mmcsd"),
+	/* MCCLK */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO8_B10", out_low),
+	/* MCCMD */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO9_A10", in_pullup),
+	/* MCCMDDIR */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO10_C11", out_high),
+	/* MCDAT3-0 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO11_B11", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO12_A11", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO13_C12", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO14_B12", in_pullup),
+	/* MCDAT0DIR */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO15_A12", out_high),
+	/* MCDAT31DIR */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO16_C13", out_high),
+	/* MCMSFBCLK */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO24_C15", in_pullup),
+	/* CD input GPIO */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO111_H21", in_nopull),
+	/* CD bias drive */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO112_J21", out_low),
+	/* I2C0 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO62_D3", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO63_D2", in_pullup),
+	/* I2C1 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO53_L4", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO54_L3", in_pullup),
+	/* I2C2 */
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO73_C21", in_pullup),
+	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
+};
+
 static inline void
 cpu8815_add_pinctrl(struct device *parent, const char *name)
 {
@@ -98,6 +141,7 @@ cpu8815_add_pinctrl(struct device *parent, const char *name)
 		.id = -1,
 	};
 
+	pinctrl_register_mappings(nhk8815_pinmap, ARRAY_SIZE(nhk8815_pinmap));
 	platform_device_register_full(&pdevinfo);
 }
 
-- 
1.7.11.7
