From: jassi.brar@samsung.com (Jassi Brar)
Date: Mon, 17 May 2010 10:36:09 +0900
Subject: [PATCH 6/6] S5PV210: DMA: Add platform devices for PL330 DMACs
In-Reply-To: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
References: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274060169-14420-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung's Soc S5PV210 has three PL330 DMACs. First is dedicated for
Memory->Memory data transfer while the other two meant for data
transfer with peripherals.
Define and add latter two PL330 DMACs as platform devices on the
S5PV210 platform.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    1 +
 arch/arm/mach-s5pv210/Makefile           |    2 +-
 arch/arm/mach-s5pv210/dma.c              |  168 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/dma.h |   26 +++++
 arch/arm/mach-s5pv210/include/mach/map.h |    4 +
 5 files changed, 200 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/dma.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/dma.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index af33a1a..7601c28 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -12,6 +12,7 @@ if ARCH_S5PV210
 config CPU_S5PV210
 	bool
 	select PLAT_S5P
+	select S3C_PL330_DMA
 	help
 	  Enable S5PV210 CPU support
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 8ebf51c..f7f1cdc 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5PV210 system
 
-obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
new file mode 100644
index 0000000..778ad5f
--- /dev/null
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -0,0 +1,168 @@
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
+static struct resource s5pv210_pdma0_resource[] = {
+	[0] = {
+		.start  = S5PV210_PA_PDMA0,
+		.end    = S5PV210_PA_PDMA0 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA0,
+		.end	= IRQ_PDMA0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pv210_pdma0_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_UART3_RX,
+		[7] = DMACH_UART3_TX,
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
+		[18] = DMACH_SPI1_RX,
+		[19] = DMACH_SPI1_TX,
+		[20] = DMACH_MAX,
+		[21] = DMACH_MAX,
+		[22] = DMACH_AC97_MICIN,
+		[23] = DMACH_AC97_PCMIN,
+		[24] = DMACH_AC97_PCMOUT,
+		[25] = DMACH_MAX,
+		[26] = DMACH_PWM,
+		[27] = DMACH_SPDIF,
+		[28] = DMACH_MAX,
+		[29] = DMACH_MAX,
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct platform_device s5pv210_device_pdma0 = {
+	.name		= "s3c-pl330",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5pv210_pdma0_resource),
+	.resource	= s5pv210_pdma0_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pv210_pdma0_pdata,
+	},
+};
+
+static struct resource s5pv210_pdma1_resource[] = {
+	[0] = {
+		.start  = S5PV210_PA_PDMA1,
+		.end    = S5PV210_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA1,
+		.end	= IRQ_PDMA1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pv210_pdma1_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_UART3_RX,
+		[7] = DMACH_UART3_TX,
+		[8] = DMACH_MAX,
+		[9] = DMACH_I2S0_RX,
+		[10] = DMACH_I2S0_TX,
+		[11] = DMACH_I2S0S_TX,
+		[12] = DMACH_I2S1_RX,
+		[13] = DMACH_I2S1_TX,
+		[14] = DMACH_I2S2_RX,
+		[15] = DMACH_I2S2_TX,
+		[16] = DMACH_SPI0_RX,
+		[17] = DMACH_SPI0_TX,
+		[18] = DMACH_SPI1_RX,
+		[19] = DMACH_SPI1_TX,
+		[20] = DMACH_MAX,
+		[21] = DMACH_MAX,
+		[22] = DMACH_PCM0_RX,
+		[23] = DMACH_PCM0_TX,
+		[24] = DMACH_PCM1_RX,
+		[25] = DMACH_PCM1_TX,
+		[26] = DMACH_MSM_REQ0,
+		[27] = DMACH_MSM_REQ1,
+		[28] = DMACH_MSM_REQ2,
+		[29] = DMACH_MSM_REQ3,
+		[30] = DMACH_PCM2_RX,
+		[31] = DMACH_PCM2_TX,
+	},
+};
+
+static struct platform_device s5pv210_device_pdma1 = {
+	.name		= "s3c-pl330",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s5pv210_pdma1_resource),
+	.resource	= s5pv210_pdma1_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pv210_pdma1_pdata,
+	},
+};
+
+static struct platform_device *s5pv210_dmacs[] __initdata = {
+	&s5pv210_device_pdma0,
+	&s5pv210_device_pdma1,
+};
+
+static int __init s5pv210_dma_init(void)
+{
+	platform_add_devices(s5pv210_dmacs, ARRAY_SIZE(s5pv210_dmacs));
+
+	return 0;
+}
+arch_initcall(s5pv210_dma_init);
diff --git a/arch/arm/mach-s5pv210/include/mach/dma.h b/arch/arm/mach-s5pv210/include/mach/dma.h
new file mode 100644
index 0000000..81209eb
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/dma.h
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
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index c22694c..c038585 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -43,6 +43,10 @@
 
 #define S5PV210_PA_SROMC	(0xE8000000)
 
+#define S5PV210_PA_MDMA		0xFA200000
+#define S5PV210_PA_PDMA0	0xE0900000
+#define S5PV210_PA_PDMA1	0xE0A00000
+
 #define S5PV210_PA_VIC0		(0xF2000000)
 #define S5P_PA_VIC0		S5PV210_PA_VIC0
 
-- 
1.6.2.5
