From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Oct 2016 18:11:54 +0800
Subject: [PATCH 3/3] ARM: dts: sun9i: cubieboard4: Enable AP6330 WiFi
In-Reply-To: <20161028101154.7350-1-wens@csie.org>
References: <20161028101154.7350-1-wens@csie.org>
Message-ID: <20161028101154.7350-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has a Ampak AP6330 WiFi/BT/FM module. Inside it is a Broadcom
BCM4330 WiFi/BT/FM combo IC. The WiFi portion is connected to mmc1, with
the enabling pin connected to PL2. The AC100 RTC provides a low power
clock signal.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 439847acd41e..67b02fe7f11c 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -76,6 +76,14 @@
 			gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "ext_clock";
+		/* enables internal regulator and de-asserts reset */
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 WL-PMU-EN */
+	};
 };
 
 &mmc0 {
@@ -88,6 +96,21 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>, <&wifi_en_pin_cubieboard4>;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_cldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&mmc1_pins {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_pins>;
@@ -128,6 +151,15 @@
 	status = "okay";
 };
 
+&r_pio {
+	wifi_en_pin_cubieboard4: wifi_en_pin at 0 {
+		allwinner,pins = "PL2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.9.3
