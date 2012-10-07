From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  8 Oct 2012 02:10:53 +0900
Subject: [PATCH v2 3/5] ARM: dts: Add Exynos4210 clock nodes
In-Reply-To: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1349629855-4962-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial set of Exynos4210 clock nodes with which device tree enabled
boards based on Exynos4210 can be booted.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4-clock.dtsi |  389 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi       |    1 +
 2 files changed, 390 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-clock.dtsi

diff --git a/arch/arm/boot/dts/exynos4-clock.dtsi b/arch/arm/boot/dts/exynos4-clock.dtsi
new file mode 100644
index 0000000..eb07613
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4-clock.dtsi
@@ -0,0 +1,389 @@
+/*
+ * Samsung's Exynos4210 SoC clock nodes
+ *
+ * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2011-2012 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	clock_ctrl at 10030000 {
+		compatible = "samsung,exynos4-clock-ctrl";
+		reg = <0x10030000 0x20000>;
+
+		xxti: xxti {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "xxti";
+			clock-frequency = <24000000>;
+		};
+
+		xusbxti: xusbxti {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "xusbxti";
+			clock-frequency = <24000000>;
+		};
+
+		sclk_hdmi24m: sclk_hdmi24m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_hdmi24m";
+			clock-frequency = <24000000>;
+		};
+
+		sclk_hdmiphy: sclk_hdmiphy {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_hdmiphy";
+			clock-frequency = <27000000>;
+		};
+
+		sclk_usbphy0: sclk_usbphy0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_usbphy0";
+			clock-frequency = <48000000>;
+		};
+
+		sclk_usbphy1: sclk_usbphy1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_usbphy1";
+			clock-frequency = <48000000>;
+		};
+
+		fin_pll: fin_pll {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "fin_pll";
+			clocks = <&xxti>, <&xusbxti>;
+			reg-info = <0x00 0 1>;
+		};
+
+		fout_apll: fout_apll {
+			compatible = "samsung,clock-pll";
+			#clock-cells = <0>;
+			clock-output-names = "fout_apll";
+			clocks = <&fin_pll>;
+		};
+
+		fout_mpll: fout_mpll {
+			compatible = "samsung,clock-pll";
+			#clock-cells = <0>;
+			clock-output-names = "fout_mpll";
+			clocks = <&fin_pll>;
+		};
+
+		fout_epll: fout_epll {
+			compatible = "samsung,clock-pll";
+			#clock-cells = <0>;
+			clock-output-names = "fout_epll";
+			clocks = <&fin_pll>;
+		};
+
+		mout_epll: mout_epll {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_epll";
+			clocks = <&fin_pll>, <&fout_epll>;
+			reg-info = <0xc210 8 1>;
+		};
+
+		mout_vpll_src: mout_vpll_src {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_vpll_src";
+			clocks = <&fin_pll>, <&sclk_hdmi24m>;
+			reg-info = <0xc214 0 1>;
+		};
+
+		fout_vpll: fout_vpll {
+			compatible = "samsung,clock-pll";
+			#clock-cells = <0>;
+			clock-output-names = "fout_vpll";
+			clocks = <&mout_vpll_src>;
+		};
+
+		mout_vpll: mout_vpll {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_vpll";
+			clocks = <&mout_vpll_src>, <&fout_vpll>;
+			reg-info = <0xc210 8 1>;
+		};
+
+		mout_apll: mout_apll {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_apll";
+			clocks = <&fin_pll>, <&fout_apll>;
+			reg-info = <0x14200 0 1>;
+		};
+
+		mout_mpll: mout_mpll {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_mpll";
+			clocks = <&fin_pll>, <&fout_mpll>;
+			reg-info = <0x14200 8 1>;
+		};
+
+		sclk_apll: sclk_apll {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_apll";
+			clocks = <&mout_apll>;
+			reg-info = <0x14500 24 3>;
+		};
+
+		mout_core: mout_core {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_core";
+			clocks = <&mout_apll>, <&mout_mpll>;
+			reg-info = <0x14200 16 1>;
+		};
+
+		div_core: div_core {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "div_core";
+			clocks = <&mout_core>;
+			reg-info = <0x14500 0 3>;
+		};
+
+		armclk: armclk {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "armclk";
+			clocks = <&div_core>;
+			reg-info = <0x14500 28 3>;
+		};
+
+		mout_aclk_200: mout_aclk_200 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_aclk_200";
+			clocks = <&mout_mpll>, <&sclk_apll>;
+			reg-info = <0xc210 12 1>;
+		};
+
+		mout_aclk_100: mout_aclk_100 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_aclk_100";
+			clocks = <&mout_mpll>, <&sclk_apll>;
+			reg-info = <0xc210 16 1>;
+		};
+
+		mout_aclk_160: mout_aclk_160 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_aclk_160";
+			clocks = <&mout_mpll>, <&sclk_apll>;
+			reg-info = <0xc210 20 1>;
+		};
+
+		mout_aclk_133: mout_aclk_133 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_aclk_133";
+			clocks = <&mout_mpll>, <&sclk_apll>;
+			reg-info = <0xc210 24 1>;
+		};
+
+		aclk_200: aclk_200 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "aclk_200";
+			clocks = <&mout_aclk_200>;
+			reg-info = <0xc510 0 3>;
+		};
+
+		aclk_100: aclk_100 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "aclk_100";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc510 4 3>;
+		};
+
+		aclk_160: aclk_160 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "aclk_160";
+			clocks = <&mout_aclk_160>;
+			reg-info = <0xc510 8 3>;
+		};
+
+		aclk_133: aclk_133 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "aclk_133";
+			clocks = <&mout_aclk_133>;
+			reg-info = <0xc510 12 3>;
+		};
+
+		uart0: uart0 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart0";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 0>;
+		};
+
+		uart1: uart1 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart1";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 1>;
+		};
+
+		uart2: uart2 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart2";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 2>;
+		};
+
+		uart3: uart3 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart3";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 3>;
+		};
+
+		uart4: uart4 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart4";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 4>;
+		};
+
+		uart5: uart5 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "uart5";
+			clocks = <&mout_aclk_100>;
+			reg-info = <0xc94c 5>;
+		};
+
+		mout_uart0: mout_uart0 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_uart0";
+			clocks = <&xxti>, <&xusbxti>, <&sclk_hdmi24m>,
+				 <&sclk_usbphy0>, <&sclk_usbphy1>,
+				 <&sclk_hdmiphy>, <&mout_mpll>, <&mout_epll>,
+				 <&mout_vpll>;
+			reg-info = <0xc250 0 4>;
+		};
+
+		mout_uart1: mout_uart1 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_uart1";
+			clocks = <&xxti>, <&xusbxti>, <&sclk_hdmi24m>,
+				 <&sclk_usbphy0>, <&sclk_usbphy1>,
+				 <&sclk_hdmiphy>, <&mout_mpll>, <&mout_epll>,
+				 <&mout_vpll>;
+			reg-info = <0xc250 4 4>;
+		};
+
+		mout_uart2: mout_uart2 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_uart2";
+			clocks = <&xxti>, <&xusbxti>, <&sclk_hdmi24m>,
+				 <&sclk_usbphy0>, <&sclk_usbphy1>,
+				 <&sclk_hdmiphy>, <&mout_mpll>, <&mout_epll>,
+				 <&mout_vpll>;
+			reg-info = <0xc250 8 4>;
+		};
+
+		mout_uart3: mout_uart3 {
+			compatible = "samsung,clock-mux";
+			#clock-cells = <0>;
+			clock-output-names = "mout_uart3";
+			clocks = <&xxti>, <&xusbxti>, <&sclk_hdmi24m>,
+				 <&sclk_usbphy0>, <&sclk_usbphy1>,
+				 <&sclk_hdmiphy>, <&mout_mpll>, <&mout_epll>,
+				 <&mout_vpll>;
+			reg-info = <0xc250 12 4>;
+		};
+
+		dout_uart0: dout_uart0 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "dout_uart0";
+			clocks = <&mout_uart0>;
+			reg-info = <0xc550 0 4>;
+		};
+
+		dout_uart1: dout_uart1 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "dout_uart1";
+			clocks = <&mout_uart1>;
+			reg-info = <0xc550 4 4>;
+		};
+
+		dout_uart2: dout_uart2 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "dout_uart2";
+			clocks = <&mout_uart2>;
+			reg-info = <0xc550 8 4>;
+		};
+
+		dout_uart3: dout_uart3 {
+			compatible = "samsung,clock-div";
+			#clock-cells = <0>;
+			clock-output-names = "dout_uart3";
+			clocks = <&mout_uart3>;
+			reg-info = <0xc550 12 4>;
+		};
+
+		sclk_uart0: sclk_uart0 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_uart0";
+			clocks = <&dout_uart0>;
+			reg-info = <0xc350 0>;
+		};
+
+		sclk_uart1: sclk_uart1 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_uart1";
+			clocks = <&dout_uart1>;
+			reg-info = <0xc350 4>;
+		};
+
+		sclk_uart2: sclk_uart2 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_uart2";
+			clocks = <&dout_uart2>;
+			reg-info = <0xc350 8>;
+		};
+
+		sclk_uart3: sclk_uart3 {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "sclk_uart3";
+			clocks = <&dout_uart3>;
+			reg-info = <0xc350 12>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index a26c3dd..1c923d3 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -20,6 +20,7 @@
  */
 
 /include/ "skeleton.dtsi"
+/include/ "exynos4-clock.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
-- 
1.7.5.4
