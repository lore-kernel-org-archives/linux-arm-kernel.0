From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Oct 2015 15:01:50 +0900
Subject: [PATCH v12 5/7] arm64: renesas: add Salvator-X board support on DTS
In-Reply-To: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1445839312-8874-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add initial board support for r8a7795 Salvator-X. At this point
only DEBUG0 and DEBUG1 serial ports are supported.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
TODO:
- Conclude discussion with Mark Rutland on:
  + Presence of ignore_loglevel in bootargs
  + Absence of rate in stdout-path

Changes since v10:
- None

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
 - Added board specific EXTAL information by folding in:
  [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- None

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Added changelog

Based on:
 [PATCH 15/25] arm64: renesas: add Salvator-X board support on DTS
 [PATCH 5/5] arm64: renesas: salvator-x: Update SCIF2 pin group
 [PATCH 5/6] arm64: renesas: salvator-x: Enable SCIF1 on serial1
---
 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 arch/arm64/boot/dts/renesas/Makefile               |  2 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 62 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 8d696a0d62b3..95d0aea4c701 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -59,6 +59,8 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Salvator-X
+    compatible = "renesas,salvator-x", "renesas,r8a7795";
 
 Note: Reference Device Tree Implementations are temporary implementations
       to ease the migration from platform devices to Device Tree, and are
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index fec69f46d65b..9ce1890a650e 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,2 +1,4 @@
+dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb
+
 always		:= $(dtb-y)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
new file mode 100644
index 000000000000..f522fda7843a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -0,0 +1,62 @@
+/*
+ * Device Tree Source for the Salvator-X board
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7795.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a7795";
+	compatible = "renesas,salvator-x", "renesas,r8a7795";
+
+	aliases {
+		serial0 = &scif2;
+		serial1 = &scif1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = &scif2;
+	};
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&pfc {
+	scif1_pins: scif1 {
+		renesas,groups = "scif1_data_a", "scif1_ctrl";
+		renesas,function = "scif1";
+	};
+	scif2_pins: scif2 {
+		renesas,groups = "scif2_data_a";
+		renesas,function = "scif2";
+	};
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.1.4
