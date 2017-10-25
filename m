From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 25 Oct 2017 16:44:08 +0800
Subject: [PATCH v3 1/2] dt-bindings: add bindings doc for hi3798cv200 combphy
In-Reply-To: <1508921049-16208-1-git-send-email-shawnguo@kernel.org>
References: <1508921049-16208-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508921049-16208-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianguo Sun <sunjianguo1@huawei.com>

It adds the device tree bindings for PCIE/SATA/USB3 combo PHY found on
HiSilicon STB SoCs.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/phy/phy-hi3798cv200-combphy.txt       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
new file mode 100644
index 000000000000..b4041e33a804
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
@@ -0,0 +1,50 @@
+HiSilicon STB PCIE/SATA/USB3 PHY
+
+Required properties:
+- compatible: Should be "hisilicon,hi3798cv200-combphy"
+- reg: Should be the address space for COMBPHY configuration and state
+  registers in peripheral controller, e.g. PERI_COMBPHY0_CFG and
+  PERI_COMBPHY0_STATE for COMBPHY0 Hi3798cv200 SoC.
+- #phy-cells: Should be 1.  The cell number is used to select the phy mode
+  as defined in <dt-bindings/phy/phy.h>.
+- clocks: The phandle to clock provider and clock specifier pair.
+- resets: The phandle to reset controller and reset specifier pair.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Note:
+- The device node should be a child of peripheral controller that contains
+  COMBPHY configuration/state and PERI_CTRL register used to select PHY mode.
+- The combphy devices should have aliases defined.
+
+Example:
+
+aliases {
+	combphy0 = &combphy0;
+	combphy1 = &combphy1;
+};
+
+peri_ctrl: peri_ctrl at 8a20000 {
+	compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
+		     "simple-mfd";
+	reg = <0x8a20000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x0 0x8a20000 0x1000>;
+
+	combphy0: phy at 850 {
+		compatible = "hisilicon,hi3798cv200-combphy";
+		reg = <0x850 0x8>;
+		#phy-cells = <1>;
+		clocks = <&crg HISTB_COMBPHY0_CLK>;
+		resets = <&crg 0x188 4>;
+	};
+
+	combphy1: phy at 858 {
+		compatible = "hisilicon,hi3798cv200-combphy";
+		reg = <0x858 0x8>;
+		#phy-cells = <1>;
+		clocks = <&crg HISTB_COMBPHY1_CLK>;
+		resets = <&crg 0x188 12>;
+	};
+};
-- 
1.9.1
