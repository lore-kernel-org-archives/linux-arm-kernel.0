From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 20 Mar 2017 19:24:05 +0530
Subject: [PATCH v6 3/4] dt-bindings: phy: Add support for QMP phy
In-Reply-To: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1490018046-8549-4-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qualcomm chipsets have QMP phy controller that provides
support to a number of controller, viz. PCIe, UFS, and USB.
Adding dt binding information for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v5:
 - Added Rob's 'Ack' for the new child nodes based bindings.
 - Dropped leading 0 from the address in 'reg' property.
 - Fixed '@xyz' part of the node name with correct address.

Changes since v4:
 - Added bindings for child nodes. Each phy lane is represented by child
   node with its own register space (for tx, rx and pcs blocks), and clocks
   and resets for power control facility.
 - Removed register space and lane offsets for tx, rx and pcs blocks from
   qmp phy node.
 - #phy-cells is now part of each child node and thus must be 0.
 - Added information on list of mandatory clocks and resets for each phy.

Changes since v3:
 - Added #clock-cells = <1>, indicating that phy is a clock provider.

Changes since v2:
 - Removed binding for "ref_clk_src" since we don't request this
   clock in the driver.
 - Addressed s/ref_clk/ref. Don't need to add '_clk' suffix to clock names.
 - Using 'phy' for the node name.

Changes since v1:
 - New patch, forked out of the original driver patch:
   "phy: qcom-qmp: new qmp phy driver for qcom-chipsets"
 - Added 'Acked-by' from Rob.
 - Updated bindings to include mem resource as a list of
   offset - length pair for serdes block and for each lane.
 - Added a new binding for 'lane-offsets' that contains offsets
   to tx, rx and pcs blocks from each lane base address.

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
new file mode 100644
index 000000000000..e11c563a65ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -0,0 +1,106 @@
+Qualcomm QMP PHY controller
+===========================
+
+QMP phy controller supports physical layer functionality for a number of
+controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
+
+Required properties:
+ - compatible: compatible list, contains:
+	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
+	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996.
+
+ - reg: offset and length of register set for PHY's common serdes block.
+
+ - #clock-cells: must be 1
+    - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
+      interface (for pipe based PHYs). These clock are then gate-controlled
+      by gcc.
+ - #address-cells: must be 1
+ - #size-cells: must be 1
+ - ranges: must be present
+
+ - clocks: a list of phandles and clock-specifier pairs,
+	   one for each entry in clock-names.
+ - clock-names: "cfg_ahb" for phy config clock,
+		"aux" for phy aux clock,
+		"ref" for 19.2 MHz ref clk,
+		For "qcom,msm8996-qmp-pcie-phy" must contain:
+			"aux", "cfg_ahb", "ref".
+		For "qcom,msm8996-qmp-usb3-phy" must contain:
+			"aux", "cfg_ahb", "ref".
+
+ - resets: a list of phandles and reset controller specifier pairs,
+	   one for each entry in reset-names.
+ - reset-names: "phy" for reset of phy block,
+		"common" for phy common block reset,
+		"cfg" for phy's ahb cfg block reset (Optional).
+		For "qcom,msm8996-qmp-pcie-phy" must contain:
+		 "phy", "common", "cfg".
+		For "qcom,msm8996-qmp-usb3-phy" must contain
+		 "phy", "common".
+
+ - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
+ - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
+
+Optional properties:
+ - vddp-ref-clk-supply: Phandle to a regulator supply to any specific refclk
+			pll block.
+
+Required nodes:
+ - Each device node of QMP phy is required to have as many child nodes as
+   the number of lanes the PHY has.
+
+Required properties for child node:
+ - reg: list of offset and length pairs of register sets for PHY blocks -
+	tx, rx and pcs.
+
+ - #phy-cells: must be 0
+
+ - clocks: a list of phandles and clock-specifier pairs,
+	   one for each entry in clock-names.
+ - clock-names: Must contain following for pcie and usb qmp phys:
+		 "pipe<lane-number>" for pipe clock specific to each lane.
+
+ - resets: a list of phandles and reset controller specifier pairs,
+	   one for each entry in reset-names.
+ - reset-names: Must contain following for pcie qmp phys:
+		 "lane<lane-number>" for reset specific to each lane.
+
+Example:
+	phy at 34000 {
+		compatible = "qcom,msm8996-qmp-pcie-phy";
+		reg = <0x34000 0x488>;
+		#clock-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+			<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_CLKREF_CLK>;
+		clock-names = "aux", "cfg_ahb", "ref";
+
+		vdda-phy-supply = <&pm8994_l28>;
+		vdda-pll-supply = <&pm8994_l12>;
+
+		resets = <&gcc GCC_PCIE_PHY_BCR>,
+			<&gcc GCC_PCIE_PHY_COM_BCR>,
+			<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+		reset-names = "phy", "common", "cfg";
+
+		pciephy_0: lane at 35000 {
+			reg = <0x35000 0x130>,
+				<0x35200 0x200>,
+				<0x35400 0x1dc>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "pipe0";
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "lane0";
+		};
+
+		pciephy_1: lane at 36000 {
+		...
+		...
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
