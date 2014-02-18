From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Feb 2014 15:17:45 +0100
Subject: [PATCH 3/3] ARM: dts: imx6sl: add board file for BQ Cervantes
In-Reply-To: <10555869.uLtJmrqZh3@phil>
References: <10555869.uLtJmrqZh3@phil>
Message-ID: <7296658.gcHrKZZqIc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bqreaders.com>

i.MX6SL based ebook-reader released in 2013.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 arch/arm/boot/dts/imx6sl-bq-cervantes.dts | 133 ++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-bq-cervantes.dts

diff --git a/arch/arm/boot/dts/imx6sl-bq-cervantes.dts b/arch/arm/boot/dts/imx6sl-bq-cervantes.dts
new file mode 100644
index 0000000..c54f498
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-bq-cervantes.dts
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2014 MundoReader S.L.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "imx6sl.dtsi"
+
+/ {
+	model = "BQ Cervantes";
+	compatible = "fsl,imx6sl";
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usdhc2_vmmc: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usdhc2_vmmc";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 0>;
+			enable-active-high;
+		};
+	};
+
+	soc {
+		gpio-keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			autorepeat;
+
+			button at 0 {
+				gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+				linux,code = <KEY_POWER>;
+				label = "GPIO Key Power";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <1>;
+				debounce-interval = <100>;
+			};
+
+			button at 1 {
+				gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+				linux,code = <KEY_HOME>;
+				label = "GPIO Key Home";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <1>;
+				debounce-interval = <100>;
+			};
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			green {
+				gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	imx6sl-bqcervantes {
+		pinctrl_zforce: zforcegrp {
+			fsl,pins = <
+				MX6SL_PAD_SD1_DAT3__GPIO5_IO06 0xc000
+				MX6SL_PAD_SD1_DAT5__GPIO5_IO09 0x80000000
+			>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	zforce at 50 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_zforce>;
+
+		compatible = "neonode,zforce";
+		reg = <0x50>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+
+		gpios = <&gpio5 6 0   /* INT */
+			 &gpio5 9 0>; /* RST */
+
+		x-size = <758>;
+		y-size = <1024>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc2 {
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	cd-gpios = <&gpio5 2 0>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	broken-cd;
+	status = "okay";
+};
-- 
1.8.5.3
