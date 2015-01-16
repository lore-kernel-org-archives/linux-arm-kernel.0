From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 16 Jan 2015 12:08:48 +0100
Subject: [PATCH v2] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
Message-ID: <1421406528-26704-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
MPCore.

Without this, there's no clocksource available during early kernel
initialization, before cmt1 is initialized, leading to a lock-up if
CONFIG_CPU_IDLE=y.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As the TWD driver does not support DT without CCF, this should NOT be
applied to a branch that still has kzm9g-reference support, as this
would lead to another lock-up.
Hence the first choice "dt-for-v3.20" is NOT OK.
"sh73a0-multiplatform-for-v3.20" is OK.

v2:
  - The clock is twd_clk
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 121bbeba8f3f6695..9aa55d52b556b4b1 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -11,6 +11,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/sh73a0-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -37,6 +38,13 @@
 		};
 	};
 
+	timer at f0000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xf0000600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&twd_clk>;
+	};
+
 	gic: interrupt-controller at f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
