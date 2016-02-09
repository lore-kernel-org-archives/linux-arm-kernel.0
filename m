From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue,  9 Feb 2016 14:27:55 +0530
Subject: [PATCH 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Touch screen driver is modified to use syscon framework
based register read/write API's. So added syscon node and
related changes in dt file.Updating the device tree documentation
file to reflect the changes.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../input/touchscreen/brcm,iproc-touchscreen.txt       | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
index 34e3382..67599ae 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
@@ -2,8 +2,16 @@
 
 Required properties:
 - compatible: must be "brcm,iproc-touchscreen"
-- reg: physical base address of the controller and length of memory mapped
-  region.
+
+One of the below 2 property is mandatory.
+- ts_syscon: handler of syscon node defining physical base address
+  of the controller and length of memory mapped region.
+  If this property is selected please make sure MFD_SYSCON config
+  is enabled in the defconfig file.
+or
+- reg: physical base address of the controller and length of memory
+  mapped region.
+
 - clocks:  The clock provided by the SOC to driver the tsc
 - clock-name:  name for the clock
 - interrupts: The touchscreen controller's interrupt
@@ -54,12 +62,16 @@ Optional properties:
 - touchscreen-inverted-y: Y axis is inverted (boolean)
 
 Example:
+	ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
+		compatible = "syscon";
+		reg = <0x180a6000 0xc30>;
+	};
 
 	touchscreen: tsc at 0x180A6000 {
 		compatible = "brcm,iproc-touchscreen";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x180A6000 0x40>;
+		syscon = <&ts_adc_syscon>;
 		clocks = <&adc_clk>;
 		clock-names = "tsc_clk";
 		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
