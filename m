From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 25 May 2016 11:29:39 -0500
Subject: [PATCH 1/5] Documentation: dt: socfpga: Add interrupt-controller to
 ecc-manager
In-Reply-To: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1464193783-5071-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Designate the ECC Manager as an interrupt controller and add child
interrupts.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 5a6b160..15eb0df 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -61,7 +61,9 @@ Required Properties:
 - #address-cells: must be 1
 - #size-cells: must be 1
 - interrupts : Should be single bit error interrupt, then double bit error
-	interrupt. Note the rising edge type.
+	interrupt.
+- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
+- #interrupt-cells : must be set to 2.
 - ranges : standard definition, should translate from local addresses
 
 Subcomponents:
@@ -70,11 +72,15 @@ L2 Cache ECC
 Required Properties:
 - compatible : Should be "altr,socfpga-a10-l2-ecc"
 - reg : Address and size for ECC error interrupt clear registers.
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
 
 On-Chip RAM ECC
 Required Properties:
 - compatible : Should be "altr,socfpga-a10-ocram-ecc"
 - reg        : Address and size for ECC block registers.
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
 
 Example:
 
@@ -85,15 +91,21 @@ Example:
 		#size-cells = <1>;
 		interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 0 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 		ranges;
 
 		l2-ecc at ffd06010 {
 			compatible = "altr,socfpga-a10-l2-ecc";
 			reg = <0xffd06010 0x4>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+				     <32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		ocram-ecc at ff8c3000 {
 			compatible = "altr,socfpga-a10-ocram-ecc";
 			reg = <0xff8c3000 0x90>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>,
+				     <33 IRQ_TYPE_LEVEL_HIGH> ;
 		};
 	};
-- 
1.7.9.5
