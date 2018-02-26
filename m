From: nobuhiro.iwamatsu@cybertrust.co.jp (Nobuhiro Iwamatsu)
Date: Mon, 26 Feb 2018 09:59:48 +0900
Subject: [PATCH 1/2] arm: dts: zynq: Add Digilent Zybo Z7 board
Message-ID: <20180226005949.31259-1-nobuhiro.iwamatsu@cybertrust.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add a DTS for the Digilent Zybo Z7 board.
This board is the successor board of Zybo, these are almost the same except
for ps-clk-frequency specifications.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
---
 arch/arm/boot/dts/Makefile         |  3 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/zynq-zybo-z7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..62605d600681 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1067,7 +1067,8 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc702.dtb \
 	zynq-zc706.dtb \
 	zynq-zed.dtb \
-	zynq-zybo.dtb
+	zynq-zybo.dtb \
+	zynq-zybo-z7.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-db.dtb \
 	armada-370-dlink-dns327l.dtb \
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
new file mode 100644
index 000000000000..97e487913f8f
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -0,0 +1,65 @@
+/*
+ * Digilent Zybo Z7 board DTS
+ *
+ *  Copyright (C) 2017 Cybertrust Japan Co., Ltd.
+ *  Copyright (C) 2017 Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
+ *
+ *  SPDX-License-Identifier:	GPL-2.0+
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	model = "Zynq ZYBO Z7 Development Board";
+	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
+
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "";
+		stdout-path = "serial0:115200n8";
+	};
+
+	usb_phy0: phy0 {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio0 46 1>;
+	};
+};
+
+&clkc {
+	ps-clk-frequency = <33333333>;
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 0 {
+		reg = <0>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
-- 
2.16.1
