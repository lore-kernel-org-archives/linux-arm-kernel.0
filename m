From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 13:00:30 +0200
Subject: [PATCH 3/5] ARM: rockchip: add dts for bqcurie2 tablet
In-Reply-To: <201310151258.53435.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
Message-ID: <201310151300.30449.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BQ Curie2 is a tablet based on the rk3066a SoC.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  109 ++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-bqcurie2.dts

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
new file mode 100644
index 0000000..035df40
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -0,0 +1,109 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "rk3066a.dtsi"
+
+/ {
+	model = "bq Curie 2";
+
+	memory {
+		reg = <0x60000000 0x40000000>;
+	};
+
+	soc {
+		uart0: serial at 10124000 {
+			status = "okay";
+		};
+
+		uart1: serial at 10126000 {
+			status = "okay";
+		};
+
+		uart2: serial at 20064000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_xfer>;
+			status = "okay";
+		};
+
+		uart3: serial at 20068000 {
+			status = "okay";
+		};
+
+		vcc_sd0: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "sdmmc-supply";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+			startup-delay-us = <100000>;
+		};
+
+		dwmmc at 10214000 { /* sdmmc */
+			num-slots = <1>;
+			status = "okay";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
+			vmmc-supply = <&vcc_sd0>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+				disable-wp;
+			};
+		};
+
+		dwmmc at 10218000 { /* wifi */
+			num-slots = <1>;
+			status = "okay";
+			non-removable;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+				disable-wp;
+			};
+		};
+
+		gpio-keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			autorepeat;
+
+			button at 0 {
+				gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
+				linux,code = <116>;
+				label = "GPIO Key Power";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <1>;
+				debounce-interval = <100>;
+			};
+			button at 1 {
+				gpios = <&gpio4 21 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
+				linux,code = <104>;
+				label = "GPIO Key Vol-";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <0>;
+				debounce-interval = <100>;
+			};
+			/* VOL+ comes somehow thru the ADC */
+		};
+	};
+};
-- 
1.7.10.4
