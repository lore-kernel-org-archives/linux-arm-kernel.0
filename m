From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 20 Mar 2017 19:24:03 +0530
Subject: [PATCH v6 1/4] dt-bindings: phy: Add support for QUSB2 phy
In-Reply-To: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1490018046-8549-2-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qualcomm chipsets have QUSB2 phy controller that provides
HighSpeed functionality for DWC3 controller.
Adding dt binding information for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v5:
 - Removed leading 0 from the address in 'reg' property.

Changes since v4:
 - None.

Changes since v3:
 - Added 'Acked-by' from Rob.
 - Removed 'reset-names' and 'nvmem-cell-names' from the bindings
   since we use only one cell.

Changes since v2:
 - Removed binding for "ref_clk_src" since we don't request this
   clock in the driver.
 - Addressed s/vdda-phy-dpdm/vdda-phy-dpdm-supply.
 - Addressed s/ref_clk/ref. Don't need to add '_clk' suffix to clock names.
 - Addressed s/tune2_hstx_trim_efuse/tune2_hstx_trim. Don't need to add
   'efuse' suffix to nvmem cell.
 - Addressed s/qusb2phy/phy for the node name.

Changes since v1:
 - New patch, forked out of the original driver patch:
   "phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips"
 - Updated dt bindings to remove 'hstx-trim-bit-offset' and
   'hstx-trim-bit-len' bindings.

 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
new file mode 100644
index 000000000000..a6d19acde9e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
@@ -0,0 +1,45 @@
+Qualcomm QUSB2 phy controller
+=============================
+
+QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
+
+Required properties:
+ - compatible: compatible list, contains "qcom,msm8996-qusb2-phy".
+ - reg: offset and length of the PHY register set.
+ - #phy-cells: must be 0.
+
+ - clocks: a list of phandles and clock-specifier pairs,
+	   one for each entry in clock-names.
+ - clock-names: must be "cfg_ahb" for phy config clock,
+			"ref" for 19.2 MHz ref clk,
+			"iface" for phy interface clock (Optional).
+
+ - vdd-phy-supply: Phandle to a regulator supply to PHY core block.
+ - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
+ - vdda-phy-dpdm-supply: Phandle to 3.1V regulator supply to Dp/Dm port signals.
+
+ - resets: Phandle to reset to phy block.
+
+Optional properties:
+ - nvmem-cells: Phandle to nvmem cell that contains 'HS Tx trim'
+		tuning parameter value for qusb2 phy.
+
+ - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
+
+Example:
+	hsusb_phy: phy at 7411000 {
+		compatible = "qcom,msm8996-qusb2-phy";
+		reg = <0x7411000 0x180>;
+		#phy-cells = <0>;
+
+		clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+			<&gcc GCC_RX1_USB2_CLKREF_CLK>,
+		clock-names = "cfg_ahb", "ref";
+
+		vdd-phy-supply = <&pm8994_s2>;
+		vdda-pll-supply = <&pm8994_l12>;
+		vdda-phy-dpdm-supply = <&pm8994_l24>;
+
+		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+		nvmem-cells = <&qusb2p_hstx_trim>;
+        };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
