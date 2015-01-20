From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:27:34 +0900
Subject: [PATCH] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
In-Reply-To: <cover.1421716945.git.horms+renesas@verge.net.au>
References: <cover.1421716945.git.horms+renesas@verge.net.au>
Message-ID: <e42c8385cfec0579a103b365d61748f199bfe239.1421716945.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a node for the Private Timer and Watchdog, as found in the Cortex-A9
MPCore.

Without this, there's no clocksource available during early kernel
initialization, before cmt1 is initialized, leading to a lock-up if
CONFIG_CPU_IDLE=y.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 0c9a357..2558bf4 100644
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
2.1.4
