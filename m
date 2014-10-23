From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 23 Oct 2014 23:53:14 +0800
Subject: [PATCH v4 6/7] ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127 dtsi
In-Reply-To: <1414079595-26129-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1414079595-26129-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1414079595-26129-7-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sysirq settings for mt6589/mt8135/mt8127
This also correct timer interrupt flag. The old flag setting
works because boot loader already set polarity for timer
interrupt. Without intpol support, the setting was not changed
so gic can get the irq correctly.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt6589.dtsi | 13 +++++++++++--
 arch/arm/boot/dts/mt8127.dtsi | 13 +++++++++++--
 arch/arm/boot/dts/mt8135.dtsi | 13 +++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index e3c7600..e7e7ddf 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -19,7 +19,7 @@
 
 / {
 	compatible = "mediatek,mt6589";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&sysirq>;
 
 	cpus {
 		#address-cells = <1>;
@@ -76,15 +76,24 @@
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		sysirq: interrupt-controller at 10200100 {
+			compatible = "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200100 0 0x1c>;
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a7-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
 			reg = <0x10211000 0x1000>,
 			      <0x10212000 0x1000>,
 			      <0x10214000 0x2000>,
diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
index 65d279d..adc6f2d 100644
--- a/arch/arm/boot/dts/mt8127.dtsi
+++ b/arch/arm/boot/dts/mt8127.dtsi
@@ -18,7 +18,7 @@
 
 / {
 	compatible = "mediatek,mt8127";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&sysirq>;
 
 	cpus {
 		#address-cells = <1>;
@@ -81,15 +81,24 @@
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8127-timer", "mediatek,mt6577-timer";
 			reg = <0 0x10008000 0 0x80>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		sysirq: interrupt-controller at 10200100 {
+			compatible = "mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200100 0 0x1c>;
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a7-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
 			reg = <0 0x10211000 0 0x1000>,
 			      <0 0x10212000 0 0x1000>,
 			      <0 0x10214000 0 0x2000>,
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index f89a4f5..9627320 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -18,7 +18,7 @@
 
 / {
 	compatible = "mediatek,mt8135";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&sysirq>;
 
 	cpu-map {
 		cluster0 {
@@ -103,15 +103,24 @@
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer", "mediatek,mt6577-timer";
 			reg = <0 0x10008000 0 0x80>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		sysirq: interrupt-controller at 10200030 {
+			compatible = "mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200030 0 0x1c>;
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
 			reg = <0 0x10211000 0 0x1000>,
 			      <0 0x10212000 0 0x1000>,
 			      <0 0x10214000 0 0x2000>,
-- 
1.8.1.1.dirty
