From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:52 +0200
Subject: [PATCH 090/102] arm64: dts: renesas: initial V3HSK board device tree
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <116a12f7d6c00e1e477aaec9e486cd510fa1895c.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device  tree for  the V3H Starter Kit board.
The board has 1 debug serial port (SCIF0); include support for it,
so that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts | 60 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index a235961c6532..9e2394bc3c62 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -9,6 +9,6 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb r8a77965-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
-dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb
+dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb r8a77980-v3hsk.dtb
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
new file mode 100644
index 000000000000..c9680994555d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the V3H Starter Kit board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+
+/dts-v1/;
+#include "r8a77980.dtsi"
+
+/ {
+	model = "Renesas V3H Starter Kit board";
+	compatible = "renesas,v3hsk", "renesas,r8a77980";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0 0x48000000 0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_b";
+		function = "scif_clk";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>, <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
-- 
2.11.0
