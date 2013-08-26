From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 Aug 2013 12:41:42 +0800
Subject: [PATCH v2 8/8] ARM: dts: vf610-twr: Add SPI NOR support
In-Reply-To: <1377492102-23543-1-git-send-email-b32955@freescale.com>
References: <1377492102-23543-1-git-send-email-b32955@freescale.com>
Message-ID: <1377492102-23543-9-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vf610-twr has two s25fl128s SPI NOR flashs connected to QuadSpi0.
Add support for them.

Note: we enable the DDR Quad read for the two NOR flashs which runs
in 66MHz.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..e9149de 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -62,3 +62,39 @@
 	pinctrl-0 = <&pinctrl_uart1_1>;
 	status = "okay";
 };
+
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0_1>;
+	fsl,nor-size = <0x1000000>;
+	fsl,spi-num-chipselects = <2>;
+	status = "okay";
+
+	flash0: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+		m25p,ddr-quad-read = <1>;
+		reg = <0>;
+
+		partition at 0 {
+			label = "s25fl128s-0";
+			reg = <0x0 0x1000000>;
+		};
+	};
+
+	flash1: s25fl128s at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+		m25p,ddr-quad-read = <1>;
+		reg = <1>;
+
+		partition at 0x0 {
+			label = "s25fl128s-1";
+			reg = <0x0 0x1000000>;
+		};
+	};
+};
-- 
1.7.1
