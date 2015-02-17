From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 15:52:39 +0100
Subject: [PATCH v4 4/5] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
In-Reply-To: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
References: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424184760-1671-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
MPCore.

Without this, there's no clocksource available during early kernel
initialization, before cmt1 is initialized, leading to a lock-up if
CONFIG_CPU_IDLE=y.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New, but this patch has been sent before as a separate patch.
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 70b694f09fd5ef9e..0b933e254d19faa4 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -11,6 +11,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/sh73a0-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -35,6 +36,13 @@
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
