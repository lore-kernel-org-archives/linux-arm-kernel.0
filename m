From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:51 -0700
Subject: [PATCH 4/9] ARM: Update the device trees for 2836.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus address for peripherals comes from the platform.h diff between
2708 and 2709, and the CPU's DT definition is based on the 2709 DT.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts |  6 +++---
 arch/arm/boot/dts/bcm2836-rpi.dtsi    |  2 +-
 arch/arm/boot/dts/bcm2836.dtsi        | 22 +++++++++++++++++-----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 668442b..006d9c9 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -1,9 +1,9 @@
 /dts-v1/;
-#include "bcm2835-rpi.dtsi"
+#include "bcm2836-rpi.dtsi"
 
 / {
-	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
-	model = "Raspberry Pi Model B+";
+	compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
+	model = "Raspberry Pi 2 Model B";
 
 	leds {
 		act {
diff --git a/arch/arm/boot/dts/bcm2836-rpi.dtsi b/arch/arm/boot/dts/bcm2836-rpi.dtsi
index 46780bb..b866911 100644
--- a/arch/arm/boot/dts/bcm2836-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2836-rpi.dtsi
@@ -1,4 +1,4 @@
-#include "bcm2835.dtsi"
+#include "bcm2836.dtsi"
 
 / {
 	memory {
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index bdf9993..2e88138 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -3,8 +3,8 @@
 #include "bcm283x-common.dtsi"
 
 / {
-	compatible = "brcm,bcm2835";
-	model = "BCM2835";
+	compatible = "brcm,bcm2836";
+	model = "BCM2836";
 	interrupt-parent = <&intc>;
 
 	chosen {
@@ -15,7 +15,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x7e000000 0x20000000 0x02000000>;
+		ranges = <0x7e000000 0x3f000000 0x01000000>;
 
 		timer at 7e003000 {
 			compatible = "brcm,bcm2835-system-timer";
@@ -23,9 +23,21 @@
 			interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
 			clock-frequency = <1000000>;
 		};
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		arm-pmu {
-			compatible = "arm,arm1176-pmu";
+		v7_cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf00>;
+			clock-frequency = <800000000>;
 		};
 	};
+
+	__overrides__ {
+		arm_freq = <&v7_cpu0>, "clock-frequency:0";
+	};
 };
-- 
2.1.4
