From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 10 May 2018 21:12:30 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: initial V3HSK board device tree
In-Reply-To: <3923fc5f-103c-94c9-57ba-cb29e8c55d05@cogentembedded.com>
References: <3923fc5f-103c-94c9-57ba-cb29e8c55d05@cogentembedded.com>
Message-ID: <50de037c-7560-c261-f96a-f86065674c9b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device  tree for  the V3H Starter Kit board.
The board has 1 debug serial port (SCIF0); include support for it,
so that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/Makefile           |    2 
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts |   60 +++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

Index: renesas/arch/arm64/boot/dts/renesas/Makefile
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/Makefile
+++ renesas/arch/arm64/boot/dts/renesas/Makefile
@@ -9,6 +9,6 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb r8a77965-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
-dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb
+dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb r8a77980-v3hsk.dtb
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
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
