From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 22 Aug 2013 11:30:24 -0500
Subject: [PATCHv4 2/4] arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp
 to just dw-apb-timer
In-Reply-To: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
References: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
Message-ID: <1377189026-16656-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

"dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
DW APB timer, just fed by different clocks. Thus, deprecate both
"dw-apb-timer-osc" and "dw-apb-timer-sp" in lieu of "dw-apb-timer".

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

v3:
- Split out a separate that cleans up the timer entries and clock information.
- Clearly states which binding is deprecated in the bindingd doc.

v2:
- Deprecate the "dw-apb-timer-osc" and "dw-apb-timer-sp" but maintain
  backwards compatibility in the driver.
---
 Documentation/devicetree/bindings/rtc/dw-apb.txt |   34 +++++++---------------
 arch/arm/boot/dts/socfpga.dtsi                   |    8 ++---
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
index eb2327b..c703d51 100644
--- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -1,7 +1,10 @@
 * Designware APB timer
 
 Required properties:
-- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- compatible: One of:
+ 	"snps,dw-apb-timer"
+	"snps,dw-apb-timer-sp" <DEPRECATED>
+	"snps,dw-apb-timer-osc" <DEPRECATED>
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: IRQ line for the timer.
@@ -20,25 +23,10 @@ systems may use one.
 
 
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
index 2cb5cb7..d9fda91 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -472,28 +472,28 @@
 		};
 
 		timer at ffc08000 {
-			compatible = "snps,dw-apb-timer-sp";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 167 4>;
 			reg = <0xffc08000 0x1000>;
 			clocks = <&osc>;
 		};
 
 		timer at ffc09000 {
-			compatible = "snps,dw-apb-timer-sp";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 168 4>;
 			reg = <0xffc09000 0x1000>;
 			clocks = <&osc>;
 		};
 
 		timer at ffd00000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 169 4>;
 			reg = <0xffd00000 0x1000>;
 			clocks = <&l4_sp_clk>;
 		};
 
 		timer at ffd01000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 170 4>;
 			reg = <0xffd01000 0x1000>;
 			clocks = <&l4_sp_clk>;
-- 
1.7.9.5
