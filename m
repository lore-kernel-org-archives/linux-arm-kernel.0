From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 20 Aug 2017 17:46:01 +0800
Subject: [PATCH 3/4] arm: dts: mt7623: add display related nodes
In-Reply-To: <9c4a8be621ac76594fad303d5d49ed32bd530605.1503222289.git.ryder.lee@mediatek.com>
References: <9c4a8be621ac76594fad303d5d49ed32bd530605.1503222289.git.ryder.lee@mediatek.com>
Message-ID: <42a9db86b49834188bd680d0144e639c98aafaa2.1503222289.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device nodes for the display function block.
Also, we add some missing pin macros in mt7623-pinfunc.h.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 210 ++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  41 ++++-
 include/dt-bindings/pinctrl/mt7623-pinfunc.h  |  12 ++
 3 files changed, 261 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 9ec3767..e11e5e7 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -20,6 +20,7 @@
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/reset/mt2701-resets.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "skeleton64.dtsi"
@@ -28,6 +29,11 @@
 	compatible = "mediatek,mt7623";
 	interrupt-parent = <&sysirq>;
 
+	aliases {
+		rdma0 = &rdma0;
+		rdma1 = &rdma1;
+	};
+
 	cpu_opp_table: opp_table {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -273,6 +279,17 @@
 			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	smi_common: smi at 1000c000 {
+		compatible = "mediatek,mt7623-smi-common",
+			     "mediatek,mt2701-smi-common";
+		reg = <0 0x1000c000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_SMI>,
+			 <&mmsys CLK_MM_SMI_COMMON>,
+			 <&infracfg CLK_INFRA_SMI>;
+		clock-names = "apb", "smi", "async";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
 	pwrap: pwrap at 1000d000 {
 		compatible = "mediatek,mt7623-pwrap",
 			     "mediatek,mt2701-pwrap";
@@ -286,6 +303,17 @@
 		clock-names = "spi", "wrap";
 	};
 
+	mipi_tx0: mipi-dphy at 10010000 {
+		compatible = "mediatek,mt7623-mipi-tx",
+			     "mediatek,mt2701-mipi-tx";
+		reg = <0 0x10010000 0 0x90>;
+		clocks = <&clk26m>;
+		clock-output-names = "mipi_tx0_pll";
+		#clock-cells = <0>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	cir: cir at 10013000 {
 		compatible = "mediatek,mt7623-cir";
 		reg = <0 0x10013000 0 0x1000>;
@@ -304,6 +332,17 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	iommu: mmsys_iommu at 10205000 {
+		compatible = "mediatek,mt7623-m4u",
+			     "mediatek,mt2701-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb0 &larb1 &larb2>;
+		#iommu-cells = <1>;
+	};
+
 	efuse: efuse at 10206000 {
 		compatible = "mediatek,mt7623-efuse",
 			     "mediatek,mt8173-efuse";
@@ -661,6 +700,169 @@
 		status = "disabled";
 	};
 
+	mmsys: syscon at 14000000 {
+		compatible = "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys",
+			     "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	display_components: dispsys at 14000000 {
+		compatible = "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys";
+		reg = <0 0x14000000 0 0x1000>;
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
+	ovl at 14007000 {
+		compatible = "mediatek,mt7623-disp-ovl",
+			     "mediatek,mt2701-disp-ovl";
+		reg = <0 0x14007000 0 0x1000>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_OVL>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
+		mediatek,larb = <&larb0>;
+	};
+
+	rdma0: rdma at 14008000 {
+		compatible = "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg = <0 0x14008000 0 0x1000>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_RDMA>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA>;
+		mediatek,larb = <&larb0>;
+	};
+
+	wdma at 14009000 {
+		compatible = "mediatek,mt7623-disp-wdma",
+			     "mediatek,mt2701-disp-wdma";
+		reg = <0 0x14009000 0 0x1000>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_WDMA>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
+		mediatek,larb = <&larb0>;
+	};
+
+	bls: bls at 1400a000 {
+		compatible = "mediatek,mt7623-disp-pwm",
+			     "mediatek,mt2701-disp-pwm";
+		reg = <0 0x1400a000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_MDP_BLS_26M>,
+			 <&mmsys CLK_MM_DISP_BLS>;
+		clock-names = "main", "mm";
+		status = "disabled";
+	};
+
+	color at 1400b000 {
+		compatible = "mediatek,mt7623-disp-color",
+			     "mediatek,mt2701-disp-color";
+		reg = <0 0x1400b000 0 0x1000>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_COLOR>;
+	};
+
+	dsi: dsi at 1400c000 {
+		compatible = "mediatek,mt7623-dsi",
+			     "mediatek,mt2701-dsi";
+		reg = <0 0x1400c000 0 0x1000>;
+		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DSI_ENGINE>,
+			 <&mmsys CLK_MM_DSI_DIG>,
+			 <&mipi_tx0>;
+		clock-names = "engine", "digital", "hs";
+		phys = <&mipi_tx0>;
+		phy-names = "dphy";
+		status = "disabled";
+	};
+
+	mutex: mutex at 1400e000 {
+		compatible = "mediatek,mt7623-disp-mutex",
+			     "mediatek,mt2701-disp-mutex";
+		reg = <0 0x1400e000 0 0x1000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_MUTEX_32K>;
+	};
+
+	larb0: larb at 14010000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x14010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <0>;
+		clocks = <&mmsys CLK_MM_SMI_LARB0>,
+			 <&mmsys CLK_MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
+	rdma1: rdma at 14012000 {
+		compatible = "mediatek,mt7623-disp-rdma",
+			     "mediatek,mt2701-disp-rdma";
+		reg = <0 0x14012000 0 0x1000>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
+		mediatek,larb = <&larb0>;
+	};
+
+	imgsys: syscon at 15000000 {
+		compatible = "mediatek,mt7623-imgsys",
+			     "mediatek,mt2701-imgsys",
+			     "syscon";
+		reg = <0 0x15000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	larb2: larb at 15001000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x15001000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <2>;
+		clocks = <&imgsys CLK_IMG_SMI_COMM>,
+			 <&imgsys CLK_IMG_SMI_COMM>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+	};
+
+	jpegdec: jpegdec at 15004000 {
+		compatible = "mediatek,mt7623-jpgdec",
+			     "mediatek,mt2701-jpgdec";
+		reg = <0 0x15004000 0 0x1000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+			  <&imgsys CLK_IMG_JPGDEC>;
+		clock-names = "jpgdec-smi",
+			      "jpgdec";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+		mediatek,larb = <&larb2>;
+		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+	};
+
+	vdecsys: syscon at 16000000 {
+		compatible = "mediatek,mt7623-vdecsys",
+			     "mediatek,mt2701-vdecsys",
+			     "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	larb1: larb at 16010000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x16010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <1>;
+		clocks = <&vdecsys CLK_VDEC_CKGEN>,
+			 <&vdecsys CLK_VDEC_LARB>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
@@ -799,4 +1001,12 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
 		status = "disabled";
 	};
+
+	bdpsys: syscon at 1c000000 {
+		compatible = "mediatek,mt7623-bdpsys",
+			     "mediatek,mt2701-bdpsys",
+			     "syscon";
+		reg = <0 0x1c000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 688a863..336814a 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -21,6 +21,19 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_bls_gpio>;
+	};
+
 	cpus {
 		cpu at 0 {
 			proc-supply = <&mt6323_vproc_reg>;
@@ -86,6 +99,10 @@
 	};
 };
 
+&bls {
+	status = "okay";
+};
+
 &cir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cir_pins_a>;
@@ -273,6 +290,21 @@
 		};
 	};
 
+	mipi_dsi_pin: mipi_dsi_pin {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_100_MIPI_TDP0_FUNC_TDP0>,
+				 <MT7623_PIN_99_MIPI_TDN0_FUNC_TDN0>,
+				 <MT7623_PIN_98_MIPI_TDP1_FUNC_TDP1>,
+				 <MT7623_PIN_97_MIPI_TDN1_FUNC_TDN1>,
+				 <MT7623_PIN_96_MIPI_TCP_FUNC_TCP>,
+				 <MT7623_PIN_95_MIPI_TCN_FUNC_TCN>,
+				 <MT7623_PIN_94_MIPI_TDP2_FUNC_TDP2>,
+				 <MT7623_PIN_93_MIPI_TDN2_FUNC_TDN2>,
+				 <MT7623_PIN_92_MIPI_TDP3_FUNC_TDP3>,
+				 <MT7623_PIN_91_MIPI_TDN3_FUNC_TDN3>;
+		};
+	};
+
 	mmc0_pins_default: mmc0default {
 		pins_cmd_dat {
 			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
@@ -376,10 +408,15 @@
 		};
 	};
 
+	pwm_bls_gpio: pwm_bls_gpio {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_203_PWM0_FUNC_DISP_PWM>;
+		};
+	};
+
 	pwm_pins_a: pwm at 0 {
 		pins_pwm {
-			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
-				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
+			pinmux = <MT7623_PIN_204_PWM1_FUNC_PWM1>,
 				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
 				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
 				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
diff --git a/include/dt-bindings/pinctrl/mt7623-pinfunc.h b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
index 436a87b..72bed67 100644
--- a/include/dt-bindings/pinctrl/mt7623-pinfunc.h
+++ b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
@@ -272,6 +272,18 @@
 #define MT7623_PIN_84_DSI_TE_FUNC_GPIO84 (MTK_PIN_NO(84) | 0)
 #define MT7623_PIN_84_DSI_TE_FUNC_DSI_TE (MTK_PIN_NO(84) | 1)
 
+#define MT7623_PIN_91_MIPI_TDN3_FUNC_GPIO91 (MTK_PIN_NO(91) | 0)
+#define MT7623_PIN_91_MIPI_TDN3_FUNC_TDN3 (MTK_PIN_NO(91) | 1)
+
+#define MT7623_PIN_92_MIPI_TDP3_FUNC_GPIO92 (MTK_PIN_NO(92) | 0)
+#define MT7623_PIN_92_MIPI_TDP3_FUNC_TDP3 (MTK_PIN_NO(92) | 1)
+
+#define MT7623_PIN_93_MIPI_TDN2_FUNC_GPIO93 (MTK_PIN_NO(93) | 0)
+#define MT7623_PIN_93_MIPI_TDN2_FUNC_TDN2 (MTK_PIN_NO(93) | 1)
+
+#define MT7623_PIN_94_MIPI_TDP2_FUNC_GPIO94 (MTK_PIN_NO(94) | 0)
+#define MT7623_PIN_94_MIPI_TDP2_FUNC_TDP2 (MTK_PIN_NO(94) | 1)
+
 #define MT7623_PIN_95_MIPI_TCN_FUNC_GPIO95 (MTK_PIN_NO(95) | 0)
 #define MT7623_PIN_95_MIPI_TCN_FUNC_TCN (MTK_PIN_NO(95) | 1)
 
-- 
1.9.1
