From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:04:11 +0800
Subject: [PATCH v4 14/20] dt-bindings: PCI: hisi: Add document for PCIe of
 Kirin SoCs
In-Reply-To: <20170615030417.14059-1-guodong.xu@linaro.org>
References: <20170615030417.14059-1-guodong.xu@linaro.org>
Message-ID: <20170615030417.14059-15-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaowei Song <songxiaowei@hisilicon.com>

This patch adds document for PCIe of Kirin SoC series.

Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/kirin-pcie.txt         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
new file mode 100644
index 0000000..68ffa0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -0,0 +1,50 @@
+HiSilicon Kirin SoCs PCIe host DT description
+
+Kirin PCIe host controller is based on Designware PCI core.
+It shares common functions with PCIe Designware core driver
+and inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties
+- compatible:
+	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
+- reg: Should contain rc_dbi, apb, phy, config registers location and length.
+- reg-names: Must include the following entries:
+  "dbi": controller configuration registers;
+  "apb": apb Ctrl register defined by Kirin;
+  "phy": apb PHY register defined by Kirin;
+  "config": PCIe configuration space registers.
+- reset-gpios: The gpio to generate PCIe perst assert and deassert signal.
+
+Optional properties:
+
+Example based on kirin960:
+
+	pcie at f4000000 {
+		compatible = "hisilicon,kirin-pcie";
+		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
+		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
+		reg-names = "dbi","apb","phy", "config";
+		bus-range = <0x0  0x1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
+		num-lanes = <1>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
+				<0x0 0 0 2 &gic 0 0 0  283 4>,
+				<0x0 0 0 3 &gic 0 0 0  284 4>,
+				<0x0 0 0 4 &gic 0 0 0  285 4>;
+		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+		clock-names = "pcie_phy_ref", "pcie_aux",
+			      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
+		reset-gpios = <&gpio11 1 0 >;
+	};
-- 
2.10.2
