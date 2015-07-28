From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 29 Jul 2015 01:14:59 +0300
Subject: [PATCH v3] ARM: shmobile: silk: initial device tree
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <2360526.88foRQAOiM@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device  tree for the R8A7794 SoC based SILK low cost board.
SCIF2 serial port support is included, so that the serial console can work.

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20150728-v4.2-rc4' tag of Simon
Horman's 'renesas.git' repo. It requires R8A7794 PFC DT patch posted yesterday
in order to compile.

Changes in version 3:
- refreshed the patch;
- reformatted the changelog.

Changes in version 2:
- removed "console=" parameter from the kernel command line;
- added PFC node with SCIF2 pins subnode and referred it from the SCIF2 node;
- rebased the patch
- mentioned the origin of patch in the changelog.

 arch/arm/boot/dts/Makefile         |    1 
 arch/arm/boot/dts/r8a7794-silk.dts |   51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -515,6 +515,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7791-koelsch.dtb \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
+	r8a7794-silk.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree Source for the SILK board
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2014-2015 Renesas Solutions Corp.
+ * Copyright (C) 2014-2015 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7794.dtsi"
+
+/ {
+	model = "SILK";
+	compatible = "renesas,silk", "renesas,r8a7794";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = &scif2;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&pfc {
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_data";
+		renesas,function = "scif2";
+	};
+};
+
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
