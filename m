From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:29:53 +0200
Subject: [PATCH 2/4] arm: dts: lpc32xx: extend description of gpio controller
 node
In-Reply-To: <1447982995-30231-1-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
Message-ID: <1447982995-30231-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds detailed description of NXP LPC32xx GPIO controller
node.

Note, in future possibly P0 and P1 banks can be converted to interrupt
controllers, but this requires pinmux configuration, which is missing
at the moment.

The change does not affect any GPIO controller clients.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 85 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 603f005..9153654 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -398,11 +398,94 @@
 				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
-			gpio: gpio at 40028000 {
+			gpio: gpio-controller at 40028000 {
 				compatible = "nxp,lpc3220-gpio";
 				reg = <0x40028000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <3>; /* bank, pin, flags */
+
+				ranges = <0 0x0 0x40028000 0x00001000>,
+					 <1 0x0 0x40028000 0x00001000>,
+					 <2 0x0 0x40028000 0x00001000>,
+					 <3 0x0 0x40028000 0x00001000>,
+					 <4 0x0 0x40028000 0x00001000>,
+					 <5 0x0 0x40028000 0x00001000>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+
+				gpio_p0: gpio-controller at 0 {
+					reg = <0 0x40 0x1C>;
+					gpio-bank-name = "p0";
+					gpios = <8>;
+
+					interrupt-parent = <&sic2>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				gpio_p1: gpio-controller at 1 {
+					reg = <1 0x60 0x1C>;
+					gpio-bank-name = "p1";
+					gpios = <24>;
+
+					interrupt-parent = <&sic2>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				gpio_p2: gpio-controller at 2 {
+					reg = <2 0x10 0x18>;
+					gpio-bank-name = "p2";
+					gpios = <13>;
+					gpio-no-output-state;
+				};
+
+				gpio_gpio: gpio-controller at 3 {
+					reg = <3 0x00 0x1C>;
+					gpio-bank-name = "gpio";
+					gpio-offset = <25>;
+					gpio-input-mask = <0x01007c00>, <0x01007c00>;
+
+					interrupt-parent = <&sic2>;
+					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+						     <1 IRQ_TYPE_LEVEL_HIGH>,
+						     <2 IRQ_TYPE_LEVEL_HIGH>,
+						     <3 IRQ_TYPE_LEVEL_HIGH>,
+						     <4 IRQ_TYPE_LEVEL_HIGH>,
+						     <5 IRQ_TYPE_LEVEL_HIGH>;
+
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio_gpi: gpio-controller at 4 {
+					reg = <4 0x00 0x04>;
+					gpio-bank-name = "gpi";
+					gpio-input-only;
+					gpio-input-mask = <0x1aff83ff>, <0x100803ff>;
+
+					interrupts-extended =
+						<&sic2 22 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 23 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 24 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 25 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 26 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 27 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 28 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 15 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2  9 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 10 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic2 11 IRQ_TYPE_LEVEL_HIGH>,
+						<&sic1  4 IRQ_TYPE_LEVEL_HIGH>;
+
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio_gpo: gpio-controller at 5 {
+					reg = <5 0x00 0x10>;
+					gpio-bank-name = "gpo";
+					gpios = <24>;
+					gpio-output-only;
+				};
 			};
 
 			timer4: timer at 4002C000 {
-- 
2.1.4
