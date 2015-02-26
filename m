From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:22 +0900
Subject: [PATCH 3/5] drivers: bus: Add Simple Power-Managed Bus DT Bindings
In-Reply-To: <cover.1424931637.git.horms+renesas@verge.net.au>
References: <cover.1424931637.git.horms+renesas@verge.net.au>
Message-ID: <7e7c17f10484d3bad38ea4dddc98485a8a40e4aa.1424931637.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/bus/simple-pm-bus.txt      | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
new file mode 100644
index 0000000..d032237
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
@@ -0,0 +1,44 @@
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
+While "simple-pm-bus" follows the "simple-bus" set of properties, as specified
+in ePAPR, it is not an extension of "simple-bus".
+
+
+Required properties:
+  - compatible: Must contain at least "simple-pm-bus".
+		Must not contain "simple-bus".
+		It's recommended to let this be preceded by one or more
+		vendor-specific compatible values.
+  - #address-cells, #size-cells, ranges: Must describe the mapping between
+		parent address and child address spaces.
+
+Optional platform-specific properties for clock or PM domain control (at least
+one of them is required):
+  - clocks: Must contain a reference to the functional clock(s),
+  - power-domains: Must contain a reference to the PM domain.
+Please refer to the binding documentation for the clock and/or PM domain
+providers for more details.
+
+
+Example:
+
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc",
+			     "simple-pm-bus";
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
