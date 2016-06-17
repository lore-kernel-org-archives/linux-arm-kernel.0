From: luoyi.ly@gmail.com (luoyi.ly at gmail.com)
Date: Fri, 17 Jun 2016 17:56:02 +0800
Subject: [PATCH V3] ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board
Message-ID: <20160617095602.14612-1-luoyi.ly@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luo Yi <luoyi.ly@gmail.com>

Add support for the Bananapi M1 Plus A20 development board from
sinovoip.com.cn . This board is nearly a clone of the Lemaker's
Bananapro, but differ with the wlan chipset connection and i2s pinout.
And I also enable the integrated audio codec on default.
---
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 230 +++++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e06a5ab..fde407f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -685,6 +685,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31s-yones-toptech-bs1078-v2.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-bananapi.dtb \
+	sun7i-a20-bananapi-m1-plus.dtb \
 	sun7i-a20-bananapro.dtb \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
new file mode 100644
index 0000000..89e38e9
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -0,0 +1,230 @@
+/*
+ * Copyright 2016 Luo Yi <luoyi.ly@gmail.com>
+ *
+ * Thanks to the original work by Hans de Goede <hdegoede@redhat.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+    model = "Banana Pi BPI-M1-Plus";
+    compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
+
+    aliases {
+        serial0 = &uart0;
+    };
+
+    chosen {
+        stdout-path = "serial0:115200n8";
+    };
+
+    leds {
+        compatible = "gpio-leds";
+        pinctrl-names = "default";
+        pinctrl-0 = <&led_pins_bananapi>;
+
+        green {
+            label = "bananapi-m1-plus:green:usr";
+            gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
+        };
+
+        red {
+            label = "bananapi-m1-plus:red:usr";
+            gpios = <&pio 7 25 GPIO_ACTIVE_HIGH>;
+            linux,default-trigger = "default-on";
+        };
+
+    };
+
+    mmc3_pwrseq: mmc3_pwrseq {
+        compatible = "mmc-pwrseq-simple";
+        pinctrl-names = "default";
+        pinctrl-0 = <&mmc3_pwrseq_pin_bananapim1plus>;
+        reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 WL-PMU-EN */
+    };
+
+    reg_gmac_3v3: gmac-3v3 {
+        compatible = "regulator-fixed";
+        pinctrl-names = "default";
+        pinctrl-0 = <&gmac_power_pin_bananapi>;
+        regulator-name = "gmac-3v3";
+        regulator-min-microvolt = <3300000>;
+        regulator-max-microvolt = <3300000>;
+        startup-delay-us = <100000>;
+        enable-active-high;
+        gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
+    };
+};
+
+&ahci {
+    status = "okay";
+};
+
+&codec {
+    status = "okay";
+};
+
+&ehci0 {
+    status = "okay";
+};
+
+&ehci1 {
+    status = "okay";
+};
+
+&gmac {
+    pinctrl-names = "default";
+    pinctrl-0 = <&gmac_pins_rgmii_a>;
+    phy = <&phy1>;
+    phy-mode = "rgmii";
+    phy-supply = <&reg_gmac_3v3>;
+    status = "okay";
+
+    phy1: ethernet-phy at 1 {
+        reg = <1>;
+    };
+};
+
+&i2c0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&i2c0_pins_a>;
+    status = "okay";
+
+    axp209: pmic at 34 {
+        compatible = "x-powers,axp209";
+        reg = <0x34>;
+        interrupt-parent = <&nmi_intc>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
+};
+
+&ir0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&ir0_rx_pins_a>;
+    status = "okay";
+};
+
+&mmc0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
+    vmmc-supply = <&reg_vcc3v3>;
+    bus-width = <4>;
+    cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+    cd-inverted;
+    status = "okay";
+};
+
+&mmc3 {
+    #address-cells = <1>;
+    #size-cells = <0>;
+    pinctrl-names = "default";
+    pinctrl-0 = <&mmc3_pins_a>;
+    vmmc-supply = <&reg_vcc3v3>;
+    mmc-pwrseq = <&mmc3_pwrseq>;
+    bus-width = <4>;
+    non-removable;
+    enable-sdio-wakeup;
+    status = "okay";
+
+    brcmf: bcrmf at 1 {
+        reg = <1>;
+        compatible = "brcm,bcm4329-fmac";
+        interrupt-parent = <&pio>;
+        interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "host-wake";
+    };
+};
+
+&mmc3_pins_a {
+    /* AP6210 requires pull-up */
+    allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&ohci0 {
+    status = "okay";
+};
+
+&ohci1 {
+    status = "okay";
+};
+
+&pio {
+    gmac_power_pin_bananapi: gmac_power_pin at 0 {
+        allwinner,pins = "PH23";
+        allwinner,function = "gpio_out";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+    };
+
+    led_pins_bananapi: led_pins at 0 {
+        allwinner,pins = "PH24", "PG2";
+        allwinner,function = "gpio_out";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+    };
+
+    mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
+        allwinner,pins = "PH10";
+        allwinner,function = "gpio_in";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+    };
+
+    mmc3_pwrseq_pin_bananapim1plus: mmc3_pwrseq_pin at 0 {
+        allwinner,pins = "PH22";
+        allwinner,function = "gpio_out";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+    };
+};
+
+&uart0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&uart0_pins_a>;
+    status = "okay";
+};
-- 
2.8.3
