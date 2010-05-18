From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 11:59:27 +0900
Subject: [PATCH 5/6] S5P6442: DMA: Add platform devices for PL330 DMACs
In-Reply-To: <1274151523-21345-1-git-send-email-jassi.brar@samsung.com>
References: <1274151523-21345-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274151567-21506-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung's Soc S5P6442 has two PL330 DMACs. First is dedicated for
Memory->Memory data transfer while the second is meant for data
transfer with peripherals.
Define and add the peripheral PL330 DMAC as platform device on the
S5P6442 platform.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/Kconfig            |    1 +
 arch/arm/mach-s5p6442/Makefile           |    2 +-
 arch/arm/mach-s5p6442/dma.c              |  105 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/dma.h |   26 +++++++
 arch/arm/mach-s5p6442/include/mach/map.h |    3 +
 5 files changed, 136 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/dma.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/dma.h

diff --git a/arch/arm/mach-s5p6442/Kconfig b/arch/arm/mach-s5p6442/Kconfig
index 4f3f6de..0fd41b4 100644
--- a/arch/arm/mach-s5p6442/Kconfig
+++ b/arch/arm/mach-s5p6442/Kconfig
@@ -12,6 +12,7 @@ if ARCH_S5P6442
 config CPU_S5P6442
 	bool
 	select PLAT_S5P
+	select S3C_PL330_DMA
 	help
 	  Enable S5P6442 CPU support
 
diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index dde39a6..17bd22e 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5P6442 system
 
-obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o dma.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5p6442/dma.c b/arch/arm/mach-s5p6442/dma.c
new file mode 100644
index 0000000..ad4f870
--- /dev/null
+++ b/arch/arm/mach-s5p6442/dma.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <plat/devs.h>
+#include <plat/irqs.h>
+
+#include <mach/map.h>
+#include <mach/irqs.h>
+
+#include <plat/s3c-pl330-pdata.h>
+
+static u64 dma_dmamask = DMA_BIT_MASK(32);
+
+static struct resource s5p6442_pdma_resource[] = {
+	[0] = {
+		.start  = S5P6442_PA_PDMA,
+		.end    = S5P6442_PA_PDMA + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA,
+		.end	= IRQ_PDMA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5p6442_pdma_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_MAX,
+		[7] = DMACH_MAX,
+		[8] = DMACH_MAX,
+		[9] = DMACH_I2S0_RX,
+		[10] = DMACH_I2S0_TX,
+		[11] = DMACH_I2S0S_TX,
+		[12] = DMACH_I2S1_RX,
+		[13] = DMACH_I2S1_TX,
+		[14] = DMACH_MAX,
+		[15] = DMACH_MAX,
+		[16] = DMACH_SPI0_RX,
+		[17] = DMACH_SPI0_TX,
+		[18] = DMACH_MAX,
+		[19] = DMACH_MAX,
+		[20] = DMACH_PCM0_RX,
+		[21] = DMACH_PCM0_TX,
+		[22] = DMACH_PCM1_RX,
+		[23] = DMACH_PCM1_TX,
+		[24] = DMACH_MAX,
+		[25] = DMACH_MAX,
+		[26] = DMACH_MAX,
+		[27] = DMACH_MSM_REQ0,
+		[28] = DMACH_MSM_REQ1,
+		[29] = DMACH_MSM_REQ2,
+		[30] = DMACH_MSM_REQ3,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct platform_device s5p6442_device_pdma = {
+	.name		= "s3c-pl330",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5p6442_pdma_resource),
+	.resource	= s5p6442_pdma_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5p6442_pdma_pdata,
+	},
+};
+
+static struct platform_device *s5p6442_dmacs[] __initdata = {
+	&s5p6442_device_pdma,
+};
+
+static int __init s5p6442_dma_init(void)
+{
+	platform_add_devices(s5p6442_dmacs, ARRAY_SIZE(s5p6442_dmacs));
+
+	return 0;
+}
+arch_initcall(s5p6442_dma_init);
diff --git a/arch/arm/mach-s5p6442/include/mach/dma.h b/arch/arm/mach-s5p6442/include/mach/dma.h
new file mode 100644
index 0000000..81209eb
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/dma.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2010 Samsung Electronics Co. Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __MACH_DMA_H
+#define __MACH_DMA_H
+
+/* This platform uses the common S3C DMA API driver for PL330 */
+#include <plat/s3c-dma-pl330.h>
+
+#endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
index 685277d..a263d77 100644
--- a/arch/arm/mach-s5p6442/include/mach/map.h
+++ b/arch/arm/mach-s5p6442/include/mach/map.h
@@ -34,6 +34,9 @@
 #define S5P6442_PA_VIC2		(0xE4200000)
 #define S5P_PA_VIC2		S5P6442_PA_VIC2
 
+#define S5P6442_PA_MDMA		0xE8000000
+#define S5P6442_PA_PDMA		0xE9000000
+
 #define S5P6442_PA_TIMER	(0xEA000000)
 #define S5P_PA_TIMER		S5P6442_PA_TIMER
 
-- 
1.6.2.5
