From: luoyi.ly@gmail.com (luoyi)
Date: Wed, 1 Jun 2016 10:40:18 +0800
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <20160531170957.GM4908@lukather>
References: <20160530123013.11575-1-luoyi.ly@gmail.com>
 <20160530194340.GE4908@lukather> <574CA1ED.8050007@web.de>
 <20160531170957.GM4908@lukather>
Message-ID: <CAFfxPQss6M4dR_=fPCamZ08A3gPyC0523f+qFTYm1e16O4t_KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the new version of the patch.  and I think maybe every board
should have their own dtb files. and we can you some cpp  macro tricks
to merge their coressponding dts file.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e06a5ab..fde407f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -685,6 +685,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
     sun6i-a31s-yones-toptech-bs1078-v2.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
     sun7i-a20-bananapi.dtb \
+    sun7i-a20-bananapi-m1-plus.dtb \
     sun7i-a20-bananapro.dtb \
     sun7i-a20-cubieboard2.dtb \
     sun7i-a20-cubietruck.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
new file mode 100644
index 0000000..548ed31
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -0,0 +1,266 @@
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
+            label = "bananapi:green:usr";
+            gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
+        };
+
+        red {
+            label = "bananapi:red:usr";
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
+
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
+
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
+
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
+
+    usb1_vbus_pin_bananapi: usb1_vbus_pin at 0 {
+        allwinner,pins = "PH0";
+        allwinner,function = "gpio_out";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+    };
+
+    usb2_vbus_pin_bananapi: usb2_vbus_pin at 0 {
+        allwinner,pins = "PH1";
+        allwinner,function = "gpio_out";
+        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+    };
+
+};
+
+&reg_usb1_vbus {
+    pinctrl-0 = <&usb1_vbus_pin_bananapi>;
+    gpio = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
+    status = "okay";
+};
+
+&reg_usb2_vbus {
+    pinctrl-0 = <&usb2_vbus_pin_bananapi>;
+    gpio = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+    status = "okay";
+};
+
+&uart0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&uart0_pins_a>;
+    status = "okay";
+};
+
+&usbphy {
+    usb1_vbus-supply = <&reg_usb1_vbus>;
+    usb2_vbus-supply = <&reg_usb2_vbus>;
+    status = "okay";
+};

2016-06-01 1:09 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Mon, May 30, 2016 at 10:26:21PM +0200, Bernhard Nortmann wrote:
>> Am 30.05.2016 um 21:43 schrieb Maxime Ripard:
>> >Hi,
>> >
>> >On Mon, May 30, 2016 at 08:30:13PM +0800, luoyi.ly at gmail.com wrote:
>> >>From: luoyi <luoyi.ly@gmail.com>
>> >>
>> >>Add support for the Bananapi M1 Plus A20 development board from sinovoip.com.cn .
>> >>This board features 1G RAM, 2 USB A receptacles, 1 micro USB receptacle for
>> >>OTG, 1 micro USB receptacle for power, HDMI, sata, Gbit ethernet, ir receiver,
>> >>3.5 mm jack for stero sound out, on board microphone, 40 gpio pins and sdio wifi.
>> >What is the difference between the M1+ and the M1?
>>
>> The M1+ is an updated version of the original Banana Pi. If you're
>> interested in the details, have a look at
>> http://linux-sunxi.org/Banana_Pi#Variants .  "BPi-M1+" is SinoVoip's
>> counterpart of LeMaker's "Banana Pro", for which a .dts already
>> exists. Judging from .fex files, only a single pin assignment seems
>> to differ between the two (audio_pa_ctrl, PH26 vs. PH15).
>
> Gee, that's confusing :)
>
> I guess we should just include the banana pro DTB and change that pin
> (and the i2s pins Luo was mentionning).
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
