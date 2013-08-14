From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 14 Aug 2013 18:29:15 -0500
Subject: [PATCHv2 1/2] ARM: dts: Change dw-apb-timer-osc and dw-apb-timer-sp
 to just dw-apb-timer
Message-ID: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

"dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
DW APB timer, just fed by different clocks. Thus, deprecate both
"dw-apb-timer-osc" and "dw-apb-timer-sp" in lieu of "dw-apb-timer",

Clean up the timer entries for socfpga by removing timer<n> and set the
correct clocks for the timers.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
CC: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Jamie Iles <jamie@jamieiles.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Pavel Machek <pavel@denx.de>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

v2:
- Deprecate the "dw-apb-timer-osc" and "dw-apb-timer-sp" but maintain
  backwards compatibility in the driver.
---
 Documentation/devicetree/bindings/rtc/dw-apb.txt |   32 ++++++----------------
 arch/arm/boot/dts/socfpga.dtsi                   |   24 ++++++++--------
 arch/arm/boot/dts/socfpga_cyclone5.dts           |    8 +++---
 arch/arm/boot/dts/socfpga_vt.dts                 |    8 +++---
 4 files changed, 29 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
index eb2327b..38060c5 100644
--- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -1,7 +1,8 @@
 * Designware APB timer
 
 Required properties:
-- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc" <DEPRECATED>
+- compatible: "snps,dw-apb-timer"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: IRQ line for the timer.
@@ -20,25 +21,10 @@ systems may use one.
 
 
 Example:
-
-		timer1: timer at ffc09000 {
-				compatible = "snps,dw-apb-timer-sp";
-				interrupts = <0 168 4>;
-				clock-frequency = <200000000>;
-				reg = <0xffc09000 0x1000>;
-			};
-
-		timer2: timer at ffd00000 {
-				compatible = "snps,dw-apb-timer-osc";
-				interrupts = <0 169 4>;
-				clock-frequency = <200000000>;
-				reg = <0xffd00000 0x1000>;
-			};
-
-		timer3: timer at ffe00000 {
-				compatible = "snps,dw-apb-timer-osc";
-				interrupts = <0 170 4>;
-				reg = <0xffe00000 0x1000>;
-				clocks = <&timer_clk>, <&timer_pclk>;
-				clock-names = "timer", "pclk";
-			};
+	timer at ffe00000 {
+		compatible = "snps,dw-apb-timer";
+		interrupts = <0 170 4>;
+		reg = <0xffe00000 0x1000>;
+		clocks = <&timer_clk>, <&timer_pclk>;
+		clock-names = "timer", "pclk";
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9706767..03845cb 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -26,10 +26,6 @@
 		ethernet1 = &gmac1;
 		serial0 = &uart0;
 		serial1 = &uart1;
-		timer0 = &timer0;
-		timer1 = &timer1;
-		timer2 = &timer2;
-		timer3 = &timer3;
 	};
 
 	cpus {
@@ -486,28 +482,32 @@
 			interrupts = <1 13 0xf04>;
 		};
 
-		timer0: timer0 at ffc08000 {
-			compatible = "snps,dw-apb-timer-sp";
+		timer at ffc08000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 167 4>;
 			reg = <0xffc08000 0x1000>;
+			clocks = <&osc>;
 		};
 
-		timer1: timer1 at ffc09000 {
-			compatible = "snps,dw-apb-timer-sp";
+		timer at ffc09000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 168 4>;
 			reg = <0xffc09000 0x1000>;
+			clocks = <&osc>;
 		};
 
-		timer2: timer2 at ffd00000 {
-			compatible = "snps,dw-apb-timer-osc";
+		timer at ffd00000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 169 4>;
 			reg = <0xffd00000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
-		timer3: timer3 at ffd01000 {
-			compatible = "snps,dw-apb-timer-osc";
+		timer at ffd01000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 170 4>;
 			reg = <0xffd01000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		uart0: serial0 at ffc02000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 698dde9..c1af01c 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -67,19 +67,19 @@
 			};
 		};
 
-		timer0 at ffc08000 {
+		timer at ffc08000 {
 			clock-frequency = <100000000>;
 		};
 
-		timer1 at ffc09000 {
+		timer at ffc09000 {
 			clock-frequency = <100000000>;
 		};
 
-		timer2 at ffd00000 {
+		timer at ffd00000 {
 			clock-frequency = <25000000>;
 		};
 
-		timer3 at ffd01000 {
+		timer at ffd01000 {
 			clock-frequency = <25000000>;
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 6f23121..72ff14c 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -57,19 +57,19 @@
 			};
 		};
 
-		timer0 at ffc08000 {
+		timer at ffc08000 {
 			clock-frequency = <7000000>;
 		};
 
-		timer1 at ffc09000 {
+		timer at ffc09000 {
 			clock-frequency = <7000000>;
 		};
 
-		timer2 at ffd00000 {
+		timer at ffd00000 {
 			clock-frequency = <7000000>;
 		};
 
-		timer3 at ffd01000 {
+		timer at ffd01000 {
 			clock-frequency = <7000000>;
 		};
 
-- 
1.7.9.5
