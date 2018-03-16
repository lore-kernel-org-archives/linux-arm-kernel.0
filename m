From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:03 +0100
Subject: [PATCH 33/69] arm64: dts: renesas: initial Condor board device tree
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <b9edbce9155c718a1eeed535e88f88d4b6ef7783.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the initial device  tree for  the R8A77980 SoC based Condor board.
The board has 1 debug serial port (SCIF0); include support for it, so
that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: correct memory size to 0x78000000 (2GiB)]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile            |  1 +
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 45 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-condor.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 2186d0193b73..c885eef4e660 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -8,4 +8,5 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
+dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
new file mode 100644
index 000000000000..daf2957d3504
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Condor board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+
+/dts-v1/;
+#include "r8a77980.dtsi"
+
+/ {
+	model = "Renesas Condor board based on r8a77980";
+	compatible = "renesas,condor", "renesas,r8a77980";
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
+&scif0 {
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
-- 
2.11.0
