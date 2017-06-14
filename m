From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:24 +0800
Subject: [PATCH v3 07/21] arm64: dts: hi3660: Add uarts nodes
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-8-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Feng <puck.chen@hisilicon.com>

Add nodes uart0 to uart4 and uart6 for hi3660 SoC.
Enable uart3 and uart6, disable uart5, in hikey960 board dts.

On HiKey960:
 - UART6 is used as default console, and is wired out through low speed
         expansion connector.
 - UART3 has RTS/CTS hardware handshake, and is wired out through low
         speed expansion connector.
 - UART5 is not used in commercial launched boards. So disable it.
 - UART4 is connected to Bluetooth, WL1837.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 20 +++++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 74 +++++++++++++++++++++++
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 1a4d6c5..0a3f2e0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -15,11 +15,17 @@
 	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
-		serial5 = &uart5;       /* console UART */
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
 	};
 
 	chosen {
-		stdout-path = "serial5:115200n8";
+		stdout-path = "serial6:115200n8";
 	};
 
 	memory at 0 {
@@ -51,6 +57,14 @@
 	status = "okay";
 };
 
-&uart5 {
+&uart3 {
+	/* On Low speed expansion */
+	label = "LS-UART0";
+	status = "okay";
+};
+
+&uart6 {
+	/* On Low speed expansion */
+	label = "LS-UART1";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index b03be4d..7a90c92 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -242,6 +242,66 @@
 			status = "disabled";
 		};
 
+		uart0: serial at fdf02000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf02000 0x0 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_MUX_UART0>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+			status = "disabled";
+		};
+
+		uart1: serial at fdf00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
+				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
+			status = "disabled";
+		};
+
+		uart2: serial at fdf03000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf03000 0x0 0x1000>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
+			status = "disabled";
+		};
+
+		uart3: serial at ffd74000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xffd74000 0x0 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_FACTOR_UART3>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			status = "disabled";
+		};
+
+		uart4: serial at fdf01000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf01000 0x0 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
+				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
+			status = "disabled";
+		};
+
 		uart5: serial at fdf05000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
@@ -249,6 +309,20 @@
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart5_pmx_func &uart5_cfg_func>;
+			status = "disabled";
+		};
+
+		uart6: serial at fff32000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfff32000 0x0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_UART6>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart6_pmx_func &uart6_cfg_func>;
 			status = "disabled";
 		};
 
-- 
2.10.2
