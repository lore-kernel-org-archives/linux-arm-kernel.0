From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:39 +0900
Subject: [PATCH v8 11/16] ARM: S5P64X0: Use generic DMA PL330 driver
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-12-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes Samsung S5P64X0 to use DMA PL330 driver
on DMADEVICE. The S5P64X0 uses DMA generic APIs instead of
SAMSUNG specific S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig            |    4 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c    |    9 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c    |    9 +-
 arch/arm/mach-s5p64x0/dma.c              |  273 ++++++++++++++++++++----------
 arch/arm/mach-s5p64x0/include/mach/dma.h |    2 +-
 5 files changed, 201 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 65c7518..9527ed2 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -9,14 +9,14 @@ if ARCH_S5P64X0
 
 config CPU_S5P6440
 	bool
-	select S3C_PL330_DMA
+	select SAMSUNG_DMADEV
 	select S5P_HRT
 	help
 	  Enable S5P6440 CPU support
 
 config CPU_S5P6450
 	bool
-	select S3C_PL330_DMA
+	select SAMSUNG_DMADEV
 	select S5P_HRT
 	help
 	  Enable S5P6450 CPU support
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 0e9cd30..c1f548f 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -146,7 +146,7 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),
@@ -499,6 +499,11 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_pclk_low,
 };
 
+static struct clk dummy_apb_pclk = {
+	.name		= "apb_pclk",
+	.id		= -1,
+};
+
 void __init_or_cpufreq s5p6440_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -581,5 +586,7 @@ void __init s5p6440_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clock(&dummy_apb_pclk);
+
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index d9dc16c..3d9b609 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -179,7 +179,7 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),
@@ -553,6 +553,11 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_audio0,
 };
 
+static struct clk dummy_apb_pclk = {
+	.name		= "apb_pclk",
+	.id		= -1,
+};
+
 void __init_or_cpufreq s5p6450_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -632,5 +637,7 @@ void __init s5p6450_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clock(&dummy_apb_pclk);
+
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
index d7ad944..aebf3fc 100644
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -21,128 +21,219 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl330.h>
+
+#include <asm/irq.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
 #include <mach/regs-clock.h>
+#include <mach/dma.h>
 
 #include <plat/devs.h>
-#include <plat/s3c-pl330-pdata.h>
+#include <plat/irqs.h>
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-static struct resource s5p64x0_pdma_resource[] = {
-	[0] = {
-		.start	= S5P64X0_PA_PDMA,
-		.end	= S5P64X0_PA_PDMA + SZ_4K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_DMA0,
-		.end	= IRQ_DMA0,
-		.flags	= IORESOURCE_IRQ,
+struct dma_pl330_peri s5p6440_pdma_peri[22] = {
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
+		.peri_id = DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_RX,
+		.rqtype = DEVTOMEM,
 	},
 };
 
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
+struct dma_pl330_platdata s5p6440_pdma_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(s5p6440_pdma_peri),
+	.peri = s5p6440_pdma_peri,
 };
 
-static struct s3c_pl330_platdata s5p6450_pdma_pdata = {
-	.peri = {
-		[0] = DMACH_UART0_RX,
-		[1] = DMACH_UART0_TX,
-		[2] = DMACH_UART1_RX,
-		[3] = DMACH_UART1_TX,
-		[4] = DMACH_UART2_RX,
-		[5] = DMACH_UART2_TX,
-		[6] = DMACH_UART3_RX,
-		[7] = DMACH_UART3_TX,
-		[8] = DMACH_UART4_RX,
-		[9] = DMACH_UART4_TX,
-		[10] = DMACH_PCM0_TX,
-		[11] = DMACH_PCM0_RX,
-		[12] = DMACH_I2S0_TX,
-		[13] = DMACH_I2S0_RX,
-		[14] = DMACH_SPI0_TX,
-		[15] = DMACH_SPI0_RX,
-		[16] = DMACH_PCM1_TX,
-		[17] = DMACH_PCM1_RX,
-		[18] = DMACH_PCM2_TX,
-		[19] = DMACH_PCM2_RX,
-		[20] = DMACH_SPI1_TX,
-		[21] = DMACH_SPI1_RX,
-		[22] = DMACH_USI_TX,
-		[23] = DMACH_USI_RX,
-		[24] = DMACH_MAX,
-		[25] = DMACH_I2S1_TX,
-		[26] = DMACH_I2S1_RX,
-		[27] = DMACH_I2S2_TX,
-		[28] = DMACH_I2S2_RX,
-		[29] = DMACH_PWM,
-		[30] = DMACH_UART5_RX,
-		[31] = DMACH_UART5_TX,
+struct dma_pl330_peri s5p6450_pdma_peri[32] = {
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
+		.peri_id = (u8)DMACH_UART4_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART4_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_USI_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_USI_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_MAX,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PWM,
+	}, {
+		.peri_id = (u8)DMACH_UART5_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART5_TX,
+		.rqtype = MEMTODEV,
 	},
 };
 
-static struct platform_device s5p64x0_device_pdma = {
-	.name		= "s3c-pl330",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p64x0_pdma_resource),
-	.resource	= s5p64x0_pdma_resource,
-	.dev		= {
+struct dma_pl330_platdata s5p6450_pdma_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(s5p6450_pdma_peri),
+	.peri = s5p6450_pdma_peri,
+};
+
+struct amba_device s5p64x0_device_pdma = {
+	.dev = {
+		.init_name = "dma-pl330",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
+	.res = {
+		.start = S5P64X0_PA_PDMA,
+		.end = S5P64X0_PA_PDMA + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_DMA0, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
 static int __init s5p64x0_dma_init(void)
 {
-	unsigned int id;
-
-	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+	unsigned int id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
 
 	if (id == 0x50000)
 		s5p64x0_device_pdma.dev.platform_data = &s5p6450_pdma_pdata;
 	else
 		s5p64x0_device_pdma.dev.platform_data = &s5p6440_pdma_pdata;
 
-	platform_device_register(&s5p64x0_device_pdma);
+	amba_device_register(&s5p64x0_device_pdma, &iomem_resource);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5p64x0/include/mach/dma.h b/arch/arm/mach-s5p64x0/include/mach/dma.h
index 1beae2c..5a622af 100644
--- a/arch/arm/mach-s5p64x0/include/mach/dma.h
+++ b/arch/arm/mach-s5p64x0/include/mach/dma.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_DMA_H
 #define __MACH_DMA_H
 
-/* This platform uses the common S3C DMA API driver for PL330 */
+/* This platform uses the common common DMA API driver for PL330 */
 #include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
-- 
1.7.1
