From: bert@biot.com (Bert Vermeulen)
Date: Mon,  4 Apr 2016 13:47:12 +0200
Subject: [PATCH v2] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
Message-ID: <1459770433-2876-1-git-send-email-bert@biot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform is based on a Marvell 88E6282 SoC and 88E6171 switch.
---
 arch/arm/boot/dts/kirkwood-viper.dts | 236 +++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-viper.dts

diff --git a/arch/arm/boot/dts/kirkwood-viper.dts b/arch/arm/boot/dts/kirkwood-viper.dts
new file mode 100644
index 0000000..3ada18d
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-viper.dts
@@ -0,0 +1,236 @@
+/*
+ * kirkwood-viper.dts - Device Tree file for Linksys viper (E4200v2 / EA4500)
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
+	model = "Linksys Viper (E4200v2 / EA4500)";
+	compatible = "linksys,viper", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = < &pmx_btn_wps &pmx_btn_reset >;
+		pinctrl-names = "default";
+
+		wps {
+			label = "WPS Button";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+
+		reset {
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
+			label = "viper:white:health";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		white-pulse {
+			label = "viper:white:pulse";
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	dsa {
+		compatible = "marvell,dsa";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		dsa,ethernet = <&eth0port>;
+		dsa,mii-bus = <&mdio>;
+
+		switch at 16,0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <16 0>;	/* MDIO address 16, switch 0 in tree */
+
+			port at 0 {
+				reg = <0>;
+				label = "ethernet1";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "ethernet2";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "ethernet3";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "ethernet4";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "internet";
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
+&pinctrl {
+	pmx_led_white_health: pmx-led-white-health {
+		marvell,pins = "mpp7";
+		marvell,function = "gpo";
+	};
+	pmx_led_white_pulse: pmx-led-white-pulse {
+		marvell,pins = "mpp14";
+		marvell,function = "gpio";
+	};
+	pmx_btn_wps: pmx-btn-wps {
+		marvell,pins = "mpp47";
+		marvell,function = "gpio";
+	};
+	pmx_btn_reset: pmx-btn-reset {
+		marvell,pins = "mpp48";
+		marvell,function = "gpio";
+	};
+};
+
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition at 80000 {
+			label = "u_env";
+			reg = <0x80000 0x20000>;
+		};
+
+		partition at A0000 {
+			label = "s_env";
+			reg = <0xA0000 0x20000>;
+		};
+
+		partition at 200000 {
+			label = "kernel";
+			reg = <0x200000 0x2A0000>;
+		};
+
+		partition at 4A0000 {
+			label = "rootfs";
+			reg = <0x4A0000 0x1760000>;
+		};
+
+		partition at 1C00000 {
+			label = "alt_kernel";
+			reg = <0x1C00000 0x2A0000>;
+		};
+
+		partition at 1EA0000 {
+			label = "alt_rootfs";
+			reg = <0x1EA0000 0x1760000>;
+		};
+
+		partition at 3600000 {
+			label = "syscfg";
+			reg = <0x3600000 0x4A00000>;
+		};
+
+		partition at C0000 {
+			label = "unused";
+			reg = <0xC0000 0x140000>;
+		};
+
+	};
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
+&uart0 {
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
+/* eth1 doesn't appear to be connected at all. */
+&eth1 {
+	status = "disabled";
+};
+
+/* There is no battery on the board, so the RTC does not keep
+   time when there is no power, making it useless. */
+&rtc {
+	status = "disabled";
+};
+
-- 
1.9.1
