From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 May 2014 21:34:34 +0200
Subject: [PATCH v3 8/8] ARM: sunxi: dt: add APP4-EVB1 board support
In-Reply-To: <1399923274-6017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399923274-6017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399923274-6017-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

The APP4 EVB1 development boards embeds an A31, together with some NAND, one SD
card slot, and one SDIO + UART WiFi and Bluetooth chip, a few I2C buses, USB,
and a LCD display.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 57 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8bc808cb7ce2..1d9c50dda655 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun5i-a10s-r7-tv-dongle.dtb \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
+	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
 	sun6i-a31-m9.dtb \
 	sun7i-a20-cubieboard2.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
new file mode 100644
index 000000000000..2bbf8867362b
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2014 Boris Brezillon
+ *
+ * Boris Brezillon <boris.brezillon@free-electrons.com>
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
+/include/ "sun6i-a31.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
+	compatible = "allwinner,app4-evb1", "allwinner,sun6i-a31";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc at 01c00000 {
+		pio: pinctrl at 01c20800 {
+			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+				allwinner,pins = "PH27";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		usbphy: phy at 01c19400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c1a000 {
+			status = "okay";
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_a>;
+		gpio = <&pio 7 27 0>;
+		status = "okay";
+	};
+};
-- 
1.9.3
