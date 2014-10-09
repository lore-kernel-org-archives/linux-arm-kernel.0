From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 9 Oct 2014 15:44:27 -0700
Subject: [PATCH V4 3/7] dt-bindings: Document Broadcom Cygnus SoC and clock
 driver
In-Reply-To: <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1412894671-5921-4-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathar@broadcom.com>

Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/arm/bcm/cygnus.txt         |   31 +++++
 .../devicetree/bindings/clock/clk-cygnus.txt       |  121 ++++++++++++++++++++
 .../devicetree/bindings/clock/clk-iproc.txt        |   48 ++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-iproc.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/cygnus.txt b/Documentation/devicetree/bindings/arm/bcm/cygnus.txt
new file mode 100644
index 0000000..4c77169
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/cygnus.txt
@@ -0,0 +1,31 @@
+Broadcom Cygnus device tree bindings
+------------------------------------
+
+
+Boards with Cygnus SoCs shall have the following properties:
+
+Required root node property:
+
+BCM11300
+compatible = "brcm,bcm11300", "brcm,cygnus";
+
+BCM11320
+compatible = "brcm,bcm11320", "brcm,cygnus";
+
+BCM11350
+compatible = "brcm,bcm11350", "brcm,cygnus";
+
+BCM11360
+compatible = "brcm,bcm11360", "brcm,cygnus";
+
+BCM58300
+compatible = "brcm,bcm58300", "brcm,cygnus";
+
+BCM58302
+compatible = "brcm,bcm58302", "brcm,cygnus";
+
+BCM58303
+compatible = "brcm,bcm58303", "brcm,cygnus";
+
+BCM58305
+compatible = "brcm,bcm58305", "brcm,cygnus";
diff --git a/Documentation/devicetree/bindings/clock/clk-cygnus.txt b/Documentation/devicetree/bindings/clock/clk-cygnus.txt
new file mode 100644
index 0000000..7e03837
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clk-cygnus.txt
@@ -0,0 +1,121 @@
+Broadcom Cygnus Clock Controller
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The Cygnus clock controller manages several PLL's and their channels, found only
+on the Cygnus chip. Clocks that are common to iProc can be found in the iProc
+clock controller. The controllers are split into a parent-child relationship
+where the parent is the PLL and the child controls the PLL's channels.
+
+All PLL's are derived from a 25MHz oscillator. The PLL's controlled are the
+GENPLL, LCPLL, the MIPI PLL. In addition, there are two clocks derived from
+GENPLL channel 0, and three that are derived directly from the oscillator.
+
+Required properties:
+- compatible: Must be one of the following:
+    "brcm,cygnus-lcpll-clk" - Controls LCPLL.
+    "brcm,cygnus-lcpll-ch" -  Controls LCPLL (parent) channels
+    "brcm,cygnus-genpll-clk" - Controls parent GENPLL
+    "brcm,cygnus-genpll-ch" - Controls GENPLL (parent) channels
+    "brcm,cygnus-mipipll-clk" - Controls MIPI PLL
+    "brcm,cygnus-mipipll-ch" - Controls parent MIPI PLL (parent) channels
+    "brcm,cygnus-osc-derived" - Controls oscillator (parent) derived channels
+        not controlled by any PLL.
+    "brcm,cygnus-pll-derived" - Controls clocks derived from GENPLL channel 0.
+	  These clocks have hard wired internal dividers and their clock rates
+	  scale according to the GENPLL channel.
+
+- reg: First register is the base address of the PLL. Register 2 and 3 are
+  required by some clocks. They are the top clock gating control used to
+  enable/disable clocks (ch 1), and the CRMU PLL AON CONTROL register which
+  powers on PLL/LDO's (ch 2).
+
+- clocks: The input parent clock phandle for the clock. This is either a PLL,
+  oscillator, or GENPLL channel 0.
+
+- channel: The PLL channel that the clock belongs to. This is used for
+  "brcm,cygnus-lcpll-ch", "brcm,cygnus-genpll-ch", "brcm,cygnus-mipipll-ch",
+  "brcm,cygnus-osc-derived" only.
+
+- div: Used by "brcm,cygnus-pll-derived" to define the hard coded internal
+  divider value. Used by "brcm,cygnus-osc-derived" to specify the programmable
+  divider.
+
+- #clock-cells: From common clock binding; shall be set to 0.
+
+Examples:
+
+		osc: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
+		lcpll: lcpll at 0301d02c {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-lcpll-clk";
+			reg = <0x0301d02c 0x1c>;
+			clocks = <&osc>;
+		};
+
+		genpll: genpll at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-clk";
+			reg = <0x0301d000 0x2c>,
+				  <0x180AA024 0x4>,
+				  <0x0301C020 0x4>;
+			clocks = <&osc>;
+		};
+
+		axi21_clk: genpll_ch0 at 0301d000 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-genpll-ch";
+			reg = <0x0301d000 0x2c>;
+			clocks = <&genpll>;
+			channel = <0>;
+		};
+
+		pcie_clk: lcpll_ch0 at 0301d02c {
+			compatible = "brcm,cygnus-lcpll-ch";
+			reg = <0x0301d02c 0x1c>;
+			#clock-cells = <0>;
+			clocks = <&lcpll>;
+			channel = <0>;
+		};
+
+		axi41_clk: axi41_clk {
+			reg = <0x0301d000 0x2c>;
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-pll-derived";
+			clocks = <&axi21_clk>;
+			div = <2>;
+		};
+
+		keypad_clk: keypad_clk at 0301D048 {
+			compatible = "brcm,cygnus-osc-derived";
+			reg = <0x0301D048 0x4>,
+				  <0x180AA024 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			channel = <0>;
+			div = <392>;
+		};
+
+		mipipll: mipipll at 180a9800 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-mipipll-clk";
+			reg = <0x180a9800 0x2c>,
+				  top_clk_gating_ctrl: <0x180AA024 0x4>,
+				  crmu_pll_aon_ctrl: <0x0301C020 0x4>;
+			clocks = <&osc>;
+		};
+
+		lcd_clk: mipipll_ch1 at 180a9800 {
+			#clock-cells = <0>;
+			compatible = "brcm,cygnus-mipipll-ch";
+			reg = <0x180a9800 0x2c>,
+				  <0x180AA024 0x4>;
+			clocks = <&mipipll>;
+			channel = <1>;
+		};
diff --git a/Documentation/devicetree/bindings/clock/clk-iproc.txt b/Documentation/devicetree/bindings/clock/clk-iproc.txt
new file mode 100644
index 0000000..b5d4f08
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clk-iproc.txt
@@ -0,0 +1,48 @@
+Broadcom iProc Clock Controller
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The iProc clock controller manages clocks that are common to iProc chips.
+The controllers are split into a parent-child relationship where the parent is
+the PLL and the child controls the PLL's channels.
+
+The only PLL controlled is the ARM PLL which is derived from a 25MHz crystal.
+
+Required properties:
+- compatible: Must be one of the following:
+    "brcm,iproc-arm-a9pll" - Controls ARM PLL.
+    "brcm,iproc-arm-ch" -  Controls ARM PLL (parent) channels
+
+- reg: The base address of the PLL.
+
+- clocks: The input parent clock phandle for the clock. This is either a PLL,
+  or oscillator.
+
+- channel: The PLL channel that the clock belongs to. This is used for
+  "brcm,iproc-arm-ch" only.
+
+- #clock-cells: From common clock binding; shall be set to 0.
+
+Example:
+
+	osc: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+	};
+
+	a9pll: arm_clk at 19000000 {
+		compatible = "brcm,iproc-arm-a9pll";
+		reg = <0x19000000 0x1000>;
+		#clock-cells = <0>;
+		clocks = <&osc>;
+	};
+
+	periph_clk: periph_clk at 19000000 {
+		compatible = "brcm,iproc-arm-ch";
+		reg = <0x19000000 0x1000>;
+		#clock-cells = <0>;
+		clocks = <&a9pll>;
+		channel = <3>;
+	};
-- 
1.7.9.5
