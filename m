From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:38 +0900
Subject: [PATCH v8 10/16] ARM: S5PC100: Use generic DMA PL330 driver
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-11-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes Samsung S5PC100 to use DMA PL330 driver
on DMADEVICE. The S5PC100 uses DMA generic APIs instead of
SAMSUNG specific S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |    2 +-
 arch/arm/mach-s5pc100/clock.c            |   11 +-
 arch/arm/mach-s5pc100/dma.c              |  323 +++++++++++++++++++----------
 arch/arm/mach-s5pc100/include/mach/dma.h |    2 +-
 4 files changed, 222 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index e8a33c4..e538a4c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -10,7 +10,7 @@ if ARCH_S5PC100
 config CPU_S5PC100
 	bool
 	select S5P_EXT_INT
-	select S3C_PL330_DMA
+	select SAMSUNG_DMADEV
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index ff5cbb3..6527c05 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -33,6 +33,11 @@ static struct clk s5p_clk_otgphy = {
 	.name		= "otg_phy",
 };
 
+static struct clk dummy_apb_pclk = {
+	.name		= "apb_pclk",
+	.id		= -1,
+};
+
 static struct clk *clk_src_mout_href_list[] = {
 	[0] = &s5p_clk_27m,
 	[1] = &clk_fin_hpll,
@@ -454,13 +459,13 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
@@ -1276,5 +1281,7 @@ void __init s5pc100_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clock(&dummy_apb_pclk);
+
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index bf4cd0f..ef803e9 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -1,4 +1,8 @@
-/*
+/* linux/arch/arm/mach-s5pc100/dma.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
  *
@@ -17,150 +21,245 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl330.h>
 
+#include <asm/irq.h>
 #include <plat/devs.h>
+#include <plat/irqs.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-
-#include <plat/s3c-pl330-pdata.h>
+#include <mach/dma.h>
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-static struct resource s5pc100_pdma0_resource[] = {
-	[0] = {
-		.start  = S5PC100_PA_PDMA0,
-		.end    = S5PC100_PA_PDMA0 + SZ_4K,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PDMA0,
-		.end	= IRQ_PDMA0,
-		.flags	= IORESOURCE_IRQ,
+struct dma_pl330_peri pdma0_peri[30] = {
+	{
+		.peri_id = (u8)DMACH_UART0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART3_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART3_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = DMACH_IRDA,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0S_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_AC97_MICIN,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_AC97_PCMIN,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_AC97_PCMOUT,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_EXTERNAL,
+	}, {
+		.peri_id = (u8)DMACH_PWM,
+	}, {
+		.peri_id = (u8)DMACH_SPDIF,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_HSI_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_HSI_TX,
+		.rqtype = MEMTODEV,
 	},
 };
 
-static struct s3c_pl330_platdata s5pc100_pdma0_pdata = {
-	.peri = {
-		[0] = DMACH_UART0_RX,
-		[1] = DMACH_UART0_TX,
-		[2] = DMACH_UART1_RX,
-		[3] = DMACH_UART1_TX,
-		[4] = DMACH_UART2_RX,
-		[5] = DMACH_UART2_TX,
-		[6] = DMACH_UART3_RX,
-		[7] = DMACH_UART3_TX,
-		[8] = DMACH_IRDA,
-		[9] = DMACH_I2S0_RX,
-		[10] = DMACH_I2S0_TX,
-		[11] = DMACH_I2S0S_TX,
-		[12] = DMACH_I2S1_RX,
-		[13] = DMACH_I2S1_TX,
-		[14] = DMACH_I2S2_RX,
-		[15] = DMACH_I2S2_TX,
-		[16] = DMACH_SPI0_RX,
-		[17] = DMACH_SPI0_TX,
-		[18] = DMACH_SPI1_RX,
-		[19] = DMACH_SPI1_TX,
-		[20] = DMACH_SPI2_RX,
-		[21] = DMACH_SPI2_TX,
-		[22] = DMACH_AC97_MICIN,
-		[23] = DMACH_AC97_PCMIN,
-		[24] = DMACH_AC97_PCMOUT,
-		[25] = DMACH_EXTERNAL,
-		[26] = DMACH_PWM,
-		[27] = DMACH_SPDIF,
-		[28] = DMACH_HSI_RX,
-		[29] = DMACH_HSI_TX,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
-	},
+struct dma_pl330_platdata s5pc100_pdma0_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
+	.peri = pdma0_peri,
 };
 
-static struct platform_device s5pc100_device_pdma0 = {
-	.name		= "s3c-pl330",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5pc100_pdma0_resource),
-	.resource	= s5pc100_pdma0_resource,
-	.dev		= {
+struct amba_device s5pc100_device_pdma0 = {
+	.dev = {
+		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s5pc100_pdma0_pdata,
 	},
-};
-
-static struct resource s5pc100_pdma1_resource[] = {
-	[0] = {
-		.start  = S5PC100_PA_PDMA1,
-		.end    = S5PC100_PA_PDMA1 + SZ_4K,
+	.res = {
+		.start = S5PC100_PA_PDMA0,
+		.end = S5PC100_PA_PDMA0 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	[1] = {
-		.start	= IRQ_PDMA1,
-		.end	= IRQ_PDMA1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	.irq = {IRQ_PDMA0, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
-static struct s3c_pl330_platdata s5pc100_pdma1_pdata = {
-	.peri = {
-		[0] = DMACH_UART0_RX,
-		[1] = DMACH_UART0_TX,
-		[2] = DMACH_UART1_RX,
-		[3] = DMACH_UART1_TX,
-		[4] = DMACH_UART2_RX,
-		[5] = DMACH_UART2_TX,
-		[6] = DMACH_UART3_RX,
-		[7] = DMACH_UART3_TX,
-		[8] = DMACH_IRDA,
-		[9] = DMACH_I2S0_RX,
-		[10] = DMACH_I2S0_TX,
-		[11] = DMACH_I2S0S_TX,
-		[12] = DMACH_I2S1_RX,
-		[13] = DMACH_I2S1_TX,
-		[14] = DMACH_I2S2_RX,
-		[15] = DMACH_I2S2_TX,
-		[16] = DMACH_SPI0_RX,
-		[17] = DMACH_SPI0_TX,
-		[18] = DMACH_SPI1_RX,
-		[19] = DMACH_SPI1_TX,
-		[20] = DMACH_SPI2_RX,
-		[21] = DMACH_SPI2_TX,
-		[22] = DMACH_PCM0_RX,
-		[23] = DMACH_PCM0_TX,
-		[24] = DMACH_PCM1_RX,
-		[25] = DMACH_PCM1_TX,
-		[26] = DMACH_MSM_REQ0,
-		[27] = DMACH_MSM_REQ1,
-		[28] = DMACH_MSM_REQ2,
-		[29] = DMACH_MSM_REQ3,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
+struct dma_pl330_peri pdma1_peri[30] = {
+	{
+		.peri_id = (u8)DMACH_UART0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART3_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART3_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = DMACH_IRDA,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0S_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ0,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ1,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ2,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ3,
 	},
 };
 
-static struct platform_device s5pc100_device_pdma1 = {
-	.name		= "s3c-pl330",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5pc100_pdma1_resource),
-	.resource	= s5pc100_pdma1_resource,
-	.dev		= {
+struct dma_pl330_platdata s5pc100_pdma1_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
+	.peri = pdma1_peri,
+};
+
+struct amba_device s5pc100_device_pdma1 = {
+	.dev = {
+		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s5pc100_pdma1_pdata,
 	},
-};
-
-static struct platform_device *s5pc100_dmacs[] __initdata = {
-	&s5pc100_device_pdma0,
-	&s5pc100_device_pdma1,
+	.res = {
+		.start = S5PC100_PA_PDMA1,
+		.end = S5PC100_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_PDMA1, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
 static int __init s5pc100_dma_init(void)
 {
-	platform_add_devices(s5pc100_dmacs, ARRAY_SIZE(s5pc100_dmacs));
+	amba_device_register(&s5pc100_device_pdma0, &iomem_resource);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5pc100/include/mach/dma.h b/arch/arm/mach-s5pc100/include/mach/dma.h
index 1beae2c..201842a 100644
--- a/arch/arm/mach-s5pc100/include/mach/dma.h
+++ b/arch/arm/mach-s5pc100/include/mach/dma.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_DMA_H
 #define __MACH_DMA_H
 
-/* This platform uses the common S3C DMA API driver for PL330 */
+/* This platform uses the common DMA API driver for PL330 */
 #include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
-- 
1.7.1
