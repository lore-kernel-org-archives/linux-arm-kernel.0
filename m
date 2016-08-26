From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 26 Aug 2016 23:21:42 +0300
Subject: [PATCH 2/3] ARM: dts: wheat: initial device tree
In-Reply-To: <3665116.9BjHTnhfR3@wasted.cogentembedded.com>
References: <3665116.9BjHTnhfR3@wasted.cogentembedded.com>
Message-ID: <4464163.ssfn2FILGm@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the initial device tree for the R8A7792  SoC based Wheat board.
The Wheat board itself has  no serial ports  wired up, the USB serial chips
are situated on a separate  debug board and  one of them is connected to
SCFI0  -- include unconditional support for  it, so that the serial console
can work.

Based  on the original (and large) patch by Vladimir Barinov 
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/Makefile          |    1 
 arch/arm/boot/dts/r8a7792-wheat.dts |   50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
===================================================================
--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -659,6 +659,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7791-koelsch.dtb \
 	r8a7791-porter.dtb \
 	r8a7792-blanche.dtb \
+	r8a7792-wheat.dtb \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7792-wheat.dts
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -0,0 +1,50 @@
+/*
+ * Device Tree Source for the Wheat board
+ *
+ * Copyright (C) 2016 Renesas Electronics Corporation
+ * Copyright (C) 2016 Cogent  Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7792.dtsi"
+
+/ {
+	model = "Wheat";
+	compatible = "renesas,wheat", "renesas,r8a7792";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
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
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
