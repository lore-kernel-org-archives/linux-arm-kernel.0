From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:57 +0200
Subject: [PATCH 7/9] ARM: dts: sun7i: Add new ba10-tvbox board
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ba10 tvbox is an A10 based android tvbox, with 512M RAM, 8G nand flash,
rtl8188ctv usb wifi 1 USB-A receptacle hooked up to an EHCI/OHCI controller,
1 USB-A receptacle hooked up to the OTG and 100Mbit ethernet using a
rtl8201 phy.

The PCB is labelled ba10 hence I've named the board ba10-tvbox. It is used
in noname allwinner A10 tv-boxes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts | 110 +++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fdc590e..fbba066 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -360,6 +360,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
 	stih416-b2020-revE.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
+	sun4i-a10-ba10-tvbox.dtb \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
new file mode 100644
index 0000000..1763cc7
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -0,0 +1,110 @@
+/*
+ * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "BA10 tvbox";
+	compatible = "allwinner,ba10-tvbox", "allwinner,sun4i-a10";
+
+	soc at 01c00000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy1>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
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
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
+		pinctrl at 01c20800 {
+			usb2_vbus_pin_a: usb2_vbus_pin at 0 {
+				allwinner,pins = "PH12";
+			};
+		};
+
+		ir0: ir at 01c21800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ir0_pins_a>;
+			status = "okay";
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
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		gpio = <&pio 7 12 0>;
+		status = "okay";
+	};
+};
-- 
2.0.0
