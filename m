From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 28 Oct 2018 15:19:44 +0000
Subject: [PATCH V8 3/5] dt-bindings: fsl: scu: update power domain binding
In-Reply-To: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540739690-23750-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the power domain binding with #power-domain-cells 1 format.
The first cell can be a global SCU power domain and the 2nd cell
the device ID. With this approach, we may remove all the sub power
domain nodes from device tree which can relief the device tree a lot.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm at vger.kernel.org
Cc: devicetree at vger.kernel.org
Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v7->v8:
 * new patch
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 37 +++++-----------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 46d0af1..c20f38e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -58,19 +58,11 @@ This binding for the SCU power domain providers uses the generic power
 domain binding[2].
 
 Required properties:
-- compatible:		Should be "fsl,scu-pd".
-- #address-cells:	Should be 1.
-- #size-cells:		Should be 0.
-
-Required properties for power domain sub nodes:
-- #power-domain-cells:	Must be 0.
-
-Optional Properties:
-- reg:			Resource ID of this power domain.
-			No exist means uncontrollable by user.
+- compatible:		Should be "fsl,imx8qxp-scu-pd".
+- #power-domain-cells:	Must be 1. Contains the Resource ID used by
+			SCU commands.
 			See detailed Resource ID list from:
-			include/dt-bindings/power/imx-rsrc.h
-- power-domains:	phandle pointing to the parent power domain.
+			include/dt-bindings/firmware/imx/rsrc.h
 
 Clock bindings based on SCU Message Protocol
 ------------------------------------------------------------
@@ -152,22 +144,9 @@ firmware {
 			...
 		};
 
-		imx8qx-pm {
-			compatible = "fsl,scu-pd";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			pd_dma: dma-power-domain {
-				#power-domain-cells = <0>;
-
-				pd_dma_lpuart0: dma-lpuart0 at 57 {
-					reg = <SC_R_UART_0>;
-					#power-domain-cells = <0>;
-					power-domains = <&pd_dma>;
-				};
-				...
-			};
-			...
+		pd: imx8qx-pd {
+			compatible = "fsl,imx8qxp-scu-pd";
+			#power-domain-cells = <1>;
 		};
 	};
 };
@@ -179,5 +158,5 @@ serial at 5a060000 {
 	clocks = <&clk IMX8QXP_UART0_CLK>,
 		 <&clk IMX8QXP_UART0_IPG_CLK>;
 	clock-names = "per", "ipg";
-	power-domains = <&pd_dma_lpuart0>;
+	power-domains = <&pd IMX_SC_R_UART_0>;
 };
-- 
2.7.4
