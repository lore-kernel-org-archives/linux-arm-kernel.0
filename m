From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 17 May 2017 23:50:16 +0800
Subject: [PATCH 3/4] dts: imx: add imx7ulp evk support
In-Reply-To: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1495036217-20049-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It includes the following support:
1) CLK
2) GPIO PTC, PTD, PTE, PTF
3) uSDHC 1/2
4) LPUART 4/5/6/7
5) LPI2C 6/7

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/boot/dts/Makefile        |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts |  98 ++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi    | 310 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0bff8e7..d4bf4fa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -470,6 +470,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb-sht11.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
+dtb-$(CONFIG_SOC_IMX7ULP) += \
+	imx7ulp-evk.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
new file mode 100644
index 0000000..ec8790d
--- /dev/null
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx7ulp.dtsi"
+
+/ {
+	model = "NXP i.MX7ULP EVK";
+	compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT based system";
+
+	chosen {
+		stdout-path = &lpuart4;
+	};
+
+	memory {
+		reg = <0x60000000 0x40000000>;
+	};
+
+	reg_vsd_3v3: regulator-vsd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc0_rst>;
+		gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&lpuart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart4>;
+	status = "okay";
+};
+
+&usdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc0_cmd_data>, <&pinctrl_usdhc0_clk>,
+		    <&pinctrl_usdhc0_cd>;
+	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_vsd_3v3>;
+	status = "okay";
+};
+
+&iomuxc1 {
+	pinctrl_lpuart4: lpuart4grp {
+		pins = <
+			ULP1_PAD_PTC3__LPUART4_RX
+			ULP1_PAD_PTC2__LPUART4_TX
+		>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_cmd_data: usdhc0_cmd_data_0_3_grp {
+		pins = <
+			ULP1_PAD_PTD1__SDHC0_CMD
+			ULP1_PAD_PTD2__SDHC0_CLK
+			ULP1_PAD_PTD7__SDHC0_D3
+			ULP1_PAD_PTD8__SDHC0_D2
+			ULP1_PAD_PTD9__SDHC0_D1
+			ULP1_PAD_PTD10__SDHC0_D0
+		>;
+		drive-strength = <1>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_clk: usdhc0_clk_grp {
+		pins = <
+			ULP1_PAD_PTD2__SDHC0_CLK
+		>;
+		drive-strength = <1>;
+		bias-pull-down;
+	};
+
+	pinctrl_usdhc0_cd: usdhc0_gpios_cd_grp {
+		pins = <
+			ULP1_PAD_PTC10__PTC10		/* USDHC0 CD */
+		>;
+		nxp,input-buffer-enable;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_rst: usdhc0_gpios_rst_grp {
+		pins = <
+			ULP1_PAD_PTD0__PTD0		/* USDHC0 RST */
+		>;
+		nxp,output-buffer-enable;
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
new file mode 100644
index 0000000..514e063
--- /dev/null
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -0,0 +1,310 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton.dtsi"
+
+#include "imx7ulp-pinfunc.h"
+
+/ {
+	interrupt-parent = <&intc>;
+
+	aliases {
+		gpio0 = &gpio_ptc;
+		gpio1 = &gpio_ptd;
+		gpio2 = &gpio_pte;
+		gpio3 = &gpio_ptf;
+		i2c0 = &lpi2c6;
+		i2c1 = &lpi2c7;
+		mmc0 = &usdhc0;
+		mmc1 = &usdhc1;
+		serial0 = &lpuart4;
+		serial1 = &lpuart5;
+		serial2 = &lpuart6;
+		serial3 = &lpuart7;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	intc: interrupt-controller at 40021000 {
+		compatible = "arm,cortex-a7-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x40021000 0x1000>,
+		      <0x40022000 0x100>;
+	};
+
+	rosc: clock-rosc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "rosc";
+		#clock-cells = <0>;
+	};
+
+	sosc: clock-sosc {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "sosc";
+		#clock-cells = <0>;
+	};
+
+	sirc: clock-sirc {
+		compatible = "fixed-clock";
+		clock-frequency = <16000000>;
+		clock-output-names = "sirc";
+		#clock-cells = <0>;
+	};
+
+	firc: clock-firc {
+		compatible = "fixed-clock";
+		clock-frequency = <48000000>;
+		clock-output-names = "firc";
+		#clock-cells = <0>;
+	};
+
+	upll: clock-upll {
+		compatible = "fixed-clock";
+		clock-frequency = <480000000>;
+		clock-output-names = "upll";
+		#clock-cells = <0>;
+	};
+
+	mpll: clock-mpll {
+		compatible = "fixed-clock";
+		clock-frequency = <480000000>;
+		clock-output-names = "mpll";
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		arm,cpu-registers-not-fw-configured;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <1000000>;
+		status = "disabled";
+	};
+
+	ahbbridge0: ahb-bridge at 40000000 {
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x40000000 0x800000>;
+		ranges;
+
+		lpuart4: serial at 402d0000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x402d0000 0x1000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPUART4>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPUART4>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+			assigned-clock-rates = <24000000>;
+			status = "disabled";
+		};
+
+		lpuart5: serial at 402e0000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x402e0000 0x1000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPUART5>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPUART5>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_FIRC>;
+			assigned-clock-rates = <48000000>;
+			status = "disabled";
+		};
+
+		tpm5: tpm at 40260000 {
+			compatible = "fsl,imx7ulp-tpm";
+			reg = <0x40260000 0x1000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+				 <&clks IMX7ULP_CLK_LPTPM5>;
+			clock-names = "ipg", "per";
+		};
+
+		usdhc0: usdhc at 40370000 {
+			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
+			reg = <0x40370000 0x10000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+				 <&clks IMX7ULP_CLK_NIC1_DIV>,
+				 <&clks IMX7ULP_CLK_USDHC0>;
+			clock-names ="ipg", "ahb", "per";
+			assigned-clocks = <&clks IMX7ULP_CLK_USDHC0>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_NIC1_DIV>;
+			bus-width = <4>;
+			fsl,tuning-start-tap = <20>;
+			fsl,tuning-step= <2>;
+			status = "disabled";
+		};
+
+		usdhc1: usdhc at 40380000 {
+			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
+			reg = <0x40380000 0x10000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+				 <&clks IMX7ULP_CLK_NIC1_DIV>,
+				 <&clks IMX7ULP_CLK_USDHC1>;
+			clock-names ="ipg", "ahb", "per";
+			assigned-clocks = <&clks IMX7ULP_CLK_USDHC1>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_NIC1_DIV>;
+			bus-width = <4>;
+			fsl,tuning-start-tap = <20>;
+			fsl,tuning-step= <2>;
+			status = "disabled";
+		};
+
+		clks: scg at 403e0000 {
+			compatible = "fsl,imx7ulp-clock";
+			reg = <0x403e0000 0x10000>,
+			      <0x403f0000 0x10000>,
+			      <0x40b30000 0x10000>;
+			reg-names = "scg1", "pcc2", "pcc3";
+			clocks = <&rosc>, <&sosc>, <&sirc>,
+				 <&firc>, <&upll>, <&mpll>;
+			clock-names = "rosc", "sosc", "sirc",
+				      "firc", "upll", "mpll";
+			#clock-cells = <1>;
+			assigned-clocks = <&clks IMX7ULP_CLK_LPTPM5>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+		};
+
+		smc1: smc at 40410000 {
+			compatible = "fsl,imx7ulp-smc1";
+			reg = <0x40410000 0x1000>;
+		};
+	};
+
+	ahbbridge1: ahb-bridge at 40800000 {
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x40800000 0x800000>;
+		ranges;
+
+		lpi2c6: lpi2c at 40a40000 {
+			compatible = "fsl,imx7ulp-lpi2c";
+			reg = <0x40a40000 0x10000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPI2C6>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPI2C6>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_FIRC>;
+			assigned-clock-rates = <48000000>;
+			status = "disabled";
+		};
+
+		lpi2c7: lpi2c at 40a50000 {
+			compatible = "fsl,imx7ulp-lpi2c";
+			reg = <0x40a50000 0x10000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPI2C7>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPI2C7>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_FIRC>;
+			assigned-clock-rates = <48000000>;
+			status = "disabled";
+		};
+
+		lpuart6: serial at 40a60000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x40a60000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPUART6>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPUART6>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_FIRC>;
+			assigned-clock-rates = <48000000>;
+			status = "disabled";
+		};
+
+		lpuart7: serial at 40a70000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x40a70000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPUART7>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPUART7>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_FIRC>;
+			assigned-clock-rates = <48000000>;
+			status = "disabled";
+		};
+
+		iomuxc1: iomuxc at 40ac0000 {
+			compatible = "fsl,imx7ulp-iomuxc1";
+			reg = <0x40ac0000 0x1000>;
+		};
+
+		gpio_ptc: gpio at 40ae0000 {
+			compatible = "fsl,vf610-gpio";
+			reg = <0x40ae0000 0x1000 0x400f0000 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&clks IMX7ULP_CLK_PCTLC>;
+			clock-names = "ipg";
+			gpio-ranges = <&iomuxc1 0 0 32>;
+		};
+
+		gpio_ptd: gpio at 40af0000 {
+			compatible = "fsl,vf610-gpio";
+			reg = <0x40af0000 0x1000 0x400f0040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&clks IMX7ULP_CLK_PCTLD>;
+			clock-names = "ipg";
+			gpio-ranges = <&iomuxc1 0 32 32>;
+		};
+
+		gpio_pte: gpio at 40b00000 {
+			compatible = "fsl,vf610-gpio";
+			reg = <0x40b00000 0x1000 0x400f0080 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&clks IMX7ULP_CLK_PCTLE>;
+			clock-names = "ipg";
+			gpio-ranges = <&iomuxc1 0 64 32>;
+		};
+
+		gpio_ptf: gpio at 40b10000 {
+			compatible = "fsl,vf610-gpio";
+			reg = <0x40b10000 0x1000 0x400f00c0 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&clks IMX7ULP_CLK_PCTLF>;
+			clock-names = "ipg";
+			gpio-ranges = <&iomuxc1 0 96 32>;
+		};
+	};
+};
-- 
2.7.4
