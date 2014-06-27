From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:25:01 +0200
Subject: [PATCH v2 04/14] clk: st: Adds Flexgen clock binding
In-Reply-To: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1403875511-7710-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Flexgen structure is composed by:
- a clock cross bar (represented by a mux element)
- a pre and final dividers (represented by a divider and gate elements)

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  5 +++
 .../devicetree/bindings/clock/st/st,flexgen.txt    | 48 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/st/st,flexgen.txt

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
index 427bad8..78978f1 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
@@ -32,6 +32,10 @@ address is common of all subnode.
 		vcc_node {
 			...
 		};
+
+		flexgen_node {
+			...
+		};
 		...
 	};
 
@@ -45,6 +49,7 @@ Each subnode should use the binding discribe in [2]..[7]
 [5] Documentation/devicetree/bindings/clock/st,clkgen-prediv.txt
 [6] Documentation/devicetree/bindings/clock/st,vcc.txt
 [7] Documentation/devicetree/bindings/clock/st,quadfs.txt
+[8] Documentation/devicetree/bindings/clock/st,flexgen.txt
 
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
new file mode 100644
index 0000000..f2d4333
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -0,0 +1,48 @@
+Binding for a type of flexgen structure found on certain
+STMicroelectronics consumer electronics SoC devices
+
+This structure includes:
+- a clock cross bar (represented by a mux element)
+- a pre and final dividers (represented by a divider and gate elements)
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be:
+  "st,flexgen"
+
+- #clock-cells : from common clock binding; shall be set to 1.
+
+- clocks : from common clock binding
+
+- clock-output-names : From common clock binding. The block has 4
+                       clock outputs but not all of them in a specific instance
+                       have to be used in the SoC. If a clock name is left as
+                       an empty string then no clock will be created for the
+                       output associated with that string index. If fewer than
+                       4 strings are provided then no clocks will be created
+                       for the remaining outputs.
+
+Example:
+
+	clockgen-d2 at x9106000 {
+		compatible = "st,clkgen-c32";
+		reg = <0x9106000 0x1000>;
+
+		clk_s_d2_flexgen: clk-s-d2-flexgen {
+			compatible = "st,flexgen";
+
+			#clock-cells = <1>;
+			clocks = <&clk_s_d2_quadfs 0>,
+				 <&clk_s_d2_quadfs 1>,
+				 <&clk_s_d2_quadfs 2>,
+				 <&clk_s_d2_quadfs 3>;
+
+			clock-output-names = "clk-pix-main-disp",
+					     "clk-pix-pip",
+					     "clk-pix-gdp1",
+					     "clk-pix-gdp2";
+		};
+	};
-- 
1.9.1
