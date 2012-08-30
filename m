From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 30 Aug 2012 09:31:43 +0200
Subject: [PATCH 6/6] ARM: Exynos: Add basic dts file for Samsung Trats board
In-Reply-To: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346311903-15920-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds basic device tree for Exynos4210-based Trats board.

Currently it provides support for eMMC over sdhci and MAX8997 PMIC.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 287 +++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/Makefile.boot     |   2 +-
 2 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-trats.dts

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
new file mode 100644
index 0000000..a9cd2d0
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -0,0 +1,287 @@
+/*
+ * Samsung's Exynos4210 based Trats board device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Device tree source file for Samsung's Trats board which is based on
+ * Samsung's Exynos4210 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4210.dtsi"
+
+/ {
+	model = "Samsung Trats based on Exynos4210";
+	compatible = "samsung,trats", "samsung,exynos4210";
+
+	memory {
+		reg =  <0x40000000 0x20000000
+			0x60000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+	};
+
+	wakeup_eint: interrupt-controller-wakeup-eint {
+		compatible = "samsung,exynos4210-wakeup-eint";
+		reg = <0x11000000 0x1000>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts =	<0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
+				<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
+				<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
+				<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
+				<0 32 0>;
+	};
+
+	vemmc_reg: voltage-regulator at 0 {
+	        compatible = "regulator-fixed";
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpk0 2 1 0 0>;
+	};
+
+	sdhci_emmc: sdhci at 12510000 {
+		bus-width = <8>;
+		non-removable;
+		gpios = <&gpk0 0 2 0 3>,
+			<&gpk0 1 2 0 3>,
+			<&gpk0 3 2 2 3>,
+			<&gpk0 4 2 2 3>,
+			<&gpk0 5 2 2 3>,
+			<&gpk0 6 2 2 3>,
+			<&gpk1 3 3 3 3>,
+			<&gpk1 4 3 3 3>,
+			<&gpk1 5 3 3 3>,
+			<&gpk1 6 3 3 3>;
+		vmmc-supply = &vemmc_reg;
+	};
+
+	i2c at 138B0000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-slave-addr = <0x10>;
+		samsung,i2c-max-bus-freq = <100000>;
+		gpios = <&gpb 6 3 3 0>,
+			<&gpb 7 3 3 0>;
+
+		max8997_pmic at 66 {
+			compatible = "maxim,max8997-pmic";
+			interrupt-parent = <&wakeup_eint>;
+
+			reg = <0x66>;
+			interrupts = <4 0>, <3 0>;
+
+			max8997,pmic-buck1-uses-gpio-dvs;
+			max8997,pmic-buck2-uses-gpio-dvs;
+			max8997,pmic-buck5-uses-gpio-dvs;
+
+			max8997,pmic-ignore-gpiodvs-side-effect;
+			max8997,pmic-buck125-default-dvs-idx = <0>;
+
+			max8997,pmic-buck125-dvs-gpios = <&gpx0 5 1 0 0>,
+						         <&gpx0 6 1 0 0>,
+							 <&gpl0 0 1 0 0>;
+
+			max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
+							 <1250000>, <1200000>,
+							 <1150000>, <1100000>,
+							 <1000000>, <950000>;
+
+			max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
+							 <950000>,  <900000>,
+							 <1100000>, <1000000>,
+							 <950000>,  <900000>;
+
+			max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
+							 <1200000>, <1200000>,
+							 <1200000>, <1200000>,
+							 <1200000>, <1200000>;
+
+			regulators {
+				valive_reg: LDO2 {
+				     regulator-name = "VALIVE_1.1V_C210";
+				     regulator-min-microvolt = <1100000>;
+				     regulator-max-microvolt = <1100000>;
+				     regulator-always-on;
+				};
+
+				vusb_reg: LDO3 {
+				     regulator-name = "VUSB_1.1V_C210";
+				     regulator-min-microvolt = <1100000>;
+				     regulator-max-microvolt = <1100000>;
+				};
+
+				vmipi_reg: LDO4 {
+				     regulator-name = "VMIPI_1.8V";
+				     regulator-min-microvolt = <1800000>;
+				     regulator-max-microvolt = <1800000>;
+				};
+
+				vpda_reg: LDO6 {
+				     regulator-name = "VCC_1.8V_PDA";
+				     regulator-min-microvolt = <1800000>;
+				     regulator-max-microvolt = <1800000>;
+				     regulator-always-on;
+				};
+
+				vcam_reg: LDO7 {
+				     regulator-name = "CAM_ISP_1.8V";
+				     regulator-min-microvolt = <1800000>;
+				     regulator-max-microvolt = <1800000>;
+				};
+
+				vusbdac_reg: LDO8 {
+				     regulator-name = "VUSB/VDAC_3.3V_C210";
+				     regulator-min-microvolt = <3300000>;
+				     regulator-max-microvolt = <3300000>;
+				};
+
+				vccpda_reg: LDO9 {
+				     regulator-name = "VCC_2.8V_PDA";
+				     regulator-min-microvolt = <2800000>;
+				     regulator-max-microvolt = <2800000>;
+				     regulator-always-on;
+				};
+
+				vpll_reg: LDO10 {
+				     regulator-name = "VPLL_1.1V_C210";
+				     regulator-min-microvolt = <1100000>;
+				     regulator-max-microvolt = <1100000>;
+				     regulator-always-on;
+				};
+
+				vcclcd_reg: LDO13 {
+				     regulator-name = "VCC_3.3V_LCD";
+				     regulator-min-microvolt = <3300000>;
+				     regulator-max-microvolt = <3300000>;
+				};
+
+				vlcd_reg: LDO15 {
+				     regulator-name = "VLCD_2.2V";
+				     regulator-min-microvolt = <2200000>;
+				     regulator-max-microvolt = <2200000>;
+				};
+
+				camsensor_reg: LDO16 {
+				     regulator-name = "CAM_SENSOR_IO_1.8V";
+				     regulator-min-microvolt = <1800000>;
+				     regulator-max-microvolt = <1800000>;
+				};
+
+				vddq_reg: LDO21 {
+				     regulator-name = "VDDQ_M1M2_1.2V";
+				     regulator-min-microvolt = <1200000>;
+				     regulator-max-microvolt = <1200000>;
+				     regulator-always-on;
+				};
+
+				varm_breg: BUCK1 {
+				     regulator-name = "VARM_1.2V_C210";
+				     regulator-min-microvolt = <900000>;
+				     regulator-max-microvolt = <1350000>;
+				     regulator-always-on;
+				};
+
+				vint_breg: BUCK2 {
+				     regulator-name = "VINT_1.1V_C210";
+				     regulator-min-microvolt = <900000>;
+				     regulator-max-microvolt = <1100000>;
+				     regulator-always-on;
+				};
+
+				camisp_breg: BUCK4 {
+				     regulator-name = "CAM_ISP_CORE_1.2V";
+				     regulator-min-microvolt = <1200000>;
+				     regulator-max-microvolt = <1200000>;
+				};
+
+				vmem_breg: BUCK5 {
+				     regulator-name = "VMEM_1.2V_C210";
+				     regulator-min-microvolt = <1200000>;
+				     regulator-max-microvolt = <1200000>;
+				     regulator-always-on;
+				};
+
+				vccsub_breg: BUCK7 {
+				     regulator-name = "VCC_SUB_2.0V";
+				     regulator-min-microvolt = <2000000>;
+				     regulator-max-microvolt = <2000000>;
+				     regulator-always-on;
+				};
+
+				safe1_sreg: ESAFEOUT1 {
+				     regulator-name = "SAFEOUT1";
+				     regulator-always-on;
+				};
+
+				safe2_sreg: ESAFEOUT2 {
+				     regulator-name = "SAFEOUT2";
+				     regulator-boot-on;
+				};
+			};
+		};
+	};
+
+	keypad at 100A0000 {
+		status = "disabled";
+	};
+
+	sdhci at 12520000 {
+		status = "disabled";
+	};
+
+	sdhci at 12530000 {
+		status = "disabled";
+	};
+
+	sdhci at 12540000 {
+		status = "disabled";
+	};
+
+	i2c at 13860000 {
+		status = "disabled";
+	};
+
+	i2c at 13870000 {
+		status = "disabled";
+	};
+
+	i2c at 13880000 {
+		status = "disabled";
+	};
+
+	i2c at 13890000 {
+		status = "disabled";
+	};
+
+	i2c at 138A0000 {
+		status = "disabled";
+	};
+
+	i2c at 138C0000 {
+		status = "disabled";
+	};
+
+	i2c at 138D0000 {
+		status = "disabled";
+	};
+
+	spi_0: spi at 13920000 {
+		status = "disabled";
+	};
+
+	spi_1: spi at 13930000 {
+		status = "disabled";
+	};
+
+	spi_2: spi at 13940000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
index 31bd181..a79d999 100644
--- a/arch/arm/mach-exynos/Makefile.boot
+++ b/arch/arm/mach-exynos/Makefile.boot
@@ -1,5 +1,5 @@
    zreladdr-y	+= 0x40008000
 params_phys-y	:= 0x40000100
 
-dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb
+dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb exynos4210-trats.dtb
 dtb-$(CONFIG_MACH_EXYNOS5_DT) += exynos5250-smdk5250.dtb
-- 
1.7.12
