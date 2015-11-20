From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:41 +0200
Subject: [PATCH 06/10] arm: dts: lpc32xx: add description of IC wakeup
 controllers
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-7-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds System Control Block simple bus device tree node and
populates it with two first subdevices, wakeup controllers connected
to LPC32xx interrupt controllers MIC, SIC1 and SIC2.

The change also assigns a name to MIC controller and set its wakeup
sources.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index fbf1984b..b2735dd 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -295,6 +295,18 @@
 					clocks = <&xtal_32k>, <&xtal>;
 					clock-names = "xtal_32k", "xtal";
 				};
+
+				wakeup_int: wakeup-controller at 20 {
+					compatible = "nxp,lpc3220-wakeup";
+					reg = <0x20 0x10>;
+					#wakeup-cells = <2>;
+				};
+
+				wakeup_pin: wakeup-controller at 30 {
+					compatible = "nxp,lpc3220-wakeup";
+					reg = <0x30 0x10>;
+					#wakeup-cells = <2>;
+				};
 			};
 
 			/*
@@ -305,9 +317,13 @@
 			 */
 			mic: interrupt-controller at 40008000 {
 				compatible = "nxp,lpc3220-mic";
-				interrupt-controller;
 				reg = <0x40008000 0xC000>;
+				interrupt-controller;
+				interrupt-controller-name = "mic";
 				#interrupt-cells = <2>;
+
+				wakeup-sources = <&wakeup_int 7 29>,
+						 <&wakeup_int 25 27>;
 			};
 
 			uart1: serial at 40014000 {
-- 
2.1.4
