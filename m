From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:14 +0200
Subject: [PATCH 7/8] ARM: realview: add KMIs to the PB1176 DTS
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Keyboard Mouse Interface (KMI) blocks to the
PB1176 DTS file, and defines the special KMI clock derived
from the 24 MHz chrystal.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index ac4c1c850db2..c292295ac1e3 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -57,6 +57,14 @@
 		clocks = <&xtal24mhz>;
 	};
 
+	kmiclk: kmiclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
 	sspclk: sspclk at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -280,6 +288,24 @@
 		compatible = "simple-bus";
 		ranges;
 
+		fpga_kmi0: kmi at 10006000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x10006000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
+		};
+
+		fpga_kmi1: kmi at 10007000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x10007000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
+		};
+
 		fpga_charlcd: charlcd at 10008000 {
 			compatible = "arm,versatile-lcd";
 			reg = <0x10008000 0x1000>;
-- 
1.9.3
