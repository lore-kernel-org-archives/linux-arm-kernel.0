From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 27 Apr 2018 13:37:16 -0500
Subject: [PATCHv2 1/3] Documentation: dt: socfpga: Add Stratix10 ECC Manager
 binding
In-Reply-To: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
References: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1524854238-19394-2-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree bindings needed to support the Stratix10
ECC Manager and SDRAM ECC.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Remove unused System Manager syscon.
    Remove unused SDRAM ECC register defines.
    Remove unused address, size and range from bindings.
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 4a1714f96bab..5626560a6cfd 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -231,3 +231,38 @@ Example:
 				     <48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
+
+Stratix10 SoCFPGA ECC Manager
+The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
+in a shared register similar to the Arria10. However, ECC requires
+access to registers that can only be read from Secure Monitor with
+SMC calls. Therefore the device tree is slightly different.
+
+Required Properties:
+- compatible : Should be "altr,socfpga-s10-ecc-manager"
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt.
+- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
+- #interrupt-cells : must be set to 2.
+
+Subcomponents:
+
+SDRAM ECC
+Required Properties:
+- compatible : Should be "altr,sdram-edac-s10"
+- interrupts : Should be single bit error interrupt, then double bit error
+	interrupt, in this order.
+
+Example:
+
+	eccmgr {
+		compatible = "altr,socfpga-s10-ecc-manager";
+		interrupts = <0 15 4>, <0 95 4>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		sdramedac {
+			compatible = "altr,sdram-edac-s10";
+			interrupts = <16 4>, <48 4>;
+		};
+	};
-- 
2.7.4
