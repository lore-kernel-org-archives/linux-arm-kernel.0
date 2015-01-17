From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:35 +0900
Subject: [PATCH 02/11] PM / Domains: Add DT bindings for the R-Mobile System
 Controller
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <3b8df3903465803f47902fe0510628efdd6ab5a3.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas R-Mobile System Controller provides a.o. power management
support, following the generic PM domain bindings in
Documentation/devicetree/bindings/power/power_domain.txt.

For now this supports the R-Mobile A1 (r8a7740) only, but it should be
sufficiently generic to handle other members of the SH-Mobile/R-Mobile
family in the future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/power/renesas,sysc-rmobile.txt        | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
new file mode 100644
index 0000000..2460476
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -0,0 +1,98 @@
+DT bindings for the Renesas R-Mobile System Controller
+
+== System Controller Node ==
+
+The R-Mobile System Controller provides the following functions:
+  - Boot mode management,
+  - Reset generation,
+  - Power management.
+
+Required properties:
+- compatible: Should be "renesas,sysc-<soctype>", "renesas,sysc-rmobile" as
+	      fallback.
+	      Examples with soctypes are:
+		- "renesas,sysc-r8a7740" (R-Mobile A1)
+- reg: Two address start and address range blocks for the device:
+         - The first block refers to the normally accessible registers,
+         - the second block refers to the registers protected by the HPB
+	   semaphore.
+
+Optional nodes:
+- pm-domains: This node contains a hierarchy of PM domain nodes, which should
+  match the Power Area Hierarchy in the Power Domain Specifications section of
+  the device's datasheet.
+
+
+== PM Domain Nodes ==
+
+Each of the PM domain nodes represents a PM domain, as documented by the
+generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+The nodes should be named by the real power area names, and thus their names
+should be unique.
+
+Required properties:
+  - #power-domain-cells: Must be 0.
+
+Optional properties:
+- reg: If the PM domain is not always-on, this property must contain the bit
+       index number for the corresponding power area in the various Power
+       Control and Status Registers. The parent's node must contain the
+       following two properties:
+	 - #address-cells: Must be 1,
+	 - #size-cells: Must be 0.
+       If the PM domain is always-on, this property must be omitted.
+
+
+Example:
+
+This shows a subset of the r8a7740 PM domain hierarchy, containing the
+C5 "always-on" domain, 2 of its subdomains (A4S and A4SU), and the A3SP domain,
+which is a subdomain of A4S.
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,sysc-r8a7740", "renesas,sysc-rmobile";
+		reg = <0xe6180000 0x8000>, <0xe6188000 0x8000>;
+
+		pm-domains {
+			pd_c5: c5 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_a4s: a4s at 10 {
+					reg = <10>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3sp: a3sp at 11 {
+						reg = <11>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4su: a4su at 20 {
+					reg = <20>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
+	};
+
+
+== PM Domain Consumers ==
+
+Hardware blocks belonging to a PM domain should contain a "power-domains"
+property that is a phandle pointing to the corresponding PM domain node.
+
+Example:
+
+	tpu: pwm at e6600000 {
+		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
+		reg = <0xe6600000 0x100>;
+		clocks = <&mstp3_clks R8A7740_CLK_TPU0>;
+		power-domains = <&pd_a3sp>;
+		#pwm-cells = <3>;
+	};
-- 
2.1.4
