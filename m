From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:12 +0200
Subject: [PATCH 5/8] ARM: realview: add PL022 SSP/SPI block to PB1176 DTS
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PL022 SSP/SPI block to the PL1176 DTS file, also
define the separate SSPCLK clock derived from the 24MHz
chrystal.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 0e5b608ab9db..313a71756a18 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -56,6 +56,14 @@
 		clocks = <&xtal24mhz>;
 	};
 
+	sspclk: sspclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
 	uartclk: uartclk at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -218,6 +226,15 @@
 			clock-names = "apb_pclk";
 		};
 
+		pb1176_ssp: ssp at 1010b000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x1010b000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sspclk>, <&pclk>;
+			clock-names = "SSPCLK", "apb_pclk";
+		};
+
 		pb1176_serial0: serial at 1010c000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x1010c000 0x1000>;
-- 
1.9.3
