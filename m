From: oskari@lemmela.net (Oskari Lemmela)
Date: Thu,  4 Oct 2018 22:34:09 +0300
Subject: [PATCH 3/4] arm64: allwinner: a64: add battery and AC power supply
 support
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Message-ID: <20181004193410.7265-4-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AXP803 DT nodes for AC and battery power supplies.
Enable AC and battery power supplies for sopine-baseboard.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 +++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..d23e5d1e9310 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,37 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_adc: adc {
+		compatible = "x-powers,axp803-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp803-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp803-ac-power-supply";
+		status = "disabled";
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp803-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..335cf2263d19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.17.1
