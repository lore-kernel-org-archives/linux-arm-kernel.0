From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 11 Oct 2016 08:33:59 +0800
Subject: [PATCH 5/5] ARM: dts: sun6i: enable ili2139 on Colorfly E708 Q1
In-Reply-To: <20161011003359.26079-1-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Message-ID: <20161011003359.26079-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many users report that their Colorfly E708 Q1's come with ili2139 touch
IC. This patch adds the device node of this IC.

It seems that two devices are attached to I2C bus 1: a ili2139 touch
controller at 0x41, and a stil unknown device at 0x38. So make PA2
controlled by a dummy regulator node, rather than a power sequence GPIO
for ili2139.

There's also some users who report that their tablets come with touch
screen with Goodix GT911 touch IC. In the device, the touch IC is
connected on the screen rather soldered on the PCB, so the two touch
screens may be both acceptable FRUs of the tablet. They have different
addresses, and may be runtime detectable. (The Allwinner BSP kernel have
such a detection method, however, mainline kernel have no such method
now except enable both touch ICs' driver and wait for one driver's
failure)

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
index 882a4d8..73ac574 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -47,6 +47,38 @@
 / {
 	model = "Colorfly E708 Q1 tablet";
 	compatible = "colorfly,e708-q1", "allwinner,sun6i-a31s";
+
+	/* This is actually a common reset line for both the
+	 * touchscreen and the accelerometer.
+	 */
+	i2c1_on: i2c1_on {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_on_e708_q1>;
+
+		regulator-name = "i2c1_on";
+		regulator-min-microvolt = "3000000";
+		regulator-max-microvolt = "3000000";
+		regulator-always-on;
+		gpio = <&pio 0 2 GPIO_ACTIVE_HIGH>; /* PA2 */
+		enable-active-high;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+
+	ctp at 41 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ili2139_int_e708_q1>;
+
+		compatible = "ilitek,ili2139", "ili2139";
+		reg = <0x41>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
+	};
 };
 
 &lradc {
@@ -61,6 +93,22 @@
 	};
 };
 
+&pio {
+	i2c1_on_e708_q1: i2c1_on at 0 {
+		allwinner,pins = "PA2";
+	        allwinner,function = "gpio_out";
+	        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+	        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	ili2139_int_e708_q1: ili2139_int at 0 {
+		allwinner,pins = "PA3";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &reg_dldo2 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
2.10.1
