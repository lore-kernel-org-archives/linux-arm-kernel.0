From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 2 Jul 2014 17:02:50 +0800
Subject: [PATCH 3/5] ARM: dts: Add initial LS1021A TWR board dts support
In-Reply-To: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1404291772-2644-4-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen Lu <B46807@freescale.com>
Signed-off-by: Chao Fu <B44548@freescale.com>
Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/boot/dts/Makefile        |   3 +-
 arch/arm/boot/dts/ls1021a-twr.dts | 236 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100755 arch/arm/boot/dts/ls1021a-twr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0569312..4482cc5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -236,7 +236,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	vf610-colibri.dtb \
 	vf610-cosmic.dtb \
 	vf610-twr.dtb \
-	ls1021a-qds.dtb
+	ls1021a-qds.dtb \
+	ls1021a-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx23-olinuxino.dtb \
 	imx23-stmp378x_devb.dtb \
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
new file mode 100755
index 0000000..16e4d7a
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -0,0 +1,236 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/dts-v1/;
+#include "ls1021a.dtsi"
+
+/ {
+	model = "LS1021A TWR Board";
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,vf610-sgtl5000";
+		simple-audio-card,name = "FSL-VF610-TWR-BOARD";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu = <&sai2>;
+
+		simple-audio-card,codec = <&codec>;
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&dspi1 {
+	bus-num = <0>;
+	status = "okay";
+
+	dspiflash: s25fl064k at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl064k";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&enet0 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&phy2>;
+	phy-connection-type = "sgmii";
+	status = "ok";
+};
+
+&enet1 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&phy0>;
+	phy-connection-type = "sgmii";
+	status = "ok";
+};
+
+&enet2 {
+	phy-handle = <&phy1>;
+	phy-connection-type = "rgmii-id";
+	status = "ok";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	codec: sgtl5000 at 14 {
+		compatible = "fsl,sgtl5000";
+		reg = <0x14>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		clocks = <&platform_clk 1>;
+	};
+};
+
+&ifc {
+	status = "okay";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	/* NOR, and CPLD on board */
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
+		0x2 0x0 0x0 0x7fb00000 0x00000100>;
+
+		nor at 0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition at 0 {
+				/* 128KB for rcw */
+				reg = <0x00000000 0x0020000>;
+				label = "NOR bank0 RCW Image";
+			};
+
+			partition at 20000 {
+				/* 1MB for DTB */
+				reg = <0x00020000 0x00100000>;
+				label = "NOR DTB Image";
+			};
+
+			partition at 120000 {
+				/* 8 MB for Linux Kernel Image */
+				reg = <0x00120000 0x00800000>;
+				label = "NOR Linux Kernel Image";
+			};
+
+			partition at 920000 {
+				/* 56MB for Ramdisk Root File System */
+				reg = <0x00920000 0x03600000>;
+				label = "NOR Ramdisk Root File System Image";
+			};
+
+			partition at 3f80000 {
+				/* 512KB for bank4 u-boot Image */
+				reg = <0x03f80000 0x80000>;
+				label = "NOR bank4 u-boot Image";
+			};
+
+			partition at 4000000 {
+				/* 128KB for bank4 RCW Image */
+				reg = <0x04000000 0x20000>;
+				label = "NOR bank4 RCW Image";
+			};
+
+			partition at 4020000 {
+				/* 63MB JFFS2 ROOT File System Image */
+				reg = <0x04020000 0x3f00000>;
+				label = "NOR JFFS2 ROOT File System Image";
+			};
+
+			partition at 7f80000 {
+				/* 512KB for bank0 u-boot Image */
+				reg = <0x07f80000 0x80000>;
+				label = "NOR bank0 u-boot Image";
+			};
+
+		};
+
+		fpga: board-control at 2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ls1021aqds-fpga", "fsl,fpga-qixis";
+			reg = <0x2 0x0 0x00000100>;
+			bank-width = <1>;
+			device-width = <1>;
+			ranges = <0 2 0 0x100>;
+		};
+
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy at 0 {
+		reg = <0x0>;
+	};
+	phy1: ethernet-phy at 1 {
+		reg = <0x1>;
+	};
+	phy2: ethernet-phy at 2 {
+		reg = <0x2>;
+	};
+	tbi1: tbi-phy at 1f {
+		reg = <0x1f>;
+		device_type = "tbi-phy";
+	};
+};
+
+&pwm6 {
+	status = "okay";
+};
+
+&pwm7 {
+	status = "okay";
+};
+
+&qspi {
+	num-cs = <2>;
+	status = "okay";
+
+	qflash0: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+
+		partition at 0 {
+			label = "s25fl128s-0";
+			reg = <0x0 0x1000000>;
+		};
+	};
+};
-- 
1.8.0
