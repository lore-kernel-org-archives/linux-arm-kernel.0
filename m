From: bert@biot.com (Bert Vermeulen)
Date: Sat,  2 Apr 2016 14:55:52 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
Message-ID: <1459601753-31193-1-git-send-email-bert@biot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform is based on a Marvell 88E6282 SoC and 88E6171 switch.

The DSA port labels follow the switchdev convention.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/boot/dts/kirkwood-candyhouse.dts | 228 ++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-candyhouse.dts

diff --git a/arch/arm/boot/dts/kirkwood-candyhouse.dts b/arch/arm/boot/dts/kirkwood-candyhouse.dts
new file mode 100644
index 0000000..1d16cef
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-candyhouse.dts
@@ -0,0 +1,228 @@
+/*
+ * kirkwood-candyhouse.dts - Device Tree file for Linksys Candyhouse (E4200v2 / EA4500)
+ *
+ * (c) 2013 Jonas Gorski <jogo@openwrt.org>
+ * (c) 2013 Deutsche Telekom Innovation Laboratories
+ * (c) 2014 Luka Perkov <luka@openwrt.org>
+ * (c) 2014 Randy C. Will <randall.will@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+
+/ {
+	model = "Linksys Candyhouse (E4200v2 / EA4500)";
+	compatible = "linksys,ea4500", "linksys,e4200v2", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_led_white_health: pmx-led-white-health {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+			pmx_led_white_pulse: pmx-led-white-pulse {
+				marvell,pins = "mpp14";
+				marvell,function = "gpio";
+			};
+			pmx_btn_wps: pmx-btn-wps {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+		};
+
+		/* There is no battery on the boards, so the RTC does not keep
+		   time when there is no power, making it useless. */
+		rtc at 10300 {
+			status = "disabled";
+		};
+
+		serial at 12000 {
+			status = "okay";
+		};
+
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = < &pmx_btn_wps &pmx_btn_reset >;
+		pinctrl-names = "default";
+
+		button at 15 {
+			label = "WPS Button";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 16 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_white_health &pmx_led_white_pulse >;
+		pinctrl-names = "default";
+
+		white-health {
+			label = "candyhouse:white:health";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		white-pulse {
+			label = "candyhouse:white:pulse";
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	dsa at 0 {
+		compatible = "marvell,dsa";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		dsa,ethernet = <&eth0port>;
+		dsa,mii-bus = <&mdio>;
+
+		switch at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10 0>;	/* MDIO address 16, switch 0 in tree */
+
+			port at 0 {
+				reg = <0>;
+				label = "sw0p0";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "sw0p1";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "sw0p2";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "sw0p3";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "sw0p4";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+			};
+		};
+	};
+};
+
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0 0x80000>;
+	};
+
+	partition at 80000 {
+		label = "u_env";
+		reg = <0x80000 0x20000>;
+	};
+
+	partition at A0000 {
+		label = "s_env";
+		reg = <0xA0000 0x20000>;
+	};
+
+	partition at 200000 {
+		label = "kernel";
+		reg = <0x200000 0x2A0000>;
+	};
+
+	partition at 4A0000 {
+		label = "rootfs";
+		reg = <0x4A0000 0x1760000>;
+	};
+
+	partition at 1C00000 {
+		label = "alt_kernel";
+		reg = <0x1C00000 0x2A0000>;
+	};
+
+	partition at 1EA0000 {
+		label = "alt_rootfs";
+		reg = <0x1EA0000 0x1760000>;
+	};
+
+	partition at 3600000 {
+		label = "syscfg";
+		reg = <0x3600000 0x4A00000>;
+	};
+};
+
+&mdio {
+	status = "okay";
+};
+
+/* eth0 is connected to a Marvell 88E6171 switch, without a PHY. So set
+ * fixed speed and duplex. */
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		speed = <1000>;
+		duplex = <1>;
+	};
+};
+
+/* eth1 is connected to the switch as well. However DSA only supports a
+ * single CPU port. So leave this port disabled to avoid confusion. */
+&eth1 {
+	status = "disabled";
+	ethernet1-port at 0 {
+		speed = <1000>;
+		duplex = <1>;
+	};
+};
-- 
1.9.1
