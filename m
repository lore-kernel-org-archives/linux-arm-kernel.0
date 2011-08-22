From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 22 Aug 2011 12:36:17 -0300
Subject: [PATCH 2/2] ARM: mx25: Print silicon revision on boot
In-Reply-To: <1314027377-15915-1-git-send-email-fabio.estevam@freescale.com>
References: <1314027377-15915-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314027377-15915-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silicon revision is useful information to have during kernel boot.

Print the MX25 silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Makefile            |    2 +-
 arch/arm/mach-imx/clock-imx25.c       |    3 ++
 arch/arm/mach-imx/cpu-imx25.c         |   40 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx25.h |    5 ++++
 4 files changed, 49 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpu-imx25.c

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
index b919ad8..d20cbfc 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -330,6 +330,9 @@ int __init mx25_clocks_init(void)
 	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
 			CRM_BASE + 0x64);
 
+	clk_enable(&iim_clk);
+	mx25_read_cpu_rev();
+
 	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 
 	return 0;
diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
new file mode 100644
index 0000000..0e7b26e
--- /dev/null
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -0,0 +1,40 @@
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
+#include <mach/hardware.h>
+#include <mach/iim.h>
+
+unsigned int mx25_cpu_rev;
+EXPORT_SYMBOL(mx25_cpu_rev);
+
+void __init mx25_read_cpu_rev(void)
+{
+	u32 rev;
+	char *srev;
+
+	rev = __raw_readl(MX25_IO_ADDRESS(MX25_IIM_BASE_ADDR + MXC_IIMSREV));
+	switch (rev) {
+	case 0x00:
+		mx25_cpu_rev = IMX_CHIP_REVISION_1_0;
+		srev = IMX_CHIP_REVISION_1_0_STRING;
+		break;
+	case 0x01:
+		mx25_cpu_rev = IMX_CHIP_REVISION_1_1;
+		srev = IMX_CHIP_REVISION_1_1_STRING;
+		break;
+	default:
+		mx25_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
+		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
+	}
+
+	pr_info("CPU identified as i.MX25, silicon rev %s\n", srev);
+}
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 087cd7a..40ddcda 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -41,6 +41,7 @@
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
+#define MX25_IIM_BASE_ADDR		0x53ff0000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_ESDHC1_BASE_ADDR		0x53fb4000
 #define MX25_ESDHC2_BASE_ADDR		0x53fb8000
@@ -104,4 +105,8 @@
 #define MX25_DMA_REQ_SSI1_RX0	28
 #define MX25_DMA_REQ_SSI1_TX0	29
 
+#ifndef __ASSEMBLY__
+extern void mx25_read_cpu_rev(void);
+#endif
+
 #endif /* ifndef __MACH_MX25_H__ */
-- 
1.7.1
