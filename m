From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Mon, 15 May 2017 16:35:01 +0800
Subject: [PATCH 2/3] Documentation: add sprd clock bindings
In-Reply-To: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
References: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170515083502.4492-3-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new directory under the 'clock' for Spreadtrum platform,
also bindings which document compatible strings and properties used for
devicetree node of clocks on Spreadtrum SoCs.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 .../clock/sprd/sprd,adjustable-pll-clock.txt       | 17 +++++
 .../bindings/clock/sprd/sprd,composite-clock.txt   | 28 +++++++++
 .../bindings/clock/sprd/sprd,divider-clock.txt     | 24 +++++++
 .../bindings/clock/sprd/sprd,gates-clock.txt       | 73 ++++++++++++++++++++++
 .../bindings/clock/sprd/sprd,muxed-clock.txt       | 23 +++++++
 5 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
new file mode 100644
index 0000000..476e315
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
@@ -0,0 +1,17 @@
+Spreadtrum adjustable pll clock driver
+
+Required properties:
+
+- compatible : must be one of:
+	"sprd,sc9836-adjustable-pll-clock"
+	"sprd,sc9860-adjustable-pll-clock"
+
+Example:
+	clk_mpll0: clk at 40400024 {
+		compatible = "sprd,sc9860-adjustable-pll-clock";
+		#clock-cells = <0>;
+		reg = <0 0x40400024 0 0x4>,
+		      <0 0x40400028 0 0x4>;
+		clocks = <&clk_mpll_gates 2>;
+		clock-output-names = "clk_mpll0";
+	};
diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
new file mode 100644
index 0000000..a476eb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
@@ -0,0 +1,28 @@
+Spreadtrum composite clock driver.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+
+- compatible:	should be "sprd,composite-clock"
+
+- sprd,mux-msk:	arbitrary bitmask for selecting clock input
+
+- sprd,div-msk:	arbitrary bitmask for programming the divider,
+		denominator of divider is the value consisted
+		of these bits plus 1
+
+Example:
+
+	clk_sensor: clk at 60e00024 {
+		compatible = "sprd,composite-clock";
+		#clock-cells = <0>;
+		reg = <0 0x60e00024 0 0x4>;
+		clocks = <&ext_26m>, <&clk_twpll_48m_def>,
+			 <&clk_twpll_76m8_def>, <&clk_twpll_96m_def>;
+		clock-output-names = "clk_sensor";
+		sprd,mux-msk = <0x3>;
+		sprd,div-msk = <0x700>;
+	};
diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
new file mode 100644
index 0000000..0bfc0ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
@@ -0,0 +1,24 @@
+Spreadtrum divider clock driver which only supports simple indexed divider
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+
+- compatible : should be "sprd,divider-clock"
+
+- sprd,div-msk:	arbitrary bitmask for programming the divider,
+		denominator of divider is the value consisted
+		of these bits plus 1.
+
+Example:
+
+	clk_sdio0_1x: clk at 402d032c {
+		compatible = "sprd,divider-clock";
+		#clock-cells = <0>;
+		reg = <0 0x402d032c 0 0x4>;
+		sprd,div-msk = <0x100>;
+		clocks = <&clk_sdio0_2x>;
+		clock-output-names = "clk_sdio0_1x";
+	};
diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
new file mode 100644
index 0000000..f23ecb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
@@ -0,0 +1,73 @@
+Spreadtrum gate clock driver
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Spreadtrum's SoCs often use one register to control more than one gate clocks.
+Clock consumers can use index to get the correct gate clock.
+
+In Spreadtrum platform, some of gate clocks have three registers, respectively
+used for controlling, setting and clearing gate clock, the addresses of
+these three registers generally are <start>, <start + offset>, and
+<start + offset * 2>, and offset would be 0x1000 or 0x100, so the register
+size of gate clocks is either 0x3000 or 0x300. While for some historical issue
+there also are some clocks which don't have independent set/clear registers.
+Please see bellow for more specific information.
+
+Required properties:
+
+- compatible:	should be one of the following:
+		"sprd,sc1000-gates-clock"
+		- offset of the registers for setting gate is 0x1000
+
+		"sprd,sc100-gates-clock"
+		- offset of the registers for setting gate is 0x100
+
+		"sprd,gates-clock"
+		- for clocks without independent set/clear registers
+
+- reg:	the first cell represents the address of this clock gate controller
+	register, the second cell implies how is the offset of set/clear
+	registers of this clock gate, like addressed in the head of this
+	file
+
+optional properties:
+
+- clock-indices:	If the identifying number for the clocks in the node
+			is not linear from zero, this property is necessary
+
+Example:
+
+	clk_mpll_gates: clk at 402b00b0 {
+		compatible = "sprd,sc1000-gates-clock";
+		#clock-cells = <1>;
+		reg = <0 0x402b00b0 0 0x3000>;
+		clocks = <&ext_26m>;
+		clock-indices = <2>, <18>;
+		clock-output-names = "clk_mpll0_gate", "clk_mpll1_gate";
+	};
+
+Below are two examples of how consumers use the gate clock.
+The 'clk_mpll0' uses index 2 of 'clk_mpll_gates' and 'clk_mpll1'
+uses index 18.
+
+Examples:
+
+	clk_mpll0: clk at 40400024 {
+		compatible = "sprd,sc9860-adjustable-pll-clock";
+		#clock-cells = <0>;
+		reg = <0 0x40400024 0 0x4>,
+		      <0 0x40400028 0 0x4>;
+		clocks = <&clk_mpll_gates 2>;
+		clock-output-names = "clk_mpll0";
+	};
+
+	clk_mpll1: clk at 4040002c {
+		compatible = "sprd,sc9860-adjustable-pll-clock";
+		#clock-cells = <0>;
+		reg = <0 0x4040002c 0 0x4>,
+		      <0 0x40400030 0 0x4>;
+		clocks = <&clk_mpll_gates 18>;
+		clock-output-names = "clk_mpll1";
+	};
diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt
new file mode 100644
index 0000000..b752977
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt
@@ -0,0 +1,23 @@
+Spreadtrum multiplexed clock driver
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+
+- compatible : should be "sprd,muxed-clock"
+
+- sprd,mux-msk:	arbitrary bitmask for selecting clock input
+
+Example:
+
+	clk_adi: clk at 402d0234 {
+		compatible = "sprd,muxed-clock";
+		#clock-cells = <0>;
+		reg = <0 0x402d0234 0 0x4>;
+		sprd,mux-msk = <0x7>;
+		clocks = <&clk_rco_4m>, <&ext_26m>, <&clk_rco_25m>,
+			 <&clk_twpll_38m4>, <&clk_twpll_51m2>;
+		clock-output-names = "clk_adi";
+	};
-- 
2.7.4
