From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 2 May 2013 15:38:04 +0800
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1367480285-26159-1-git-send-email-b35083@freescale.com>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
Message-ID: <1367480285-26159-2-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Freescale Vybrid Family platform core definitions,
core drivers, including clock, period interrupt timer(PIT),
and DTS based machine support with MVF600 Tower development board.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
V2:
  Use CLOCKSOURCE_OF_DECLARE init timer
  Add ONESHOT mode support
  Add more clks definitions on MVF600 soc

 .../devicetree/bindings/clock/mvf600-clock.txt     | 180 +++++++++
 arch/arm/mach-imx/Kconfig                          |  15 +
 arch/arm/mach-imx/Makefile                         |   3 +
 arch/arm/mach-imx/clk-mvf.c                        | 406 +++++++++++++++++++++
 arch/arm/mach-imx/common.h                         |   1 +
 arch/arm/mach-imx/mach-mvf600.c                    | 118 ++++++
 arch/arm/mach-imx/pit.c                            | 244 +++++++++++++
 7 files changed, 967 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvf600-clock.txt
 create mode 100644 arch/arm/mach-imx/clk-mvf.c
 create mode 100644 arch/arm/mach-imx/mach-mvf600.c
 create mode 100644 arch/arm/mach-imx/pit.c

diff --git a/Documentation/devicetree/bindings/clock/mvf600-clock.txt b/Documentation/devicetree/bindings/clock/mvf600-clock.txt
new file mode 100644
index 0000000..9f8b20e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvf600-clock.txt
@@ -0,0 +1,180 @@
+* Clock bindings for Freescale Vybrid Family
+
+Required properties:
+- compatible: Should be "fsl,mvf-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of MVF600
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	dummy			0
+	sirc_128k		1
+	sirc_32k		2
+	firc			3
+	sxosc			4
+	fxosc			5
+	fxosc_half		6
+	slow_clk		7
+	fast_clk		8
+	audio_ext		9
+	enet_ext		10
+	pll1_main_528m		11
+	pll1_pfd1_500m		12
+	pll1_pfd2_452m		13
+	pll1_pfd3_396m		14
+	pll1_pfd4_528m		15
+	pll2_main_528m		16
+	pll2_pfd1_500m		17
+	pll2_pfd2_396m		18
+	pll2_pfd3_339m		19
+	pll2_pfd4_413m		20
+	pll3_main_480m		21
+	pll3_pfd1_308m		22
+	pll3_pfd2_332m		23
+	pll3_pfd3_298m		24
+	pll3_pfd4_320m		25
+	pll4_main		26
+	pll5_main		27
+	pll6_main		28
+	pll3_main_div		29
+	pll4_main_div		30
+	pll6_main_div		31
+	pll1_sw			32
+	pll2_sw			33
+	sys_sw			34
+	ddr_sw			35
+	sys_bus_clk		36
+	platform_bus_clk	37
+	ipg_bus_clk		38
+	uart0_clk		39
+	uart1_clk		40
+	uart2_clk		41
+	uart3_clk		42
+	uart4_clk		43
+	uart5_clk		44
+	pit_clk			45
+	i2c0_clk		46
+	i2c1_clk		47
+	i2c2_clk		48
+	i2c3_clk		49
+	ftm0_ext_sw		50
+	ftm0_fix_sw		51
+	ftm0_ext_fix_gate	52
+	ftm1_ext_sw		53
+	ftm1_fix_sw		54
+	ftm1_ext_fix_gate	55
+	ftm2_ext_sw		56
+	ftm2_fix_sw		57
+	ftm2_ext_fix_gate	58
+	ftm3_ext_sw		59
+	ftm3_fix_sw		60
+	ftm3_ext_fix_gate	61
+	ftm0_clk		62
+	ftm1_clk		63
+	ftm2_clk		64
+	ftm3_clk		65
+	enet_50m		66
+	enet_25m		67
+	enet_clk_sw		68
+	enet_clk		69
+	enet_ts_sw		70
+	enet_ts			71
+	dspi0_clk		72
+	dspi1_clk		73
+	dspi2_clk		74
+	dspi3_clk		75
+	wdt_clk			76
+	esdhc0_sw		77
+	esdhc0_gate		78
+	esdhc0_div		79
+	esdhc0_clk		80
+	esdhc1_sw		81
+	esdhc1_gate		82
+	esdhc1_div		83
+	esdhc1_clk		84
+	dcu0_sw			85
+	dcu0_gate		86
+	dcu0_div		87
+	dcu0_clk		88
+	dcu1_sw			89
+	dcu1_gate		90
+	dcu1_div		91
+	dcu1_clk		92
+	esai_sw			93
+	esai_gate		94
+	esai_div		95
+	esai_clk		96
+	sai0_sw			97
+	sai0_gate		98
+	sai0_div		99
+	sai0_clk		100
+	sai1_sw			101
+	sai1_gate		102
+	sai1_div		103
+	sai1_clk		104
+	sai2_sw			105
+	sai2_gate		106
+	sai2_div		107
+	sai2_clk		108
+	sai3_sw			109
+	sai3_gate		110
+	sai3_div		111
+	sai3_clk		112
+	usbc0_clk		113
+	usbc1_clk		114
+	qspi0_sw		115
+	qspi0_gate		116
+	qspi0_x4_div		117
+	qspi0_x2_div		118
+	qspi0_x1_div		119
+	qspi1_sw		120
+	qspi1_gate		121
+	qspi1_x4_div		122
+	qspi1_x2_div		123
+	qspi1_x1_div		124
+	qspi0_clk		125
+	qspi1_clk		126
+	nfc_sw			127
+	nfc_gate		128
+	nfc_pre_div		129
+	nfc_frac_div		130
+	nfc_inv			131
+	nfc_clk			132
+	vadc_sw			133
+	vadc_gate		134
+	vadc_div		135
+	vadc_div_half		136
+	vadc_clk		137
+	adc0_clk		138
+	adc1_clk		139
+	dac0_clk		140
+	dac1_clk		141
+	flexcan0_clk		142
+	flexcan1_clk		143
+	asrc_clk		144
+	gpu_sw			145
+	gpu_gate		146
+	gpu2d_clk		147
+
+
+
+Examples:
+
+clks: ccm at 4006b000 {
+	compatible = "fsl,mvf-ccm";
+	reg = <0x4006b000 0x1000>;
+	#clock-cells = <1>;
+};
+
+uart1: serial at 40028000 { /* UART1 */
+	compatible = "fsl,mvf-uart";
+	reg = <0x40028000 0x1000>;
+	interrupts = <0 62 0x04>;
+	clocks = <&clks 35>;
+	clock-names = "ipg";
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 78f795d..2fb9562 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -819,6 +819,21 @@ config SOC_IMX6Q
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
 
+config SOC_MVF600
+	bool "Vybrid Family MVF600 support"
+	select CPU_V7
+	select ARM_GIC
+	select COMMON_CLK
+	select CLKSRC_OF
+	select PINCTRL
+	select PINCTRL_MVF
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
+
+	help
+	  This enable support for Freescale Vybrid Family VF6xx MPU.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index b16eb39..76a2ead 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -112,4 +112,7 @@ obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
+# Vybrid based machines
+obj-$(CONFIG_SOC_MVF600) += clk-mvf.o mach-mvf600.o pit.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/clk-mvf.c b/arch/arm/mach-imx/clk-mvf.c
new file mode 100644
index 0000000..1467a304
--- /dev/null
+++ b/arch/arm/mach-imx/clk-mvf.c
@@ -0,0 +1,406 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/hrtimer.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/clkdev.h>
+#include <linux/regulator/consumer.h>
+#include <asm/div64.h>
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "hardware.h"
+#include "common.h"
+#include "clk.h"
+
+
+#define CCM_CCR		(ccm_base + 0x00)
+#define CCM_CSR		(ccm_base + 0x04)
+#define CCM_CCSR		(ccm_base + 0x08)
+#define CCM_CACRR		(ccm_base + 0x0c)
+#define CCM_CSCMR1		(ccm_base + 0x10)
+#define CCM_CSCDR1		(ccm_base + 0x14)
+#define CCM_CSCDR2		(ccm_base + 0x18)
+#define CCM_CSCDR3		(ccm_base + 0x1c)
+#define CCM_CSCMR2		(ccm_base + 0x20)
+#define CCM_CSCDR4		(ccm_base + 0x24)
+#define CCM_CLPCR		(ccm_base + 0x2c)
+#define CCM_CISR		(ccm_base + 0x30)
+#define CCM_CIMR		(ccm_base + 0x34)
+#define CCM_CGPR		(ccm_base + 0x3c)
+#define CCM_CCGR0		(ccm_base + 0x40)
+#define CCM_CCGR1		(ccm_base + 0x44)
+#define CCM_CCGR2		(ccm_base + 0x48)
+#define CCM_CCGR3		(ccm_base + 0x4c)
+#define CCM_CCGR4		(ccm_base + 0x50)
+#define CCM_CCGR5		(ccm_base + 0x54)
+#define CCM_CCGR6		(ccm_base + 0x58)
+#define CCM_CCGR7		(ccm_base + 0x5c)
+#define CCM_CCGR8		(ccm_base + 0x60)
+#define CCM_CCGR9		(ccm_base + 0x64)
+#define CCM_CCGR10		(ccm_base + 0x68)
+#define CCM_CCGR11		(ccm_base + 0x6C)
+#define CCM_CMEOR0		(ccm_base + 0x70)
+#define CCM_CMEOR1		(ccm_base + 0x74)
+#define CCM_CMEOR2		(ccm_base + 0x78)
+#define CCM_CMEOR3		(ccm_base + 0x7C)
+#define CCM_CMEOR4		(ccm_base + 0x80)
+#define CCM_CMEOR5		(ccm_base + 0x84)
+#define CCM_CPPDSR		(ccm_base + 0x88)
+#define CCM_CCOWR		(ccm_base + 0x8C)
+#define CCM_CCPGR0		(ccm_base + 0x90)
+#define CCM_CCPGR1		(ccm_base + 0x94)
+#define CCM_CCPGR2		(ccm_base + 0x98)
+#define CCM_CCPGR3		(ccm_base + 0x9C)
+
+#define CCM_CCGRx_CGn(n)		(n * 2)
+
+#define PFD_528SYS_BASE		(anatop_base + 0x2B0)
+#define PFD_528_BASE		(anatop_base + 0x100)
+#define PFD_USB_BASE		(anatop_base + 0xF0) /* pll3 pfd definition */
+
+
+static void __iomem *anatop_base;
+static void __iomem *ccm_base;
+
+/* This is used multiple times */
+static const char const *fast_clk_sel[] = { "firc", "fxosc", };
+static const char const *slow_clk_sel[] = { "sirc_32k", "sxosc", };
+static const char const *pll1_pfd_sel[] = {
+	"pll1_main", "pll1_pfd1", "pll1_pfd2", "pll1_pfd3", "pll1_pfd4",
+};
+static const char const *pll2_pfd_sel[] = {
+	"pll2_main", "pll2_pfd1", "pll2_pfd2", "pll2_pfd3", "pll2_pfd4",
+};
+static const char const *sys_clk_sel[] = {
+	"fast_clk", "slow_clk", "pll2_sw", "pll2_main", "pll1_sw", "pll3_main",
+};
+static const char const *ddr_clk_sel[] = { "pll2_pfd2", "sys_clk", };
+static const char const *rmii_clk_sel[] = {
+	"enet_ext", "audio_ext", "enet_50m", "enet_25m",
+};
+static const char const *enet_ts_clk_sel[] = {
+	"enet_ext", "fxosc", "audio_ext", "usb_clk", "enet_ts_clk", "enet_25m", "enet_50m",
+};
+static const char const *esai_clk_sel[] = {
+	"audio_ext", "mlb_clk", "spdif_rx_clk", "pll4_main_div",
+};
+static const char const *sai_clk_sel[] = {
+	"audio_ext", "mlb_clk", "spdif_rx_clk", "pll4_main_div",
+};
+static const char const *nfc_clk_sel[] = {
+	"platform_bus", "pll1_pfd1", "pll3_pfd1", "pll3_pfd3",
+};
+static const char const *qspi_clk_sel[] = {
+	"pll3_main", "pll3_pfd4", "pll2_pfd4", "pll1_pfd4",
+};
+static const char const *esdhc_clk_sel[] = {
+	"pll3_main", "pll3_pfd3", "pll1_pfd3", "platform_bus",
+};
+static const char const *dcu_clk_sel[] = { "pll1_pfd2", "pll3_main", };
+static const char const *gpu_clk_sel[] = { "pll2_pfd2", "pll3_pfd2", };
+static const char const *vadc_clk_sel[] = { "pll6_main_div", "pll3_main_div", "pll3_main", };
+/* FTM counter clock source, not module clock */
+static const char const *ftm_ext_clk_sel[] = {"sirc_128k", "sxosc", "fxosc_half", "audio_ext", };
+static const char const *ftm_fix_clk_sel[] = { "sxosc", "ipg_bus", };
+
+enum mvf_clks {
+	dummy,
+	sirc_128k, sirc_32k, firc, sxosc, fxosc, fxosc_half,
+	slow_clk, fast_clk, audio_ext, enet_ext,
+	pll1_main_528m, pll1_pfd1_500m, pll1_pfd2_452m,
+	pll1_pfd3_396m, pll1_pfd4_528m, pll2_main_528m, pll2_pfd1_500m,
+	pll2_pfd2_396m, pll2_pfd3_339m, pll2_pfd4_413m, pll3_main_480m,
+	pll3_pfd1_308m, pll3_pfd2_332m, pll3_pfd3_298m, pll3_pfd4_320m,
+	pll4_main, pll5_main, pll6_main,
+	pll3_main_div, pll4_main_div, pll6_main_div,
+	pll1_sw, pll2_sw, sys_sw, ddr_sw,
+	sys_bus_clk, platform_bus_clk, ipg_bus_clk,
+	uart0_clk, uart1_clk, uart2_clk, uart3_clk, uart4_clk, uart5_clk,
+	pit_clk,
+	i2c0_clk, i2c1_clk, i2c2_clk, i2c3_clk,
+	ftm0_ext_sw, ftm0_fix_sw, ftm0_ext_fix_gate,
+	ftm1_ext_sw, ftm1_fix_sw, ftm1_ext_fix_gate,
+	ftm2_ext_sw, ftm2_fix_sw, ftm2_ext_fix_gate,
+	ftm3_ext_sw, ftm3_fix_sw, ftm3_ext_fix_gate,
+	ftm0_clk, ftm1_clk, ftm2_clk, ftm3_clk,
+	enet_50m, enet_25m, enet_clk_sw, enet_clk, enet_ts_sw, enet_ts,
+	dspi0_clk, dspi1_clk, dspi2_clk, dspi3_clk,
+	wdt_clk,
+	esdhc0_sw, esdhc0_gate, esdhc0_div, esdhc0_clk,
+	esdhc1_sw, esdhc1_gate, esdhc1_div, esdhc1_clk,
+	dcu0_sw, dcu0_gate, dcu0_div, dcu0_clk,
+	dcu1_sw, dcu1_gate, dcu1_div, dcu1_clk,
+	esai_sw, esai_gate, esai_div, esai_clk,
+	sai0_sw, sai0_gate, sai0_div, sai0_clk,
+	sai1_sw, sai1_gate, sai1_div, sai1_clk,
+	sai2_sw, sai2_gate, sai2_div, sai2_clk,
+	sai3_sw, sai3_gate, sai3_div, sai3_clk,
+	usbc0_clk, usbc1_clk,
+	qspi0_sw, qspi0_gate, qspi0_x4_div, qspi0_x2_div, qspi0_x1_div,
+	qspi1_sw, qspi1_gate, qspi1_x4_div, qspi1_x2_div, qspi1_x1_div,
+	qspi0_clk, qspi1_clk,
+	nfc_sw, nfc_gate, nfc_pre_div, nfc_frac_div, nfc_inv, nfc_clk,
+	vadc_sw, vadc_gate, vadc_div, vadc_div_half, vadc_clk,
+	adc0_clk, adc1_clk, dac0_clk, dac1_clk,
+	flexcan0_clk, flexcan1_clk,
+	asrc_clk,
+	gpu_sw, gpu_gate, gpu2d_clk,
+	clk_max
+};
+
+static struct clk_div_table pll4_main_div_table[] = {
+	[0] = {.val = 0, .div = 1},
+	[1] = {.val = 1, .div = 2},
+	[2] = {.val = 2, .div = 6},
+	[3] = {.val = 3, .div = 8},
+	[4] = {.val = 4, .div = 10},
+	[5] = {.val = 5, .div = 12},
+	[6] = {.val = 6, .div = 14},
+	[7] = {.val = 7, .div = 16},
+};
+static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
+
+int __init mvf_clocks_init(void)
+{
+	struct device_node *np;
+
+	clk[dummy] = imx_clk_fixed("dummy", 0);
+	clk[sirc_128k] = imx_clk_fixed("sirc_128k", 128000); /* slow internal IRC */
+	clk[sirc_32k] = imx_clk_fixed("sirc_32k", 32000); /* slow internal IRC */
+	clk[firc] = imx_clk_fixed("firc", 24000000); /* fast internal IRC */
+	clk[sxosc] = imx_clk_fixed("sxosc", 32000); /* fixed 32k external osc */
+
+	for_each_compatible_node(np, NULL, "fixed-clock") {
+		u32 rate;
+
+		if (of_property_read_u32(np, "clock-frequency", &rate))
+			continue;
+		else if (of_device_is_compatible(np, "fsl,mvf-osc"))
+			clk[fxosc] = imx_clk_fixed("fxosc", rate);
+		else if (of_device_is_compatible(np, "fsl,mvf-audio-ext-clk"))
+			clk[audio_ext] = imx_clk_fixed("audio_ext", rate);
+		else if (of_device_is_compatible(np, "fsl,mvf-enet-ext-clk"))
+			clk[enet_ext] = imx_clk_fixed("enet_ext", rate);
+	}
+
+	/* default to 24Mhz OSC */
+	if (!clk[fxosc])
+		clk[fxosc] = imx_clk_fixed("fxosc", 24000000);
+
+	clk[fxosc_half] = imx_clk_fixed_factor("fxosc_half", "fxosc", 1, 2);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-anatop");
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-ccm");
+	ccm_base = of_iomap(np, 0);
+	WARN_ON(!ccm_base);
+
+	clk[slow_clk] = imx_clk_mux("slow_clk", CCM_CCSR, 4, 1,
+				slow_clk_sel, ARRAY_SIZE(slow_clk_sel));
+	clk[fast_clk] = imx_clk_mux("fast_clk", CCM_CCSR, 5, 1,
+				fast_clk_sel, ARRAY_SIZE(fast_clk_sel));
+
+	clk[pll1_main_528m] = imx_clk_fixed_factor("pll1_main",	"fast_clk", 22, 1);
+	clk[pll1_pfd1_500m] = imx_clk_pfd("pll1_pfd1", "pll1_main", PFD_528SYS_BASE, 0);
+	clk[pll1_pfd2_452m] = imx_clk_pfd("pll1_pfd2", "pll1_main", PFD_528SYS_BASE, 1);
+	clk[pll1_pfd3_396m] = imx_clk_pfd("pll1_pfd3", "pll1_main", PFD_528SYS_BASE, 2);
+	clk[pll1_pfd4_528m] = imx_clk_pfd("pll1_pfd4", "pll1_main", PFD_528SYS_BASE, 3);
+
+	clk[pll2_main_528m] = imx_clk_fixed_factor("pll2_main", "fast_clk", 22, 1);
+	clk[pll2_pfd1_500m] = imx_clk_pfd("pll2_pfd1", "pll2_main", PFD_528_BASE, 0);
+	clk[pll2_pfd2_396m] = imx_clk_pfd("pll2_pfd2", "pll2_main", PFD_528_BASE, 1);
+	clk[pll2_pfd3_339m] = imx_clk_pfd("pll2_pfd3", "pll2_main", PFD_528_BASE, 2);
+	clk[pll2_pfd4_413m] = imx_clk_pfd("pll2_pfd4", "pll2_main", PFD_528_BASE, 3);
+
+	clk[pll3_main_480m] = imx_clk_fixed_factor("pll3_main", "fast_clk", 20, 1);
+	clk[pll4_main] = imx_clk_fixed_factor("pll4_main", "fast_clk", 25, 1);
+	/* Enet pll: fixed 50Mhz */
+	clk[pll5_main] = imx_clk_fixed_factor("pll5_main", "fast_clk", 125, 6);
+	clk[enet_50m] = imx_clk_fixed_factor("enet_50m", "pll5_main", 1, 10);
+	clk[enet_25m] = imx_clk_fixed_factor("enet_25m", "pll5_main", 1, 20);
+	/* Video pll: default 960Mhz */
+	clk[pll6_main] = imx_clk_fixed_factor("pll6_main", "fast_clk", 40, 1);
+	clk[pll1_sw] = imx_clk_mux("pll1_sw", CCM_CCSR, 16, 3, pll1_pfd_sel, 5);
+	clk[pll2_sw] = imx_clk_mux("pll2_sw", CCM_CCSR, 19, 3, pll2_pfd_sel, 5);
+	clk[sys_sw] = imx_clk_mux("sys_sw", CCM_CCSR, 0, 3, sys_clk_sel, ARRAY_SIZE(sys_clk_sel));
+	clk[ddr_sw] = imx_clk_mux("ddr_sw", CCM_CCSR, 6, 1, ddr_clk_sel, ARRAY_SIZE(ddr_clk_sel));
+	clk[sys_bus_clk] = imx_clk_divider("sys_bus", "sys_sw", CCM_CACRR, 0, 3);
+	clk[platform_bus_clk] = imx_clk_divider("platform_bus", "sys_bus", CCM_CACRR, 3, 3);
+	clk[ipg_bus_clk] = imx_clk_divider("ipg_bus", "platform_bus", CCM_CACRR, 11, 2);
+
+	clk[pll3_main_div] = imx_clk_divider("pll3_main_div", "pll3_main", CCM_CACRR, 20, 1);
+	clk[pll4_main_div] = clk_register_divider_table(NULL, "pll4_main_div", "pll4_main", 0,
+			CCM_CACRR, 6, 3, 0, pll4_main_div_table, &imx_ccm_lock);
+	clk[pll6_main_div] = imx_clk_divider("pll6_main_div", "pll6_main", CCM_CACRR, 21, 1);
+
+	clk[usbc0_clk] = imx_clk_gate2("usbc0_clk", "pll3_main", CCM_CCGR1, CCM_CCGRx_CGn(4));
+	clk[usbc1_clk] = imx_clk_gate2("usbc1_clk", "pll3_main", CCM_CCGR7, CCM_CCGRx_CGn(4));
+
+	clk[qspi0_sw] = imx_clk_mux("qspi0_sw", CCM_CSCMR1, 22, 2, qspi_clk_sel, 4);
+	clk[qspi0_x4_div] = imx_clk_divider("qspi0_x4", "qspi0_sw", CCM_CSCDR3, 0, 2);
+	clk[qspi0_x2_div] = imx_clk_divider("qspi0_x2", "qspi0_x4", CCM_CSCDR3, 2, 1);
+	clk[qspi0_x1_div] = imx_clk_divider("qspi0_x1", "qspi0_x2", CCM_CSCDR3, 3, 1);
+	clk[qspi0_gate] = imx_clk_gate("qspi0_gate", "qspi0_x1", CCM_CSCDR3, 4);
+	clk[qspi0_clk] = imx_clk_gate2("qspi0_clk", "qspi0_en", CCM_CCGR2, CCM_CCGRx_CGn(4));
+
+	clk[qspi1_sw] = imx_clk_mux("qspi1_sw", CCM_CSCMR1, 24, 2, qspi_clk_sel, 4);
+	clk[qspi1_x4_div] = imx_clk_divider("qspi1_x4", "qspi1_sw", CCM_CSCDR3, 8, 2);
+	clk[qspi1_x2_div] = imx_clk_divider("qspi1_x2", "qspi1_x4", CCM_CSCDR3, 10, 1);
+	clk[qspi1_x1_div] = imx_clk_divider("qspi1_x1", "qspi1_x2", CCM_CSCDR3, 11, 1);
+	clk[qspi1_gate] = imx_clk_gate("qspi1_gate", "qspi1_x1", CCM_CSCDR3, 12);
+	clk[qspi1_clk] = imx_clk_gate2("qspi1_clk", "qspi1_en", CCM_CCGR8, CCM_CCGRx_CGn(4));
+
+	clk[enet_clk_sw] = imx_clk_mux("enet_sw", CCM_CSCMR2, 4, 2, rmii_clk_sel, 4);
+	clk[enet_ts_sw] = imx_clk_mux("enet_ts_sw", CCM_CSCMR2, 0, 3, enet_ts_clk_sel, 7);
+	clk[enet_clk] = imx_clk_gate("enet_clk", "enet_sw", CCM_CSCDR1, 24);
+	clk[enet_ts] = imx_clk_gate("enet_ts_clk", "enet_ts_sw", CCM_CSCDR1, 23);
+
+	clk[pit_clk] = imx_clk_gate2("pit_clk", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(7));
+
+	clk[uart0_clk] = imx_clk_gate2("uart0_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(7));
+	clk[uart1_clk] = imx_clk_gate2("uart1_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(8));
+	clk[uart2_clk] = imx_clk_gate2("uart2_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(9));
+	clk[uart3_clk] = imx_clk_gate2("uart3_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(10));
+
+	clk[i2c0_clk] = imx_clk_gate2("i2c0_clk", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
+	clk[i2c1_clk] = imx_clk_gate2("i2c1_clk", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
+
+	clk[dspi0_clk] = imx_clk_gate2("dspi0_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(12));
+	clk[dspi1_clk] = imx_clk_gate2("dspi1_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(13));
+	clk[dspi2_clk] = imx_clk_gate2("dspi2_clk", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(12));
+	clk[dspi3_clk] = imx_clk_gate2("dspi3_clk", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(13));
+
+	clk[wdt_clk] = imx_clk_gate2("wdt_clk", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(14));
+
+	clk[esdhc0_sw] = imx_clk_mux("esdhc0_sw", CCM_CSCMR1, 16, 2, esdhc_clk_sel, 4);
+	clk[esdhc0_gate] = imx_clk_gate("esdhc0_gate", "esdhc0_sw", CCM_CSCDR2, 28);
+	clk[esdhc0_div] = imx_clk_divider("esdhc0_div", "esdhc0_gate", CCM_CSCDR2, 16, 4);
+	clk[esdhc0_clk] = imx_clk_gate2("eshc0_clk", "esdhc0_div", CCM_CCGR7, CCM_CCGRx_CGn(1));
+
+	clk[esdhc1_sw] = imx_clk_mux("esdhc1_sw", CCM_CSCMR1, 18, 2, esdhc_clk_sel, 4);
+	clk[esdhc1_gate] = imx_clk_gate("esdhc1_gate", "esdhc1_sw", CCM_CSCDR2, 29);
+	clk[esdhc1_div] = imx_clk_divider("esdhc1_div", "esdhc1_gate", CCM_CSCDR2, 20, 4);
+	clk[esdhc1_clk] = imx_clk_gate2("eshc1_clk", "esdhc1_div", CCM_CCGR7, CCM_CCGRx_CGn(2));
+
+	/*
+	 * ftm_ext_clk and ftm_fix_clk are FTM timer counter's
+	 * selectable clock source, both use a common gate bit
+	 * in CCM_CSCDR1, select "dummy" as "ftm0_ext_fix_gate"
+	 * parent make the gate doesn't provids any clock freq
+	 * except for gate/ungate.
+	 */
+	clk[ftm0_ext_sw] = imx_clk_mux("ftm0_ext_sw", CCM_CSCMR2, 6, 2, ftm_ext_clk_sel, 4);
+	clk[ftm0_fix_sw] = imx_clk_mux("ftm0_fix_sw", CCM_CSCMR2, 14, 1, ftm_fix_clk_sel, 2);
+	clk[ftm0_ext_fix_gate] = imx_clk_gate("ftm0_ext_fix_gate", "dummy", CCM_CSCDR1, 25);
+	/* ftm(n)_clk are FTM module operation clock */
+	clk[ftm0_clk] = imx_clk_gate2("ftm0_clk", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(8));
+	clk[ftm1_clk] = imx_clk_gate2("ftm1_clk", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(9));
+	clk[ftm2_clk] = imx_clk_gate2("ftm2_clk", "ipg_bus", CCM_CCGR7, CCM_CCGRx_CGn(8));
+	clk[ftm3_clk] = imx_clk_gate2("ftm3_clk", "ipg_bus", CCM_CCGR7, CCM_CCGRx_CGn(9));
+
+	clk[dcu0_sw] = imx_clk_mux("dcu0_sw", CCM_CSCMR1, 28, 1, dcu_clk_sel, 2);
+	clk[dcu0_gate] = imx_clk_gate("dcu0_gate", "dcu0_sw", CCM_CSCDR3, 19);
+	clk[dcu0_div] = imx_clk_divider("dcu0_div", "dcu0_gate", CCM_CSCDR3, 16, 3);
+	clk[dcu0_clk] = imx_clk_gate2("dcu0_clk", "dcu0_div", CCM_CCGR3, CCM_CCGRx_CGn(8));
+	clk[dcu1_sw] = imx_clk_mux("dcu1_sw", CCM_CSCMR1, 29, 1, dcu_clk_sel, 2);
+	clk[dcu1_gate] = imx_clk_gate("dcu1_gate", "dcu1_sw", CCM_CSCDR3, 23);
+	clk[dcu1_div] = imx_clk_divider("dcu1_div", "dcu1_gate", CCM_CSCDR3, 20, 3);
+	clk[dcu1_clk] = imx_clk_gate2("dcu1_clk", "dcu1_div", CCM_CCGR9, CCM_CCGRx_CGn(8));
+
+	clk[esai_sw] = imx_clk_mux("esai_sw", CCM_CSCMR1, 20, 2, esai_clk_sel, 4);
+	clk[esai_gate] = imx_clk_gate("esai_gate", "esai_sw", CCM_CSCDR2, 30);
+	clk[esai_div] = imx_clk_divider("esai_div", "esai_gate", CCM_CSCDR2, 24, 4);
+	clk[esai_clk] = imx_clk_gate2("esai_clk", "esai_div", CCM_CCGR4, CCM_CCGRx_CGn(2));
+
+	clk[sai0_sw] = imx_clk_mux("sai0_sw", CCM_CSCMR1, 0, 2, sai_clk_sel, 4);
+	clk[sai0_gate] = imx_clk_gate("sai0_gate", "sai0_sw", CCM_CSCDR1, 16);
+	clk[sai0_div] = imx_clk_divider("sai0_div", "sai0_gate", CCM_CSCDR1, 0, 4);
+	clk[sai0_clk] = imx_clk_gate2("sai0_clk", "sai0_div", CCM_CCGR0, CCM_CCGRx_CGn(15));
+
+	clk[sai1_sw] = imx_clk_mux("sai1_sw", CCM_CSCMR1, 2, 2, sai_clk_sel, 4);
+	clk[sai1_gate] = imx_clk_gate("sai1_gate", "sai1_sw", CCM_CSCDR1, 17);
+	clk[sai1_div] = imx_clk_divider("sai1_div", "sai1_gate", CCM_CSCDR1, 4, 4);
+	clk[sai1_clk] = imx_clk_gate2("sai1_clk", "sai1_div", CCM_CCGR1, CCM_CCGRx_CGn(0));
+
+	clk[sai2_sw] = imx_clk_mux("sai2_sw", CCM_CSCMR1, 4, 2, sai_clk_sel, 4);
+	clk[sai2_gate] = imx_clk_gate("sai2_gate", "sai2_sw", CCM_CSCDR1, 18);
+	clk[sai2_div] = imx_clk_divider("sai2_div", "sai2_gate", CCM_CSCDR1, 8, 4);
+	clk[sai2_clk] = imx_clk_gate2("sai2_clk", "sai2_div", CCM_CCGR1, CCM_CCGRx_CGn(1));
+
+	clk[sai3_sw] = imx_clk_mux("sai3_sw", CCM_CSCMR1, 6, 2, sai_clk_sel, 4);
+	clk[sai3_gate] = imx_clk_gate("sai3_gate", "sai3_sw", CCM_CSCDR1, 19);
+	clk[sai3_div] = imx_clk_divider("sai3_div", "sai3_gate", CCM_CSCDR1, 12, 4);
+	clk[sai3_clk] = imx_clk_gate2("sai3_clk", "sai3_div", CCM_CCGR1, CCM_CCGRx_CGn(2));
+
+	clk[nfc_sw] = imx_clk_mux("nfc_sw", CCM_CSCMR1, 12, 2, nfc_clk_sel, 4);
+	clk[nfc_gate] = imx_clk_gate("nfc_gate", "nfc_sw", CCM_CSCDR2, 9);
+	clk[nfc_pre_div] = imx_clk_divider("nfc_pre_div", "nfc_gate", CCM_CSCDR3, 13, 3);
+	clk[nfc_frac_div] = imx_clk_divider("nfc_frac_div", "nfc_pre_div", CCM_CSCDR2, 4, 4);
+	clk[nfc_clk] = imx_clk_gate2("nfc_clk", "nfc_frac_div", CCM_CCGR10, CCM_CCGRx_CGn(0));
+
+	clk[gpu_sw] = imx_clk_mux("gpu_sw", CCM_CSCMR1, 14, 1, gpu_clk_sel, 2);
+	clk[gpu_gate] = imx_clk_gate("gpu_gate", "gpu_sw", CCM_CSCDR2, 10);
+	clk[gpu2d_clk] = imx_clk_gate2("gpu_clk", "gpu_gate", CCM_CCGR8, CCM_CCGRx_CGn(15));
+
+	clk[vadc_sw] = imx_clk_mux("vadc_sw", CCM_CSCMR1, 8, 2, vadc_clk_sel, 3);
+	clk[vadc_gate] = imx_clk_gate("vadc_gate", "vadc_sw", CCM_CSCDR1, 22);
+	clk[vadc_div] = imx_clk_divider("vadc_div", "vadc_gate", CCM_CSCDR1, 20, 2);
+	clk[vadc_div_half] = imx_clk_fixed_factor("vadc_div_half", "vadc_div", 1, 2);
+	clk[vadc_clk] = imx_clk_gate2("vadc_clk", "vadc_div", CCM_CCGR8, CCM_CCGRx_CGn(7));
+
+	clk[adc0_clk] = imx_clk_gate2("adc0_clk", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(11));
+	clk[adc1_clk] = imx_clk_gate2("adc1_clk", "ipg_bus", CCM_CCGR7, CCM_CCGRx_CGn(11));
+	clk[dac0_clk] = imx_clk_gate2("dac0_clk", "ipg_bus", CCM_CCGR8, CCM_CCGRx_CGn(12));
+	clk[dac1_clk] = imx_clk_gate2("dac1_clk", "ipg_bus", CCM_CCGR8, CCM_CCGRx_CGn(13));
+
+	clk[asrc_clk] = imx_clk_gate2("asrc_clk", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(1));
+
+	clk[flexcan0_clk] = imx_clk_gate2("flexcan0_clk", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(0));
+	clk[flexcan1_clk] = imx_clk_gate2("flexcan1_clk", "ipg_bus", CCM_CCGR9, CCM_CCGRx_CGn(4));
+
+	clk_set_parent(clk[qspi0_sw], clk[pll1_pfd4_528m]);
+	clk_set_rate(clk[qspi0_x4_div],	clk_get_rate(clk[qspi0_x4_div]->parent) / 2);
+	clk_set_rate(clk[qspi0_x2_div],	clk_get_rate(clk[qspi0_x2_div]->parent) / 2);
+	clk_set_rate(clk[qspi0_x1_div],	clk_get_rate(clk[qspi0_x1_div]->parent) / 2);
+
+	clk_set_parent(clk[qspi1_sw], clk[pll1_pfd4_528m]);
+	clk_set_rate(clk[qspi1_x4_div], clk_get_rate(clk[qspi1_x4_div]->parent) / 2);
+	clk_set_rate(clk[qspi1_x2_div], clk_get_rate(clk[qspi1_x2_div]->parent) / 2);
+	clk_set_rate(clk[qspi1_x1_div], clk_get_rate(clk[qspi1_x1_div]->parent) / 2);
+
+	clk_set_parent(clk[sai0_gate], clk[audio_ext]);
+	clk_set_parent(clk[sai1_gate], clk[audio_ext]);
+	clk_set_parent(clk[sai2_gate], clk[audio_ext]);
+	clk_set_parent(clk[sai3_gate], clk[audio_ext]);
+
+	/* Add the clocks to provider list */
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4cba7db..683c4f4 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -68,6 +68,7 @@ extern int mx31_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
+extern int mvf_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-mvf600.c b/arch/arm/mach-imx/mach-mvf600.c
new file mode 100644
index 0000000..56d3fb0
--- /dev/null
+++ b/arch/arm/mach-imx/mach-mvf600.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clocksource.h>
+#include <linux/platform_device.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <asm/memory.h>
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/system_misc.h>
+
+#include "common.h"
+
+
+void mvf_restart(char mode, const char *cmd)
+{
+	struct device_node *np;
+	void __iomem *wdog_base;
+	struct clk *wdog_clk;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-wdt");
+	wdog_base = of_iomap(np, 0);
+	if (!wdog_base)
+		goto soft;
+
+	wdog_clk = of_clk_get_by_name(np, "wdog");
+	if (!IS_ERR(wdog_clk))
+		clk_prepare_enable(wdog_clk);
+
+	/* enable wdog */
+	writew_relaxed(1 << 2, wdog_base);
+
+	/* wait for reset to assert ... */
+	mdelay(500);
+
+	pr_err("Watchdog reset failed to assert reset\n");
+
+	/* delay to allow the serial port to show the message */
+	mdelay(50);
+
+soft:
+	/* we'll take a jump through zero as a poor second */
+	soft_restart(0);
+}
+
+static void __init mvf_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static void __init mvf_of_init_irq(void)
+{
+	struct device_node *np;
+	void __iomem *mscm_base;
+	int i;
+
+	l2x0_of_init(0, ~0UL);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-mscm");
+	mscm_base = of_iomap(np, 0);
+	if (!mscm_base)
+		return;
+
+	/* route each shared peripheral interrupt to CP0 */
+	for (i = 0; i < 111; i++)
+		__raw_writew(1, mscm_base + 0x880 + 2 * i);
+
+	iounmap(mscm_base);
+
+	irqchip_init();
+}
+
+static void __init mvf_timer_init(void)
+{
+	mvf_clocks_init();
+	clocksource_of_init();
+}
+
+/*
+ * initialize __mach_desc_ data structure.
+ */
+static const char *mvf_dt_compat[] __initdata = {
+	"fsl,mvf600",
+	NULL,
+};
+
+DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid Family (Device Tree)")
+	.init_irq	= mvf_of_init_irq,
+	.init_machine	= mvf_init_machine,
+	.init_time	= mvf_timer_init,
+	.dt_compat	= mvf_dt_compat,
+	.restart	= mvf_restart,
+MACHINE_END
diff --git a/arch/arm/mach-imx/pit.c b/arch/arm/mach-imx/pit.c
new file mode 100644
index 0000000..e2df0e5
--- /dev/null
+++ b/arch/arm/mach-imx/pit.c
@@ -0,0 +1,244 @@
+/*
+ *  Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/mach/time.h>
+#include <asm/sched_clock.h>
+
+
+#define PITMCR		0x00
+#define PITLTMR64H	0xE0
+#define PITLTMR64L	0xE4
+
+#define PITLDVAL	0x00
+#define PITCVAL		0x04
+#define PITTCTRL	0x08
+#define PITTFLG		0x0C
+
+/*
+ * Vybrid has 8 pit timers: pit0 - pit7,
+ * Each memory mapped register occupy 0x10 Bytes
+ */
+#define PITOFFSET0	0x100
+#define PITOFFSETx(n)	(PITOFFSET0 + 0x10 * n)
+
+/* bit definitation */
+#define PITMCR_MDIS		(1 << 1)
+#define PITMCR_FRZ		(1 << 0)
+
+#define PITTCTRL_TEN		(1 << 0)
+#define PITTCTRL_TIE		(1 << 1)
+#define	PITCTRL_CHN		(1 << 2)
+
+#define PITTFLG_TIF		0x1
+
+static struct clock_event_device clockevent_pit;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
+
+static void __iomem *clksrc_base;
+static void __iomem *clkevt_base;
+static void __iomem *sched_clock_reg;
+static unsigned long pit_cycle_per_jiffy;
+
+static inline void pit_timer_enable(void)
+{
+	__raw_writel(PITTCTRL_TEN | PITTCTRL_TIE, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_timer_disable(void)
+{
+	__raw_writel(0, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_disable(void)
+{
+	unsigned long val;
+
+	val = __raw_readl(clkevt_base + PITTCTRL);
+	val &= ~PITTCTRL_TIE;
+	__raw_writel(val, clkevt_base + PITTCTRL);
+}
+
+static inline void pit_irq_enable(void)
+{
+	unsigned long val;
+
+	val = __raw_readl(clkevt_base + PITTCTRL);
+	val |= PITTCTRL_TIE;
+	__raw_writel(val, clkevt_base + PITTCTRL);
+}
+
+static void pit_irq_acknowledge(void)
+{
+	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
+}
+
+static unsigned int mvf_read_sched_clock(void)
+{
+	return __raw_readl(sched_clock_reg);
+}
+
+
+static int __init pit_clocksource_init(struct clk *pit_clk)
+{
+	unsigned int c = clk_get_rate(pit_clk);
+
+	sched_clock_reg = clksrc_base + PITCVAL;
+
+	setup_sched_clock(mvf_read_sched_clock, 32, c);
+	return clocksource_mmio_init(clksrc_base + PITCVAL, "pit", c, 300, 32,
+			clocksource_mmio_readl_down);
+}
+
+/* set clock event */
+static int pit_set_next_event(unsigned long delta,
+				struct clock_event_device *unused)
+{
+	pit_timer_disable();
+	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
+	pit_irq_acknowledge();
+	pit_timer_enable();
+
+	return 0;
+}
+
+static void pit_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	pit_timer_disable();
+	pit_irq_acknowledge();
+
+	/* Remember timer mode */
+	clockevent_mode = mode;
+	local_irq_restore(flags);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+
+		__raw_writel(pit_cycle_per_jiffy - 1, clkevt_base + PITLDVAL);
+		pit_timer_enable();
+
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+
+		break;
+	default:
+		WARN(1, "%s: unhandled event mode %d\n", __func__, mode);
+		break;
+	}
+}
+
+/*
+ * interrupt handler for the timer
+ */
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_pit;
+
+	pit_irq_acknowledge();
+
+	if (clockevent_mode == CLOCK_EVT_MODE_ONESHOT)
+		pit_timer_disable();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pit_timer_irq = {
+	.name		= "MVF PIT Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pit_timer_interrupt,
+};
+
+static struct clock_event_device clockevent_pit = {
+	.name		= "pit",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= pit_set_mode,
+	.set_next_event	= pit_set_next_event,
+	.rating		= 300,
+};
+
+static int __init pit_clockevent_init(struct clk *pit_clk)
+{
+	unsigned int c = clk_get_rate(pit_clk);
+
+	clockevent_pit.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&clockevent_pit, c, 0x100, 0xffffff00);
+
+	return 0;
+}
+
+static void __init pit_timer_init(struct device_node *np)
+{
+	struct clk *pit_clk;
+	void __iomem *timer_base;
+	int irq;
+
+	if (!np) {
+		pr_err("Failed to find pit DT node\n");
+		BUG();
+	}
+
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
+
+	/* chose PIT2 as clocksource, PIT3 as clockevent dev */
+	clksrc_base = timer_base + PITOFFSETx(2);
+	clkevt_base = timer_base + PITOFFSETx(3);
+
+	irq = irq_of_parse_and_map(np, 0);
+
+	pit_clk = of_clk_get_by_name(np, "pit");
+	if (IS_ERR(pit_clk)) {
+		pr_err("Vybrid PIT timer: unable to get clk\n");
+		return;
+	}
+
+	clk_prepare_enable(pit_clk);
+
+	pit_cycle_per_jiffy = clk_get_rate(pit_clk)/(HZ);
+
+	/*
+	 * Initialise to a known state (all timers off, and timing reset)
+	 */
+	__raw_writel(0x0, timer_base + PITMCR);
+
+	__raw_writel(0, clkevt_base + PITTCTRL);
+	__raw_writel(0xffffffff, clkevt_base + PITLDVAL);
+
+	__raw_writel(0, clksrc_base + PITTCTRL);
+	__raw_writel(0xffffffff, clksrc_base + PITLDVAL);
+	__raw_writel(PITTCTRL_TEN, clksrc_base + PITTCTRL);
+
+	pit_clocksource_init(pit_clk);
+
+	setup_irq(irq, &pit_timer_irq);
+
+	pit_clockevent_init(pit_clk);
+}
+
+CLOCKSOURCE_OF_DECLARE(mvf600, "fsl,mvf-pit", pit_timer_init);
-- 
1.8.0
