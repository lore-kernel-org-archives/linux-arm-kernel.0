From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Jun 2017 20:33:41 +0200
Subject: [PATCH 3/3] ARM: dts: meson8: add and use the real clock controller
In-Reply-To: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170604183341.21417-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the dummy clk81 gate and replaces it with the actual clock
controller's CLKID_CLK81. This will also allow us to pass the real clock
IDs to all devices where the clock is controlled by clkc in the future.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 6993077331c7..9b0b3ddbb17e 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -43,6 +43,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
 /include/ "meson.dtsi"
 
@@ -82,13 +83,6 @@
 			reg = <0x203>;
 		};
 	};
-
-	clk81: clk at 0 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <141666666>;
-	};
-
 }; /* end of / */
 
 &aobus {
@@ -126,6 +120,12 @@
 };
 
 &cbus {
+	clkc: clock-controller at 4000 {
+		#clock-cells = <1>;
+		compatible = "amlogic,meson8-clkc";
+		reg = <0x8000 0x4>, <0x4000 0x460>;
+	};
+
 	pinctrl_cbus: pinctrl at 9880 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
 		reg = <0x9880 0x10>;
@@ -172,20 +172,20 @@
 };
 
 &ethmac {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 	clock-names = "stmmaceth";
 };
 
 &i2c_AO {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &i2c_A {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &i2c_B {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &L2 {
@@ -195,21 +195,21 @@
 };
 
 &spifc {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &uart_AO {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &uart_A {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &uart_B {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
 
 &uart_C {
-	clocks = <&clk81>;
+	clocks = <&clkc CLKID_CLK81>;
 };
-- 
2.13.0
