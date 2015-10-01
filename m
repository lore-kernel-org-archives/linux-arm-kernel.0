From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 30 Sep 2015 18:19:48 -0700
Subject: [PATCH v2] arm64: dts: add all hi6220 uart nodes
Message-ID: <1443662388-25686-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds all UART nodes for the Hi6220 SoC. Recently a board[1] has
been developed to standardize UART access across all the 96boards consumer
edition boards. To use this hardware on HiKey we must configure and enable
UART3. However, to ensure backward compatibility we must keep UART0 enabled
as well.

I have removed the hard coded clock index values in favor of using the ones
already defined in include/dt-bindings/clock/hi6220-clock.h.

Since UART0 needs to be soldered, it has been suggested to use the UART3 as
the default console.

This patch was boot tested on top of next-20150930, with both UART
configurations.

[1] http://www.seeedstudio.com/depot/96Boards-UART-p-2525.html?ref=newInBazaar

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
In v2:
  - Drop unused alias, and add comments. (Arnd, Rob)
  - Switch default console to use UART3 with stdout-path. (Mark, Rob)

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |  7 +++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 43 +++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e36a539..aa101ac 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -17,11 +17,14 @@
 	compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
 
 	aliases {
-		serial0 = &uart0;
+		serial0 = &uart0; /* On board UART0 */
+		serial1 = &uart1; /* BT UART */
+		serial2 = &uart2; /* LS Expansion UART0 */
+		serial3 = &uart3; /* LS Expansion UART1 */
 	};
 
 	chosen {
-		stdout-path = "serial0:115200n8";
+		stdout-path = "serial3:115200n8";
 	};
 
 	memory at 0 {
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..82d2488 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/hi6220-clock.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -164,8 +165,48 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf8015000 0x0 0x1000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
+			clocks = <&ao_ctrl HI6220_UART0_PCLK>,
+				 <&ao_ctrl HI6220_UART0_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		uart1: uart at f7111000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xf7111000 0x0 0x1000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_UART1_PCLK>,
+				 <&sys_ctrl HI6220_UART1_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: uart at f7112000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xf7112000 0x0 0x1000>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_UART2_PCLK>,
+				 <&sys_ctrl HI6220_UART2_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart3: uart at f7113000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xf7113000 0x0 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_UART3_PCLK>,
+				 <&sys_ctrl HI6220_UART3_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart4: uart at f7114000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xf7114000 0x0 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_UART4_PCLK>,
+				 <&sys_ctrl HI6220_UART4_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
