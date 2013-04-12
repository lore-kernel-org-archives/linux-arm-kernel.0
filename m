From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 12 Apr 2013 14:57:03 +0800
Subject: [PATCH 1/3] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1365749825-20601-1-git-send-email-b35083@freescale.com>
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
Message-ID: <1365749825-20601-2-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Freescale Vybrid Family platform core definitions,
core drivers including clock, period interrupt timer(PIT),
and DTS based machine support with MVF600 Tower development board.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/mach-imx/Kconfig       |  39 +++++
 arch/arm/mach-imx/Makefile      |   4 +
 arch/arm/mach-imx/Makefile.boot |   4 +
 arch/arm/mach-imx/clk-mvf.c     | 320 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/common.h      |   3 +
 arch/arm/mach-imx/mach-mvf600.c | 121 +++++++++++++++
 arch/arm/mach-imx/pit.c         | 254 +++++++++++++++++++++++++++++++
 7 files changed, 745 insertions(+)
 create mode 100644 arch/arm/mach-imx/clk-mvf.c
 create mode 100644 arch/arm/mach-imx/mach-mvf600.c
 create mode 100644 arch/arm/mach-imx/pit.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..173258b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -55,6 +55,16 @@ config MXC_USE_EPIT
 	  uses the same clocks as the GPT. Anyway, on some systems the GPT
 	  may be in use for other purposes.
 
+config HAVE_PIT
+	bool
+
+config MXC_USE_PIT
+	bool "Use PIT"
+	depends on HAVE_PIT
+	help
+          Use PIT as the system timer on systems that have it
+	  such as Vybrid platform.
+
 config MXC_ULPI
 	bool
 
@@ -101,6 +111,9 @@ config ARCH_MX51
 config ARCH_MX53
 	bool
 
+config ARCH_MVF
+	bool
+
 config SOC_IMX1
 	bool
 	select ARCH_MX1
@@ -169,6 +182,24 @@ config	SOC_IMX51
 	select PINCTRL_IMX51
 	select SOC_IMX5
 
+config SOC_MVF
+	bool
+
+config SOC_MVF600
+	bool
+	select CPU_V7
+	select ARM_GIC
+	select COMMON_CLK
+	select ARCH_MVF
+	select SOC_MVF
+	select HAVE_PIT
+	select MXC_USE_PIT
+	select PINCTRL
+	select PINCTRL_MVF
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
+
 if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
@@ -828,6 +859,14 @@ config SOC_IMX6Q
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
 
+config MACH_MVF600_TWR
+	bool "Vybrid MVF600 Tower support"
+	select SOC_MVF600
+
+	help
+          Include support for Freescale Vybrid Family Tower Board
+	  based on MVF600 SOC.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..e8502f1 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_MXC_AVIC) += avic.o
 obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
+obj-$(CONFIG_MXC_USE_PIT) += pit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 
@@ -112,4 +113,7 @@ obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
+# Vybrid based machines
+obj-$(CONFIG_SOC_MVF600) += clk-mvf.o mach-mvf600.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 41ba1bb..5551acf 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -33,3 +33,7 @@ initrd_phys-$(CONFIG_SOC_IMX53)	:= 0x70800000
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
+
+zreladdr-$(CONFIG_SOC_MVF)	:= 0x80008000
+params_phys-$(CONFIG_SOC_MVF)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_MVF)	:= 0x80800000
diff --git a/arch/arm/mach-imx/clk-mvf.c b/arch/arm/mach-imx/clk-mvf.c
new file mode 100644
index 0000000..fa2eca3
--- /dev/null
+++ b/arch/arm/mach-imx/clk-mvf.c
@@ -0,0 +1,320 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
+#define CCM_CCGRx_CGn_OFFSET(n)		(n * 2)
+
+#define PFD_528SYS_BASE		(anatop_base + 0x2B0)
+#define PFD_528_BASE		(anatop_base + 0x100)
+#define PFD_USB_BASE            (anatop_base + 0xF0) /* pll3 pfd definition */
+
+
+static void __iomem *anatop_base;
+static void __iomem *ccm_base;
+
+/* This is used multiple times */
+static const char const *fast_clk_sel[] = { "firc", "fxosc", };
+static const char const *slow_clk_sel[] = { "sirc", "sxosc", };
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
+	"enet_ext", "audio_ext_clk", "enet_50m", "enet_25m",
+};
+static const char const *enet_ts_clk_sel[] = {
+	"enet_ext", "fxosc", "audio_ext_clk", "usb_clk", "enet_ts_clk",
+	"enet_25m", "enet_50m",
+};
+static const char const *esai_clk_sel[] = {
+	"audio_ext_clk", "mlb_clk", "spdif_rx_clk", "pll4_main_div",
+};
+static const char const *sai_clk_sel[] = {
+	"audio_ext_clk", "mlb_clk", "spdif_rx_clk", "pll4_main_div",
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
+static const char const *dcu_clk_sel[] = {
+	"pll1_pfd2", "pll3_main",
+};
+static const char const *gpu_clk_sel[] = { "pll2_pfd2", "pll3_pfd2", };
+static const char const *vadc_lk_sel[] = {
+	"pll6_main_div", "pll3_main_div", "pll3_main",
+};
+
+enum mvf_clks {
+	dummy, sirc, firc, sxosc, fxosc, slow_clk, fast_clk, audio_ext_clk,
+	enet_ext_clk, pll1_main_528m, pll1_pfd1_500m, pll1_pfd2_452m,
+	pll1_pfd3_396m, pll1_pfd4_528m, pll2_main_528m, pll2_pfd1_500m,
+	pll2_pfd2_396m, pll2_pfd3_339m, pll2_pfd4_413m, pll3_main_480m,
+	pll3_pfd1_308m, pll3_pfd2_332m, pll3_pfd3_298m, pll3_pfd4_320m,
+	pll4_main, pll5_main, pll6_main,
+	pll1_pfd_sw, pll2_pfd_sw, sys_clk_sw, ddr_clk_sw,
+	sys_bus_clk, platform_bus_clk, ipg_bus_clk,
+	uart0_clk_gate, uart1_clk_gate, uart2_clk_gate, uart3_clk_gate,
+	uart4_clk_gate, uart5_clk_gate, pit_clk_gate,
+	i2c0_clk_gate, i2c1_clk_gate, i2c2_clk_gate, i2c3_clk_gate,
+	ftm0_clk_gate, ftm1_clk_gate, ftm2_clk_gate, ftm3_clk_gate,
+	enet_50m, enet_25m, enet_clk_sw, enet_clk_gate, enet_ts_sw,
+	enet_ts_gate,
+	audio_ext_clk_gate, dspi_clk_gate, wdt_clk_gate,
+	esdhc0_clk_gate, esdhc1_clk_gate,
+	dcu0_clk_gate, dcu1_clk_gate,
+	sai0_clk_gate, sai1_clk_gate, sai2_clk_gate, sai3_clk_gate,
+	usbc0_clk_gate, usbc1_clk_gate,
+	qspi0_clk_sw, qspi0_clk_gate, qspi0_x4_div, qspi0_x2_div, qspi0_x1_div,
+	asrc_clk_gate,
+	caam_clk_gate,
+	gpu2d_clk_gate,
+	openvg_clk_gate,
+	clk_max
+};
+
+static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
+
+int __init mvf_clocks_init(void)
+{
+	struct device_node *np;
+	__iomem void *base;
+	int irq;
+
+	clk[dummy] = imx_clk_fixed("dummy", 0);
+	clk[sirc] = imx_clk_fixed("sirc", 32000); /* slow internal IRC */
+	clk[firc] = imx_clk_fixed("firc", 24000000);/* fast internal IRC */
+
+	for_each_compatible_node(np, NULL, "fixed-clock") {
+		u32 rate;
+
+		if (of_property_read_u32(np, "clock-frequency", &rate))
+			continue;
+		if (of_device_is_compatible(np, "fsl,mvf-ckil"))
+			clk[sxosc] = imx_clk_fixed("sxosc", rate);
+		else if (of_device_is_compatible(np, "fsl,mvf-osc"))
+			clk[fxosc] = imx_clk_fixed("fxosc", rate);
+		else if (of_device_is_compatible(np, "fsl,mvf-audio-ext-clk"))
+			clk[audio_ext_clk] =
+					imx_clk_fixed("audio_ext_clk", rate);
+		else if (of_device_is_compatible(np, "fsl,mvf-enet-ext-clk"))
+			clk[enet_ext_clk] = imx_clk_fixed("enet_ext", rate);
+	}
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
+			slow_clk_sel, ARRAY_SIZE(slow_clk_sel));
+	clk[fast_clk] = imx_clk_mux("fast_clk", CCM_CCSR, 5, 1,
+			fast_clk_sel, ARRAY_SIZE(fast_clk_sel));
+
+	clk[pll1_main_528m] = imx_clk_fixed_factor("pll1_main",
+						"fast_clk", 22, 1);
+	clk[pll1_pfd1_500m] = imx_clk_pfd("pll1_pfd1", "pll1_main",
+						PFD_528SYS_BASE, 0);
+	clk[pll1_pfd2_452m] = imx_clk_pfd("pll1_pfd2", "pll1_main",
+						PFD_528SYS_BASE, 1);
+	clk[pll1_pfd3_396m] = imx_clk_pfd("pll1_pfd3", "pll1_main",
+						PFD_528SYS_BASE, 2);
+	clk[pll1_pfd4_528m] = imx_clk_pfd("pll1_pfd4", "pll1_main",
+						PFD_528SYS_BASE, 3);
+
+	clk[pll2_main_528m] = imx_clk_fixed_factor("pll2_main",
+						"fast_clk", 22, 1);
+	clk[pll2_pfd1_500m] = imx_clk_pfd("pll2_pfd1", "pll2_main",
+						PFD_528_BASE, 0);
+	clk[pll2_pfd2_396m] = imx_clk_pfd("pll2_pfd2", "pll2_main",
+						PFD_528_BASE, 1);
+	clk[pll2_pfd3_339m] = imx_clk_pfd("pll2_pfd3", "pll2_main",
+						PFD_528_BASE, 2);
+	clk[pll2_pfd4_413m] = imx_clk_pfd("pll2_pfd4", "pll2_main",
+						PFD_528_BASE, 3);
+
+	/* USB pll, 480Mhz */
+	clk[pll3_main_480m] = imx_clk_fixed_factor("usb_main",
+						"fast_clk", 20, 1);
+	/* Audio pll */
+	clk[pll4_main] = imx_clk_fixed_factor("audio_main", "fast_clk", 25, 1);
+	/* Enet pll, fixed to 50Mhz on Vybrid */
+	clk[pll5_main] = imx_clk_fixed_factor("pll5_main", "fast_clk", 125, 6);
+	clk[enet_50m] = imx_clk_fixed_factor("enet_50m", "pll5_main", 1, 10);
+	clk[enet_25m] = imx_clk_fixed_factor("enet_25m", "pll5_main", 1, 20);
+	/* Video pll: default 960Mhz */
+	clk[pll6_main] = imx_clk_fixed_factor("video_main", "fast_clk", 40, 1);
+
+	clk[pll1_pfd_sw] = imx_clk_mux("pll1_sw", CCM_CCSR, 16, 3,
+			pll1_pfd_sel, ARRAY_SIZE(pll1_pfd_sel));
+
+	clk[pll2_pfd_sw] = imx_clk_mux("pll2_sw", CCM_CCSR, 19, 3,
+			pll2_pfd_sel, ARRAY_SIZE(pll2_pfd_sel));
+
+	clk[sys_clk_sw] = imx_clk_mux("sys_sw", CCM_CCSR, 0, 3,
+			sys_clk_sel, ARRAY_SIZE(sys_clk_sel));
+
+	clk[ddr_clk_sw] = imx_clk_mux("ddr_sw", CCM_CCSR, 6, 1,
+			ddr_clk_sel, ARRAY_SIZE(ddr_clk_sel));
+
+	clk[sys_bus_clk] = imx_clk_divider("sys_bus", "sys_sw",
+						CCM_CACRR, 0, 3);
+	clk[platform_bus_clk] = imx_clk_divider("platform_bus", "sys_bus",
+						CCM_CACRR, 3, 3);
+	clk[ipg_bus_clk] = imx_clk_divider("ipg_bus", "platform_bus",
+						CCM_CACRR, 11, 2);
+
+	clk[qspi0_clk_sw] = imx_clk_mux("qspi0_sw", CCM_CSCMR1, 22, 2,
+					qspi_clk_sel, ARRAY_SIZE(qspi_clk_sel));
+	clk[qspi0_x4_div] = imx_clk_divider("qspi0_x4", "qspi0_sw",
+						CCM_CSCDR3, 0, 2);
+	clk[qspi0_x2_div] = imx_clk_divider("qspi0_x2", "qspi0_x4",
+						CCM_CSCDR3, 2, 1);
+	clk[qspi0_x1_div] = imx_clk_divider("qspi0_x1", "qspi0_x2",
+					CCM_CSCDR3, 3, 1);
+	clk[qspi0_clk_gate] = imx_clk_gate("qspi0_clk", "qspi0_x1",
+					CCM_CSCDR3, 4);
+
+	clk[enet_clk_sw] = imx_clk_mux("enet_sw", CCM_CSCMR2, 4, 2,
+				rmii_clk_sel, ARRAY_SIZE(rmii_clk_sel));
+	clk[enet_clk_gate] = imx_clk_gate("enet_clk", "enet_sw",
+				CCM_CSCDR1, 24);
+	clk[enet_ts_sw] = imx_clk_mux("enet_ts_sw", CCM_CSCMR2, 0, 3,
+				enet_ts_clk_sel, ARRAY_SIZE(enet_ts_clk_sel));
+	clk[enet_ts_gate] = imx_clk_gate("enet_ts_clk", "enet_ts_sw",
+				CCM_CSCDR1, 23);
+
+	clk[pit_clk_gate] = imx_clk_gate2("pit_clk", "ipg_bus", CCM_CCGR1,
+						CCM_CCGRx_CGn_OFFSET(7));
+	clk[uart0_clk_gate] = imx_clk_gate2("uart0_clk", "ipg_bus", CCM_CCGR0,
+						CCM_CCGRx_CGn_OFFSET(7));
+
+	/* Add the clocks to provider list */
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	clk_register_clkdev(clk[pit_clk_gate], "mvf-pit", NULL);
+	clk_register_clkdev(clk[uart0_clk_gate], "mvf-uart", NULL);
+	clk_register_clkdev(clk[uart0_clk_gate], "mvf_uart.0", NULL);
+	clk_register_clkdev(clk[uart0_clk_gate], "mvf_uart.1", NULL);
+	clk_register_clkdev(clk[enet_clk_gate], "fec.0", NULL);
+	clk_register_clkdev(clk[enet_clk_gate], "fec.1", NULL);
+	clk_register_clkdev(clk[enet_clk_gate], "switch.0", NULL);
+	clk_register_clkdev(clk[qspi0_clk_gate], "qspi.0", NULL);
+
+	clk_set_parent(clk[qspi0_x4_div], clk[pll1_pfd4_528m]);
+	clk_set_rate(clk[qspi0_x4_div],
+			clk_get_rate(clk[qspi0_x4_div]->parent) / 2);
+	clk_set_rate(clk[qspi0_x2_div],
+			clk_get_rate(clk[qspi0_x2_div]->parent) / 2);
+	clk_set_rate(clk[qspi0_x1_div],
+			clk_get_rate(clk[qspi0_x1_div]->parent) / 2);
+
+
+	clk_prepare(clk[pit_clk_gate]);
+	clk_prepare(clk[uart0_clk_gate]);
+	clk_prepare(clk[enet_clk_gate]);
+
+	/* init system timer */
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-pit");
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+	irq = irq_of_parse_and_map(np, 0);
+	pit_timer_init(base, irq);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5bf4a97..dba5b10 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -41,6 +41,7 @@ extern void mx31_init_irq(void);
 extern void mx35_init_irq(void);
 extern void mx51_init_irq(void);
 extern void mx53_init_irq(void);
+extern void mvf_init_irq(void);
 extern void imx1_soc_init(void);
 extern void imx21_soc_init(void);
 extern void imx25_soc_init(void);
@@ -51,6 +52,7 @@ extern void imx51_soc_init(void);
 extern void imx51_init_late(void);
 extern void imx53_init_late(void);
 extern void epit_timer_init(void __iomem *base, int irq);
+extern void pit_timer_init(void __iomem *base, int irq);
 extern void mxc_timer_init(void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
 extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
@@ -68,6 +70,7 @@ extern int mx31_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
+extern int mvf_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-mvf600.c b/arch/arm/mach-imx/mach-mvf600.c
new file mode 100644
index 0000000..fa3b34c
--- /dev/null
+++ b/arch/arm/mach-imx/mach-mvf600.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
+#include "hardware.h"
+#include "mxc.h"
+
+
+void mvf_restart(char mode, const char *cmd)
+{
+	struct device_node *np;
+	void __iomem *wdog_base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-wdt");
+	wdog_base = of_iomap(np, 0);
+	if (!wdog_base)
+		goto soft;
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
+	for (i = 0; i < 128; i++)
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
+}
+
+/*
+ * initialize __mach_desc_ data structure.
+ */
+static const char *mvf_dt_compat[] __initdata = {
+	"fsl,imx-mvf600",
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
index 0000000..03f0037
--- /dev/null
+++ b/arch/arm/mach-imx/pit.c
@@ -0,0 +1,254 @@
+/*
+ *  Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <asm/mach/time.h>
+#include <asm/sched_clock.h>
+
+#include "hardware.h"
+#include "common.h"
+
+#define PITMCR		0x00
+#define PITLTMR64H	0xE0
+#define PITLTMR64L	0xE4
+
+#define PITOFFSET	0x120
+#define PITLDVAL	0x00
+#define PITCVAL		0x04
+#define PITTCTRL	0x08
+#define PITTFLG		0x0C
+
+/*
+ * Total 8 pit timers, each memory map occupy 0x10 Bytes
+ * get base offset for pit(n)
+ */
+#define PITOFFSETx(n)	(PITOFFSET + 0x10 * n)
+
+/* bit definitation */
+#define PITMCR_MDIS		(1 << 1)
+#define PITMCR_FRZ		(1 << 0)
+
+#define PITTCTRL_TEN		(1 << 0)
+#define PITTCTRL_TIE		(1 << 1)
+#define	PITCTRL_CHN		(1 << 2)
+
+#define PITTFLG_TIF		(1 << 0)
+
+static cycle_t pit_cnt;
+static struct clock_event_device clockevent_pit;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
+
+static void __iomem *timer_base;
+static unsigned long pit_cycle_per_jiffy;
+
+static inline void pit_irq_disable(void)
+{
+	unsigned long val;
+
+	val = __raw_readl(timer_base + PITOFFSET + PITTCTRL);
+	val &= ~PITTCTRL_TIE;
+	__raw_writel(val, timer_base + PITOFFSET + PITTCTRL);
+}
+
+static inline void pit_irq_enable(void)
+{
+	unsigned long val;
+
+	val = __raw_readl(timer_base + PITOFFSET + PITTCTRL);
+	val |= PITTCTRL_TIE;
+	__raw_writel(val, timer_base + PITOFFSET + PITTCTRL);
+}
+
+static void pit_irq_acknowledge(void)
+{
+	__raw_writel(PITTFLG_TIF, timer_base + PITOFFSET + PITTFLG);
+}
+
+static cycle_t pit_read_clk(struct clocksource *cs);
+
+static void __iomem *sched_clock_reg;
+
+static unsigned int mvf_read_sched_clock(void)
+{
+	return __raw_readl(sched_clock_reg);
+}
+
+static int __init pit_clocksource_init(struct clk *pit_clk)
+{
+	unsigned int c = clk_get_rate(pit_clk);
+	void __iomem *reg = timer_base + PITOFFSET + PITCVAL;
+
+	sched_clock_reg = reg;
+
+	setup_sched_clock(mvf_read_sched_clock, 32, c);
+	return clocksource_mmio_init(timer_base + PITOFFSET + PITCVAL,
+					"pit", c, 200, 32, pit_read_clk);
+}
+
+/* clock event */
+
+static int pit_set_next_event(unsigned long evt,
+			      struct clock_event_device *unused)
+{
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
+	/* Disable interrupt in PIT module */
+	pit_irq_disable();
+
+	if (mode != clockevent_mode) {
+		/* Clear pending interrupt */
+		pit_irq_acknowledge();
+	}
+
+	/* Remember timer mode */
+	clockevent_mode = mode;
+	local_irq_restore(flags);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+
+		__raw_writel(0, timer_base + PITOFFSET + PITTCTRL);
+		__raw_writel(pit_cycle_per_jiffy,
+				timer_base + PITOFFSET + PITLDVAL);
+		__raw_writel(PITTCTRL_TEN, timer_base + PITOFFSET + PITTCTRL);
+
+		pit_irq_enable();
+
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+
+		local_irq_save(flags);
+		pit_irq_enable();
+		local_irq_restore(flags);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		/* Left event sources disabled, no more interrupts appear */
+		break;
+	}
+}
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_pit;
+
+	pit_irq_acknowledge();
+
+	pit_cnt += pit_cycle_per_jiffy;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static cycle_t pit_read_clk(struct clocksource *cs)
+{
+	unsigned long flags;
+	cycle_t cycles;
+	unsigned long pcntr;
+
+	local_irq_save(flags);
+	pcntr = __raw_readl(timer_base + PITOFFSET + PITCVAL);
+	cycles = pit_cnt;
+	local_irq_restore(flags);
+
+	return cycles + pit_cycle_per_jiffy - pcntr;
+}
+
+
+static struct irqaction pit_timer_irq = {
+	.name		= "MVF PIT Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pit_timer_interrupt,
+};
+
+static struct clock_event_device clockevent_pit = {
+	.name		= "pit",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.set_mode	= pit_set_mode,
+	.set_next_event	= pit_set_next_event,
+	.rating		= 100,
+};
+
+static int __init pit_clockevent_init(struct clk *pit_clk)
+{
+	unsigned int c = clk_get_rate(pit_clk);
+
+	clockevent_pit.mult = div_sc(c, NSEC_PER_SEC,
+					clockevent_pit.shift);
+	clockevent_pit.max_delta_ns =
+			clockevent_delta2ns(0xfffffffe, &clockevent_pit);
+	clockevent_pit.min_delta_ns =
+			clockevent_delta2ns(0x800, &clockevent_pit);
+	clockevent_pit.cpumask = cpumask_of(0);
+	clockevents_register_device(&clockevent_pit);
+
+	return 0;
+}
+
+void __init pit_timer_init(void __iomem *base, int irq)
+{
+	struct clk *pit_clk;
+
+	pit_clk = clk_get_sys(NULL, "mvf-pit");
+	if (IS_ERR(pit_clk)) {
+		pr_err("Vybrid PIT timer: unable to get clk\n");
+		return;
+	}
+
+	clk_prepare_enable(pit_clk);
+
+	timer_base = base;
+
+	pit_cycle_per_jiffy = clk_get_rate(pit_clk)/(HZ);
+
+	/*
+	 * Initialise to a known state (all timers off, and timing reset)
+	 */
+	__raw_writel(0x0, timer_base + PITMCR);
+
+	__raw_writel(0, timer_base + PITOFFSET + PITTCTRL);
+	__raw_writel(0xffffffff, timer_base + PITOFFSET + PITLDVAL);
+	__raw_writel(PITTCTRL_TEN, timer_base + PITOFFSET + PITTCTRL);
+
+	/* init and register the timer to the framework */
+	pit_clocksource_init(pit_clk);
+
+	pit_clockevent_init(pit_clk);
+
+	/* Make irqs happen */
+	setup_irq(irq, &pit_timer_irq);
+}
-- 
1.8.0
