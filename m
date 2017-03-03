From: jon.mason@broadcom.com (Jon Mason)
Date: Thu,  2 Mar 2017 19:21:33 -0500
Subject: [PATCH v2 2/3] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
References: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1488500494-20622-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

Add support for the ARM TWD Watchdog to the bcm5301x device tree.  The
ARM TWD timer allocated the register space for the WDT, so this patch
necessitated shrinking that.  Also, the GIC masks were added for these.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 00de62d..4e3fbce 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -70,10 +70,19 @@
 			clocks = <&periph_clk>;
 		};
 
-		local-timer at 20600 {
+		timer at 20600 {
 			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x20600 0x100>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>;
+			reg = <0x20600 0x20>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&periph_clk>;
+		};
+
+		watchdog at 20620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0x20620 0x20>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.7.4
