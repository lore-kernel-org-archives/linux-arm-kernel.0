From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:37 -0400
Subject: [PATCH 02/10] clk: nsp: add clock support for Broadcom Northstar Plus
 SoC
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Northstar Plus SoC is architected under the iProc
architecture. It has the following PLLs: ARMPLL, GENPLL, LCPLL0, all
derived from an onboard crystal.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 drivers/clk/bcm/Makefile            |   2 +
 drivers/clk/bcm/clk-nsp.c           | 139 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm-nsp.h |  51 +++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-nsp.c
 create mode 100644 include/dt-bindings/clock/bcm-nsp.h

diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 8a7a477..e258b28 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
 obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
+obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
+obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
diff --git a/drivers/clk/bcm/clk-nsp.c b/drivers/clk/bcm/clk-nsp.c
new file mode 100644
index 0000000..708961a
--- /dev/null
+++ b/drivers/clk/bcm/clk-nsp.c
@@ -0,0 +1,139 @@
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
+#include <dt-bindings/clock/bcm-nsp.h>
+#include "clk-iproc.h"
+
+#define reg_val(o, s, w) { .offset = o, .shift = s, .width = w, }
+
+#define aon_val(o, pw, ps, is) { .offset = o, .pwr_width = pw, \
+	.pwr_shift = ps, .iso_shift = is }
+
+#define reset_val(o, rs, prs, kis, kiw, kps, kpw, kas, kaw) { .offset = o, \
+	.reset_shift = rs, .p_reset_shift = prs, .ki_shift = kis, \
+	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas, \
+	.ka_width = kaw }
+
+#define vco_ctrl_val(uo, lo) { .u_offset = uo, .l_offset = lo }
+
+#define enable_val(o, es, hs, bs) { .offset = o, .enable_shift = es, \
+	.hold_shift = hs, .bypass_shift = bs }
+
+static void __init nsp_armpll_init(struct device_node *node)
+{
+	iproc_armpll_setup(node);
+}
+CLK_OF_DECLARE(nsp_armpll, "brcm,nsp-armpll", nsp_armpll_init);
+
+static const struct iproc_pll_ctrl genpll = {
+	.flags = IPROC_CLK_PLL_HAS_NDIV_FRAC | IPROC_CLK_EMBED_PWRCTRL,
+	.aon = aon_val(0x0, 1, 12, 0),
+	.reset = reset_val(0x0, 11, 10, 4, 3, 0, 4, 7, 3),
+	.ndiv_int = reg_val(0x14, 20, 10),
+	.ndiv_frac = reg_val(0x14, 0, 20),
+	.pdiv = reg_val(0x18, 24, 3),
+	.status = reg_val(0x20, 12, 1),
+};
+
+static const struct iproc_clk_ctrl genpll_clk[] = {
+	[BCM_NSP_GENPLL_PHY_CLK] = {
+		.channel = BCM_NSP_GENPLL_PHY_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 12, 6, 18),
+		.mdiv = reg_val(0x18, 16, 8),
+	},
+	[BCM_NSP_GENPLL_ENET_SW_CLK] = {
+		.channel = BCM_NSP_GENPLL_ENET_SW_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 13, 7, 19),
+		.mdiv = reg_val(0x18, 8, 8),
+	},
+	[BCM_NSP_GENPLL_USB_PHY_REF_CLK] = {
+		.channel = BCM_NSP_GENPLL_USB_PHY_REF_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 14, 8, 20),
+		.mdiv = reg_val(0x18, 0, 8),
+	},
+	[BCM_NSP_GENPLL_IPROCFAST_CLK] = {
+		.channel = BCM_NSP_GENPLL_IPROCFAST_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 15, 9, 21),
+		.mdiv = reg_val(0x1c, 16, 8),
+	},
+	[BCM_NSP_GENPLL_SATA1_CLK] = {
+		.channel = BCM_NSP_GENPLL_SATA1_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 16, 10, 22),
+		.mdiv = reg_val(0x1c, 8, 8),
+	},
+	[BCM_NSP_GENPLL_SATA2_CLK] = {
+		.channel = BCM_NSP_GENPLL_SATA2_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x4, 17, 11, 23),
+		.mdiv = reg_val(0x1c, 0, 8),
+	},
+};
+
+static void __init nsp_genpll_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &genpll, NULL, 0, genpll_clk,
+			    ARRAY_SIZE(genpll_clk));
+}
+CLK_OF_DECLARE(nsp_genpll_clk, "brcm,nsp-genpll", nsp_genpll_clk_init);
+
+static const struct iproc_pll_ctrl lcpll0 = {
+	.flags = IPROC_CLK_PLL_HAS_NDIV_FRAC | IPROC_CLK_EMBED_PWRCTRL,
+	.aon = aon_val(0x0, 1, 24, 0),
+	.reset = reset_val(0x0, 23, 22, 16, 3, 12, 4, 19, 4),
+	.ndiv_int = reg_val(0x4, 20, 8),
+	.ndiv_frac = reg_val(0x4, 0, 20),
+	.pdiv = reg_val(0x4, 28, 3),
+	.status = reg_val(0x10, 12, 1),
+};
+
+static const struct iproc_clk_ctrl lcpll0_clk[] = {
+	[BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK] = {
+		.channel = BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 6, 3, 9),
+		.mdiv = reg_val(0x8, 24, 8),
+	},
+	[BCM_NSP_LCPLL0_SDIO_CLK] = {
+		.channel = BCM_NSP_LCPLL0_SDIO_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 7, 4, 10),
+		.mdiv = reg_val(0x8, 16, 8),
+	},
+	[BCM_NSP_LCPLL0_DDR_PHY_CLK] = {
+		.channel = BCM_NSP_LCPLL0_DDR_PHY_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = enable_val(0x0, 8, 5, 11),
+		.mdiv = reg_val(0x8, 8, 8),
+	},
+};
+
+static void __init nsp_lcpll0_clk_init(struct device_node *node)
+{
+	iproc_pll_clk_setup(node, &lcpll0, NULL, 0, lcpll0_clk,
+			    ARRAY_SIZE(lcpll0_clk));
+}
+CLK_OF_DECLARE(nsp_lcpll0_clk, "brcm,nsp-lcpll0", nsp_lcpll0_clk_init);
diff --git a/include/dt-bindings/clock/bcm-nsp.h b/include/dt-bindings/clock/bcm-nsp.h
new file mode 100644
index 0000000..ad5827c
--- /dev/null
+++ b/include/dt-bindings/clock/bcm-nsp.h
@@ -0,0 +1,51 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *	* Redistributions of source code must retain the above copyright
+ *	  notice, this list of conditions and the following disclaimer.
+ *	* Redistributions in binary form must reproduce the above copyright
+ *	  notice, this list of conditions and the following disclaimer in
+ *	  the documentation and/or other materials provided with the
+ *	  distribution.
+ *	* Neither the name of Broadcom Corporation nor the names of its
+ *	  contributors may be used to endorse or promote products derived
+ *	  from this software without specific prior written permission.
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
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _CLOCK_BCM_NSP_H
+#define _CLOCK_BCM_NSP_H
+
+/* GENPLL clock channel ID */
+#define BCM_NSP_GENPLL			0
+#define BCM_NSP_GENPLL_PHY_CLK		1
+#define BCM_NSP_GENPLL_ENET_SW_CLK	2
+#define BCM_NSP_GENPLL_USB_PHY_REF_CLK	3
+#define BCM_NSP_GENPLL_IPROCFAST_CLK	4
+#define BCM_NSP_GENPLL_SATA1_CLK	5
+#define BCM_NSP_GENPLL_SATA2_CLK	6
+
+/* LCPLL0 clock channel ID */
+#define BCM_NSP_LCPLL0			0
+#define BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK	1
+#define BCM_NSP_LCPLL0_SDIO_CLK		2
+#define BCM_NSP_LCPLL0_DDR_PHY_CLK	3
+
+#endif /* _CLOCK_BCM_NSP_H */
-- 
1.9.1
