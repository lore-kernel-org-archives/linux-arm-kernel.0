From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 29 Dec 2017 15:52:52 +0800
Subject: [PATCH v5 10/16] dt-bindings: Document the Rockchip ISP1 bindings
In-Reply-To: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1514533978-20408-11-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacob Chen <jacob2.chen@rock-chips.com>

Add DT bindings documentation for Rockchip ISP1

Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/rockchip-isp1.txt    | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-isp1.txt

diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.txt b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
new file mode 100644
index 0000000..4631a4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
@@ -0,0 +1,69 @@
+Rockchip SoC Image Signal Processing unit v1
+----------------------------------------------
+
+Rockchip ISP1 is the Camera interface for the Rockchip series of SoCs
+which contains image processing, scaling, and compression funcitons.
+
+Required properties:
+- compatible: value should be one of the following
+	"rockchip,rk3288-cif-isp";
+	"rockchip,rk3399-cif-isp";
+- reg : offset and length of the register set for the device.
+- interrupts: should contain ISP interrupt.
+- clocks: phandle to the required clocks.
+- clock-names: required clock name.
+- iommus: required a iommu node.
+
+port node
+-------------------
+
+The device node should contain one 'port' child node with child 'endpoint'
+nodes, according to the bindings defined in Documentation/devicetree/bindings/
+media/video-interfaces.txt.
+
+- endpoint(parallel):
+	- remote-endpoint: Connecting to a sensor with a parallel video bus.
+	- parallel_bus properties: Refer to Documentation/devicetree/bindings/
+		media/video-interfaces.txt.
+- endpoint(mipi):
+	- remote-endpoint: Connecting to Rockchip MIPI-DPHY,
+		which is defined in rockchip-mipi-dphy.txt.
+
+The port node must contain at least one endpoint, either parallel or mipi.
+It could have multiple endpoints, but please note the hardware don't support
+two sensors work at a time, they are supposed to work asynchronously.
+
+Device node example
+-------------------
+
+	isp0: isp0 at ff910000 {
+		compatible = "rockchip,rk3399-cif-isp";
+		reg = <0x0 0xff910000 0x0 0x4000>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_ISP0>,
+			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
+			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
+		clock-names = "clk_isp",
+			      "aclk_isp", "aclk_isp_wrap",
+			      "hclk_isp", "hclk_isp_wrap";
+		power-domains = <&power RK3399_PD_ISP0>;
+		iommus = <&isp0_mmu>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* mipi */
+			isp0_mipi_in: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&dphy_rx0_out>;
+			};
+
+			/* parallel */
+			isp0_parallel_in: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&ov5640_out>;
+				bus-width = <8>;
+			};
+		};
+	};
-- 
1.9.1
