From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:43 -0500
Subject: [PATCHv3 6/9] Documentation: dt: socfpga: Add Altera Arria10 L2 cache
 binding
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-7-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera L2
cache on the Arria10 chip. Since all the peripherals share
IRQs, the IRQ fields are now in the ecc_manager.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2 Correct spelling of Arria10 in patch title.
v3 Major restructuring change for ecc_manager to include IRQs
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 885f93d..37ff9bf 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -3,6 +3,7 @@ This driver uses the EDAC framework to implement the SOCFPGA ECC Manager.
 The ECC Manager counts and corrects single bit errors and counts/handles
 double bit errors which are uncorrectable.
 
+Cyclone5 and Arria5 ECC Manager
 Required Properties:
 - compatible : Should be "altr,socfpga-ecc-manager"
 - #address-cells: must be 1
@@ -47,3 +48,42 @@ Example:
 			interrupts = <0 178 1>, <0 179 1>;
 		};
 	};
+
+Arria10 SoCFPGA ECC Manager
+The Arria10 SoC ECC Manager handles the IRQs for each peripheral
+in a shared register instead of individual IRQs like the Cyclone5
+and Arria5. Therefore the device tree is different as well.
+
+Required Properties:
+- compatible : Should be "altr,socfpga-a10-ecc-manager"
+- altr,sysgr-syscon : phandle to Arria10 System Manager Block
+	containing the ECC manager registers.
+- #address-cells: must be 1
+- #size-cells: must be 1
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt. Note the rising edge type.
+- ranges : standard definition, should translate from local addresses
+
+Subcomponents:
+
+L2 Cache ECC
+Required Properties:
+- compatible : Should be "altr,socfpga-a10-l2-ecc"
+- reg : Address and size for ECC error interrupt clear registers.
+
+Example:
+
+	eccmgr: eccmgr at ffd06000 {
+		compatible = "altr,socfpga-a10-ecc-manager";
+		altr,sysmgr-syscon = <&sysmgr>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 0 IRQ_TYPE_LEVEL_HIGH>;
+		ranges;
+
+		l2-ecc at ffd06010 {
+			compatible = "altr,socfpga-a10-l2-ecc";
+			reg = <0xffd06010 0x4>;
+		};
+	};
-- 
1.7.9.5
