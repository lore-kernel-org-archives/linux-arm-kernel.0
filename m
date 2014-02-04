From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:25 +0100
Subject: [PATCH 09/10] ARM: ux500: move AB8500 clock out pins to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-9-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the AB8500 pin settings for the clock out pins over
to the device tree. We can delete the special setup calls for the
platforms only using the AB8500 and not AB8505.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 51 +++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c | 41 --------------------------
 arch/arm/mach-ux500/board-mop500.h      |  2 --
 arch/arm/mach-ux500/cpu-db8500.c        |  7 -----
 4 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 333b554c0bf7..30f8601da323 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -370,6 +370,57 @@
 							};
 						};
 					};
+					/*
+					 * Clock output pins associated with regulators.
+					 */
+					sysclkreq2 {
+						sysclkreq2_default_mode: sysclkreq2_default {
+							default_mux {
+								ste,function = "sysclkreq";
+								ste,pins = "sysclkreq2_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO1_T10";
+								input-enable;
+								bias-disable;
+							};
+						};
+						sysclkreq2_sleep_mode: sysclkreq2_sleep {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio1_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO1_T10";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					sysclkreq4 {
+						sysclkreq4_default_mode: sysclkreq4_default {
+							default_mux {
+								ste,function = "sysclkreq";
+								ste,pins = "sysclkreq4_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO3_U9";
+								input-enable;
+								bias-disable;
+							};
+						};
+						sysclkreq4_sleep_mode: sysclkreq4_sleep {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio3_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO3_U9";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index cbe91714f57f..1597ff7538e3 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -21,16 +21,6 @@
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
 BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 
-#define AB8500_MUX_HOG(group, func) \
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-ab8500.0", group, func)
-#define AB8500_PIN_HOG(pin, conf) \
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-ab8500.0", pin, abx500_##conf)
-
-#define AB8500_MUX_STATE(group, func, dev, state) \
-	PIN_MAP_MUX_GROUP(dev, state, "pinctrl-ab8500.0", group, func)
-#define AB8500_PIN_STATE(pin, conf, dev, state) \
-	PIN_MAP_CONFIGS_PIN(dev, state, "pinctrl-ab8500.0", pin, abx500_##conf)
-
 #define AB8505_MUX_HOG(group, func) \
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-ab8505.0", group, func)
 #define AB8505_PIN_HOG(pin, conf) \
@@ -41,22 +31,6 @@ BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 #define AB8505_PIN_STATE(pin, conf, dev, state) \
 	PIN_MAP_CONFIGS_PIN(dev, state, "pinctrl-ab8505.0", pin, abx500_##conf)
 
-static struct pinctrl_map __initdata ab8500_pinmap[] = {
-	/* Sysclkreq2 */
-	AB8500_MUX_STATE("sysclkreq2_d_1", "sysclkreq", "regulator.35", PINCTRL_STATE_DEFAULT),
-	AB8500_PIN_STATE("GPIO1_T10", in_nopull, "regulator.35", PINCTRL_STATE_DEFAULT),
-	/* sysclkreq2 disable, mux in gpio configured in input pulldown */
-	AB8500_MUX_STATE("gpio1_a_1", "gpio", "regulator.35", PINCTRL_STATE_SLEEP),
-	AB8500_PIN_STATE("GPIO1_T10", in_pd, "regulator.35", PINCTRL_STATE_SLEEP),
-
-	/* Sysclkreq4 */
-	AB8500_MUX_STATE("sysclkreq4_d_1", "sysclkreq", "regulator.36", PINCTRL_STATE_DEFAULT),
-	AB8500_PIN_STATE("GPIO3_U9", in_nopull, "regulator.36", PINCTRL_STATE_DEFAULT),
-	/* sysclkreq4 disable, mux in gpio configured in input pulldown */
-	AB8500_MUX_STATE("gpio3_a_1", "gpio", "regulator.36", PINCTRL_STATE_SLEEP),
-	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
-};
-
 static struct pinctrl_map __initdata ab8505_pinmap[] = {
 	/* Sysclkreq2 */
 	AB8505_MUX_STATE("sysclkreq2_d_1", "sysclkreq", "regulator.36", PINCTRL_STATE_DEFAULT),
@@ -116,19 +90,4 @@ void __init mop500_pinmaps_init(void)
 	if (machine_is_u8520())
 		pinctrl_register_mappings(ab8505_pinmap,
 					  ARRAY_SIZE(ab8505_pinmap));
-	else
-		pinctrl_register_mappings(ab8500_pinmap,
-					  ARRAY_SIZE(ab8500_pinmap));
-}
-
-void __init snowball_pinmaps_init(void)
-{
-	pinctrl_register_mappings(ab8500_pinmap,
-				  ARRAY_SIZE(ab8500_pinmap));
-}
-
-void __init hrefv60_pinmaps_init(void)
-{
-	pinctrl_register_mappings(ab8500_pinmap,
-				  ARRAY_SIZE(ab8500_pinmap));
 }
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index d48e8662c676..320517e17ac9 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -89,7 +89,5 @@ extern struct msp_i2s_platform_data msp2_platform_data;
 extern struct msp_i2s_platform_data msp3_platform_data;
 
 void __init mop500_pinmaps_init(void);
-void __init snowball_pinmaps_init(void);
-void __init hrefv60_pinmaps_init(void);
 
 #endif
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index bc8a6183560d..2e52fcba57bd 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -194,13 +194,6 @@ static void __init u8500_init_machine(void)
 	/* Pinmaps must be in place before devices register */
 	if (of_machine_is_compatible("st-ericsson,mop500"))
 		mop500_pinmaps_init();
-	else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
-		snowball_pinmaps_init();
-	} else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
-		hrefv60_pinmaps_init();
-	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
-		/* TODO: Add pinmaps for ccu9540 board. */
-
 	/* automatically probe child nodes of dbx5x0 devices */
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
-- 
1.8.5.3
