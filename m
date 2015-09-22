From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 15:36:05 +0200
Subject: [PATCH 6/6] ARM: dts: sun7i: Add dts file for Wits Pro A20 DKT
In-Reply-To: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
References: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442928966-6418-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jelle de Jong <jelledejong@powercraft.nl>

The Wits Pro A20 DKT is an A20 Development KiT with 1G RAM, 4G NAND,
sdio wifi, 1Gbit ethernet, 1024x768 lcd screen with ft5x_ts touchscreen
and a ton of IO connectors.

Note there seem to be multiple sdcard slots on the board (4 in total), but
other then mmc0 none of these are hooked up by default, there is a ton of
dip-switches which likely allow hooking some of these up, but the
documentation of the board only describes the use of a fraction of them,
so for now we only support mmc0.

Signed-off-by: Jelle de Jong <jelledejong@powercraft.nl>
[hdegoede at redhat.com: Use pwrseq instead of a regulator for the wifi-en pin]
[hdegoede at redhat.com: Add support for OOB irq for the sdio wifi]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Also see: http://www.merrii.com/en/pla_d.asp?id=163

Changes in v2:
-Use mmc-pwrseq-simple instead of a regulator for the wifi-en pin
-Add support for OOB irq for the sdio wifi
---
 arch/arm/boot/dts/Makefile                       |   3 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 226 +++++++++++++++++++++++
 2 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a8b4ef1..63c4765 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -625,7 +625,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-orangepi-mini.dtb \
 	sun7i-a20-pcduino3.dtb \
 	sun7i-a20-pcduino3-nano.dtb \
-	sun7i-a20-wexler-tab7200.dtb
+	sun7i-a20-wexler-tab7200.dtb \
+	sun7i-a20-wits-pro-a20-dkt.dtb
 dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-evb.dtb \
 	sun8i-a23-gt90h-v4.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
new file mode 100644
index 0000000..85b500d
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -0,0 +1,226 @@
+/*
+ * Copyright 2015 Jelle de Jong <jelledejong@powercraft.nl>
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
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Wits Pro A20 DKT";
+	compatible = "wits,pro-a20-dkt", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	mmc3_pwrseq: mmc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc3_pin_ap6xxx_wl_regon>;
+		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&mmc3_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <7 10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	vmmc3_pin_ap6xxx_wl_regon: vmmc3_pin at 0 {
+		allwinner,pins = "PH9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.4.3
