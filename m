From: slash.tmp@free.fr (Mason)
Date: Mon, 2 May 2016 16:33:17 +0200
Subject: [PATCH] ARM: dts: tango4: Update device tree
Message-ID: <5727652D.9020900@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Match device tree with latest clock driver.
Update cpus node for cpufreq.
Import watchdog node.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
This patch applies on top of the thermal DT changes.
[PATCH v8 2/2] ARM: dts: tango4: Initial thermal support
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm/boot/dts/tango4-common.dtsi      | 16 ++++++++++++----
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  5 ++++-
 arch/arm/boot/dts/tango4-vantage-1172.dts |  1 -
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index ef665d21d317..dd7eb5f624d9 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -3,11 +3,13 @@
  * https://github.com/mansr/linux-tangox
  */
 
-#define CPU_CLK 0
-#define SYS_CLK 1
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#define  CPU_CLK	0
+#define  SYS_CLK	1
+#define  USB_CLK	2
+#define SDIO_CLK	3
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
@@ -70,7 +72,7 @@
 
 		clkgen: clkgen at 10000 {
 			compatible = "sigma,tango4-clkgen";
-			reg = <0x10000 0x40>;
+			reg = <0x10000 0x100>;
 			clocks = <&xtal>;
 			#clock-cells = <1>;
 		};
@@ -89,6 +91,12 @@
 			reg-shift = <2>;
 		};
 
+		watchdog at 1fd00 {
+			compatible = "sigma,smp8759-wdt";
+			reg = <0x1fd00 8>;
+			clocks = <&xtal>;
+		};
+
 		eth0: ethernet at 26000 {
 			compatible = "sigma,smp8734-ethernet";
 			reg = <0x26000 0x800>;
diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
index 01d5f8f1c71d..d2e65c46bcc7 100644
--- a/arch/arm/boot/dts/tango4-smp8758.dtsi
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -1,4 +1,4 @@
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "tango4-common.dtsi"
 
 / {
 	cpus {
@@ -11,6 +11,9 @@
 			next-level-cache = <&l2cc>;
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&clkgen CPU_CLK>;
+			clock-latency = <1>;
+			operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
 		};
 
 		cpu1: cpu at 1 {
diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
index 3e5b9c81a51c..4cab64cb581e 100644
--- a/arch/arm/boot/dts/tango4-vantage-1172.dts
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -1,7 +1,6 @@
 /dts-v1/;
 
 #include "tango4-smp8758.dtsi"
-#include "tango4-common.dtsi"
 
 / {
 	model = "Sigma Designs SMP8758 Vantage-1172 Rev E1";
-- 
2.8.1
