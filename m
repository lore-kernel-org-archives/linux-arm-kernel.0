From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 14:36:03 +0100
Subject: [PATCH 5/8] ARM i.MX1: implement clocks using common clock framework
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332164166-6055-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig    |    1 +
 arch/arm/mach-imx/Makefile   |    2 +-
 arch/arm/mach-imx/clk-imx1.c |  118 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-imx1.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..4cd86fb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -37,6 +37,7 @@ config ARCH_MX53
 config SOC_IMX1
 	bool
 	select ARCH_MX1
+	select COMMON_CLK
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 1f138ae..cec4843 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
-obj-$(CONFIG_SOC_IMX1) += clock-imx1.o mm-imx1.o
+obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clock-imx21.o mm-imx21.o
 
 obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
new file mode 100644
index 0000000..b9b8589
--- /dev/null
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include "clk.h"
+
+/* CCM register addresses */
+#define IO_ADDR_CCM(off)	(MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR + (off)))
+
+#define CCM_CSCR	IO_ADDR_CCM(0x0)
+#define CCM_MPCTL0	IO_ADDR_CCM(0x4)
+#define CCM_SPCTL0	IO_ADDR_CCM(0xc)
+#define CCM_PCDR	IO_ADDR_CCM(0x20)
+
+/* SCM register addresses */
+#define IO_ADDR_SCM(off)	(MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR + (off)))
+
+#define SCM_GCCR	IO_ADDR_SCM(0xc)
+
+struct clkl {
+	struct clk_lookup lookup;
+	const char *clkname;
+};
+
+#define clkdev(d, n, c) \
+	{ \
+		.lookup.dev_id = d, \
+		.lookup.con_id = n, \
+		.clkname = c, \
+	},
+
+static struct clkl lookups[] = {
+	clkdev(NULL, "dma", "dma_gate")
+	clkdev("mx1-camera.0", NULL, "csi_gate")
+	clkdev(NULL, "mma", "mma_gate")
+	clkdev("imx_udc.0", NULL, "usbd_gate")
+	clkdev("imx-gpt.0", "per", "per1")
+	clkdev("imx1-uart.0", "per", "per1")
+	clkdev("imx1-uart.0", "ipg", "hclk")
+	clkdev("imx1-uart.1", "per", "per1")
+	clkdev("imx1-uart.1", "ipg", "hclk")
+	clkdev("imx1-uart.2", "per", "per1")
+	clkdev("imx1-uart.2", "ipg", "hclk")
+	clkdev("imx-i2c.0", NULL, "hclk")
+	clkdev("imx1-cspi.0", "per", "per2")
+	clkdev("imx1-cspi.0", "ipg", "dummy")
+	clkdev("imx1-cspi.1", "per", "per2")
+	clkdev("imx1-cspi.1", "ipg", "dummy")
+	clkdev("imx-mmc.0", NULL, "per2")
+	clkdev("imx-fb.0", "per", "per2")
+	clkdev("imx-fb.0", "ipg", "dummy")
+	clkdev("imx-fb.0", "ahb", "dummy")
+	clkdev(NULL, "mshc", "hclk")
+	clkdev(NULL, "ssi", "per3")
+	clkdev("mxc_rtc.0", NULL, "clk32")
+	clkdev(NULL, "clko", "clko")
+};
+
+static char *prem_sel_clks[] = { "clk32_premult", "clk16m", };
+static char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m", "prem",
+				"fclk", };
+
+int __init mx1_clocks_init(unsigned long fref)
+{
+	int i;
+
+	imx_clk_fixed("dummy", 0);
+	imx_clk_fixed("clk32", fref);
+	imx_clk_fixed("clk16m_ext", 16000000);
+	imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
+	imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
+	imx_clk_mux("prem", CCM_CSCR, 16, 1, prem_sel_clks, ARRAY_SIZE(prem_sel_clks));
+	imx_clk_pllv1("mpll", "clk32_premult", CCM_MPCTL0);
+	imx_clk_pllv1("spll", "prem", CCM_SPCTL0);
+	imx_clk_divider("mcu", "clk32_premult", CCM_CSCR, 15, 1);
+	imx_clk_divider("fclk", "mpll", CCM_CSCR, 15, 1);
+	imx_clk_divider("hclk", "spll", CCM_CSCR, 10, 4);
+	imx_clk_divider("clk48m", "spll", CCM_CSCR, 26, 3);
+	imx_clk_divider("per1", "spll", CCM_PCDR, 0, 4);
+	imx_clk_divider("per2", "spll", CCM_PCDR, 4, 4);
+	imx_clk_divider("per3", "spll", CCM_PCDR, 16, 7);
+	imx_clk_mux("clko", CCM_CSCR, 29, 3, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
+	imx_clk_gate("dma_gate", "hclk", SCM_GCCR, 4);
+	imx_clk_gate("csi_gate", "hclk", SCM_GCCR, 2);
+	imx_clk_gate("mma_gate", "hclk", SCM_GCCR, 1);
+	imx_clk_gate("usbd_gate", "clk48m", SCM_GCCR, 0);
+
+	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
+		struct clkl *l = &lookups[i];
+		l->lookup.clk = __clk_lookup(l->clkname);
+		clkdev_add(&l->lookup);
+	}
+
+	mxc_timer_init(NULL, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
+			MX1_TIM1_INT);
+
+	return 0;
+}
-- 
1.7.9.1
