From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 12 May 2015 00:00:51 +0200
Subject: [PATCH v4 5/7] ARM: dts: Add DT for Embedded Artists LPC4357
 Developers Kit
In-Reply-To: <1431381653-25356-1-git-send-email-manabian@gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
Message-ID: <1431381653-25356-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic support for Embedded Artists' LPC4357 Developer's Kit. Board
features a LPC4357 Soc, 32 MB SDRAM, 128 MB NAND Flash, 16 MB SPI
Flash, USB and Ethernet.

More information can be found on:
http://www.embeddedartists.com/products/kits/lpc4357_kit.php

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                         |  2 ++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        | 41 ++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357.dtsi                     | 39 ++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
 create mode 100644 arch/arm/boot/dts/lpc4357.dtsi

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 80339192c93e..ae3460c0e5fd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -60,6 +60,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+ea	Embedded Artists AB
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
 elan	Elan Microelectronic Corp.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db2937a..b95d8a6a1e36 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -201,6 +201,8 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
+dtb-$(CONFIG_ARCH_LPC18XX) += \
+	lpc4357-ea4357-devkit.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
new file mode 100644
index 000000000000..08a6f757f924
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -0,0 +1,41 @@
+/*
+ * Embedded Artist LPC4357 Developer's Kit
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
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
+#include "lpc4357.dtsi"
+
+/ {
+	model = "Embedded Artists' LPC4357 Developer's Kit";
+	compatible = "ea,lpc4357-developers-kit", "nxp,lpc4357", "nxp,lpc4350";
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
+		reg = <0x28000000 0x2000000>; /* 32 MB */
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/lpc4357.dtsi b/arch/arm/boot/dts/lpc4357.dtsi
new file mode 100644
index 000000000000..fb9ecc754e8d
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4357.dtsi
@@ -0,0 +1,39 @@
+/*
+ * NXP LPC435x, LPC433x, LPC4327, LPC4325, LPC4317 and LPC4315 SoC
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
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
+	compatible = "nxp,lpc4357";
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
+			reg = <0x10000000 0x8000>; /* 32 KiB local SRAM */
+		};
+
+		sram1: sram at 10080000 {
+			compatible = "mmio-sram";
+			reg = <0x10080000 0xa000>; /* 32 + 8 KiB local SRAM */
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
