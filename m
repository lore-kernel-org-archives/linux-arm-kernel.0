From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Jul 2014 01:02:58 +0200
Subject: [PATCH 6/6] ARM: dts: add rk3288 evaluation board
In-Reply-To: <1471578.ILeMmG2DL6@diego>
References: <1471578.ILeMmG2DL6@diego>
Message-ID: <2186895.xqgxh7zegl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There exist 2 variants using either the act8846 or rk808 as pmic, while the
rest of the board stays the same.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 136 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts   |  19 +++++
 arch/arm/boot/dts/rk3288-evb.dtsi        |  77 +++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-evb-act8846.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb-rk808.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb.dtsi

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
new file mode 100644
index 0000000..9b1ef03
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -0,0 +1,136 @@
+/*
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
+#include "rk3288-evb.dtsi"
+
+/ {
+	compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";
+};
+
+&i2c0 {
+	hym8563 at 51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+
+		#clock-cells = <0>;
+		clock-output-names = "xin32k";
+	};
+
+	act8846: act8846 at 5a {
+		compatible = "active-semi,act8846";
+		reg = <0x5a>;
+		status = "okay";
+	};
+};
+
+&act8846 {
+	regulators {
+		vcc_ddr: REG1 {
+			regulator-name = "VCC_DDR";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+		};
+
+		vcc_io: REG2 {
+			regulator-name = "VCC_IO";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd_log: REG3 {
+			regulator-name = "VDD_LOG";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-always-on;
+		};
+
+		vcc_20: REG4 {
+			regulator-name = "VCC_20";
+			regulator-min-microvolt = <2000000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-always-on;
+		};
+
+		vccio_sd: REG5 {
+			regulator-name = "VCCIO_SD";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd10_lcd: REG6 {
+			regulator-name = "VDD10_LCD";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-always-on;
+		};
+
+		vcca_codec: REG7 {
+			regulator-name = "VCCA_CODEC";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vcca_tp: REG8 {
+			regulator-name = "VCCA_TP";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vccio_pmu: REG9 {
+			regulator-name = "VCCIO_PMU";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd_10: REG10 {
+			regulator-name = "VDD_10";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-always-on;
+		};
+
+		vcc_18: REG11 {
+			regulator-name = "VCC_18";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vcc18_lcd: REG12 {
+			regulator-name = "VCC18_LCD";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
new file mode 100644
index 0000000..c168cb2
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -0,0 +1,19 @@
+/*
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
+#include "rk3288-evb.dtsi"
+
+/ {
+	compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
+
+};
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
new file mode 100644
index 0000000..ff642d4
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -0,0 +1,77 @@
+/*
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
+#include "rk3288.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	memory {
+		reg = <0x0 0x80000000>;
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
+				gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+				linux,code = <116>;
+				label = "GPIO Key Power";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <1>;
+				debounce-interval = <100>;
+			};
+		};
+
+		i2c0: i2c at ff650000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_xfer>;
+			status = "okay";
+		};
+
+		watchdog at ff800000 {
+			status = "okay";
+		};
+
+		serial at ff180000 {
+			status = "okay";
+		};
+
+		serial at ff190000 {
+			status = "okay";
+		};
+
+		uart2: serial at ff690000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_xfer>;
+			status = "okay";
+		};
+
+		uart3: serial at ff1b0000 {
+			status = "okay";
+		};
+
+		uart4: serial at ff1c0000 {
+			status = "okay";
+		};
+	};
+};
-- 
1.9.0
