From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:37 +0900
Subject: [PATCH v8 09/16] ARM: S5PV210: Use generic DMA PL330 driver
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-10-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes Samsung S5PV210 to use DMA PL330 driver
on DMADEVICE. The S5PV210 uses DMA generic APIs instead of
SAMSUNG specific S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    2 +-
 arch/arm/mach-s5pv210/clock.c            |   10 +-
 arch/arm/mach-s5pv210/dma.c              |  316 +++++++++++++++++++-----------
 arch/arm/mach-s5pv210/include/mach/dma.h |    2 +-
 4 files changed, 214 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 69dd87c..d960090 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -11,7 +11,7 @@ if ARCH_S5PV210
 
 config CPU_S5PV210
 	bool
-	select S3C_PL330_DMA
+	select SAMSUNG_DMADEV
 	select S5P_EXT_INT
 	select S5P_HRT
 	select S5PV210_PM if PM
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 52a8e60..d35726a 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -203,6 +203,11 @@ static struct clk clk_pcmcdclk2 = {
 	.name		= "pcmcdclk",
 };
 
+static struct clk dummy_apb_pclk = {
+	.name		= "apb_pclk",
+	.id		= -1,
+};
+
 static struct clk *clkset_vpllsrc_list[] = {
 	[0] = &clk_fin_vpll,
 	[1] = &clk_sclk_hdmi27m,
@@ -289,13 +294,13 @@ static struct clk_ops clk_fout_apll_ops = {
 
 static struct clk init_clocks_off[] = {
 	{
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.0",
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.1",
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
@@ -1161,5 +1166,6 @@ void __init s5pv210_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clock(&dummy_apb_pclk);
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
index 497d343..f79d0b0 100644
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -1,4 +1,8 @@
-/*
+/* linux/arch/arm/mach-s5pv210/dma.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
  *
@@ -17,151 +21,239 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl330.h>
 
+#include <asm/irq.h>
 #include <plat/devs.h>
 #include <plat/irqs.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-
-#include <plat/s3c-pl330-pdata.h>
+#include <mach/dma.h>
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-static struct resource s5pv210_pdma0_resource[] = {
-	[0] = {
-		.start  = S5PV210_PA_PDMA0,
-		.end    = S5PV210_PA_PDMA0 + SZ_4K,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PDMA0,
-		.end	= IRQ_PDMA0,
-		.flags	= IORESOURCE_IRQ,
+struct dma_pl330_peri pdma0_peri[28] = {
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
+		.peri_id = DMACH_MAX,
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
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
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
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
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
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_PWM,
+	}, {
+		.peri_id = (u8)DMACH_SPDIF,
+		.rqtype = MEMTODEV,
 	},
 };
 
-static struct s3c_pl330_platdata s5pv210_pdma0_pdata = {
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
-		[9] = DMACH_I2S0_RX,
-		[10] = DMACH_I2S0_TX,
-		[11] = DMACH_I2S0S_TX,
-		[12] = DMACH_I2S1_RX,
-		[13] = DMACH_I2S1_TX,
-		[14] = DMACH_MAX,
-		[15] = DMACH_MAX,
-		[16] = DMACH_SPI0_RX,
-		[17] = DMACH_SPI0_TX,
-		[18] = DMACH_SPI1_RX,
-		[19] = DMACH_SPI1_TX,
-		[20] = DMACH_MAX,
-		[21] = DMACH_MAX,
-		[22] = DMACH_AC97_MICIN,
-		[23] = DMACH_AC97_PCMIN,
-		[24] = DMACH_AC97_PCMOUT,
-		[25] = DMACH_MAX,
-		[26] = DMACH_PWM,
-		[27] = DMACH_SPDIF,
-		[28] = DMACH_MAX,
-		[29] = DMACH_MAX,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
-	},
+struct dma_pl330_platdata s5pv210_pdma0_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
+	.peri = pdma0_peri,
 };
 
-static struct platform_device s5pv210_device_pdma0 = {
-	.name		= "s3c-pl330",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5pv210_pdma0_resource),
-	.resource	= s5pv210_pdma0_resource,
-	.dev		= {
+struct amba_device s5pv210_device_pdma0 = {
+	.dev = {
+		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s5pv210_pdma0_pdata,
 	},
-};
-
-static struct resource s5pv210_pdma1_resource[] = {
-	[0] = {
-		.start  = S5PV210_PA_PDMA1,
-		.end    = S5PV210_PA_PDMA1 + SZ_4K,
+	.res = {
+		.start = S5PV210_PA_PDMA0,
+		.end = S5PV210_PA_PDMA0 + SZ_4K,
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
 
-static struct s3c_pl330_platdata s5pv210_pdma1_pdata = {
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
-		[20] = DMACH_MAX,
-		[21] = DMACH_MAX,
-		[22] = DMACH_PCM0_RX,
-		[23] = DMACH_PCM0_TX,
-		[24] = DMACH_PCM1_RX,
-		[25] = DMACH_PCM1_TX,
-		[26] = DMACH_MSM_REQ0,
-		[27] = DMACH_MSM_REQ1,
-		[28] = DMACH_MSM_REQ2,
-		[29] = DMACH_MSM_REQ3,
-		[30] = DMACH_PCM2_RX,
-		[31] = DMACH_PCM2_TX,
+struct dma_pl330_peri pdma1_peri[32] = {
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
+		.peri_id = DMACH_MAX,
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
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_TX,
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
+	}, {
+		.peri_id = (u8)DMACH_PCM2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM2_TX,
+		.rqtype = MEMTODEV,
 	},
 };
 
-static struct platform_device s5pv210_device_pdma1 = {
-	.name		= "s3c-pl330",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5pv210_pdma1_resource),
-	.resource	= s5pv210_pdma1_resource,
-	.dev		= {
+struct dma_pl330_platdata s5pv210_pdma1_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
+	.peri = pdma1_peri,
+};
+
+struct amba_device s5pv210_device_pdma1 = {
+	.dev = {
+		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s5pv210_pdma1_pdata,
 	},
-};
-
-static struct platform_device *s5pv210_dmacs[] __initdata = {
-	&s5pv210_device_pdma0,
-	&s5pv210_device_pdma1,
+	.res = {
+		.start = S5PV210_PA_PDMA1,
+		.end = S5PV210_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_PDMA1, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
 static int __init s5pv210_dma_init(void)
 {
-	platform_add_devices(s5pv210_dmacs, ARRAY_SIZE(s5pv210_dmacs));
+	amba_device_register(&s5pv210_device_pdma0, &iomem_resource);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5pv210/include/mach/dma.h b/arch/arm/mach-s5pv210/include/mach/dma.h
index 1beae2c..201842a 100644
--- a/arch/arm/mach-s5pv210/include/mach/dma.h
+++ b/arch/arm/mach-s5pv210/include/mach/dma.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_DMA_H
 #define __MACH_DMA_H
 
-/* This platform uses the common S3C DMA API driver for PL330 */
+/* This platform uses the common DMA API driver for PL330 */
 #include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
-- 
1.7.1
