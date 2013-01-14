From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 14 Jan 2013 15:04:18 +1300
Subject: [PATCH 3/4] serial: vt8500: UART uses gated clock rather than 24Mhz
 reference
In-Reply-To: <1358129060-9399-1-git-send-email-linux@prisktech.co.nz>
References: <1358129060-9399-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358129060-9399-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART modules on Wondermedia SoCs are connected via a gated clock
source, rather than directly to the 24Mhz reference clock. While
uboot enables UART0 for debugging, other UART ports are unavailable
until the clock is enabled.

This patch checks that a valid clock is actually passed from devicetree,
enables the clock in probe. This change removes the fallback when a
clock was not specified as it doesn't apply any longer (and would only
work if the UART clock was already enabled).

DTSI files are updated for VT8500, WM8505 and WM8650.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500.dtsi      |   40 +++++++++++++++++++++---
 arch/arm/boot/dts/wm8505.dtsi      |   60 ++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/wm8650.dtsi      |   20 ++++++++++--
 drivers/tty/serial/vt8500_serial.c |   17 ++++++----
 4 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index d8645e9..cf31ced 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -45,6 +45,38 @@
 					compatible = "fixed-clock";
 					clock-frequency = <24000000>;
 				};
+
+				clkuart0: uart0 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <1>;
+				};
+
+				clkuart1: uart1 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <2>;
+				};
+
+				clkuart2: uart2 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <3>;
+				};
+
+				clkuart3: uart3 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <4>;
+				};
 			};
 		};
 
@@ -83,28 +115,28 @@
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
-			clocks = <&ref24>;
+			clocks = <&clkuart0>;
 		};
 
 		uart at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
-			clocks = <&ref24>;
+			clocks = <&clkuart1>;
 		};
 
 		uart at d8210000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8210000 0x1040>;
 			interrupts = <47>;
-			clocks = <&ref24>;
+			clocks = <&clkuart2>;
 		};
 
 		uart at d82c0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82c0000 0x1040>;
 			interrupts = <50>;
-			clocks = <&ref24>;
+			clocks = <&clkuart3>;
 		};
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index 330f833..e74a1c0 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -59,6 +59,54 @@
 					compatible = "fixed-clock";
 					clock-frequency = <24000000>;
 				};
+
+				clkuart0: uart0 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <1>;
+				};
+
+				clkuart1: uart1 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <2>;
+				};
+
+				clkuart2: uart2 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <3>;
+				};
+
+				clkuart3: uart3 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <4>;
+				};
+
+				clkuart4: uart4 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <22>;
+				};
+
+				clkuart5: uart5 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -96,42 +144,42 @@
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
-			clocks = <&ref24>;
+			clocks = <&clkuart0>;
 		};
 
 		uart at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
-			clocks = <&ref24>;
+			clocks = <&clkuart1>;
 		};
 
 		uart at d8210000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8210000 0x1040>;
 			interrupts = <47>;
-			clocks = <&ref24>;
+			clocks = <&clkuart2>;
 		};
 
 		uart at d82c0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82c0000 0x1040>;
 			interrupts = <50>;
-			clocks = <&ref24>;
+			clocks = <&clkuart3>;
 		};
 
 		uart at d8370000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8370000 0x1040>;
 			interrupts = <31>;
-			clocks = <&ref24>;
+			clocks = <&clkuart4>;
 		};
 
 		uart at d8380000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd8380000 0x1040>;
 			interrupts = <30>;
-			clocks = <&ref24>;
+			clocks = <&clkuart5>;
 		};
 
 		rtc at d8100000 {
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index 83b9467..e0c42ff 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -75,6 +75,22 @@
 					reg = <0x204>;
 				};
 
+				clkuart0: uart0 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <1>;
+				};
+
+				clkuart1: uart1 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x250>;
+					enable-bit = <2>;
+				};
+
 				arm: arm {
 					#clock-cells = <0>;
 					compatible = "via,vt8500-device-clock";
@@ -128,14 +144,14 @@
 			compatible = "via,vt8500-uart";
 			reg = <0xd8200000 0x1040>;
 			interrupts = <32>;
-			clocks = <&ref24>;
+			clocks = <&clkuart0>;
 		};
 
 		uart at d82b0000 {
 			compatible = "via,vt8500-uart";
 			reg = <0xd82b0000 0x1040>;
 			interrupts = <33>;
-			clocks = <&ref24>;
+			clocks = <&clkuart1>;
 		};
 
 		rtc at d8100000 {
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 8865afd..7de279a 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -604,12 +604,16 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 
 	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (vt8500_port->clk) {
-		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
-	} else {
-		/* use the default of 24Mhz if not specified and warn */
-		pr_warn("%s: serial clock source not specified\n", __func__);
-		vt8500_port->uart.uartclk = 24000000;
+	if (IS_ERR(vt8500_port->clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = clk_prepare_enable(vt8500_port->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		goto err;
 	}
 
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
@@ -639,6 +643,7 @@ static int vt8500_serial_remove(struct platform_device *pdev)
 	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
+	clk_disable_unprepare(vt8500_port->clk);
 	uart_remove_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 	kfree(vt8500_port);
 
-- 
1.7.9.5
