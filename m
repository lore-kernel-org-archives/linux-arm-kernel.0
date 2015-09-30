From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 01 Oct 2015 02:02:27 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: porter: initial device tree
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <2525707.dTm8VYu5Xs@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device tree for the R8A7791 SoC based Porter low cost board
(which  is a  slightly modified version  of the Henninger board).

SCIF0 serial port support is included, so that the serial console can work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
This patch is against the 'renesas-devel-20150930-v4.3-rc3' tag of Simon
Horman's 'renesas.git' repo.

Changes in version 2:
- removed the 'console=' kernel parameter from the "bootargs" prop;
- removed trailing space in the change log;
- added Geert's ACK.

 arch/arm/boot/dts/Makefile           |    1 
 arch/arm/boot/dts/r8a7791-porter.dts |   54 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -532,6 +532,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7791-porter.dtb \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -0,0 +1,54 @@
+/*
+ * Device Tree Source for the Porter board
+ *
+ * Copyright (C) 2015 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7791.dtsi"
+
+/ {
+	model = "Porter";
+	compatible = "renesas,porter", "renesas,r8a7791";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = &scif0;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&pfc {
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_d";
+		renesas,function = "scif0";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
