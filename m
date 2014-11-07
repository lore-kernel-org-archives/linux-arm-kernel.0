From: vigneshr@ti.com (Vignesh R)
Date: Fri, 7 Nov 2014 11:19:09 +0530
Subject: [PATCH 4/5] ARM: dts: AM335x: Make charge delay a DT parameter for tsc
In-Reply-To: <1415339350-17679-1-git-send-email-vigneshr@ti.com>
References: <1415339350-17679-1-git-send-email-vigneshr@ti.com>
Message-ID: <1415339350-17679-5-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The charge delay value is by default 0xB000. But it can be set to lower
values on some boards as long as false pen-ups are avoided. Lowering the
value increases the sampling rate (though current sampling rate is
sufficient for tsc operation). Hence charge delay has been made a DT
parameter.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 15 +++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts                          |  1 +
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index 878549ba814d..b87574bae009 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -28,6 +28,20 @@ Required properties:
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 
+Optional properties:
+- child "tsc"
+	ti,charge-delay: Length of touch screen charge delay step in terms of
+			 ADC clock cycles. Charge delay value should be large
+			 in order to avoid false pen-up events. This value
+			 affects the overall sampling speed, hence need to be
+			 kept as low as possible, while avoiding false pen-up
+			 event. Start from a lower value, say 0x400, and
+			 increase value until false pen-up events are avoided.
+			 The pen-up detection happens immediately after the
+			 charge step, so this does in fact function as a
+			 hardware knob for adjusting the amount of "settling
+			 time".
+
 Example:
 	tscadc: tscadc at 44e0d000 {
 		compatible = "ti,am3359-tscadc";
@@ -36,6 +50,7 @@ Example:
 			ti,x-plate-resistance = <200>;
 			ti,coordiante-readouts = <5>;
 			ti,wire-config = <0x00 0x11 0x22 0x33>;
+			ti,charge-delay = <0xB000>;
 		};
 
 		adc {
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e2156a583de7..80be0462298b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -641,6 +641,7 @@
 		ti,x-plate-resistance = <200>;
 		ti,coordinate-readouts = <5>;
 		ti,wire-config = <0x00 0x11 0x22 0x33>;
+		ti,charge-delay = <0xB000>;
 	};
 
 	adc {
-- 
1.9.1
