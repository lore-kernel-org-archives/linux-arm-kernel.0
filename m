From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 07 Feb 2017 17:13:25 +0900
Subject: [PATCH] arm64: dts: Enable ir-spi in the tm2 and tm2e boards
References: <CGME20170207081338epcas5p23530ff8663c58f8868a0f9dfa2e19f7a@epcas5p2.samsung.com>
Message-ID: <20170207081325.9769-1-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree node for the ir-spi driver which enable the
ir led for remote controlling.

This patch sets first the GPR3[3] gpio line as a regulator-fixed
for enabling an external regulator which powers the IR LED.

Removes also the default assignment of the GPG3[5] and GPG3[7]
related to the SPI3 line.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 27 ++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 098ad557fee3..c61df2318d8b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -106,6 +106,13 @@
 		};
 	};
 
+	irda_regulator: irda-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpr3 3 0>;
+		regulator-name = "irda_regulator";
+	};
+
 	sound {
 		compatible = "samsung,tm2-audio";
 		audio-codec = <&wm5110>;
@@ -1073,8 +1080,6 @@
 
 		PIN(INPUT, gpg3-0, DOWN, FAST_SR1);
 		PIN(INPUT, gpg3-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpg3-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpg3-7, DOWN, FAST_SR1);
 	};
 };
 
@@ -1152,6 +1157,24 @@
 	};
 };
 
+&spi_3 {
+	status = "okay";
+	no-cs-readback;
+
+	irled at 0 {
+		compatible = "ir-spi-led";
+		reg = <0x0>;
+		spi-max-frequency = <5000000>;
+		power-supply = <&irda_regulator>;
+		duty-cycle = <60>;
+		led-active-low;
+
+		controller-data {
+			samsung,spi-feedback-delay = <0>;
+		};
+	};
+};
+
 &timer {
 	clock-frequency = <24000000>;
 };
-- 
2.11.0
