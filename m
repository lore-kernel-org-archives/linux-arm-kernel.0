From: agross@codeaurora.org (Andy Gross)
Date: Wed,  7 Jan 2015 21:26:12 -0600
Subject: [Patch v2 2/2] dt/bindings: qcom_adm: Fix channel specificers
In-Reply-To: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
References: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
Message-ID: <1420687572-7116-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the crci information from the dma channel property.  At least
one client device requires using more than one CRCI value for a channel.  This
does not match the current binding and the crci information needs to be removed.

Instead, the client device will provide this information via other means.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 Documentation/devicetree/bindings/dma/qcom_adm.txt |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_adm.txt b/Documentation/devicetree/bindings/dma/qcom_adm.txt
index 9bcab91..fba67c6 100644
--- a/Documentation/devicetree/bindings/dma/qcom_adm.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_adm.txt
@@ -4,8 +4,7 @@ Required properties:
 - compatible: must contain "qcom,adm" for IPQ/APQ8064 and MSM8960
 - reg: Address range for DMA registers
 - interrupts: Should contain one interrupt shared by all channels
-- #dma-cells: must be <2>.  First cell denotes the channel number.  Second cell
-  denotes CRCI (client rate control interface) flow control assignment.
+- #dma-cells: must be <1>.  First cell denotes the channel number.
 - clocks: Should contain the core clock and interface clock.
 - clock-names: Must contain "core" for the core clock and "iface" for the
   interface clock.
@@ -22,7 +21,7 @@ Example:
 			compatible = "qcom,adm";
 			reg = <0x18300000 0x100000>;
 			interrupts = <0 170 0>;
-			#dma-cells = <2>;
+			#dma-cells = <1>;
 
 			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
 			clock-names = "core", "iface";
@@ -35,15 +34,12 @@ Example:
 			qcom,ee = <0>;
 		};
 
-DMA clients must use the format descripted in the dma.txt file, using a three
+DMA clients must use the format descripted in the dma.txt file, using a two
 cell specifier for each channel.
 
 Each dmas request consists of 3 cells:
  1. phandle pointing to the DMA controller
  2. channel number
- 3. CRCI assignment, if applicable.  If no CRCI flow control is required, use 0.
-    The CRCI is used for flow control.  It identifies the peripheral device that
-    is the source/destination for the transferred data.
 
 Example:
 
@@ -56,7 +52,7 @@ Example:
 
 		cs-gpios = <&qcom_pinmux 20 0>;
 
-		dmas = <&adm_dma 6 9>,
-			<&adm_dma 5 10>;
+		dmas = <&adm_dma 6>,
+			<&adm_dma 5>;
 		dma-names = "rx", "tx";
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
