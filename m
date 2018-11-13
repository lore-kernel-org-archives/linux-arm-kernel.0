From: lukma@denx.de (Lukasz Majewski)
Date: Tue, 13 Nov 2018 13:12:13 +0100
Subject: [PATCH] ARM: dts: Provide support for reading ID code from MVB device
 (BK4)
Message-ID: <20181113121213.14296-1-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The procedure to read this ID value is as follows:

rmmod spi_fsl_dspi
insmod spi-gpio.ko

echo 504 > /sys/class/gpio/export
cat /sys/class/gpio/gpio504/value
...
echo 511 > /sys/class/gpio/export
cat /sys/class/gpio/gpio511/value

rmmod spi-gpio.ko
insmod spi_fsl_dspi

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/vf610-bk4.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index cab95714c058..f01c735807ae 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -59,6 +59,29 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	spi_gpio {
+		compatible = "spi-gpio";
+		pinctrl-0 = <&pinctrl_gpio_spi>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* PTD12 ->RPIO[91] */
+		sck-gpios  = <&gpio2 27 GPIO_ACTIVE_LOW>;
+		/* PTD10 ->RPIO[89] */
+		miso-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <0>;
+
+		72xx165 at 0 {
+			compatible = "pisosr-gpio";
+			reg = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* PTB18 -> RGPIO[40] */
+			load-gpios  = <&gpio1 8 GPIO_ACTIVE_LOW>;
+			spi-max-frequency = <100000>;
+		};
+	};
 };
 
 &adc0 {
@@ -430,6 +453,14 @@
 		>;
 	};
 
+	pinctrl_gpio_spi: pinctrl-gpio-spi {
+		fsl,pins = <
+			VF610_PAD_PTB18__GPIO_40        0x1183
+			VF610_PAD_PTD10__GPIO_89        0x1183
+			VF610_PAD_PTD12__GPIO_91        0x1183
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			VF610_PAD_PTA22__I2C2_SCL               0x34df
-- 
2.11.0
