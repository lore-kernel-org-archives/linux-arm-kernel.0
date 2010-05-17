From: jassi.brar@samsung.com (Jassi Brar)
Date: Mon, 17 May 2010 10:35:47 +0900
Subject: [PATCH 3/6] S5PC100: DMA: Add platform devices for PL330 DMACs
In-Reply-To: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
References: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274060147-14322-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung's Soc S5PC100 has three PL330 DMACs. First is dedicated for
Memory->Memory data transfer while the other two meant for data
transfer with peripherals.
Define and add latter two PL330 DMACs as platform devices on the
S5PC100 platform.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |    1 +
 arch/arm/mach-s5pc100/Makefile           |    2 +-
 arch/arm/mach-s5pc100/dma.c              |  167 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5pc100/include/mach/dma.h |   26 +++++
 4 files changed, 195 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/dma.c
 create mode 100644 arch/arm/mach-s5pc100/include/mach/dma.h

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 27ec167..0b157b0 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -7,6 +7,7 @@
 
 config CPU_S5PC100
 	bool
+	select S3C_PL330_DMA
 	select CPU_S5PC100_INIT
 	select CPU_S5PC100_CLOCK
 	help
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 809ff10..c32801e 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -11,7 +11,7 @@ obj-				:=
 
 # Core support for S5PC100 system
 
-obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
+obj-$(CONFIG_CPU_S5PC100)	+= cpu.o dma.o
 
 # Helper and device support
 
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
new file mode 100644
index 0000000..8e7af46
--- /dev/null
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -0,0 +1,167 @@
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
+
+#include <plat/s3c-pl330-pdata.h>
+
+static u64 dma_dmamask = DMA_BIT_MASK(32);
+
+static struct resource s5pc100_pdma0_resource[] = {
+	[0] = {
+		.start  = S5PC100_PA_PDMA0,
+		.end    = S5PC100_PA_PDMA0 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA0,
+		.end	= IRQ_PDMA0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pc100_pdma0_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_UART3_RX,
+		[7] = DMACH_UART3_TX,
+		[8] = DMACH_IRDA,
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
+		[20] = DMACH_SPI2_RX,
+		[21] = DMACH_SPI2_TX,
+		[22] = DMACH_AC97_MICIN,
+		[23] = DMACH_AC97_PCMIN,
+		[24] = DMACH_AC97_PCMOUT,
+		[25] = DMACH_EXTERNAL,
+		[26] = DMACH_PWM,
+		[27] = DMACH_SPDIF,
+		[28] = DMACH_HSI_RX,
+		[29] = DMACH_HSI_TX,
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct platform_device s5pc100_device_pdma0 = {
+	.name		= "s3c-pl330",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5pc100_pdma0_resource),
+	.resource	= s5pc100_pdma0_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pc100_pdma0_pdata,
+	},
+};
+
+static struct resource s5pc100_pdma1_resource[] = {
+	[0] = {
+		.start  = S5PC100_PA_PDMA1,
+		.end    = S5PC100_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA1,
+		.end	= IRQ_PDMA1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pc100_pdma1_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_UART3_RX,
+		[7] = DMACH_UART3_TX,
+		[8] = DMACH_IRDA,
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
+		[20] = DMACH_SPI2_RX,
+		[21] = DMACH_SPI2_TX,
+		[22] = DMACH_PCM0_RX,
+		[23] = DMACH_PCM0_TX,
+		[24] = DMACH_PCM1_RX,
+		[25] = DMACH_PCM1_TX,
+		[26] = DMACH_MSM_REQ0,
+		[27] = DMACH_MSM_REQ1,
+		[28] = DMACH_MSM_REQ2,
+		[29] = DMACH_MSM_REQ3,
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct platform_device s5pc100_device_pdma1 = {
+	.name		= "s3c-pl330",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s5pc100_pdma1_resource),
+	.resource	= s5pc100_pdma1_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pc100_pdma1_pdata,
+	},
+};
+
+static struct platform_device *s5pc100_dmacs[] __initdata = {
+	&s5pc100_device_pdma0,
+	&s5pc100_device_pdma1,
+};
+
+static int __init s5pc100_dma_init(void)
+{
+	platform_add_devices(s5pc100_dmacs, ARRAY_SIZE(s5pc100_dmacs));
+
+	return 0;
+}
+arch_initcall(s5pc100_dma_init);
diff --git a/arch/arm/mach-s5pc100/include/mach/dma.h b/arch/arm/mach-s5pc100/include/mach/dma.h
new file mode 100644
index 0000000..81209eb
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/dma.h
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
-- 
1.6.2.5
