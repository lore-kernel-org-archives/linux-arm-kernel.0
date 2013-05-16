From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 16 May 2013 14:10:48 +0800
Subject: [PATCH v3 4/4] ARM: dts: add initial MVF600 Tower board dts support
In-Reply-To: <1368684648-20826-1-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
Message-ID: <1368684648-20826-5-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial MVF600 Tower board  support with uart, fec,
i2c, qspi, and sai enabled.

Signed-off-by: Xiaochun Li <b41219@freescale.com>
Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
v3:
  split DTS support to SoC and board patches.
  sort node by alphabet order of labels.

 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/mvf600-twr.dts | 108 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mvf600-twr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 87e603c..968164b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -122,7 +122,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
-	imx6sl-evk.dtb
+	imx6sl-evk.dtb \
+	mvf600-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx23-olinuxino.dtb \
 	imx23-stmp378x_devb.dtb \
diff --git a/arch/arm/boot/dts/mvf600-twr.dts b/arch/arm/boot/dts/mvf600-twr.dts
new file mode 100644
index 0000000..fe2e0e6
--- /dev/null
+++ b/arch/arm/boot/dts/mvf600-twr.dts
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/dts-v1/;
+#include "mvf600.dtsi"
+
+/ {
+	model = "MVF600 Tower Board";
+	compatible = "fsl,mvf600-twr", "fsl,mvf600";
+
+	chosen {
+		bootargs = "console=ttyLP1,115200";
+	};
+
+	memory {
+		reg = <0x80000000 0x8000000>;
+	};
+
+	clocks {
+		audio_ext {
+			compatible = "fixed-clock";
+			clock-frequency = <24576000>;
+		};
+
+		enet_ext {
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	sound {
+		compatible = "fsl,mvf600-audio-sgtl5000";
+		model = "mvf600-sgtl5000";
+		sai-controller = <&sai2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
+
+};
+
+&fec0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec0_1>;
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1_1>;
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0_1>;
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks MVF600_CLK_SAI2>;
+	};
+};
+
+&qspi0 { /* QuadSPI0 */
+	fsl,spi-num-chipselects = <1>;
+	fsl,spi-flash-chipselects = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0_1>;
+	status = "okay";
+
+	flash: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		linux,modalias = "m25p80";
+		modal = "s25fl128s";
+		partition at 0 {
+			label = "s25fl128s";
+			reg = <0x0 0x1000000>;
+		};
+	};
+};
+
+&sai2 {
+	fsl,mode = "i2s-slave";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2_1>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
-- 
1.8.0
