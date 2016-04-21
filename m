From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Apr 2016 13:44:43 +1000
Subject: [PATCH 1/7] PM / Domains: Add DT bindings for the R-Car System
 Controller
In-Reply-To: <cover.1461210185.git.horms+renesas@verge.net.au>
References: <cover.1461210185.git.horms+renesas@verge.net.au>
Message-ID: <a85fff3b01ac1d67d9ef15672a9b5b5a4a44204e.1461210185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas R-Car System Controller provides power management for the
CPU cores and various coprocessors, following the generic PM domain
bindings in Documentation/devicetree/bindings/power/power_domain.txt.

This supports R-Car Gen1 (H1), Gen2, and Gen3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
new file mode 100644
index 000000000000..b74e4d4785ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -0,0 +1,48 @@
+DT bindings for the Renesas R-Car System Controller
+
+== System Controller Node ==
+
+The R-Car System Controller provides power management for the CPU cores and
+various coprocessors.
+
+Required properties:
+  - compatible: Must contain exactly one of the following:
+      - "renesas,r8a7779-sysc" (R-Car H1)
+      - "renesas,r8a7790-sysc" (R-Car H2)
+      - "renesas,r8a7791-sysc" (R-Car M2-W)
+      - "renesas,r8a7792-sysc" (R-Car V2H)
+      - "renesas,r8a7793-sysc" (R-Car M2-N)
+      - "renesas,r8a7794-sysc" (R-Car E2)
+      - "renesas,r8a7795-sysc" (R-Car H3)
+  - reg: Address start and address range for the device.
+  - #power-domain-cells: Must be 1.
+
+
+Example:
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,r8a7791-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
+
+== PM Domain Consumers ==
+
+Devices residing in a power area must refer to that power area, as documented
+by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+Required properties:
+  - power-domains: A phandle and symbolic PM domain specifier, as defined in
+		   <dt-bindings/power/r8a77*-sysc.h>.
+
+
+Example:
+
+	L2_CA15: cache-controller at 0 {
+		compatible = "cache";
+		power-domains = <&sysc R8A7791_PD_CA15_SCU>;
+		cache-unified;
+		cache-level = <2>;
+	};
-- 
2.7.0.rc3.207.g0ac5344
