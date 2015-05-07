From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  7 May 2015 18:48:36 +0200
Subject: [PATCH v3 6/7] ARM: dts: Add DT for Hitex LPC4350 Evaluation Board
In-Reply-To: <1431017317-23740-1-git-send-email-manabian@gmail.com>
References: <1431017317-23740-1-git-send-email-manabian@gmail.com>
Message-ID: <1431017317-23740-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel.dalessandro@gmail.com>

Add basic support for Hitex LPC4350 Evaluation Board. Board
features a LPC4350 Soc, 8 MB SDRAM, 8 MB SPI Flash, USB and
Ethernet.

More information can be found on:
http://www.hitex.com/index.php?id=3212

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@gmail.com>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           | 45 ++++++++++++++++++++++
 arch/arm/boot/dts/lpc4350.dtsi                     | 39 +++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc4350-hitex-eval.dts
 create mode 100644 arch/arm/boot/dts/lpc4350.dtsi

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae3460c0e5fd..7e7d7a7cae2c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -94,6 +94,7 @@ haoyu	Haoyu Microelectronic Co. Ltd.
 himax	Himax Technologies, Inc.
 hisilicon	Hisilicon Limited.
 hit	Hitachi Ltd.
+hitex	Hitex Development Tools
 honeywell	Honeywell
 hp	Hewlett Packard
 i2se	I2SE GmbH
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b95d8a6a1e36..1e5b2ea02aad 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -202,6 +202,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC18XX) += \
+	lpc4350-hitex-eval.dtb \
 	lpc4357-ea4357-devkit.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	ea3250.dtb phy3250.dtb
diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
new file mode 100644
index 000000000000..d04072f40817
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -0,0 +1,45 @@
+/*
+ * Hitex LPC4350 Evaluation Board
+ *
+ * Copyright 2015 Ariel D'Alessandro <ariel.dalessandro@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+/dts-v1/;
+
+#include "lpc18xx.dtsi"
+#include "lpc4350.dtsi"
+
+/ {
+	model = "Hitex LPC4350 Evaluation Board";
+	compatible = "hitex,lpc4350-eval-board", "nxp,lpc4350";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x28000000 0x800000>; /* 8 MB */
+	};
+};
+
+&pll1 {
+	clock-mult = <15>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/lpc4350.dtsi b/arch/arm/boot/dts/lpc4350.dtsi
new file mode 100644
index 000000000000..c4422f587055
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4350.dtsi
@@ -0,0 +1,39 @@
+/*
+ * NXP LPC4350 and LPC4330 SoC
+ *
+ * Copyright 2015 Ariel D'Alessandro <ariel.dalessandro@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+
+/ {
+	compatible = "nxp,lpc4350", "nxp,lpc4330";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-m4";
+		};
+	};
+
+	soc {
+		sram0: sram at 10000000 {
+			compatible = "mmio-sram";
+			reg = <0x10000000 0x20000>; /* 96 + 32 KiB local SRAM */
+		};
+
+		sram1: sram at 10080000 {
+			compatible = "mmio-sram";
+			reg = <0x10080000 0x12000>; /* 64 + 8 KiB local SRAM */
+		};
+
+		sram2: sram at 20000000 {
+			compatible = "mmio-sram";
+			reg = <0x20000000 0x10000>; /* 4 x 16 KiB AHB SRAM */
+		};
+	};
+};
-- 
1.8.0
