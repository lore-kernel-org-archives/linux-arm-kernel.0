From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 10:40:38 +0900
Subject: [PATCH 1/9] S5PV310: DMA: Add platform devices for PL330 DMACs
Message-ID: <1288057238-25377-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Samsung's Soc S5PV310 has three PL330 DMACs. First is dedicated for
Memory->Memory data transfer while the other two meant for data
transfer with peripherals.
Define and add latter two PL330 DMACs as platform devices on the
S5PV310 platform.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig             |    1 +
 arch/arm/mach-s5pv310/Makefile            |    2 +-
 arch/arm/mach-s5pv310/dma.c               |  168 +++++++++++++++++++++++++++++
 arch/arm/mach-s5pv310/include/mach/dma.h  |   26 +++++
 arch/arm/mach-s5pv310/include/mach/irqs.h |    3 +
 arch/arm/mach-s5pv310/include/mach/map.h  |    5 +
 6 files changed, 204 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/dma.c
 create mode 100644 arch/arm/mach-s5pv310/include/mach/dma.h

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 1150b36..d64efe0 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -11,6 +11,7 @@ if ARCH_S5PV310
 
 config CPU_S5PV310
 	bool
+	select S3C_PL330_DMA
 	help
 	  Enable S5PV310 CPU support
 
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 84afc64..d265adb 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -13,7 +13,7 @@ obj-				:=
 # Core support for S5PV310 system
 
 obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o
+obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-s5pv310/dma.c b/arch/arm/mach-s5pv310/dma.c
new file mode 100644
index 0000000..28a63c5
--- /dev/null
+++ b/arch/arm/mach-s5pv310/dma.c
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
+static struct resource s5pv310_pdma0_resource[] = {
+	[0] = {
+		.start = S5PV310_PA_PDMA0,
+		.end = S5PV310_PA_PDMA0 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA0,
+		.end	= IRQ_PDMA0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pv310_pdma0_pdata = {
+	.peri = {
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+		[24] = DMACH_AC97_PCMOUT,
+		[23] = DMACH_AC97_PCMIN,
+		[22] = DMACH_AC97_MICIN,
+		[24] = DMACH_SLIMBUS4_TX,
+		[23] = DMACH_SLIMBUS4_RX,
+		[22] = DMACH_SLIMBUS2_TX,
+		[21] = DMACH_SLIMBUS2_RX,
+		[20] = DMACH_SLIMBUS0_TX,
+		[19] = DMACH_SLIMBUS0_RX,
+		[3] = DMACH_UART4_TX,
+		[2] = DMACH_UART4_RX,
+		[5] = DMACH_UART2_TX,
+		[4] = DMACH_UART2_RX,
+		[1] = DMACH_UART0_TX,
+		[0] = DMACH_UART0_RX,
+		[13] = DMACH_I2S2_TX,
+		[12] = DMACH_I2S2_RX,
+		[10] = DMACH_I2S0_TX,
+		[9] = DMACH_I2S0_RX,
+		[11] = DMACH_I2S0S_TX,
+		[19] = DMACH_SPI2_TX,
+		[18] = DMACH_SPI2_RX,
+		[17] = DMACH_SPI0_TX,
+		[16] = DMACH_SPI0_RX,
+		[5] = DMACH_MSM_REQ2,
+		[4] = DMACH_MSM_REQ0,
+		[3] = DMACH_PCM2_TX,
+		[2] = DMACH_PCM2_RX,
+		[1] = DMACH_PCM0_TX,
+		[0] = DMACH_PCM0_RX,
+	},
+};
+
+static struct platform_device s5pv310_device_pdma0 = {
+	.name		= "s3c-pl330",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5pv310_pdma0_resource),
+	.resource	= s5pv310_pdma0_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pv310_pdma0_pdata,
+	},
+};
+
+static struct resource s5pv310_pdma1_resource[] = {
+	[0] = {
+		.start = S5PV310_PA_PDMA1,
+		.end = S5PV310_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_PDMA1,
+		.end	= IRQ_PDMA1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5pv310_pdma1_pdata = {
+	.peri = {
+		[0] = DMACH_PCM0_RX,
+		[1] = DMACH_PCM0_TX,
+		[2] = DMACH_PCM1_RX,
+		[3] = DMACH_PCM1_TX,
+		[4] = DMACH_MSM_REQ1,
+		[5] = DMACH_MSM_REQ3,
+		[6] = DMACH_SPI1_RX,
+		[7] = DMACH_SPI1_TX,
+		[8] = DMACH_I2S0S_TX,
+		[9] = DMACH_I2S0_RX,
+		[10] = DMACH_I2S0_TX,
+		[11] = DMACH_I2S1_RX,
+		[12] = DMACH_I2S1_TX,
+		[13] = DMACH_UART0_RX,
+		[14] = DMACH_UART0_TX,
+		[15] = DMACH_UART1_RX,
+		[16] = DMACH_UART1_TX,
+		[17] = DMACH_UART3_RX,
+		[18] = DMACH_UART3_TX,
+		[19] = DMACH_SLIMBUS1_RX,
+		[20] = DMACH_SLIMBUS1_TX,
+		[21] = DMACH_SLIMBUS3_RX,
+		[22] = DMACH_SLIMBUS3_TX,
+		[23] = DMACH_SLIMBUS5_RX,
+		[24] = DMACH_SLIMBUS5_TX,
+		[25] = DMACH_SLIMBUS0AUX_RX,
+		[26] = DMACH_SLIMBUS0AUX_TX,
+		[27] = DMACH_SPDIF,
+		[28] = DMACH_MAX,
+		[29] = DMACH_MAX,
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct platform_device s5pv310_device_pdma1 = {
+	.name		= "s3c-pl330",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5pv310_pdma1_resource),
+	.resource	= s5pv310_pdma1_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5pv310_pdma1_pdata,
+	},
+};
+
+static struct platform_device *s5pv310_dmacs[] __initdata = {
+	&s5pv310_device_pdma0,
+	&s5pv310_device_pdma1,
+};
+
+static int __init s5pv310_dma_init(void)
+{
+	platform_add_devices(s5pv310_dmacs, ARRAY_SIZE(s5pv310_dmacs));
+
+	return 0;
+}
+arch_initcall(s5pv310_dma_init);
diff --git a/arch/arm/mach-s5pv310/include/mach/dma.h b/arch/arm/mach-s5pv310/include/mach/dma.h
new file mode 100644
index 0000000..81209eb
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/dma.h
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
diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 99e7dad..3c05c58 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -54,6 +54,9 @@
 #define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(64))
 #define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
 
+#define IRQ_PDMA0		COMBINER_IRQ(21, 0)
+#define IRQ_PDMA1		COMBINER_IRQ(21, 1)
+
 #define IRQ_TIMER0_VIC		COMBINER_IRQ(22, 0)
 #define IRQ_TIMER1_VIC		COMBINER_IRQ(22, 1)
 #define IRQ_TIMER2_VIC		COMBINER_IRQ(22, 2)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 1e3384f..f6a6587 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -50,6 +50,11 @@
 #define S5PV310_PA_GIC_DIST		(0x10501000)
 #define S5PV310_PA_L2CC			(0x10502000)
 
+/* DMA */
+#define S5PV310_PA_MDMA		0x10810000
+#define S5PV310_PA_PDMA0	0x12680000
+#define S5PV310_PA_PDMA1	0x12690000
+
 #define S5PV310_PA_GPIO1		(0x11400000)
 #define S5PV310_PA_GPIO2		(0x11000000)
 #define S5PV310_PA_GPIO3		(0x03860000)
-- 
1.6.2.5
