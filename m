From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Dec 2013 15:10:25 +0100
Subject: [PATCH 1/2] ARM i.MX35: Add devicetree support.
In-Reply-To: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
References: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1387375826-4018-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/clock/imx35-clock.txt      | 113 +++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |   8 ++
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/clk-imx35.c                      |  14 +++
 arch/arm/mach-imx/imx35-dt.c                       |  57 +++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 arch/arm/mach-imx/imx35-dt.c

diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.txt b/Documentation/devicetree/bindings/clock/imx35-clock.txt
new file mode 100644
index 0000000..a703564
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.txt
@@ -0,0 +1,113 @@
+* Clock bindings for Freescale i.MX35
+
+Required properties:
+- compatible: Should be "fsl,imx35-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX35
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	ckih			0
+	mpll			1
+	ppll			2
+	mpll_075		3
+	arm			4
+	hsp			5
+	hsp_div			6
+	hsp_sel			7
+	ahb			8
+	ipg			9
+	arm_per_div		10
+	ahb_per_div		11
+	ipg_per			12
+	uart_sel		13
+	uart_div		14
+	esdhc_sel		15
+	esdhc1_div		16
+	esdhc2_div		17
+	esdhc3_div		18
+	spdif_sel		19
+	spdif_div_pre		20
+	spdif_div_post		21
+	ssi_sel			22
+	ssi1_div_pre		23
+	ssi1_div_post		24
+	ssi2_div_pre		25
+	ssi2_div_post		26
+	usb_sel			27
+	usb_div			28
+	nfc_div			29
+	asrc_gate		30
+	pata_gate		31
+	audmux_gate		32
+	can1_gate		33
+	can2_gate		34
+	cspi1_gate		35
+	cspi2_gate		36
+	ect_gate		37
+	edio_gate		38
+	emi_gate		39
+	epit1_gate		40
+	epit2_gate		41
+	esai_gate		42
+	esdhc1_gate		43
+	esdhc2_gate		44
+	esdhc3_gate		45
+	fec_gate		46
+	gpio1_gate		47
+	gpio2_gate		48
+	gpio3_gate		49
+	gpt_gate		50
+	i2c1_gate		51
+	i2c2_gate		52
+	i2c3_gate		53
+	iomuxc_gate		54
+	ipu_gate		55
+	kpp_gate		56
+	mlb_gate		57
+	mshc_gate		58
+	owire_gate		59
+	pwm_gate		60
+	rngc_gate		61
+	rtc_gate		62
+	rtic_gate		63
+	scc_gate		64
+	sdma_gate		65
+	spba_gate		66
+	spdif_gate		67
+	ssi1_gate		68
+	ssi2_gate		69
+	uart1_gate		70
+	uart2_gate		71
+	uart3_gate		72
+	usbotg_gate		73
+	wdog_gate		74
+	max_gate		75
+	admux_gate		76
+	csi_gate		77
+	csi_div			78
+	csi_sel			79
+	iim_gate		80
+	gpu2d_gate		81
+
+Examples:
+
+clks: ccm at 53f80000 {
+	compatible = "fsl,imx35-ccm";
+	reg = <0x53f80000 0x4000>;
+	interrupts = <31>;
+	#clock-cells = <1>;
+};
+
+esdhc1: esdhc at 53fb4000 {
+	compatible = "fsl,imx35-esdhc";
+	reg = <0x53fb4000 0x4000>;
+	interrupts = <7>;
+	clocks = <&clks 9>, <&clks 8>, <&clks 43>;
+	clock-names = "ipg", "ahb", "per";
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6..44233c9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -138,6 +138,7 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
+	select PINCTRL
 
 config SOC_IMX5
 	bool
@@ -625,6 +626,13 @@ config MACH_IMX31_DT
 
 comment "MX35 platforms:"
 
+config MACH_IMX35_DT
+	bool "Support i.MX35 platforms from device tree"
+	select SOC_IMX35
+	help
+	  Include support for Freescale i.MX35 based platforms
+	  using the device tree for discovery.
+
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select IMX_HAVE_PLATFORM_FLEXCAN
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5383c58..f20a117 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
+obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
 
 obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 2193c83..a4d5e42 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -45,6 +45,8 @@ static struct arm_ahb_div clk_consumer[] = {
 static char hsp_div_532[] = { 4, 8, 3, 0 };
 static char hsp_div_400[] = { 3, 6, 3, 0 };
 
+static struct clk_onecell_data clk_data;
+
 static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
@@ -286,3 +288,15 @@ int __init mx35_clocks_init(void)
 
 	return 0;
 }
+
+static int __init mx35_clocks_init_dt(struct device_node *ccm_node)
+{
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(ccm_node, of_clk_src_onecell_get, &clk_data);
+
+	mx35_clocks_init();
+
+	return 0;
+}
+CLK_OF_DECLARE(imx35, "fsl,imx35-ccm", mx35_clocks_init_dt);
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
new file mode 100644
index 0000000..8073d3f
--- /dev/null
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2012 Steffen Trumtrar, Pengutronix
+ *
+ * based on imx27-dt.c
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "common.h"
+#include "mx35.h"
+
+static void __init imx35_dt_init(void)
+{
+	mxc_arch_reset_init_dt();
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     NULL, NULL);
+}
+
+static void __init imx35_irq_init(void)
+{
+	imx_init_l2cache();
+	mx35_init_irq();
+}
+
+static void __init imx35_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
+static const char *imx35_dt_board_compat[] __initdata = {
+	"fsl,imx35",
+	NULL
+};
+
+DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
+	.map_io		= mx35_map_io,
+	.init_early	= imx35_init_early,
+	.init_irq	= imx35_irq_init,
+	.init_time	= imx35_timer_init,
+	.handle_irq	= imx35_handle_irq,
+	.init_machine	= imx35_dt_init,
+	.dt_compat	= imx35_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.8.5.1
