From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 28 Feb 2017 15:31:25 -0500
Subject: [PATCH 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
References: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
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
index 4fbb089..3fbc450 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -70,10 +70,19 @@
 			clocks = <&periph_clk>;
 		};
 
-		local-timer at 20600 {
+		timer at 20600 {
 			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x20600 0x100>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x20600 0x20>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&periph_clk>;
+		};
+
+		watchdog at 20620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0x20620 0x20>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.7.4
