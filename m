From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  3 Dec 2014 15:37:34 +0100
Subject: [PATCH] [RFC] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
Message-ID: <1417617454-14533-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
MPCore.

Without this, there's no clocksource available during early kernel
initialization, before cmt1 is initialized, leading to a lock-up if
CONFIG_CPU_IDLE=y.

FIXME The clock should be the PERIPH clock, but the sh73a0 CPG driver
      doesn't have support for that clock yet. Hence we use the ZG
      clock, which runs at the same frequency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Unlike "arm,armv7-timer" (used on R-Car Gen2), "arm,cortex-a9-twd-time"
does require a clock, which is not documented in its bindings?
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index cca22ec59a2edd63..c53b19f40ae0977f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -11,6 +11,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/sh73a0-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -43,6 +44,13 @@
 		      <0xf0000100 0x100>;
 	};
 
+	timer at f0000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xf0000600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&cpg_clocks SH73A0_CLK_ZG>;	// FIXME CLK_PERIPH
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
