From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Jan 2015 17:16:15 +0100
Subject: [PATCH v4 3/5] drivers: bus: Add Simple Power-Managed Bus DT Bindings
In-Reply-To: <1422288977-20353-1-git-send-email-geert+renesas@glider.be>
References: <1422288977-20353-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1422288977-20353-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v4:
  - Replace "simple-bus" by "simple-pm-bus",
  - Remove the "renesas,bsc" bindings. They will be specified in a
    separate document.

v3:
  - Add Tested-by,
  - Document required properties inherited from "simple-bus",
  - Document required "reg" property for "renesas,bsc",
  - Move "ranges" before "reg" in the example,

v2:
  - New.
---
 .../devicetree/bindings/bus/simple-pm-bus.txt      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
new file mode 100644
index 0000000000000000..0415e93a816c5ac0
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
@@ -0,0 +1,41 @@
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
+The bindings for the Simple Power-Managed Bus extend the bindings for
+"simple-bus", as specified in ePAPR.
+
+
+Required properties:
+  - compatible: Must contain at least "simple-pm-bus".
+		It's recommended to let this be preceded by one or more
+		vendor-specific compatible values.
+  - #address-cells, #size-cells, ranges: Must describe the mapping between
+		parent address and child address spaces.
+
+Optional platform-specific properties for clock or PM domain control (at least
+one of them is required):
+  - clocks: Must contain a reference to the functional clock(s),
+  - power-domains: Must contain a reference to the PM domain.
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
1.9.1
