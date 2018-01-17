From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 15:41:09 +0100
Subject: [PATCH 1/5] arm: zynq: Add Xilinx cc108 board
In-Reply-To: <cover.1516200065.git.michal.simek@xilinx.com>
References: <cover.1516200065.git.michal.simek@xilinx.com>
Message-ID: <2dd39101153bb1985180c856f17bd60ca79d620f.1516200065.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board contains 7z010 with 512MB memory, ethernet, qspi, uart, usbs
and sd. But board is not supporting booting from sd card.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/Makefile       |  1 +
 arch/arm/boot/dts/zynq-cc108.dts | 75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-cc108.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..679cd258bc1f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1036,6 +1036,7 @@ dtb-$(CONFIG_ARCH_VT8500) += \
 	wm8750-apc8750.dtb \
 	wm8850-w70v2.dtb
 dtb-$(CONFIG_ARCH_ZYNQ) += \
+	zynq-cc108.dtb \
 	zynq-microzed.dtb \
 	zynq-parallella.dtb \
 	zynq-zc702.dtb \
diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
new file mode 100644
index 000000000000..1a0f631c1d8d
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-cc108.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CC108 board DTS
+ *
+ * (C) Copyright 2007-2018 Xilinx, Inc.
+ * (C) Copyright 2007-2013 Michal Simek
+ * (C) Copyright 2007-2012 PetaLogix Qld Pty Ltd
+ *
+ * Michal SIMEK <monstr@monstr.eu>
+ */
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
+	model = "Xilinx Zynq";
+
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+
+	usb_phy0: phy0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+
+	usb_phy1: phy1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&sdhci1 {
+	status = "okay";
+	broken-cd ;
+	wp-inverted ;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy1>;
+};
-- 
1.9.1
