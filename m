From: howard.chen@linaro.org (Howard Chen)
Date: Tue,  6 Jan 2015 16:42:30 +0800
Subject: [PATCH 1/2] Add sysirq device node for mt6592,
 also correct the timer interrupt.
Message-ID: <1420533751-23999-1-git-send-email-howard.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Howard Chen <howard.chen@linaro.org>
---
 arch/arm/boot/dts/mt6592.dtsi | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
index 31e5a09..1db453f 100644
--- a/arch/arm/boot/dts/mt6592.dtsi
+++ b/arch/arm/boot/dts/mt6592.dtsi
@@ -18,7 +18,7 @@
 
 / {
 	compatible = "mediatek,mt6592";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&sysirq>;
 
 	cpus {
 		#address-cells = <1>;
@@ -78,21 +78,34 @@
 		#clock-cells = <0>;
 	};
 
+	uart_clk: uart_clk {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
 	timer: timer at 10008000 {
 		compatible = "mediatek,mt6577-timer";
 		reg = <0x10008000 0x80>;
-		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&system_clk>, <&rtc_clk>;
 		clock-names = "system-clk", "rtc-clk";
 	};
 
+	sysirq: interrupt-controller at 10200220 {
+		compatible = "mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0x10200220 0x1c>;
+	};
+
 	gic: interrupt-controller at 10211000 {
 		compatible = "arm,cortex-a7-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 		reg = <0x10211000 0x1000>,
 		      <0x10212000 0x1000>;
 	};
-
 };
-
-- 
1.9.1
