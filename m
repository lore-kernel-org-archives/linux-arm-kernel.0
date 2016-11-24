From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 25 Nov 2016 01:12:16 +0300
Subject: [PATCH] dt-bindings: document how to setup rockchip timers as
 clocksource
Message-ID: <1480025536-6837-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch describes how to setup rockchip timers in device tree
so they can be used as clocksource.

I'm going to implement this feature.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 .../bindings/timer/rockchip,rk-timer.txt           |   35 +++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index 7bc9691..15f8fed 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -16,7 +16,18 @@ Required properties:
 - clock-names : must include the following entries:
   "timer", "pclk"
 
-Example:
+Note:
+If device tree contain only one timer, than the timer will be intialized
+as clockevent provider. If device tree contain two timers, than first timer
+will be initialized as clockevent provider and second one as clocksource.
+
+If you want to bind specific timer as clockevent (i.e. one from alive subsystem)
+and specific timer as clocksource, you can number the timers in "aliases" node.
+
+If device tree contain only one timer and the timer is named as timer1 in
+"aliases" node, then the timer will be initialized as clocksource.
+
+Example (clockevent only):
 	timer: timer at ff810000 {
 		compatible = "rockchip,rk3288-timer";
 		reg = <0xff810000 0x20>;
@@ -24,3 +35,25 @@ Example:
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
 		clock-names = "timer", "pclk";
 	};
+
+Example (clockevent and clocksource with explicit numbering):
+	aliases {
+		timer0 = &timer6;
+		timer1 = &timer5;
+	};
+
+	timer5: timer at 20038080 {
+		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
+		reg = <0x20038080 0x20>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER5>, <&cru PCLK_TIMER0>;
+		clock-names = "timer", "pclk";
+	};
+
+	timer6: timer at 200380A0 {
+		compatible = ""rockchip,rk3188-timer", rockchip,rk3288-timer";
+		reg = <0x200380A0 0x20>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER6>, <&cru PCLK_TIMER0>;
+		clock-names = "timer", "pclk";
+	};
-- 
1.7.9.5
