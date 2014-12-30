From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 30 Dec 2014 11:34:03 +0800
Subject: [PATCH RFC v7 13/21] Documentation: dt-bindings: Add bindings for
 i.MX specific Synopsys DW MIPI DSI driver
In-Reply-To: <1419910451-15268-1-git-send-email-Ying.Liu@freescale.com>
References: <1419910451-15268-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419910451-15268-14-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings for i.MX specific Synopsys DW MIPI DSI driver.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v6->v7:
 * None.

v5->v6:
 * Add the #address-cells and #size-cells properties in the example 'ports'
   node.
 * Remove the useless pllref_gate clock from the required clocks, clock-names
   property.

v4->v5:
 * None.

v3->v4:
 * Newly introduced in v4.  This is separated from the relevant driver patch
   in v3 to address Stefan Wahren's comment.

 .../devicetree/bindings/drm/imx/mipi_dsi.txt       | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt

diff --git a/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt b/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
new file mode 100644
index 0000000..75a7766
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
@@ -0,0 +1,78 @@
+i.MX specific Device-Tree bindings for Synopsys DesignWare MIPI DSI host controller
+
+MIPI DSI host controller
+========================
+
+The MIPI DSI host controller is a Synopsys DesignWare IP.
+The common device tree documentation for this controller can be found
+at [1].
+
+Required properties:
+ - #address-cells: Should be <1>.
+ - #size-cells: Should be <0>.
+ - compatible: The compatible string should be "fsl,imx6q-mipi-dsi"
+   for i.MX6q/sdl SoCs.
+ - reg: Physical base address of the controller and length of memory
+   mapped region.
+ - interrupts: The controller's interrupt number to the CPU(s).
+ - gpr: Should be <&gpr>.
+   The phandle points to the iomuxc-gpr region containing the
+   multiplexer control register for the controller.
+ - clocks, clock-names: Phandles to the controller pllref and core_cfg clocks,
+   as described in [2] and [3].
+
+Required sub-nodes:
+ - ports: This node may contain up to four port nodes with endpoint
+   definitions as defined in [4], corresponding to the four inputs to
+   the controller multiplexer.
+ - A node to represent a DSI peripheral as described in [5].
+
+[1] Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt.
+[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[3] Documentation/devicetree/bindings/clock/imx6q-clock.txt
+[4] Documentation/devicetree/bindings/media/video-interfaces.txt
+[5] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+
+example:
+	gpr: iomuxc-gpr at 020e0000 {
+		/* ... */
+	};
+
+	mipi_dsi: mipi at 021e0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx6q-mipi-dsi";
+		reg = <0x021e0000 0x4000>;
+		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		gpr = <&gpr>;
+		clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+			 <&clks IMX6QDL_CLK_MIPI_CORE_CFG>;
+		clock-names = "pllref", "core_cfg";
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
