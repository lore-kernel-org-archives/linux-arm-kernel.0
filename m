From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 Jan 2018 21:11:10 +0800
Subject: [PATCH V3 10/10] add imx7ulp support
In-Reply-To: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516367470-24340-11-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts    |  87 +++++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi       | 202 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig |  16 ++-
 arch/arm/mach-imx/Kconfig            |   9 ++
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/common.h           |   1 +
 arch/arm/mach-imx/cpu.c              |   3 +
 arch/arm/mach-imx/mach-imx7ulp.c     |  37 +++++++
 arch/arm/mach-imx/mxc.h              |   1 +
 arch/arm/mach-imx/pm-imx7ulp.c       |  32 ++++++
 11 files changed, 381 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9..3257e71 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -519,6 +519,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
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
index 0000000..cc4e6ef
--- /dev/null
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -0,0 +1,87 @@
+/*
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
+		bootargs = "console=ttyLP0,115200 earlycon=lpuart32,0x402D0010,115200";
+		stdout-path = &lpuart4;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
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
+	pinctrl-0 = <>;
+	pinctrl-0 = <&pinctrl_usdhc0_cmd_data>, <&pinctrl_usdhc0_clk>;
+//		    <&pinctrl_usdhc0_cd>, <&pinctrl_usdhc0_rst>;
+	status = "okay";
+};
+
+&iomuxc1 {
+	pinctrl_lpuart4: lpuart4grp {
+		pins = <
+			IMX7ULP_PAD_PTC3__LPUART4_RX
+			IMX7ULP_PAD_PTC2__LPUART4_TX
+		>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_cmd_data: usdhc0_cmd_data_0_3_grp {
+		pins = <
+			IMX7ULP_PAD_PTD1__SDHC0_CMD
+			IMX7ULP_PAD_PTD2__SDHC0_CLK
+			IMX7ULP_PAD_PTD7__SDHC0_D3
+			IMX7ULP_PAD_PTD8__SDHC0_D2
+			IMX7ULP_PAD_PTD9__SDHC0_D1
+			IMX7ULP_PAD_PTD10__SDHC0_D0
+		>;
+		drive-strength = <1>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_clk: usdhc0_clk_grp {
+		pins = <
+			IMX7ULP_PAD_PTD2__SDHC0_CLK
+		>;
+		drive-strength = <1>;
+		bias-pull-down;
+	};
+
+	pinctrl_usdhc0_cd: usdhc0_gpios_cd_grp {
+		pins = <
+			IMX7ULP_PAD_PTC10__PTC10		/* USDHC0 CD */
+		>;
+		nxp,input-buffer-enable;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_rst: usdhc0_gpios_rst_grp {
+		pins = <
+			IMX7ULP_PAD_PTD0__PTD0		/* USDHC0 RST */
+		>;
+		nxp,output-buffer-enable;
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
new file mode 100644
index 0000000..05410ba
--- /dev/null
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -0,0 +1,202 @@
+/*
+ * Copyright NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton.dtsi"
+
+#include "imx7ulp-pinfunc.h"
+
+/ {
+	interrupt-parent = <&intc>;
+
+	aliases {
+		serial0 = &lpuart4;
+		serial1 = &lpuart6;
+		serial2 = &lpuart5;
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
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		rosc: clock at 0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "rosc";
+			#clock-cells = <0>;
+		};
+
+		sosc: clock at 1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			clock-frequency = <24000000>;
+			clock-output-names = "sosc";
+			#clock-cells = <0>;
+		};
+
+		sirc: clock at 2 {
+			compatible = "fixed-clock";
+			reg = <2>;
+			clock-frequency = <16000000>;
+			clock-output-names = "sirc";
+			#clock-cells = <0>;
+		};
+
+		firc: clock at 3 {
+			compatible = "fixed-clock";
+			reg = <3>;
+			clock-frequency = <48000000>;
+			clock-output-names = "firc";
+			#clock-cells = <0>;
+		};
+
+		upll: clock at 4 {
+			compatible = "fixed-clock";
+			reg = <4>;
+			clock-frequency = <480000000>;
+			clock-output-names = "upll";
+			#clock-cells = <0>;
+		};
+
+		mpll: clock at 5 {
+			compatible = "fixed-clock";
+			reg = <5>;
+			clock-frequency = <480000000>;
+			clock-output-names = "mpll";
+			#clock-cells = <0>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		arm,cpu-registers-not-fw-configured;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&intc>;
+		clock-frequency = <1000000>;
+		status = "disabled";
+	};
+
+	sram: sram at 20000000 {
+		compatible = "fsl,lpm-sram";
+		reg = <0x20008000 0x4000>;
+	};
+
+	ahbbridge0: ahb-bridge0 at 40000000 {
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x40000000 0x800000>;
+		ranges;
+
+		lpuart4: serial at 402D0000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x402D0000 0x1000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_LPUART4>;
+			clock-names = "ipg";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPUART4>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+			assigned-clock-rates = <24000000>;
+			status = "disabled";
+		};
+
+		lpuart5: serial at 402E0000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x402E0000 0x1000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
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
+			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sl-usdhc";
+			reg = <0x40370000 0x10000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+				 <&clks IMX7ULP_CLK_NIC1_DIV>,
+				 <&clks IMX7ULP_CLK_USDHC0>;
+			clock-names ="ipg", "ahb", "per";
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		clks: scg1 at 403e0000 {
+			compatible = "fsl,imx7ulp-clock";
+			reg = <0x403e0000 0x10000>,
+			      <0x403f0000 0x10000>,
+			      <0x40b30000 0x10000>;
+			reg-names = "scg1", "pcc2", "pcc3";
+			clocks = <&rosc>, <&sosc>, <&sirc>,
+				 <&firc>, <&upll>, <&mpll>;
+			clock-names = "rosc", "sosc", "sirc",
+				      "firc", "upll", "mpll";
+			assigned-clocks = <&clks IMX7ULP_CLK_LPTPM5>,
+					  <&clks IMX7ULP_CLK_USDHC1>;
+			assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>,
+						 <&clks IMX7ULP_CLK_NIC1_DIV>;
+			#clock-cells = <1>;
+		};
+
+		smc1: smc1 at 40410000 {
+			compatible = "fsl,imx7ulp-smc1";
+			reg = <0x40410000 0x1000>;
+		};
+	};
+
+	ahbbridge1: ahb-bridge1 at 40800000 {
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x40800000 0x800000>;
+		ranges;
+
+		iomuxc1: iomuxc1 at 40ac0000 {
+			compatible = "fsl,imx7ulp-iomuxc1";
+			reg = <0x40ac0000 0x1000>;
+		};
+
+		lpuart6: serial at 40A60000 {
+			compatible = "fsl,imx7ulp-lpuart";
+			reg = <0x40A60000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0d44949..3ce8ff6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -41,6 +41,7 @@ CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
+CONFIG_SOC_IMX7ULP=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
@@ -48,9 +49,7 @@ CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
 CONFIG_ARM_PSCI=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_CMA=y
 CONFIG_FORCE_MAX_ZONEORDER=14
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_KEXEC=y
@@ -81,7 +80,6 @@ CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_H4=y
-CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
@@ -90,7 +88,6 @@ CONFIG_RFKILL_INPUT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
-CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
@@ -167,9 +164,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
@@ -178,7 +175,6 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
-CONFIG_HID_MULTITOUCH=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
@@ -228,13 +224,13 @@ CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
+CONFIG_RC_CORE=y
+CONFIG_RC_DEVICES=y
+CONFIG_IR_GPIO_CIR=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_RC_CORE=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-CONFIG_RC_DEVICES=y
-CONFIG_IR_GPIO_CIR=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
@@ -245,7 +241,6 @@ CONFIG_VIDEO_CODA=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
-CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
@@ -283,6 +278,7 @@ CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 782699e..54002c3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -554,6 +554,15 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
 
 if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 
+config SOC_IMX7ULP
+	bool "i.MX7ULP support"
+	select ARM_GIC
+	select CLKSRC_IMX_TPM
+	select HAVE_ARM_ARCH_TIMER
+	select PINCTRL_IMX7ULP
+	help
+	  This enables support for Freescale i.MX7 Ultra Low Power processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8ff7105..69c2517 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) += mach-imx7ulp.o pm-imx7ulp.o
 
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index b09a2ec..b0e85df 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -128,6 +128,7 @@ void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
 void imx6ul_pm_init(void);
+void imx7ulp_pm_init(void);
 
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index d4e55f2..46f344f 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -138,6 +138,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
+	case MXC_CPU_IMX7ULP:
+		soc_id = "i.MX7ULP";
+		break;
 	default:
 		soc_id = "Unknown";
 	}
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
new file mode 100644
index 0000000..9f7a25c
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+#include "hardware.h"
+
+static void __init imx7ulp_init_machine(void)
+{
+	imx7ulp_pm_init();
+
+	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
+	imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_1_0);
+	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
+}
+
+static const char *const imx7ulp_dt_compat[] __initconst = {
+	"fsl,imx7ulp",
+	NULL,
+};
+
+DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
+	.init_machine	= imx7ulp_init_machine,
+	.dt_compat	= imx7ulp_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index e00d626..ac9677b 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -41,6 +41,7 @@
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
+#define MXC_CPU_IMX7ULP		0xff
 
 #define IMX_DDR_TYPE_LPDDR2		1
 
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
new file mode 100644
index 0000000..00401e0
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define SMC_PMCTRL		0x10
+#define BP_PMCTRL_PSTOPO        16
+#define PSTOPO_PSTOP3		0x3
+
+void __init imx7ulp_pm_init(void)
+{
+	struct device_node *np;
+	void __iomem *smc1_base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
+	smc1_base = of_iomap(np, 0);
+	WARN_ON(!smc1_base);
+
+	/* Partial Stop mode 3 with system/bus clock enabled */
+	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO, smc1_base + SMC_PMCTRL);
+}
-- 
2.7.4
