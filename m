From: ipaton0@gmail.com (Iain Paton)
Date: Fri, 10 Oct 2014 14:15:24 +0100
Subject: [PATCH v5] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <20141009195630.GJ19438@lukather>
References: <54280AA7.1090401@gmail.com> <20140928164337.GB15315@lukather>
 <54295711.9010901@gmail.com> <20140929132543.GC4081@lukather>
 <54296D8B.3080304@gmail.com> <20141002124807.GC4039@lukather>
 <5431C8EF.3070809@gmail.com> <20141006092049.GF4090@lukather>
 <54366326.3060303@gmail.com> <20141009195630.GJ19438@lukather>
Message-ID: <5437DBEC.1000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Olimex A20-OLinuXino-Lime2
https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXIno-LIME2

Differences to previous Lime boards are 1GB RAM and gigabit ethernet

Signed-off-by: Iain Paton <ipaton0@gmail.com>
---

changes for v2
 add axp209 regulators node

changes for v3
 add reg_axp_ipsout regulator
 follow suggestion by Chen-Yu in
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/292645.html
  on parenting the regulators

changes for v4
 give regulators better names
 add spacing between nodes
 drop ldo5 as it doesn't appear to be used

changes for v5
 order nodes by address instead of by name
 drop extraneous newline

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 228 ++++++++++++++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2f42b18..ea6c672 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -420,6 +420,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-olinuxino-lime.dtb \
+	sun7i-a20-olinuxino-lime2.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-pcduino3.dtb
 dtb-$(CONFIG_MACH_SUN8I) += \
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
new file mode 100644
index 0000000..187729a
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -0,0 +1,228 @@
+/*
+ * Copyright 2014 - Iain Paton <ipaton0@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/include/ "sun7i-a20.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Olimex A20-OLinuXino-LIME2";
+	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vcc3v3>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			usb2_vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c14000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c14400 {
+			status = "okay";
+		};
+
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
+		pinctrl at 01c20800 {
+			ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
+				allwinner,pins = "PC3";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			led_pins_olinuxinolime: led_pins at 0 {
+				allwinner,pins = "PH2";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					vdd_rtc: ldo1 {
+						regulator-min-microvolt = <1300000>;
+						regulator-max-microvolt = <1300000>;
+						regulator-always-on;
+					};
+
+					avcc: ldo2 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+					};
+
+					vcc_csi0: ldo3 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <3500000>;
+						regulator-always-on;
+					};
+
+					vcc_csi1: ldo4 {
+						regulator-min-microvolt = <1250000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+					};
+
+					vdd_cpu: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					vdd_int: dcdc3 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <3500000>;
+						regulator-always-on;
+					};
+				};
+			};
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		gmac: ethernet at 01c50000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_rgmii_a>;
+			phy = <&phy1>;
+			phy-mode = "rgmii";
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinolime>;
+
+		green {
+			label = "a20-olinuxino-lime2:green:usr";
+			gpios = <&pio 7 2 0>;
+			default-state = "on";
+		};
+	};
+
+	reg_ahci_5v: ahci-5v {
+		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
+		gpio = <&pio 2 3 0>;
+		status = "okay";
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		status = "okay";
+	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
-- 
1.8.5.1
