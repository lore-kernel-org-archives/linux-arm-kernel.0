From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 18:32:06 +0000
Subject: [PATCH] Revert "ARM: dove: dt: revert PMU interrupt controller node"
Message-ID: <1393093926-16591-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit ae10f8329f9b22d650aa12307b260eba2bc0c571.

The driver for this node didn't make it into v3.14, but will be in
v3.15.  So we can add the node back.

Despite what ae10f8329f9b says, the node without the driver generated a
WARN_ON, but the affected systems still booted.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
RESEND:  Apparently I don't learn from previous mistakes.  Fixed Andrew's email
address so lakml will accept it.

 arch/arm/boot/dts/dove.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 644b1f40cb30..a88ed73c1c86 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -387,6 +387,15 @@
 				#clock-cells = <1>;
 			};
 
+			pmu_intc: pmu-interrupt-ctrl at d0050 {
+				compatible = "marvell,dove-pmu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xd0050 0x8>;
+				interrupts = <33>;
+				marvell,#interrupts = <7>;
+			};
+
 			pinctrl: pin-ctrl at d0200 {
 				compatible = "marvell,dove-pinctrl";
 				reg = <0xd0200 0x10>;
@@ -609,6 +618,8 @@
 			rtc: real-time-clock at d8500 {
 				compatible = "marvell,orion-rtc";
 				reg = <0xd8500 0x20>;
+				interrupt-parent = <&pmu_intc>;
+				interrupts = <5>;
 			};
 
 			gpio2: gpio-ctrl at e8400 {
-- 
1.9.0
