From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:33 +0800
Subject: [PATCH RFC v9 10/20] Documentation: dt-bindings: Add bindings for
 Synopsys DW MIPI DSI DRM bridge driver
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423720903-24806-11-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings for Synopsys DesignWare MIPI DSI
host controller DRM bridge driver.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v8->v9:
 * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
 * To address Philipp's comment, mention that a common compatible string
   "snps,dw-mipi-dsi" should be appended for all SoCs.
 * To address Philipp's comment, add a new required clock pclk and clean up
   clock-names.

v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * Add the #address-cells and #size-cells properties in the example 'ports'
   node.
 * Remove the useless input-port properties from the example port at 0 and port at 1
   nodes.

v4->v5:
 * None.

v3->v4:
 * Newly introduced in v4.  This is separated from the relevant driver patch
   in v3 to address Stefan Wahren's comment.

 .../devicetree/bindings/drm/bridge/dw_mipi_dsi.txt | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt

diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
new file mode 100644
index 0000000..bb87466
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
@@ -0,0 +1,76 @@
+Device-Tree bindings for Synopsys DesignWare MIPI DSI host controller
+
+The controller is a digital core that implements all protocol functions
+defined in the MIPI DSI specification, providing an interface between
+the system and the MIPI DPHY, and allowing communication with a MIPI DSI
+compliant display.
+
+Required properties:
+ - #address-cells: Should be <1>.
+ - #size-cells: Should be <0>.
+ - compatible: The first compatible string should be "fsl,imx6q-mipi-dsi"
+   for i.MX6q/sdl SoCs.  For other SoCs, please refer to their specific
+   device tree binding documentations.  A common compatible string
+   "snps,dw-mipi-dsi" should be appended for all SoCs.
+ - reg: Represent the physical address range of the controller.
+ - interrupts: Represent the controller's interrupt to the CPU(s).
+ - clocks, clock-names: Phandles to the controller's pll reference
+   clock(ref), configuration clock(cfg) and APB clock(pclk), as
+   described in [1].
+
+For more required properties, please refer to relevant device tree binding
+documentations which describe the controller embedded in specific SoCs.
+
+Required sub-nodes:
+ - A node to represent a DSI peripheral as described in [2].
+
+For more required sub-nodes, please refer to relevant device tree binding
+documentations which describe the controller embedded in specific SoCs.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+
+example:
+	gpr: iomuxc-gpr at 020e0000 {
+		/* ... */
+	};
+
+	mipi_dsi: mipi at 021e0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x021e0000 0x4000>;
+		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		gpr = <&gpr>;
+		clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+			 <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+			 <&clks IMX6QDL_CLK_MIPI_IPG>;
+		clock-names = "ref", "cfg", "pclk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				mipi_mux_0: endpoint {
+					remote-endpoint = <&ipu1_di0_mipi>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				mipi_mux_1: endpoint {
+					remote-endpoint = <&ipu1_di1_mipi>;
+				};
+			};
+		};
+
+		panel {
+			compatible = "truly,tft480800-16-e-dsi";
+			reg = <0>;
+			/* ... */
+		};
+	};
-- 
2.1.0
