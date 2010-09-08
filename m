From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  8 Sep 2010 17:12:05 +0900
Subject: [PATCH v2 08/13] ARM: S5P64X0: Move DMA support for S5P64X0
Message-ID: <1283933525-31598-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves DMA support files in the mach-s5p64x0
for S5P6440 and S5P6450 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
Changes since v1:
- Fixed id of s5p6440_device_pdma
- Added SoC detection for assign each platform device
- Removed unuseful dma_ch of m2m transfer

 arch/arm/mach-s5p6440/dma.c                        |  105 -------------
 arch/arm/mach-s5p64x0/dma.c                        |  165 ++++++++++++++++++++
 .../include/mach/dma.h                             |    0
 arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h |   20 +++
 4 files changed, 185 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/dma.c
 create mode 100644 arch/arm/mach-s5p64x0/dma.c
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/dma.h (100%)

diff --git a/arch/arm/mach-s5p6440/dma.c b/arch/arm/mach-s5p6440/dma.c
deleted file mode 100644
index 07606ad..0000000
--- a/arch/arm/mach-s5p6440/dma.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-
-#include <plat/devs.h>
-#include <plat/irqs.h>
-
-#include <mach/map.h>
-#include <mach/irqs.h>
-
-#include <plat/s3c-pl330-pdata.h>
-
-static u64 dma_dmamask = DMA_BIT_MASK(32);
-
-static struct resource s5p6440_pdma_resource[] = {
-	[0] = {
-		.start  = S5P6440_PA_PDMA,
-		.end    = S5P6440_PA_PDMA + SZ_4K,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_DMA0,
-		.end	= IRQ_DMA0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c_pl330_platdata s5p6440_pdma_pdata = {
-	.peri = {
-		[0] = DMACH_UART0_RX,
-		[1] = DMACH_UART0_TX,
-		[2] = DMACH_UART1_RX,
-		[3] = DMACH_UART1_TX,
-		[4] = DMACH_UART2_RX,
-		[5] = DMACH_UART2_TX,
-		[6] = DMACH_UART3_RX,
-		[7] = DMACH_UART3_TX,
-		[8] = DMACH_MAX,
-		[9] = DMACH_MAX,
-		[10] = DMACH_PCM0_TX,
-		[11] = DMACH_PCM0_RX,
-		[12] = DMACH_I2S0_TX,
-		[13] = DMACH_I2S0_RX,
-		[14] = DMACH_SPI0_TX,
-		[15] = DMACH_SPI0_RX,
-		[16] = DMACH_MAX,
-		[17] = DMACH_MAX,
-		[18] = DMACH_MAX,
-		[19] = DMACH_MAX,
-		[20] = DMACH_SPI1_TX,
-		[21] = DMACH_SPI1_RX,
-		[22] = DMACH_MAX,
-		[23] = DMACH_MAX,
-		[24] = DMACH_MAX,
-		[25] = DMACH_MAX,
-		[26] = DMACH_MAX,
-		[27] = DMACH_MAX,
-		[28] = DMACH_MAX,
-		[29] = DMACH_PWM,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
-	},
-};
-
-static struct platform_device s5p6440_device_pdma = {
-	.name		= "s3c-pl330",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5p6440_pdma_resource),
-	.resource	= s5p6440_pdma_resource,
-	.dev		= {
-		.dma_mask = &dma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &s5p6440_pdma_pdata,
-	},
-};
-
-static struct platform_device *s5p6440_dmacs[] __initdata = {
-	&s5p6440_device_pdma,
-};
-
-static int __init s5p6440_dma_init(void)
-{
-	platform_add_devices(s5p6440_dmacs, ARRAY_SIZE(s5p6440_dmacs));
-
-	return 0;
-}
-arch_initcall(s5p6440_dma_init);
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
new file mode 100644
index 0000000..62c44dd
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -0,0 +1,165 @@
+/* linux/arch/arm/mach-s5p64x0/dma.c
+ *
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
+*/
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/map.h>
+#include <mach/irqs.h>
+#include <mach/regs-clock.h>
+
+#include <plat/devs.h>
+#include <plat/s3c-pl330-pdata.h>
+
+static u64 dma_dmamask = DMA_BIT_MASK(32);
+
+static struct resource s5p64x0_pdma_resource[] = {
+	[0] = {
+		.start	= S5P64X0_PA_PDMA,
+		.end	= S5P64X0_PA_PDMA + SZ_4K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DMA0,
+		.end	= IRQ_DMA0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pl330_platdata s5p6440_pdma_pdata = {
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
+		[9] = DMACH_MAX,
+		[10] = DMACH_PCM0_TX,
+		[11] = DMACH_PCM0_RX,
+		[12] = DMACH_I2S0_TX,
+		[13] = DMACH_I2S0_RX,
+		[14] = DMACH_SPI0_TX,
+		[15] = DMACH_SPI0_RX,
+		[16] = DMACH_MAX,
+		[17] = DMACH_MAX,
+		[18] = DMACH_MAX,
+		[19] = DMACH_MAX,
+		[20] = DMACH_SPI1_TX,
+		[21] = DMACH_SPI1_RX,
+		[22] = DMACH_MAX,
+		[23] = DMACH_MAX,
+		[24] = DMACH_MAX,
+		[25] = DMACH_MAX,
+		[26] = DMACH_MAX,
+		[27] = DMACH_MAX,
+		[28] = DMACH_MAX,
+		[29] = DMACH_PWM,
+		[30] = DMACH_MAX,
+		[31] = DMACH_MAX,
+	},
+};
+
+static struct s3c_pl330_platdata s5p6450_pdma_pdata = {
+	.peri = {
+		[0] = DMACH_UART0_RX,
+		[1] = DMACH_UART0_TX,
+		[2] = DMACH_UART1_RX,
+		[3] = DMACH_UART1_TX,
+		[4] = DMACH_UART2_RX,
+		[5] = DMACH_UART2_TX,
+		[6] = DMACH_UART3_RX,
+		[7] = DMACH_UART3_TX,
+		[8] = DMACH_UART4_RX,
+		[9] = DMACH_UART4_TX,
+		[10] = DMACH_PCM0_TX,
+		[11] = DMACH_PCM0_RX,
+		[12] = DMACH_I2S0_TX,
+		[13] = DMACH_I2S0_RX,
+		[14] = DMACH_SPI0_TX,
+		[15] = DMACH_SPI0_RX,
+		[16] = DMACH_PCM1_TX,
+		[17] = DMACH_PCM1_RX,
+		[18] = DMACH_PCM2_TX,
+		[19] = DMACH_PCM2_RX,
+		[20] = DMACH_SPI1_TX,
+		[21] = DMACH_SPI1_RX,
+		[22] = DMACH_USI_TX,
+		[23] = DMACH_USI_RX,
+		[24] = DMACH_MAX,
+		[25] = DMACH_I2S1_TX,
+		[26] = DMACH_I2S1_RX,
+		[27] = DMACH_I2S2_TX,
+		[28] = DMACH_I2S2_RX,
+		[29] = DMACH_PWM,
+		[30] = DMACH_UART5_RX,
+		[31] = DMACH_UART5_TX,
+	},
+};
+
+static struct platform_device s5p6440_device_pdma = {
+	.name		= "s3c-pl330",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p64x0_pdma_resource),
+	.resource	= s5p64x0_pdma_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5p6440_pdma_pdata,
+	},
+};
+
+static struct platform_device s5p6450_device_pdma = {
+	.name		= "s3c-pl330",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p64x0_pdma_resource),
+	.resource	= s5p64x0_pdma_resource,
+	.dev		= {
+		.dma_mask = &dma_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s5p6450_pdma_pdata,
+	},
+};
+
+static struct platform_device *s5p6440_dmacs[] __initdata = {
+	&s5p6440_device_pdma,
+};
+
+static struct platform_device *s5p6450_dmacs[] __initdata = {
+	&s5p6450_device_pdma,
+};
+
+static int __init s5p64x0_dma_init(void)
+{
+	unsigned int id;
+
+	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+
+	if (id == 0x50000)
+		platform_add_devices(s5p6450_dmacs, ARRAY_SIZE(s5p6450_dmacs));
+	else
+		platform_add_devices(s5p6440_dmacs, ARRAY_SIZE(s5p6440_dmacs));
+
+	return 0;
+}
+arch_initcall(s5p64x0_dma_init);
diff --git a/arch/arm/mach-s5p6440/include/mach/dma.h b/arch/arm/mach-s5p64x0/include/mach/dma.h
similarity index 100%
rename from arch/arm/mach-s5p6440/include/mach/dma.h
rename to arch/arm/mach-s5p64x0/include/mach/dma.h
diff --git a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h b/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
index 5fe6721..8107442 100644
--- a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
@@ -32,6 +32,12 @@ enum dma_ch {
 	DMACH_UART2_TX,
 	DMACH_UART3_RX,
 	DMACH_UART3_TX,
+	DMACH_UART4_RX,
+	DMACH_UART4_TX,
+	DMACH_UART5_RX,
+	DMACH_UART5_TX,
+	DMACH_USI_RX,
+	DMACH_USI_TX,
 	DMACH_IRDA,
 	DMACH_I2S0_RX,
 	DMACH_I2S0_TX,
@@ -64,6 +70,20 @@ enum dma_ch {
 	DMACH_MSM_REQ2,
 	DMACH_MSM_REQ1,
 	DMACH_MSM_REQ0,
+	DMACH_SLIMBUS0_RX,
+	DMACH_SLIMBUS0_TX,
+	DMACH_SLIMBUS0AUX_RX,
+	DMACH_SLIMBUS0AUX_TX,
+	DMACH_SLIMBUS1_RX,
+	DMACH_SLIMBUS1_TX,
+	DMACH_SLIMBUS2_RX,
+	DMACH_SLIMBUS2_TX,
+	DMACH_SLIMBUS3_RX,
+	DMACH_SLIMBUS3_TX,
+	DMACH_SLIMBUS4_RX,
+	DMACH_SLIMBUS4_TX,
+	DMACH_SLIMBUS5_RX,
+	DMACH_SLIMBUS5_TX,
 	/* END Marker, also used to denote a reserved channel */
 	DMACH_MAX,
 };
-- 
1.6.2.5
