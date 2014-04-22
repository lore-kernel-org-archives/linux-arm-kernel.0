From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 22 Apr 2014 11:19:31 -0300
Subject: [PATCH] ARM: dts: am33xx: Move the cppi41dma node so it's probed early
Message-ID: <1398176371-26468-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA controller is needed for the USB controller to be correctly
registered. Therefore, if the DMA node is located at the end an unecessary
probe deferral is produced systematically.

This is easily fixed by moving the node at the beggining of the child list,
so it's probed first.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
Felipe, Sebastian:

I cannot see why the cppi41dma node must be placed inside the
"ti,am33xx-usb" compatible node. Tried to move it out
so it's probed just like the edma engine, but the USB doesn't work
properly in that case.

Can you enlighten me?

In any case, this change is good enough to remove the deferral probe.

Thanks!

 arch/arm/boot/dts/am33xx.dtsi | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9770e35..c673be4 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -453,6 +453,21 @@
 			ti,hwmods = "usb_otg_hs";
 			status = "disabled";
 
+			cppi41dma: dma-controller at 47402000 {
+				compatible = "ti,am3359-cppi41";
+				reg =  <0x47400000 0x1000
+					0x47402000 0x1000
+					0x47403000 0x1000
+					0x47404000 0x4000>;
+				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				interrupts = <17>;
+				interrupt-names = "glue";
+				#dma-cells = <2>;
+				#dma-channels = <30>;
+				#dma-requests = <256>;
+				status = "disabled";
+			};
+
 			usb_ctrl_mod: control at 44e10620 {
 				compatible = "ti,am335x-usb-ctrl-module";
 				reg = <0x44e10620 0x10
@@ -556,20 +571,6 @@
 					"tx14", "tx15";
 			};
 
-			cppi41dma: dma-controller@47402000 {
-				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
-					0x47403000 0x1000
-					0x47404000 0x4000>;
-				reg-names = "glue", "controller", "scheduler", "queuemgr";
-				interrupts = <17>;
-				interrupt-names = "glue";
-				#dma-cells = <2>;
-				#dma-channels = <30>;
-				#dma-requests = <256>;
-				status = "disabled";
-			};
 		};
 
 		epwmss0: epwmss at 48300000 {
-- 
1.9.1
