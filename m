From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 Jan 2014 18:22:54 +0000
Subject: [PATCH 2/2] ARM: add DT support for cubox-i platforms
In-Reply-To: <20140116182211.GX15937@n2100.arm.linux.org.uk>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
Message-ID: <E1W3rag-00009y-8V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/Makefile             |  2 +
 arch/arm/boot/dts/imx6dl-cubox-i.dts   | 12 ++++++
 arch/arm/boot/dts/imx6q-cubox-i.dts    | 16 +++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 78 ++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 875af333c6dc..1eeae00d9d09 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,11 +136,13 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-cubox-i.dtb \
 	imx6dl-hummingboard.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
+	imx6q-cubox-i.dtb \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
new file mode 100644
index 000000000000..58aa8f2b0f26
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) 2014 Russell King
+ */
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-cubox-i.dtsi"
+
+/ {
+	model = "SolidRun Cubox-i Solo/DualLite";
+	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
new file mode 100644
index 000000000000..bc5f31e3e892
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2014 Russell King
+ */
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-cubox-i.dtsi"
+
+/ {
+	model = "SolidRun Cubox-i Dual/Quad";
+	compatible = "solidrun,cubox-i/q", "fsl,imx6q";
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
new file mode 100644
index 000000000000..6fbca9063b10
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2014 Russell King
+ */
+#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-microsom-ar8035.dtsi"
+
+/ {
+	ir_recv: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio3 9 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cubox_i_ir>;
+	};
+
+	codec: spdif-transmitter {
+		compatible = "linux,spdif-dit";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cubox_i_spdif>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		/* IMX6 doesn't implement this yet */
+		spdif-controller = <&spdif>;
+		spdif-out;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_1>;
+
+	status = "okay";
+
+	rtc: pcf8523 at 68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	cubox_i {
+		pinctrl_cubox_i_ir: cubox_i-ir {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09 0x80000000
+			>;
+		};
+
+		pinctrl_cubox_i_spdif: cubox_i-spdif {
+			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0>;
+		};
+
+		pinctrl_cubox_i_usdhc2: cubox_i-usdhc2 {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+				MX6QDL_PAD_GPIO_4__SD2_CD_B    0x1f071
+			>;
+		};
+	};
+};
+
+&spdif {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cubox_i_usdhc2>;
+	vmmc-supply = <&reg_3p3v>;
+	fsl,cd-controller;
+	status = "okay";
+};
-- 
1.8.3.1
