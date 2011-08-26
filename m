From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 26 Aug 2011 13:35:19 +0800
Subject: [[PATCH v3 2/6] ARM: mx25: Print silicon revision on boot
In-Reply-To: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
References: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314336923-25162-3-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silicon revision is useful information to have during kernel boot.
Print the MX25 silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>

---
Resend: The patch first comes from Fabio, I did some change to use
the generic function for displaying silicon revision
---
 arch/arm/mach-imx/Makefile            |    2 +-
 arch/arm/mach-imx/clock-imx25.c       |    6 +++++
 arch/arm/mach-imx/cpu-imx25.c         |   41 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx25.h |    4 +++
 4 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e9eb36d..0a5332c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
 obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
 
-obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
+obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
 
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index e63e235..b0fec74c 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -263,6 +263,7 @@ DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
 DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(iim_clk,    0, CCM_CGCR1, 26, NULL, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -310,6 +311,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 	/* i.mx25 has the i.mx35 type sdma */
 	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
+	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 };
 
 int __init mx25_clocks_init(void)
@@ -334,6 +336,10 @@ int __init mx25_clocks_init(void)
 	/* Clock source for gpt is ahb_div */
 	__raw_writel(__raw_readl(CRM_BASE+0x64) & ~(1 << 5), CRM_BASE + 0x64);
 
+	clk_enable(&iim_clk);
+	imx_print_silicon_rev("i.MX25", mx25_revision());
+	clk_disable(&iim_clk);
+
 	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 
 	return 0;
diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
new file mode 100644
index 0000000..6914bcb
--- /dev/null
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -0,0 +1,41 @@
+/*
+ * MX25 CPU type detection
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/iim.h>
+
+static int mx25_cpu_rev = -1;
+
+static int mx25_read_cpu_rev(void)
+{
+	u32 rev;
+
+	rev = __raw_readl(MX25_IO_ADDRESS(MX25_IIM_BASE_ADDR + MXC_IIMSREV));
+	switch (rev) {
+	case 0x00:
+		return IMX_CHIP_REVISION_1_0;
+	case 0x01:
+		return IMX_CHIP_REVISION_1_1;
+	default:
+		return IMX_CHIP_REVISION_UNKNOWN;
+	}
+}
+
+int mx25_revision(void)
+{
+	if (mx25_cpu_rev == -1)
+		mx25_cpu_rev = mx25_read_cpu_rev();
+
+	return mx25_cpu_rev;
+}
+EXPORT_SYMBOL(mx25_revision);
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 087cd7a..8dcab80 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -104,4 +104,8 @@
 #define MX25_DMA_REQ_SSI1_RX0	28
 #define MX25_DMA_REQ_SSI1_TX0	29
 
+#ifndef __ASSEMBLY__
+extern int mx25_revision(void);
+#endif
+
 #endif /* ifndef __MACH_MX25_H__ */
-- 
1.7.4.1
