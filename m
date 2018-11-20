From: eric@anholt.net (Eric Anholt)
Date: Tue, 20 Nov 2018 13:37:01 -0800
Subject: [PATCH v2 4/5] ARM: bcm283x: Extend the WDT DT node out to cover the
 whole PM block.
In-Reply-To: <20181120213702.27958-1-eric@anholt.net>
References: <20181120213702.27958-1-eric@anholt.net>
Message-ID: <20181120213702.27958-5-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was covering part of the PM block's range, up to the WDT regs.  To
support the rest of the PM block's functionality, we need the full
register range plus the AXI Async Bridge regs for PM sequencing.

This doesn't convert any of the consumers over to the new binding yet,
since we will need to be careful in coordinating our usage of firmware
services that might power domains on and off versus the bcm2835-pm
driver's access of those same domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 31b29646b14c..bd5be68b4561 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -121,8 +121,16 @@
 		};
 
 		watchdog at 7e100000 {
-			compatible = "brcm,bcm2835-pm-wdt";
-			reg = <0x7e100000 0x28>;
+			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x7e100000 0x114>,
+			      <0x7e00a000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_V3D>,
+				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+				 <&clocks BCM2835_CLOCK_H264>,
+				 <&clocks BCM2835_CLOCK_ISP>;
+			clock-names = "v3d", "peri_image", "h264", "isp";
 		};
 
 		clocks: cprman at 7e101000 {
-- 
2.19.1
