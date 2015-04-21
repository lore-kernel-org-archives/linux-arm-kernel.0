From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:56 -0700
Subject: [PATCH 9/9] ARM: BCM283x: Register fixed clocks for uart in the DT.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-10-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were previously relying on the fixed clock registration in
clk-bcm2835, but there doesn't seem to be any real reason to not just
define it in the DT (and for the 2836 port, I would have needed to
change the clock's physical address in clk-bcm2835.c).  Also, because
we weren't registering the apb_pclk in clk-bcm2835 as a clock device,
we were picking up the uart clock node as apb_pclk by accident.

This gets serial working on 2836.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x-common.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x-common.dtsi b/arch/arm/boot/dts/bcm283x-common.dtsi
index c15e309..2ce6661 100644
--- a/arch/arm/boot/dts/bcm283x-common.dtsi
+++ b/arch/arm/boot/dts/bcm283x-common.dtsi
@@ -67,8 +67,9 @@
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-			clock-frequency = <3000000>;
 			arm,primecell-periphid = <0x00241011>;
+			clocks = <&uart0_clk>, <&apb_pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		i2s: i2s at 7e203000 {
@@ -155,5 +156,19 @@
 			clock-output-names = "spi";
 			clock-frequency = <250000000>;
 		};
+
+		apb_pclk: apb_pclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "apb_pclk";
+			clock-frequency = <126000000>;
+		};
+
+		uart0_clk: uart0_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "uart0_clk";
+			clock-frequency = <3000000>;
+		};
 	};
 };
-- 
2.1.4
