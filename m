From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:06 +0900
Subject: [PATCH 3/4] drivers: bus: Add Simple Power-Managed Bus DT Bindings
In-Reply-To: <cover.1421371868.git.horms+renesas@verge.net.au>
References: <cover.1421371868.git.horms+renesas@verge.net.au>
Message-ID: <892517727ea400046d8e611ac027479f2a4a7378.1421371868.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/bus/simple-pm-bus.txt      | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
new file mode 100644
index 0000000..d03abf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
@@ -0,0 +1,52 @@
+Simple Power-Managed Bus
+========================
+
+A Simple Power-Managed Bus is a transparent bus that doesn't need a real
+driver, as it's typically initialized by the boot loader.
+
+However, its bus controller is part of a PM domain, or under the control of a
+functional clock.  Hence, the bus controller's PM domain and/or clock must be
+enabled for child devices connected to the bus (either on-SoC or externally)
+to function.
+
+
+Generic compatible values and properties
+----------------------------------------
+
+Required properties:
+  - compatible: Must be at least one of the vendor-specific compatible values
+		from a vendor-specific section below, and "simple-bus" as a
+		fallback.
+  - #address-cells, #size-cells, ranges: Must describe the mapping between
+		parent address and child address spaces.
+
+Optional platform-specific properties for clock or PM domain control (at least
+one of them is required):
+  - clocks: Must contain a reference to the functional clock(s),
+  - power-domains: Must contain a reference to the PM domain.
+
+
+Vendor-specific compatible values and properties
+------------------------------------------------
+
+Renesas Bus State Controller (BSC):
+  - compatible: Must be an SoC-specific value, and "renesas,bsc" as a fallback.
+                SoC-specific values can be:
+		"renesas,bsc-r8a73a4" for R-Mobile APE6 (r8a73a4)
+		"renesas,bsc-sh73a0" for SH-Mobile AG5 (sh73a0)
+  - reg: Must contain the base address and length to access the bus controller.
+  - interrupts: Must contain a reference to the BSC interrupt, if available.
+
+
+Example:
+
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x20000000>;
+		reg = <0xfec10000 0x400>;
+		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&zb_clk>;
+		power-domains = <&pd_a4s>;
+	};
-- 
2.1.4
