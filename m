From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:18:30 +0900
Subject: [PATCH 3/9] ARM: dts: uniphier: rework UniPhier System Bus nodes
In-Reply-To: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456471116-8140-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review process of the UniPhier System Bus driver
(drivers/bus/uniphier.c), the current binding of the System Bus
Controller turned out to be no good.  In order to make the driver
really usable, we have to switch over to the new binding defined by
Documentation/devicetree/bindings/bus/uniphier-system-bus.txt.
The old binding will be still supported for a while to keep the
backward compatibility.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi             | 20 +++++++++++---------
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi             | 20 +++++++++++---------
 arch/arm/boot/dts/uniphier-support-card.dtsi         |  3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 19 +++++++++++++------
 4 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
index ea9301a..f847e68 100644
--- a/arch/arm/boot/dts/uniphier-common32.dtsi
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -52,12 +52,6 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -98,9 +92,17 @@
 			clocks = <&uart_clk>;
 		};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			status = "disabled";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
 		};
 
 		timer at 60000200 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 691a17d..4c746ea 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -94,12 +94,6 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		timer at 20000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20000200 0x20>;
@@ -216,9 +210,17 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			status = "disabled";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
 		};
 
 		usb0: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index fa807e8..51ecc9b9 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -42,7 +42,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-&extbus {
+&system_bus {
+	status = "okay";
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 
 	support_card: support_card {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index e6871ea..e682a3f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -133,12 +133,6 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -261,6 +255,19 @@
 			clock-frequency = <400000>;
 		};
 
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			status = "disabled";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
+		};
+
 		pinctrl: pinctrl at 5f801000 {
 			compatible = "socionext,ph1-ld20-pinctrl", "syscon";
 			reg = <0x5f801000 0xe00>;
-- 
1.9.1
