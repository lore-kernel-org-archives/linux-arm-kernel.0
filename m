From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sun,  4 Oct 2015 21:58:48 +0300
Subject: [PATCH 3/3] ARM: dts: sun4i: Add AXP209 PMU regulators for pcDuino1/2
In-Reply-To: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <1443985128-23137-4-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows voltage-scaling with cpufreq-dt. The reliability of
voltage-scaling has been checked by reducing the voltage of all
operating points by 0.025V (for extra safety headroom) and running
libjpeg-turbo decoding tests on 5 pcDuino2 boards. It means that
the standard sun4i voltages should be perfectly fine too.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts | 35 +++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index c9b9330..55714d0 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -104,6 +104,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -129,12 +133,8 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
 	};
 };
 
@@ -191,6 +191,33 @@
 	};
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.4.9
