From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Thu, 24 Mar 2016 11:17:13 +0530
Subject: [PATCH v5 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1458798435-20222-2-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Cygnus SOC touch screen controller registers are shared
with ADC and flex timer. Using readl/writel could lead to
race condition. So touch screen driver is enhanced to support
register access using syscon framework API's to take care of
mutually exclusive access.In addition to this existing touchscreen
node name "tsc" is renamed to "touchscreen".

Hence touchscreen dt node bindings document is updated to take care
of above changes in the touchscreen driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../input/touchscreen/brcm,iproc-touchscreen.txt    | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
index 34e3382..25541f3 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
@@ -2,11 +2,17 @@
 
 Required properties:
 - compatible: must be "brcm,iproc-touchscreen"
-- reg: physical base address of the controller and length of memory mapped
-  region.
+- ts_syscon: handler of syscon node defining physical base
+  address of the controller and length of memory mapped region.
+  If this property is selected please make sure MFD_SYSCON config
+  is enabled in the defconfig file.
 - clocks:  The clock provided by the SOC to driver the tsc
 - clock-name:  name for the clock
 - interrupts: The touchscreen controller's interrupt
+- address-cells: Specify the number of u32 entries needed in child nodes.
+  Should set to 1.
+- size-cells: Specify number of u32 entries needed to specify child nodes size
+  in reg property. Should set to 1.
 
 Optional properties:
 - scanning_period: Time between scans. Each step is 1024 us.  Valid 1-256.
@@ -53,13 +59,18 @@ Optional properties:
 - touchscreen-inverted-x: X axis is inverted (boolean)
 - touchscreen-inverted-y: Y axis is inverted (boolean)
 
-Example:
+Example: An example of touchscreen node
 
-	touchscreen: tsc at 0x180A6000 {
+	ts_adc_syscon: ts_adc_syscon at 180a6000 {
+		compatible = "brcm,iproc-ts-adc-syscon","syscon";
+		reg = <0x180a6000 0xc30>;
+	};
+
+	touchscreen: touchscreen at 180A6000 {
 		compatible = "brcm,iproc-touchscreen";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x180A6000 0x40>;
+		ts_syscon = <&ts_adc_syscon>;
 		clocks = <&adc_clk>;
 		clock-names = "tsc_clk";
 		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
