From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Feb 2017 20:02:43 +0100
Subject: [PATCH v3 1/4] dt-bindings: add multidomain support to i.MX GPC DT
 binding
Message-ID: <20170217190246.14881-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new binding for the Freescale i.MX GPC block, which allows
to describe multiple power domains in a more natural way. The driver
will continue to support the old binding for existing DTBs, but new
features like the additional domains present on i.MX6SX will only be
usable with the new binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
- use 'power-supply' as name for the domain supply
- clarify that 'pgc' is a node, not a property
---
 .../devicetree/bindings/power/fsl,imx-gpc.txt      | 80 ++++++++++++++--------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
index 65cc0345747d..1598c8029add 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -1,22 +1,40 @@
 Freescale i.MX General Power Controller
 =======================================
 
-The i.MX6Q General Power Control (GPC) block contains DVFS load tracking
-counters and Power Gating Control (PGC) for the CPU and PU (GPU/VPU) power
-domains.
+The i.MX6 General Power Control (GPC) block contains DVFS load tracking
+counters and Power Gating Control (PGC).
 
 Required properties:
 - compatible: Should be "fsl,imx6q-gpc" or "fsl,imx6sl-gpc"
 - reg: should be register base and length as documented in the
   datasheet
-- interrupts: Should contain GPC interrupt request 1
-- pu-supply: Link to the LDO regulator powering the PU power domain
-- clocks: Clock phandles to devices in the PU power domain that need
-	  to be enabled during domain power-up for reset propagation.
-- #power-domain-cells: Should be 1, see below:
+- interrupts: Should contain one interrupt specifier for the GPC interrupt
+- clocks: Must contain an entry for each entry in clock-names.
+  See Documentation/devicetree/bindings/clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - ipg
 
-The gpc node is a power-controller as documented by the generic power domain
-bindings in Documentation/devicetree/bindings/power/power_domain.txt.
+The power domains are generic power domain providers as documented in
+Documentation/devicetree/bindings/power/power_domain.txt. They are described as
+subnodes of the power gating controller 'pgc' node of the GPC and should
+contain the following:
+
+Required properties:
+- reg: the DOMAIN_INDEX as used by the client devices to refer to this
+  power domain
+  The following DOMAIN_INDEX values are valid for i.MX6Q:
+  ARM_DOMAIN     0
+  PU_DOMAIN      1
+  The following additional DOMAIN_INDEX value is valid for i.MX6SL:
+  DISPLAY_DOMAIN 2
+
+- #power-domain-cells: Should be 0
+
+Optional properties:
+- clocks: a number of phandles to clocks that need to be enabled during domain
+  power-up sequencing to ensure reset propagation into devices located inside
+  this power domain
+- power-supply: a phandle to the regulator powering this domain
 
 Example:
 
@@ -25,14 +43,29 @@ Example:
 		reg = <0x020dc000 0x4000>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		pu-supply = <&reg_pu>;
-		clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
-			 <&clks IMX6QDL_CLK_GPU3D_SHADER>,
-			 <&clks IMX6QDL_CLK_GPU2D_CORE>,
-			 <&clks IMX6QDL_CLK_GPU2D_AXI>,
-			 <&clks IMX6QDL_CLK_OPENVG_AXI>,
-			 <&clks IMX6QDL_CLK_VPU_AXI>;
-		#power-domain-cells = <1>;
+		clocks = <&clks IMX6QDL_CLK_IPG>;
+		clock-names = "ipg";
+		
+		pgc {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-domain at 0 {
+				reg = <0>;
+				#power-domain-cells = <0>;
+			};
+			pd_pu: power-domain at 1 {
+				reg = <1>;
+				#power-domain-cells = <0>;
+				power-supply = <&reg_pu>;
+				clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
+				         <&clks IMX6QDL_CLK_GPU3D_SHADER>,
+				         <&clks IMX6QDL_CLK_GPU2D_CORE>,
+				         <&clks IMX6QDL_CLK_GPU2D_AXI>,
+				         <&clks IMX6QDL_CLK_OPENVG_AXI>,
+				         <&clks IMX6QDL_CLK_VPU_AXI>;
+			};
+		};
 	};
 
 
@@ -40,20 +73,13 @@ Specifying power domain for IP modules
 ======================================
 
 IP cores belonging to a power domain should contain a 'power-domains' property
-that is a phandle pointing to the gpc device node and a DOMAIN_INDEX specifying
-the power domain the device belongs to.
+that is a phandle pointing to the power domain the device belongs to.
 
 Example of a device that is part of the PU power domain:
 
 	vpu: vpu at 02040000 {
 		reg = <0x02040000 0x3c000>;
 		/* ... */
-		power-domains = <&gpc 1>;
+		power-domains = <&pd_pu>;
 		/* ... */
 	};
-
-The following DOMAIN_INDEX values are valid for i.MX6Q:
-ARM_DOMAIN     0
-PU_DOMAIN      1
-The following additional DOMAIN_INDEX value is valid for i.MX6SL:
-DISPLAY_DOMAIN 2
-- 
2.11.0
