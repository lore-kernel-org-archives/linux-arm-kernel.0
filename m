From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:44 -0400
Subject: [PATCH 09/10] clk: ns2: add clock support for Broadcom Northstar 2 SoC
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-10-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Northstar 2 SoC is architected under the iProc
architecture. It has the following PLLs: GENPLL SCR, GENPLL SW,
LCPLL DDR, LCPLL Ports, all derived from an onboard crystal.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm64/Kconfig.platforms        |   1 +
 drivers/clk/Makefile                |   3 +-
 drivers/clk/bcm/Makefile            |   1 +
 drivers/clk/bcm/clk-ns2.c           | 290 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm-ns2.h |  72 +++++++++
 5 files changed, 366 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/bcm/clk-ns2.c
 create mode 100644 include/dt-bindings/clock/bcm-ns2.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..2790f21 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,6 +2,7 @@ menu "Platform selection"
 
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
+	select COMMON_CLK_IPROC
 	help
 	  This enables support for Broadcom iProc based SoCs
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d08b3e5..ea81eaa 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -47,7 +47,8 @@ obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
-obj-$(CONFIG_ARCH_BCM)			+= bcm/
+obj-$(CONFIG_CLK_BCM_KONA)		+= bcm/
+obj-$(CONFIG_COMMON_CLK_IPROC)		+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index e258b28..2d1cbc5 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
+obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-ns2.o
 obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
 obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
 obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
diff --git a/drivers/clk/bcm/clk-ns2.c b/drivers/clk/bcm/clk-ns2.c
new file mode 100644
index 0000000..1d08281
--- /dev/null
+++ b/drivers/clk/bcm/clk-ns2.c
@@ -0,0 +1,290 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/clkdev.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+
+#include <dt-bindings/clock/bcm-ns2.h>
+#include "clk-iproc.h"
+
+#define reg_val(o, s, w) { .offset = o, .shift = s, .width = w, }
+
+#define aon_val(o, pw, ps, is) { .offset = o, .pwr_width = pw, \
+	.pwr_shift = ps, .iso_shift = is }
+
+#define reset_val(o, rs, prs) { .offset = o, .reset_shift = rs, \
+	.p_reset_shift = prs }
+
+#define df_val(o, kis, kiw, kps, kpw, kas, kaw) { .offset = o, .ki_shift = kis,\
+	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas,    \
+	.ka_width = kaw }
+
+#define vco_ctrl_val(uo, lo) { .u_offset = uo, .l_offset = lo }
+
+#define enable_val(o, es, hs, bs) { .offset = o, .enable_shift = es, \
+	.hold_shift = hs, .bypass_shift = bs }
+
+static const struct iproc_pll_ctrl genpll_scr = {
+	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
+	.aon = aon_val(0x0, 1, 15, 12),
+	.reset = reset_val(0x4, 2, 1),
+	.dig_filter = df_val(0x0, 9, 3, 5, 4, 2, 3),
+	.ndiv_int = reg_val(0x8, 4, 10),
+	.pdiv = reg_val(0x8, 0, 4),
+	.vco_ctrl = vco_ctrl_val(0x10, 0xc),
+	.status = reg_val(0x0, 27, 1),
+};
+
+
+static const struct iproc_clk_ctrl genpll_scr_clk[] = {
+	/* bypass_shift, the last value passed into enable_val(), is not defined
+	 * in NS2.  However, it doesn't appear to be used anywhere, so setting
+	 * it to 0.
+	 */
+	[BCM_NS2_GENPLL_SCR_SCR_CLK] = {
+		.channel = BCM_NS2_GENPLL_SCR_SCR_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 18, 12, 0),
+		.mdiv = reg_val(0x18, 0, 8),
+	},
+	[BCM_NS2_GENPLL_SCR_FS_CLK] = {
+		.channel = BCM_NS2_GENPLL_SCR_FS_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 19, 13, 0),
+		.mdiv = reg_val(0x18, 8, 8),
+	},
+	[BCM_NS2_GENPLL_SCR_AUDIO_CLK] = {
+		.channel = BCM_NS2_GENPLL_SCR_AUDIO_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 20, 14, 0),
+		.mdiv = reg_val(0x14, 0, 8),
+	},
+	[BCM_NS2_GENPLL_SCR_CH3_UNUSED] = {
+		.channel = BCM_NS2_GENPLL_SCR_CH3_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 21, 15, 0),
+		.mdiv = reg_val(0x14, 8, 8),
+	},
+	[BCM_NS2_GENPLL_SCR_CH4_UNUSED] = {
+		.channel = BCM_NS2_GENPLL_SCR_CH4_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 22, 16, 0),
+		.mdiv = reg_val(0x14, 16, 8),
+	},
+	[BCM_NS2_GENPLL_SCR_CH5_UNUSED] = {
+		.channel = BCM_NS2_GENPLL_SCR_CH5_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 23, 17, 0),
+		.mdiv = reg_val(0x14, 24, 8),
+	},
+};
+
+static void __init ns2_genpll_scr_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &genpll_scr, NULL, 0, genpll_scr_clk,
+			    ARRAY_SIZE(genpll_scr_clk));
+}
+CLK_OF_DECLARE(ns2_genpll_src_clk, "brcm,ns2-genpll-scr",
+	       ns2_genpll_scr_clk_init);
+
+static const struct iproc_pll_ctrl genpll_sw = {
+	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
+	.aon = aon_val(0x0, 2, 9, 8),
+	.reset = reset_val(0x4, 2, 1),
+	.dig_filter = df_val(0x0, 9, 3, 5, 4, 2, 3),
+	.ndiv_int = reg_val(0x8, 4, 10),
+	.pdiv = reg_val(0x8, 0, 4),
+	.vco_ctrl = vco_ctrl_val(0x10, 0xc),
+	.status = reg_val(0x0, 13, 1),
+};
+
+static const struct iproc_clk_ctrl genpll_sw_clk[] = {
+	/* bypass_shift, the last value passed into enable_val(), is not defined
+	 * in NS2.  However, it doesn't appear to be used anywhere, so setting
+	 * it to 0.
+	 */
+	[BCM_NS2_GENPLL_SW_RPE_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_RPE_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 18, 12, 0),
+		.mdiv = reg_val(0x18, 0, 8),
+	},
+	[BCM_NS2_GENPLL_SW_250_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_250_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 19, 13, 0),
+		.mdiv = reg_val(0x18, 8, 8),
+	},
+	[BCM_NS2_GENPLL_SW_NIC_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_NIC_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 20, 14, 0),
+		.mdiv = reg_val(0x14, 0, 8),
+	},
+	[BCM_NS2_GENPLL_SW_CHIMP_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_CHIMP_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 21, 15, 0),
+		.mdiv = reg_val(0x14, 8, 8),
+	},
+	[BCM_NS2_GENPLL_SW_PORT_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_PORT_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 22, 16, 0),
+		.mdiv = reg_val(0x14, 16, 8),
+	},
+	[BCM_NS2_GENPLL_SW_SDIO_CLK] = {
+		.channel = BCM_NS2_GENPLL_SW_SDIO_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 23, 17, 0),
+		.mdiv = reg_val(0x14, 24, 8),
+	},
+};
+
+static void __init ns2_genpll_sw_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &genpll_sw, NULL, 0, genpll_sw_clk,
+			    ARRAY_SIZE(genpll_sw_clk));
+}
+CLK_OF_DECLARE(ns2_genpll_sw_clk, "brcm,ns2-genpll-sw",
+	       ns2_genpll_sw_clk_init);
+
+static const struct iproc_pll_ctrl lcpll_ddr = {
+	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
+	.aon = aon_val(0x0, 2, 1, 0),
+	.reset = reset_val(0x4, 2, 1),
+	.dig_filter = df_val(0x0, 9, 3, 5, 4, 1, 4),
+	.ndiv_int = reg_val(0x8, 4, 10),
+	.pdiv = reg_val(0x8, 0, 4),
+	.vco_ctrl = vco_ctrl_val(0x10, 0xc),
+	.status = reg_val(0x0, 0, 1),
+};
+
+static const struct iproc_clk_ctrl lcpll_ddr_clk[] = {
+	/* bypass_shift, the last value passed into enable_val(), is not defined
+	 * in NS2.  However, it doesn't appear to be used anywhere, so setting
+	 * it to 0.
+	 */
+	[BCM_NS2_LCPLL_DDR_PCIE_SATA_USB_CLK] = {
+		.channel = BCM_NS2_LCPLL_DDR_PCIE_SATA_USB_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 18, 12, 0),
+		.mdiv = reg_val(0x14, 0, 8),
+	},
+	[BCM_NS2_LCPLL_DDR_DDR_CLK] = {
+		.channel = BCM_NS2_LCPLL_DDR_DDR_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 19, 13, 0),
+		.mdiv = reg_val(0x14, 8, 8),
+	},
+	[BCM_NS2_LCPLL_DDR_CH2_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_DDR_CH2_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 20, 14, 0),
+		.mdiv = reg_val(0x10, 0, 8),
+	},
+	[BCM_NS2_LCPLL_DDR_CH3_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_DDR_CH3_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 21, 15, 0),
+		.mdiv = reg_val(0x10, 8, 8),
+	},
+	[BCM_NS2_LCPLL_DDR_CH4_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_DDR_CH4_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 22, 16, 0),
+		.mdiv = reg_val(0x10, 16, 8),
+	},
+	[BCM_NS2_LCPLL_DDR_CH5_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_DDR_CH5_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 23, 17, 0),
+		.mdiv = reg_val(0x10, 24, 8),
+	},
+};
+
+static void __init ns2_lcpll_ddr_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &lcpll_ddr, NULL, 0, lcpll_ddr_clk,
+			    ARRAY_SIZE(lcpll_ddr_clk));
+}
+CLK_OF_DECLARE(ns2_lcpll_ddr_clk, "brcm,ns2-lcpll-ddr",
+	       ns2_lcpll_ddr_clk_init);
+
+static const struct iproc_pll_ctrl lcpll_ports = {
+	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
+	.aon = aon_val(0x0, 2, 5, 4),
+	.reset = reset_val(0x4, 2, 1),
+	.dig_filter = df_val(0x0, 9, 3, 5, 4, 1, 4),
+	.ndiv_int = reg_val(0x8, 4, 10),
+	.pdiv = reg_val(0x8, 0, 4),
+	.vco_ctrl = vco_ctrl_val(0x10, 0xc),
+	.status = reg_val(0x0, 0, 1),
+};
+
+static const struct iproc_clk_ctrl lcpll_ports_clk[] = {
+	/* bypass_shift, the last value passed into enable_val(), is not defined
+	 * in NS2.  However, it doesn't appear to be used anywhere, so setting
+	 * it to 0.
+	 */
+	[BCM_NS2_LCPLL_PORTS_WAN_CLK] = {
+		.channel = BCM_NS2_LCPLL_PORTS_WAN_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 18, 12, 0),
+		.mdiv = reg_val(0x14, 0, 8),
+	},
+	[BCM_NS2_LCPLL_PORTS_RGMII_CLK] = {
+		.channel = BCM_NS2_LCPLL_PORTS_RGMII_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 19, 13, 0),
+		.mdiv = reg_val(0x14, 8, 8),
+	},
+	[BCM_NS2_LCPLL_PORTS_CH2_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_PORTS_CH2_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 20, 14, 0),
+		.mdiv = reg_val(0x10, 0, 8),
+	},
+	[BCM_NS2_LCPLL_PORTS_CH3_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_PORTS_CH3_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 21, 15, 0),
+		.mdiv = reg_val(0x10, 8, 8),
+	},
+	[BCM_NS2_LCPLL_PORTS_CH4_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_PORTS_CH4_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 22, 16, 0),
+		.mdiv = reg_val(0x10, 16, 8),
+	},
+	[BCM_NS2_LCPLL_PORTS_CH5_UNUSED] = {
+		.channel = BCM_NS2_LCPLL_PORTS_CH5_UNUSED,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 23, 17, 0),
+		.mdiv = reg_val(0x10, 24, 8),
+	},
+};
+
+static void __init ns2_lcpll_ports_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &lcpll_ports, NULL, 0, lcpll_ports_clk,
+			    ARRAY_SIZE(lcpll_ports_clk));
+}
+CLK_OF_DECLARE(ns2_lcpll_ports_clk, "brcm,ns2-lcpll-ports",
+	       ns2_lcpll_ports_clk_init);
diff --git a/include/dt-bindings/clock/bcm-ns2.h b/include/dt-bindings/clock/bcm-ns2.h
new file mode 100644
index 0000000..d99c7a2
--- /dev/null
+++ b/include/dt-bindings/clock/bcm-ns2.h
@@ -0,0 +1,72 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _CLOCK_BCM_NS2_H
+#define _CLOCK_BCM_NS2_H
+
+/* GENPLL SCR clock channel ID */
+#define BCM_NS2_GENPLL_SCR		0
+#define BCM_NS2_GENPLL_SCR_SCR_CLK	1
+#define BCM_NS2_GENPLL_SCR_FS_CLK	2
+#define BCM_NS2_GENPLL_SCR_AUDIO_CLK	3
+#define BCM_NS2_GENPLL_SCR_CH3_UNUSED	4
+#define BCM_NS2_GENPLL_SCR_CH4_UNUSED	5
+#define BCM_NS2_GENPLL_SCR_CH5_UNUSED	6
+
+/* GENPLL SW clock channel ID */
+#define BCM_NS2_GENPLL_SW		0
+#define BCM_NS2_GENPLL_SW_RPE_CLK	1
+#define BCM_NS2_GENPLL_SW_250_CLK	2
+#define BCM_NS2_GENPLL_SW_NIC_CLK	3
+#define BCM_NS2_GENPLL_SW_CHIMP_CLK	4
+#define BCM_NS2_GENPLL_SW_PORT_CLK	5
+#define BCM_NS2_GENPLL_SW_SDIO_CLK	6
+
+/* LCPLL DDR clock channel ID */
+#define BCM_NS2_LCPLL_DDR		0
+#define BCM_NS2_LCPLL_DDR_PCIE_SATA_USB_CLK	1
+#define BCM_NS2_LCPLL_DDR_DDR_CLK	2
+#define BCM_NS2_LCPLL_DDR_CH2_UNUSED	3
+#define BCM_NS2_LCPLL_DDR_CH3_UNUSED	4
+#define BCM_NS2_LCPLL_DDR_CH4_UNUSED	5
+#define BCM_NS2_LCPLL_DDR_CH5_UNUSED	6
+
+/* LCPLL PORTS clock channel ID */
+#define BCM_NS2_LCPLL_PORTS		0
+#define BCM_NS2_LCPLL_PORTS_WAN_CLK	1
+#define BCM_NS2_LCPLL_PORTS_RGMII_CLK	2
+#define BCM_NS2_LCPLL_PORTS_CH2_UNUSED	3
+#define BCM_NS2_LCPLL_PORTS_CH3_UNUSED	4
+#define BCM_NS2_LCPLL_PORTS_CH4_UNUSED	5
+#define BCM_NS2_LCPLL_PORTS_CH5_UNUSED	6
+
+#endif /* _CLOCK_BCM_NS2_H */
-- 
1.9.1
