From: ideal.song@samsung.com (Inha Song)
Date: Fri, 23 Jan 2015 14:03:30 +0900
Subject: [alsa-devel] [PATCH v4 3/3] ARM: dts: Add sound nodes for
 exynos4412-trats2
In-Reply-To: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
References: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
Message-ID: <1421989410-12490-4-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add WM1811 audio codec, I2S interface and the sound
machine nodes to enable audio on exynos4412-trats2 board.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 29231b4..6205b98 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -203,6 +203,25 @@
 		};
 	};
 
+	i2c at 138A0000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-slave-addr = <0x10>;
+		samsung,i2c-max-bus-freq = <100000>;
+		pinctrl-0 = <&i2c4_bus>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		wm1811: wm1811 at 1a {
+			compatible = "wlf,wm1811";
+			reg = <0x1a>;
+			clocks = <&pmu_system_controller 0>;
+			clock-names = "MCLK1";
+			DCVDD-supply = <&ldo3_reg>;
+			DBVDD1-supply = <&ldo3_reg>;
+			wlf,ldo1ena = <&gpj0 4 0>;
+		};
+	};
+
 	i2c at 138D0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
@@ -838,6 +857,24 @@
 		};
 	};
 
+	i2s0: i2s at 03830000 {
+		pinctrl-0 = <&i2s0_bus>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	sound {
+		compatible = "samsung,trats2-audio";
+		samsung,i2s-controller = <&i2s0>;
+		samsung,model = "Trats2";
+		samsung,audio-codec = <&wm1811>;
+		samsung,audio-routing =
+			"SPK", "SPKOUTLN",
+			"SPK", "SPKOUTLP",
+			"SPK", "SPKOUTRN",
+			"SPK", "SPKOUTRP";
+	};
+
 	exynos-usbphy at 125B0000 {
 		status = "okay";
 	};
@@ -865,6 +902,11 @@
 	};
 };
 
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents =  <&clock CLK_XUSBXTI>;
+};
+
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
-- 
2.0.0.390.gcb682f8
