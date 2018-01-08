From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:17 -0600
Subject: [PATCH v5 18/44] dt-bindings: clock: Add binding for TI DA8XX CFGCHIP
 mux clocks
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-19-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new binding for multiplexer clocks that are part of the
CFGCHIPn registers on TI DA8XX-like SoCs. Currently, there are only
bindings given for the ASYNC3 clock domain, but there are additional
clock multiplexers in this syscon that could be added in the future
if needed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../clock/ti/davinci/da8xx-cfgchip-mux.txt         | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-mux.txt

diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-mux.txt b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-mux.txt
new file mode 100644
index 0000000..8c874ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-mux.txt
@@ -0,0 +1,42 @@
+Binding for TI DA8XX/OMAP-L13X/AM17XX/AM18XX CFGCHIP multiplexer clocks
+
+TI DA8XX/OMAP-L13X/AM17XX/AM18XX SoCs contain a general purpose set of
+registers call CFGCHIPn. Some of these registers function as clock
+multiplexers. This document describes the bindings for those clocks.
+
+Required properties:
+- compatible: shall be "ti,da850-async3-clock".
+- #clock-cells: from common clock binding; shall be set to 0.
+- clocks: phandle list of clocks corresponding to clock-names
+- clock-names: must include the following: "pll0_sysclk2", "pll1_sysclk2".
+
+Optional properties:
+- clock-output-names: from common clock binding.
+
+Parent:
+This node must be a child of a "ti,da830-cfgchip" node.
+
+Assignment:
+The assigned-clocks and assigned-clock-parents from the common clock bindings
+can be used to indicate which parent clock should be used.
+
+Examples:
+
+        cfgchip: syscon at 1417c {
+                compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
+                reg = <0x1417c 0x14>;
+
+                async3_clk: async3 {
+                        compatible = "ti,da850-async3-clock";
+                        #clock-cells = <0>;
+                        clocks = <&pll0_sysclk 2>, <&pll1_sysclk 2>;
+                        clock-names = "pll0_sysclk2", "pll1_sysclk2";
+                        assigned-clocks = <&async3_clk>;
+                        assigned-clock-parents = <&pll1_sysclk 2>;
+                        clock-output-names = "async3";
+                };
+        };
+
+Also see:
+- Documentation/devicetree/bindings/clock/clock-bindings.txt
+
-- 
2.7.4
