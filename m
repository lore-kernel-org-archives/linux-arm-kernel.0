From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:20 +0100
Subject: [PATCH 01/19] ARM: sunxi: dt: Add sunxi-common-regulators include file
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most sunxi boards with a sata connector also have a gpio controlled connector
for sata target power and almost all sunxi boards have a gpio controlled vbus
for usb1 and usb2.

This commit adds an include file for the regulators representing these
supplies, avoiding the need to copy and paste the regulator code to allmost
all sunxi board dts files.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 75 ++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/sunxi-common-regulators.dtsi

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
new file mode 100644
index 0000000..18eeac0
--- /dev/null
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -0,0 +1,75 @@
+/*
+ * sunxi boards common regulator (ahci target power supply, usb-vbus) code
+ *
+ * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
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
+	soc at 01c00000 {
+		pio: pinctrl at 01c20800 {
+			ahci_pwr_pin_a: ahci_pwr_pin at 0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+				allwinner,pins = "PH6";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			usb2_vbus_pin_a: usb2_vbus_pin at 0 {
+				allwinner,pins = "PH3";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+	};
+
+	reg_ahci_5v: ahci-5v {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ahci_pwr_pin_a>;
+		regulator-name = "ahci-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 1 8 0>;
+		status = "disabled";
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb1_vbus_pin_a>;
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 6 0>;
+		status = "disabled";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_pin_a>;
+		regulator-name = "usb2-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 3 0>;
+		status = "disabled";
+	};
+};
-- 
1.9.0
