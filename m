From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 5 Aug 2013 17:02:37 -0500
Subject: [RESEND PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
Message-ID: <1375740158-10012-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

"dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
DW APB timer, just fed by different clocks.

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
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/rtc/dw-apb.txt |   21 +++----------------
 arch/arm/boot/dts/rk3066a.dtsi                   |    6 +++---
 arch/arm/boot/dts/socfpga.dtsi                   |   24 +++++++++++-----------
 arch/arm/boot/dts/socfpga_cyclone5.dts           |    8 ++++----
 arch/arm/boot/dts/socfpga_vt.dts                 |    8 ++++----
 5 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
index eb2327b..0a1020e 100644
--- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -1,7 +1,7 @@
 * Designware APB timer
 
 Required properties:
-- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- compatible: "snps,dw-apb-timer"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: IRQ line for the timer.
@@ -20,23 +20,8 @@ systems may use one.
 
 
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
+		timer1: timer at ffe00000 {
+				compatible = "snps,dw-apb-timer";
 				interrupts = <0 170 4>;
 				reg = <0xffe00000 0x1000>;
 				clocks = <&timer_clk>, <&timer_pclk>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 56bfac9..2dff468 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -71,7 +71,7 @@
 		};
 
 		timer at 20038000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			reg = <0x20038000 0x100>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_gates1 0>, <&clk_gates7 7>;
@@ -79,7 +79,7 @@
 		};
 
 		timer at 2003a000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			reg = <0x2003a000 0x100>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_gates1 1>, <&clk_gates7 8>;
@@ -87,7 +87,7 @@
 		};
 
 		timer at 2000e000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			reg = <0x2000e000 0x100>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_gates1 2>, <&clk_gates7 9>;
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 93ee655..4e8291b 100644
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
+		timer0: timer at ffc08000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 167 4>;
 			reg = <0xffc08000 0x1000>;
+			clocks = <&osc>;
 		};
 
-		timer1: timer1 at ffc09000 {
-			compatible = "snps,dw-apb-timer-sp";
+		timer1: timer at ffc09000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 168 4>;
 			reg = <0xffc09000 0x1000>;
+			clocks = <&osc>;
 		};
 
-		timer2: timer2 at ffd00000 {
-			compatible = "snps,dw-apb-timer-osc";
+		timer2: timer at ffd00000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 169 4>;
 			reg = <0xffd00000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
-		timer3: timer3 at ffd01000 {
-			compatible = "snps,dw-apb-timer-osc";
+		timer3: timer at ffd01000 {
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 170 4>;
 			reg = <0xffd01000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		uart0: serial0 at ffc02000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 102c4d8..54b8483 100644
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
index d93deb0..6a1d8b7 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -58,19 +58,19 @@
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
