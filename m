From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 Jun 2014 10:56:18 +0400
Subject: [PATCH 2/2] ARM: i.MX: Migrate Freescale Logic Product Development
 i.MX27 Lite-Kit board to devicetree
In-Reply-To: <1402642578-2456-1-git-send-email-shc_work@mail.ru>
References: <1402642578-2456-1-git-send-email-shc_work@mail.ru>
Message-ID: <1402642578-2456-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT support for Freescale Logic Product Development
i.MX27 Lite-Kit and removes platform representation for this board
from the tree.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile          |  1 +
 arch/arm/boot/dts/imx27-litekit.dts | 72 ++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig           |  9 ----
 arch/arm/mach-imx/Makefile          |  1 -
 arch/arm/mach-imx/mach-imx27lite.c  | 83 -------------------------------------
 5 files changed, 73 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-litekit.dts
 delete mode 100644 arch/arm/mach-imx/mach-imx27lite.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b681398..25bd629 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -166,6 +166,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27dev.dtb \
 	imx27-eukrea-mbimxsd27-baseboard.dtb \
 	imx27-ipcam.dtb \
+	imx27-litekit.dtb \
 	imx27-pdk.dtb \
 	imx27-phytec-phycore-rdk.dtb \
 	imx27-phytec-phycard-s-rdk.dtb \
diff --git a/arch/arm/boot/dts/imx27-litekit.dts b/arch/arm/boot/dts/imx27-litekit.dts
new file mode 100644
index 0000000..4c1b34c
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-litekit.dts
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx27.dtsi"
+
+/ {
+	model = "Freescale Logic Product Development i.MX27 Lite-Kit";
+	compatible = "fsl,imx27-litekit", "fsl,imx27";
+
+	memory {
+		reg = <0xa0000000 0x04000000>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	imx27-ipcam {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX27_PAD_SD3_CMD__FEC_TXD0	0x0
+				MX27_PAD_SD3_CLK__FEC_TXD1	0x0
+				MX27_PAD_ATA_DATA0__FEC_TXD2	0x0
+				MX27_PAD_ATA_DATA1__FEC_TXD3	0x0
+				MX27_PAD_ATA_DATA2__FEC_RX_ER	0x0
+				MX27_PAD_ATA_DATA3__FEC_RXD1	0x0
+				MX27_PAD_ATA_DATA4__FEC_RXD2	0x0
+				MX27_PAD_ATA_DATA5__FEC_RXD3	0x0
+				MX27_PAD_ATA_DATA6__FEC_MDIO	0x0
+				MX27_PAD_ATA_DATA7__FEC_MDC	0x0
+				MX27_PAD_ATA_DATA8__FEC_CRS	0x0
+				MX27_PAD_ATA_DATA9__FEC_TX_CLK	0x0
+				MX27_PAD_ATA_DATA10__FEC_RXD0	0x0
+				MX27_PAD_ATA_DATA11__FEC_RX_DV	0x0
+				MX27_PAD_ATA_DATA12__FEC_RX_CLK	0x0
+				MX27_PAD_ATA_DATA13__FEC_COL	0x0
+				MX27_PAD_ATA_DATA14__FEC_TX_ER	0x0
+				MX27_PAD_ATA_DATA15__FEC_TX_EN	0x0
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX27_PAD_UART1_TXD__UART1_TXD	0x0
+				MX27_PAD_UART1_RXD__UART1_RXD	0x0
+				MX27_PAD_UART1_CTS__UART1_CTS	0x0
+				MX27_PAD_UART1_RTS__UART1_RTS	0x0
+			>;
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ca187be..9297cd4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -357,15 +357,6 @@ config MACH_IMX27_VISSTRIM_M10
 	  This includes specific configurations for the board and its
 	  peripherals.
 
-config MACH_IMX27LITE
-	bool "LogicPD MX27 LITEKIT platform"
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select SOC_IMX27
-	help
-	  Include support for MX27 LITEKIT platform. This includes specific
-	  configurations for the board and its peripherals.
-
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index a364e20..12eee2a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
 obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
-obj-$(CONFIG_MACH_IMX27LITE) += mach-imx27lite.o
 obj-$(CONFIG_MACH_IMX27_VISSTRIM_M10) += mach-imx27_visstrim_m10.o
 obj-$(CONFIG_MACH_CPUIMX27) += mach-cpuimx27.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
deleted file mode 100644
index 9992089..0000000
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Copyright 2007 Robert Schwebel <r.schwebel@pengutronix.de>, Pengutronix
- * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
- * Copyright 2009 Daniel Schaeffer (daniel.schaeffer at timesys.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "devices-imx27.h"
-#include "hardware.h"
-#include "iomux-mx27.h"
-
-static const int mx27lite_pins[] __initconst = {
-	/* UART1 */
-	PE12_PF_UART1_TXD,
-	PE13_PF_UART1_RXD,
-	PE14_PF_UART1_CTS,
-	PE15_PF_UART1_RTS,
-	/* FEC */
-	PD0_AIN_FEC_TXD0,
-	PD1_AIN_FEC_TXD1,
-	PD2_AIN_FEC_TXD2,
-	PD3_AIN_FEC_TXD3,
-	PD4_AOUT_FEC_RX_ER,
-	PD5_AOUT_FEC_RXD1,
-	PD6_AOUT_FEC_RXD2,
-	PD7_AOUT_FEC_RXD3,
-	PD8_AF_FEC_MDIO,
-	PD9_AIN_FEC_MDC,
-	PD10_AOUT_FEC_CRS,
-	PD11_AOUT_FEC_TX_CLK,
-	PD12_AOUT_FEC_RXD0,
-	PD13_AOUT_FEC_RX_DV,
-	PD14_AOUT_FEC_RX_CLK,
-	PD15_AOUT_FEC_COL,
-	PD16_AIN_FEC_TX_ER,
-	PF23_AIN_FEC_TX_EN,
-};
-
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static void __init mx27lite_init(void)
-{
-	imx27_soc_init();
-
-	mxc_gpio_setup_multiple_pins(mx27lite_pins, ARRAY_SIZE(mx27lite_pins),
-		"imx27lite");
-	imx27_add_imx_uart0(&uart_pdata);
-	imx27_add_fec(NULL);
-}
-
-static void __init mx27lite_timer_init(void)
-{
-	mx27_clocks_init(26000000);
-}
-
-MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
-	.atag_offset = 0x100,
-	.map_io = mx27_map_io,
-	.init_early = imx27_init_early,
-	.init_irq = mx27_init_irq,
-	.init_time	= mx27lite_timer_init,
-	.init_machine = mx27lite_init,
-	.restart	= mxc_restart,
-MACHINE_END
-- 
1.8.5.5
