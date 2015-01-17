From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:40 +0900
Subject: [PATCH 07/11] ARM: shmobile: Add DT bindings for Renesas memory
 controllers
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <753b9c9cfdfeae57f956c55e1ccdfcf2d90e6196.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add DT bindings for Renesas R-Mobile and SH-Mobile memory controllers.
Currently memory controller device nodes are used only to reference PM
domains, and prevent these PM domains from being powered down, which
would crash the system.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../renesas-memory-controllers.txt                 | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt b/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
new file mode 100644
index 0000000..c64b792
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
@@ -0,0 +1,44 @@
+DT bindings for Renesas R-Mobile and SH-Mobile memory controllers
+=================================================================
+
+Renesas R-Mobile and SH-Mobile SoCs contain one or more memory controllers.
+These memory controllers differ from one SoC variant to another, and are called
+by different names ("DDR Bus Controller (DBSC)", "DDR3 Bus State Controller
+(DBSC3)", "SDRAM Bus State Controller (SBSC)").
+
+Currently memory controller device nodes are used only to reference PM
+domains, and prevent these PM domains from being powered down, which would
+crash the system.
+
+As there exist no actual drivers for these controllers yet, these bindings
+should be considered EXPERIMENTAL for now.
+
+Required properties:
+  - compatible: Must be one of the following SoC-specific values:
+		  - "renesas,dbsc-r8a73a4" (R-Mobile APE6)
+		  - "renesas,dbsc3-r8a7740" (R-Mobile A1)
+		  - "renesas,sbsc-sh73a0" (SH-Mobile AG5)
+  - reg: Must contain the base address and length of the memory controller's
+	 registers.
+
+Optional properties:
+  - interrupts: Must contain a list of interrupt specifiers for memory
+		controller interrupts, if available.
+  - interrupts-names: Must contain a list of interrupt names corresponding to
+		      the interrupts in the interrupts property, if available.
+		      Valid interrupt names are:
+			- "sec" (secure interrupt)
+			- "temp" (normal (temperature) interrupt)
+  - power-domains: Must contain a reference to the PM domain that the memory
+		   controller belongs to, if available.
+
+Example:
+
+	sbsc1: memory-controller at fe400000 {
+		compatible = "renesas,sbsc-sh73a0";
+		reg = <0xfe400000 0x400>;
+		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sec", "temp";
+		power-domains = <&pd_a4bc0>;
+	};
-- 
2.1.4
