From: david@lechnology.com (David Lechner)
Date: Thu, 31 May 2018 15:25:48 -0500
Subject: [PATCH 1/2] ARM: dts: da850-lego-ev3: Add Bluetooth nodes
In-Reply-To: <20180531202549.11255-1-david@lechnology.com>
References: <20180531202549.11255-1-david@lechnology.com>
Message-ID: <20180531202549.11255-2-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds nodes for describing the Bluetooth chip and connections on
LEGO MINDSTORMS EV3 to da850-lego-ev3.dts.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index bef42dc78817..fe4cc87394b9 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -187,6 +187,15 @@
 		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
 	};
 
+	bt_slow_clk: bt-clock {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ecap2_pins>, <&bt_clock_bias>;
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&ecap2 0 30518 0>;
+	};
+
 	/* ARM local RAM */
 	memory at ffff0000 {
 		compatible = "syscon", "simple-mfd";
@@ -251,6 +260,20 @@
 			bias-disable;
 		};
 	};
+
+	bt_clock_bias: bt-clock-bias-groups {
+		disable {
+			groups = "cp2";
+			bias-disable;
+		};
+	};
+
+	bt_pic_bias: bt-pic-bias-groups {
+		disable {
+			groups = "cp20";
+			bias-disable;
+		};
+	};
 };
 
 /* Input port 1 */
@@ -260,6 +283,22 @@
 	pinctrl-0 = <&serial1_rxtx_pins>;
 };
 
+&serial2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial2_rxtx_pins>, <&serial2_rtscts_pins>, <&bt_pic_bias>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,cc2560";
+		clocks = <&bt_slow_clk>;
+		clock-names = "ext_clock";
+		enable-gpios = <&gpio 73 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		nvmem-cells = <&bdaddr>;
+		nvmem-cell-names = "bd-address";
+	};
+};
+
 &rtc0 {
 	status = "okay";
 };
@@ -278,6 +317,12 @@
 		pagesize = <64>;
 		read-only;
 		reg = <0x50>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		bdaddr: bdaddr at 3f06 {
+			reg = <0x3f06 0x06>;
+		};
 	};
 };
 
@@ -362,6 +407,10 @@
 	};
 };
 
+&ecap2 {
+	status = "okay";
+};
+
 &ehrpwm0 {
 	status = "okay";
 };
@@ -375,6 +424,39 @@
 		gpios = <6 GPIO_ACTIVE_HIGH>;
 		output-high;
 	};
+
+	/* Don't impede Bluetooth clock signal */
+	bt_clock_en {
+		gpio-hog;
+		gpios = <5 GPIO_ACTIVE_HIGH>;
+		input;
+	};
+
+	/*
+	 * There is a PIC microcontroller for interfacing with an Apple MFi
+	 * chip. This interferes with normal Bluetooth operation, so we need
+	 * to make sure it is turned off. Note: The publicly available
+	 * schematics from LEGO don't show that these pins are connected to
+	 * anything, but they are present in the source code from LEGO.
+	 */
+
+	bt_pic_en {
+		gpio-hog;
+		gpios = <51 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
+
+	bt_pic_rst {
+		gpio-hog;
+		gpios = <78 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+
+	bt_pic_cts {
+		gpio-hog;
+		gpios = <87 GPIO_ACTIVE_HIGH>;
+		input;
+	};
 };
 
 &usb_phy {
-- 
2.17.0
