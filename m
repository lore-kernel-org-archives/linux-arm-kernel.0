From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:48 +0530
Subject: [RFC PATCH 33/40] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-34-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM654x has two SERDES instances. Each instance has three input clocks
(left input, externel reference clock and right input) and two output
clocks (left output and right output) in addition to a PLL mux clock
which the SERDES uses for Clock Multiplier Unit (CMU refclock).
The PLL mux clock can select from one of the three input clocks.
The right output can select between left input and external reference
clock while the left output can select between the right input and
external reference clock.

The left and right input reference clock of SERDES0 and SERDES1
respectively are connected to the SoC clock. In the case of two lane
SERDES personality card, the left input of SERDES1 is connected to
the right output of SERDES0 in a chained fashion.

See section "Reference Clock Distribution" of AM65x Sitara Processors
TRM (SPRUID7 ? April 2018) for more details.

Add dt-binding documentation in order to represent all these different
configurations in device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/phy/ti-phy.txt        | 77 +++++++++++++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    | 13 ++++
 2 files changed, 90 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 57dfda8a7a1d..fc2fff6b2c37 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -132,3 +132,80 @@ sata_phy: phy at 4a096000 {
 	syscon-pllreset = <&scm_conf 0x3fc>;
 	#phy-cells = <0>;
 };
+
+
+TI AM654 SERDES
+
+Required properties:
+ - compatible: Should be "ti,phy-am654-serdes"
+ - reg : Address and length of the register set for the device.
+ - reg-names: Should be "serdes" which corresponds to the register space
+	populated in "reg".
+ - #phy-cells: determine the number of cells that should be given in the
+	phandle while referencing this phy. Should be "2". The 1st cell
+	corresponds to the phy type (should be one of the types specified in
+	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
+	lane function.
+	If SERDES0 is referenced 2nd cell should be:
+		0 - USB3
+		1 - PCIe0 Lane0
+		2 - ICSS2 SGMII Lane0
+	If SERDES1 is referenced 2nd cell should be:
+		0 - PCIe1 Lane0
+		1 - PCIe0 Lane1
+		2 - ICSS2 SGMII Lane1
+ - clocks: List of clock-specifiers representing the input to the SERDES.
+	Should have 3 items representing the left input clock, external
+	reference clock and right input clock in that order.
+ - clock-output-names: List of clock names for each of the clock outputs of
+	SERDES. Should have 3 items for CMU reference clock,
+	left output clock and right output clock in that order.
+ - assigned-clocks: As defined in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+ - assigned-clock-parents: As defined in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+ - #clock-cells: Should be <1> to choose between the 3 output clocks.
+	Defined in Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+   The following macros are defined in dt-bindings/phy/phy-am654-serdes.h
+   for selecting the correct reference clock. This can be used while
+   specifying the clocks created by SERDES.
+	=> AM654_SERDES_CMU_REFCLK
+	=> AM654_SERDES_LO_REFCLK
+	=> AM654_SERDES_RO_REFCLK
+
+ - mux-controls: phandle to the multiplexer
+
+Example:
+
+Example for SERDES0 is given below. It has 3 clock inputs;
+left input reference clock as indicated by <&k3_clks 153 4>, external
+reference clock as indicated by <&k3_clks 153 1> and right input
+reference clock as indicated by <&serdes1 AM654_SERDES_LO_REFCLK>. (The
+right input of SERDES0 is connected to the left output of SERDES1).
+
+SERDES0 registers 3 clock outputs as indicated in clock-output-names. The
+first refers to the CMU reference clock, second refers to the left output
+reference clock and the third refers to the right output reference clock.
+
+The assigned-clocks and assigned-clock-parents is used here to set the
+parent of left input reference clock to MAINHSDIV_CLKOUT4 and parent of
+CMU reference clock to left input reference clock.
+
+serdes0: serdes at 900000 {
+	compatible = "ti,phy-am654-serdes";
+	reg = <0x0 0x900000 0x0 0x2000>;
+	reg-names = "serdes";
+	#phy-cells = <2>;
+	power-domains = <&k3_pds 153>;
+	clocks = <&k3_clks 153 4>, <&k3_clks 153 1>,
+			<&serdes1 AM654_SERDES_LO_REFCLK>;
+	clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk",
+				"serdes0_ro_refclk";
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+	ti,serdes-clk = <&serdes0_clk>;
+	mux-controls = <&serdes_mux 0>;
+	#clock-cells = <1>;
+	status = "disabled";
+};
diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
new file mode 100644
index 000000000000..e8d901729ed9
--- /dev/null
+++ b/include/dt-bindings/phy/phy-am654-serdes.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for AM654 SERDES.
+ */
+
+#ifndef _DT_BINDINGS_AM654_SERDES
+#define _DT_BINDINGS_AM654_SERDES
+
+#define AM654_SERDES_CMU_REFCLK	0
+#define AM654_SERDES_LO_REFCLK	1
+#define AM654_SERDES_RO_REFCLK	2
+
+#endif /* _DT_BINDINGS_AM654_SERDES */
-- 
2.17.1
