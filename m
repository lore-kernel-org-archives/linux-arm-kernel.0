From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Feb 2014 21:09:33 +0100
Subject: [PATCH v5 6/7] ARM: dt: add clock data for s3c2416
In-Reply-To: <2678040.KALsQ0bZFm@phil>
References: <2678040.KALsQ0bZFm@phil>
Message-ID: <2730351.Rbk38HtDO7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock controller itself, the xti clock on the smdk2416
as well as the clock references in the individual device nodes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 13 +++++++++++
 arch/arm/boot/dts/s3c2416.dtsi         | 42 ++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index 59594cf..ea92fd6 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -19,6 +19,19 @@
 		reg =  <0x30000000 0x4000000>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		xti: xti {
+			compatible = "fixed-clock";
+			clock-frequency = <12000000>;
+			clock-output-names = "xti";
+			#clock-cells = <0>;
+		};
+	};
+
 	serial at 50000000 {
 		status = "okay";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index e6555bd..955e4a4 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/clock/s3c2443.h>
 #include "s3c24xx.dtsi"
 #include "s3c2416-pinctrl.dtsi"
 
@@ -28,26 +29,53 @@
 		compatible = "samsung,s3c2416-irq";
 	};
 
+	clocks: clock-controller at 0x4c000000 {
+		compatible = "samsung,s3c2416-clock";
+		reg = <0x4c000000 0x40>;
+		#clock-cells = <1>;
+	};
+
 	pinctrl at 56000000 {
 		compatible = "samsung,s3c2416-pinctrl";
 	};
 
+	timer at 51000000 {
+		clocks = <&clocks PCLK_PWM>;
+		clock-names = "timers";
+	};
+
 	serial at 50000000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 50004000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 50008000 {
 		compatible = "samsung,s3c2440-uart";
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART2>, <&clocks PCLK_UART2>,
+				<&clocks SCLK_UART>;
 	};
 
 	serial at 5000C000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
 		interrupts = <1 18 24 4>, <1 18 25 4>;
+		clock-names = "uart", "clk_uart_baud2",
+				"clk_uart_baud3";
+		clocks = <&clocks PCLK_UART3>, <&clocks PCLK_UART3>,
+				<&clocks SCLK_UART>;
 		status = "disabled";
 	};
 
@@ -55,6 +83,10 @@
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4AC00000 0x100>;
 		interrupts = <0 0 21 3>;
+		clock-names = "hsmmc", "mmc_busclk.0",
+				"mmc_busclk.2";
+		clocks = <&clocks HCLK_HSMMC0>, <&clocks HCLK_HSMMC0>,
+				<&clocks MUX_HSMMC0>;
 		status = "disabled";
 	};
 
@@ -62,18 +94,28 @@
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4A800000 0x100>;
 		interrupts = <0 0 20 3>;
+		clock-names = "hsmmc", "mmc_busclk.0",
+				"mmc_busclk.2";
+		clocks = <&clocks HCLK_HSMMC1>, <&clocks HCLK_HSMMC1>,
+				<&clocks MUX_HSMMC1>;
 		status = "disabled";
 	};
 
 	watchdog at 53000000 {
 		interrupts = <1 9 27 3>;
+		clocks = <&clocks PCLK_WDT>;
+		clock-names = "watchdog";
 	};
 
 	rtc at 57000000 {
 		compatible = "samsung,s3c2416-rtc";
+		clocks = <&clocks PCLK_RTC>;
+		clock-names = "rtc";
 	};
 
 	i2c at 54000000 {
 		compatible = "samsung,s3c2440-i2c";
+		clocks = <&clocks PCLK_I2C0>;
+		clock-names = "i2c";
 	};
 };
-- 
1.8.5.3
