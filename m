From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:11:05 +0200
Subject: [PATCH 2/4] ARM: ux500: add board documentation
In-Reply-To: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
References: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1431619867-14700-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This documents the device tree bindings on the top level of
the Ux500 boards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/arm/ux500/boards.txt       | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/boards.txt

diff --git a/Documentation/devicetree/bindings/arm/ux500/boards.txt b/Documentation/devicetree/bindings/arm/ux500/boards.txt
new file mode 100644
index 000000000000..b8737a8de718
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ux500/boards.txt
@@ -0,0 +1,83 @@
+ST-Ericsson Ux500 boards
+------------------------
+
+Required properties (in root node) one of these:
+	compatible = "st-ericsson,mop500" (legacy)
+	compatible = "st-ericsson,u8500"
+
+Required node (under root node):
+
+soc: represents the system-on-chip and contains the chip
+peripherals
+
+Required property of soc node, one of these:
+	compatible = "stericsson,db8500"
+
+Required subnodes under soc node:
+
+backupram: (used for CPU spin tables and for storing data
+during retention, system won't boot without this):
+	compatible = "ste,dbx500-backupram"
+
+scu:
+	see binding for arm/scu.txt
+
+interrupt-controller:
+	see binding for arm/gic.txt
+
+timer:
+	see binding for arm/twd.txt
+
+clocks:
+	see binding for clocks/ux500.txt
+
+Example:
+
+/dts-v1/;
+
+/ {
+        model = "ST-Ericsson HREF (pre-v60) and ST UIB";
+        compatible = "st-ericsson,mop500", "st-ericsson,u8500";
+
+        soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "stericsson,db8500";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		backupram at 80150000 {
+			compatible = "ste,dbx500-backupram";
+			reg = <0x80150000 0x2000>;
+		};
+
+		intc: interrupt-controller at a0411000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0xa0411000 0x1000>,
+			      <0xa0410100 0x100>;
+		};
+
+		scu at a04100000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xa0410000 0x100>;
+		};
+
+		timer at a0410600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xa0410600 0x20>;
+			interrupts = <1 13 0x304>; /* IRQ level high per-CPU */
+			clocks = <&smp_twd_clk>;
+		};
+
+		clocks {
+			compatible = "stericsson,u8500-clks";
+
+			smp_twd_clk: smp-twd-clock {
+				#clock-cells = <0>;
+			};
+		};
+        };
+};
-- 
1.9.3
