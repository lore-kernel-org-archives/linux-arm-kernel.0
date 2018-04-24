From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 24 Apr 2018 13:35:57 -0500
Subject: [PATCH 1/3] Documentation: dt: socfpga: Add Stratix10 ECC Manager
 binding
In-Reply-To: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1524594959-5259-2-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree bindings needed to support the Stratix10
ECC Manager and SDRAM ECC to the existing bindings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 4a1714f96bab..fe48ad293a24 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -231,3 +231,50 @@ Example:
 				     <48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
+
+Stratix10 SoCFPGA ECC Manager
+The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
+in a shared register similar to the Arria10. However, ECC requires
+access to registers that can only be read in EL3 with SMC calls.
+Therefore the device tree is slightly different.
+
+Required Properties:
+- compatible : Should be "altr,socfpga-s10-ecc-manager"
+- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
+	containing the ECC manager registers.
+- #address-cells: must be 1
+- #size-cells: must be 1
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt.
+- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
+- #interrupt-cells : must be set to 2.
+- ranges : standard definition, should translate from local addresses
+
+Subcomponents:
+
+SDRAM ECC
+Required Properties:
+- compatible : Should be "altr,sdram-edac-s10"
+- reg : Address and size for ECC error interrupt clear registers.
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
+Example:
+
+	eccmgr: eccmgr at ffd12000 {
+		compatible = "altr,socfpga-s10-ecc-manager";
+		altr,sysmgr-syscon = <&sysmgr>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <0 15 4>, <0 95 4>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ranges;
+
+		sdramedac at f8011100 {
+			compatible = "altr,sdram-edac-s10";
+			reg = <0xf8011100 0xC0>;
+			interrupts = <16 4>, <48 4>;
+		};
+	};
+
-- 
2.7.4
