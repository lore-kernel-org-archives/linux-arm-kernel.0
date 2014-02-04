From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:26 +0100
Subject: [PATCH 10/10] ARM: ux500: move last AB8505 set-up to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-10-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the set-up of the HREF500 with its AB8505 ASIC to
a device tree include. Since there is not yet any device tree
for this board the DTSI is currently unused. After this delete
the board file for pins for good and migration of pins to the
device tree is complete.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8505.dtsi  | 240 ++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/Makefile            |   1 -
 arch/arm/mach-ux500/board-mop500-pins.c |  93 -------------
 arch/arm/mach-ux500/board-mop500.h      |   2 -
 arch/arm/mach-ux500/cpu-db8500.c        |   3 -
 5 files changed, 240 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-ab8505.dtsi
 delete mode 100644 arch/arm/mach-ux500/board-mop500-pins.c

diff --git a/arch/arm/boot/dts/ste-href-ab8505.dtsi b/arch/arm/boot/dts/ste-href-ab8505.dtsi
new file mode 100644
index 000000000000..6006d62086a2
--- /dev/null
+++ b/arch/arm/boot/dts/ste-href-ab8505.dtsi
@@ -0,0 +1,240 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	soc {
+		prcmu at 80157000 {
+			ab8505 {
+				ab8505-gpio {
+					/* Hog a few default settings */
+					pinctrl-names = "default";
+					pinctrl-0 = <&gpio2_default_mode>,
+						    <&gpio10_default_mode>,
+						    <&gpio11_default_mode>,
+						    <&gpio13_default_mode>,
+						    <&gpio34_default_mode>,
+						    <&gpio50_default_mode>,
+						    <&pwm_default_mode>,
+						    <&adi2_default_mode>,
+						    <&modsclsda_default_mode>,
+						    <&resethw_default_mode>,
+						    <&service_default_mode>;
+
+					/*
+					 * Pins 2, 10, 11, 13, 34 and 50
+					 * are muxed in as GPIO, and configured as INPUT PULL DOWN
+					 */
+					gpio2 {
+						gpio2_default_mode: gpio2_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio2_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO2_R5";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio10 {
+						gpio10_default_mode: gpio10_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio10_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO10_B16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio11 {
+						gpio11_default_mode: gpio11_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio11_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO11_B17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio13 {
+						gpio13_default_mode: gpio13_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio13_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO13_D17";
+								input-enable;
+								bias-disable;
+							};
+						};
+					};
+					gpio34 {
+						gpio34_default_mode: gpio34_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio34_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO34_H14";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio50 {
+						gpio50_default_mode: gpio50_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio50_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO50_L4";
+								input-enable;
+								bias-disable;
+							};
+						};
+					};
+					/* This sets up the PWM pin 14 */
+					pwm {
+						pwm_default_mode: pwm_default {
+							default_mux {
+								ste,function = "pwmout";
+								ste,pins = "pwmout1_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO14_C16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					/* This sets up audio interface 2 */
+					adi2 {
+						adi2_default_mode: adi2_default {
+							default_mux {
+								ste,function = "adi2";
+								ste,pins = "adi2_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO17_P2",
+									 "GPIO18_N3",
+									 "GPIO19_T1",
+									 "GPIO20_P3";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					/* Modem I2C setup (SCL and SDA pins) */
+					modsclsda {
+						modsclsda_default_mode: modsclsda_default {
+							default_mux {
+								ste,function = "modsclsda";
+								ste,pins = "modsclsda_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO40_J15",
+									"GPIO41_J14";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					resethw {
+						resethw_default_mode: resethw_default {
+							default_mux {
+								ste,function = "resethw";
+								ste,pins = "resethw_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO52_D16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					service {
+						service_default_mode: service_default {
+							default_mux {
+								ste,function = "service";
+								ste,pins = "service_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO53_D15";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
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
+								ste,pins = "GPIO1_N4";
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
+								ste,pins = "GPIO1_N4";
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
+								ste,pins = "GPIO3_P5";
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
+								ste,pins = "GPIO3_P5";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index d05ba759da30..de544aabf292 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500-sdi.o \
 				board-mop500-regulators.o \
-				board-mop500-pins.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
deleted file mode 100644
index 1597ff7538e3..000000000000
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/bug.h>
-#include <linux/string.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/pinctrl/pinconf-generic.h>
-
-#include <asm/mach-types.h>
-
-#include "board-mop500.h"
-
-/* These simply sets bias for pins */
-#define BIAS(a,b) static unsigned long a[] = { b }
-
-BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
-BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
-
-#define AB8505_MUX_HOG(group, func) \
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-ab8505.0", group, func)
-#define AB8505_PIN_HOG(pin, conf) \
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-ab8505.0", pin, abx500_##conf)
-
-#define AB8505_MUX_STATE(group, func, dev, state) \
-	PIN_MAP_MUX_GROUP(dev, state, "pinctrl-ab8505.0", group, func)
-#define AB8505_PIN_STATE(pin, conf, dev, state) \
-	PIN_MAP_CONFIGS_PIN(dev, state, "pinctrl-ab8505.0", pin, abx500_##conf)
-
-static struct pinctrl_map __initdata ab8505_pinmap[] = {
-	/* Sysclkreq2 */
-	AB8505_MUX_STATE("sysclkreq2_d_1", "sysclkreq", "regulator.36", PINCTRL_STATE_DEFAULT),
-	AB8505_PIN_STATE("GPIO1_N4", in_nopull, "regulator.36", PINCTRL_STATE_DEFAULT),
-	/* sysclkreq2 disable, mux in gpio configured in input pulldown */
-	AB8505_MUX_STATE("gpio1_a_1", "gpio", "regulator.36", PINCTRL_STATE_SLEEP),
-	AB8505_PIN_STATE("GPIO1_N4", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
-
-	/* pins 2 is muxed in GPIO, configured in INPUT PULL DOWN */
-	AB8505_MUX_HOG("gpio2_a_1", "gpio"),
-	AB8505_PIN_HOG("GPIO2_R5", in_pd),
-
-	/* Sysclkreq4 */
-	AB8505_MUX_STATE("sysclkreq4_d_1", "sysclkreq", "regulator.37", PINCTRL_STATE_DEFAULT),
-	AB8505_PIN_STATE("GPIO3_P5", in_nopull, "regulator.37", PINCTRL_STATE_DEFAULT),
-	/* sysclkreq4 disable, mux in gpio configured in input pulldown */
-	AB8505_MUX_STATE("gpio3_a_1", "gpio", "regulator.37", PINCTRL_STATE_SLEEP),
-	AB8505_PIN_STATE("GPIO3_P5", in_pd, "regulator.37", PINCTRL_STATE_SLEEP),
-
-	AB8505_MUX_HOG("gpio10_d_1", "gpio"),
-	AB8505_PIN_HOG("GPIO10_B16", in_pd),
-
-	AB8505_MUX_HOG("gpio11_d_1", "gpio"),
-	AB8505_PIN_HOG("GPIO11_B17", in_pd),
-
-	AB8505_MUX_HOG("gpio13_d_1", "gpio"),
-	AB8505_PIN_HOG("GPIO13_D17", in_nopull),
-
-	AB8505_MUX_HOG("pwmout1_d_1", "pwmout"),
-	AB8505_PIN_HOG("GPIO14_C16", in_pd),
-
-	AB8505_MUX_HOG("adi2_d_1", "adi2"),
-	AB8505_PIN_HOG("GPIO17_P2", in_pd),
-	AB8505_PIN_HOG("GPIO18_N3", in_pd),
-	AB8505_PIN_HOG("GPIO19_T1", in_pd),
-	AB8505_PIN_HOG("GPIO20_P3", in_pd),
-
-	AB8505_MUX_HOG("gpio34_a_1", "gpio"),
-	AB8505_PIN_HOG("GPIO34_H14", in_pd),
-
-	AB8505_MUX_HOG("modsclsda_d_1", "modsclsda"),
-	AB8505_PIN_HOG("GPIO40_J15", in_pd),
-	AB8505_PIN_HOG("GPIO41_J14", in_pd),
-
-	AB8505_MUX_HOG("gpio50_d_1", "gpio"),
-	AB8505_PIN_HOG("GPIO50_L4", in_nopull),
-
-	AB8505_MUX_HOG("resethw_d_1", "resethw"),
-	AB8505_PIN_HOG("GPIO52_D16", in_pd),
-
-	AB8505_MUX_HOG("service_d_1", "service"),
-	AB8505_PIN_HOG("GPIO53_D15", in_pd),
-};
-
-void __init mop500_pinmaps_init(void)
-{
-	if (machine_is_u8520())
-		pinctrl_register_mappings(ab8505_pinmap,
-					  ARRAY_SIZE(ab8505_pinmap));
-}
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 320517e17ac9..bb408b8f48de 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -88,6 +88,4 @@ extern struct msp_i2s_platform_data msp1_platform_data;
 extern struct msp_i2s_platform_data msp2_platform_data;
 extern struct msp_i2s_platform_data msp3_platform_data;
 
-void __init mop500_pinmaps_init(void);
-
 #endif
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 2e52fcba57bd..180b3c59be36 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -191,9 +191,6 @@ static void __init u8500_init_machine(void)
 {
 	struct device *parent = db8500_soc_device_init();
 
-	/* Pinmaps must be in place before devices register */
-	if (of_machine_is_compatible("st-ericsson,mop500"))
-		mop500_pinmaps_init();
 	/* automatically probe child nodes of dbx5x0 devices */
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
-- 
1.8.5.3
