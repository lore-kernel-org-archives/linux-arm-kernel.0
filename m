From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:36 +0900
Subject: [PATCH v8 08/16] ARM: EXYNOS4: Use generic DMA PL330 driver
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-9-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes Samsung EXYNOS4 to use DMA PL330 driver
on DMADEVICE. The EXYNOS4 uses DMA generic APIs instead of
SAMSUNG specific S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig |    2 +-
 arch/arm/mach-exynos4/clock.c |   11 ++-
 arch/arm/mach-exynos4/dma.c   |  299 ++++++++++++++++++++++++++---------------
 3 files changed, 198 insertions(+), 114 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 0c77ab9..9f00cf3 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -11,7 +11,7 @@ if ARCH_EXYNOS4
 
 config CPU_EXYNOS4210
 	bool
-	select S3C_PL330_DMA
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 851dea0..fee2dd8 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -43,6 +43,11 @@ static struct clk clk_sclk_usbphy1 = {
 	.name		= "sclk_usbphy1",
 };
 
+static struct clk dummy_apb_pclk = {
+	.name		= "apb_pclk",
+	.id		= -1,
+};
+
 static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
@@ -454,12 +459,12 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.0",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
-		.name		= "pdma",
+		.name		= "dma",
 		.devname	= "s3c-pl330.1",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 1),
@@ -1210,5 +1215,7 @@ void __init exynos4_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clock(&dummy_apb_pclk);
+
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
index 564bb53..d57d662 100644
--- a/arch/arm/mach-exynos4/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -21,151 +21,228 @@
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
 
-static struct resource exynos4_pdma0_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_PDMA0,
-		.end	= EXYNOS4_PA_PDMA0 + SZ_4K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PDMA0,
-		.end	= IRQ_PDMA0,
-		.flags	= IORESOURCE_IRQ,
+struct dma_pl330_peri pdma0_peri[28] = {
+	{
+		.peri_id = (u8)DMACH_PCM0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_PCM2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_PCM2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ0,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ2,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0S_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_UART4_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART4_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS2_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS2_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS4_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS4_TX,
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
 	},
 };
 
-static struct s3c_pl330_platdata exynos4_pdma0_pdata = {
-	.peri = {
-		[0] = DMACH_PCM0_RX,
-		[1] = DMACH_PCM0_TX,
-		[2] = DMACH_PCM2_RX,
-		[3] = DMACH_PCM2_TX,
-		[4] = DMACH_MSM_REQ0,
-		[5] = DMACH_MSM_REQ2,
-		[6] = DMACH_SPI0_RX,
-		[7] = DMACH_SPI0_TX,
-		[8] = DMACH_SPI2_RX,
-		[9] = DMACH_SPI2_TX,
-		[10] = DMACH_I2S0S_TX,
-		[11] = DMACH_I2S0_RX,
-		[12] = DMACH_I2S0_TX,
-		[13] = DMACH_I2S2_RX,
-		[14] = DMACH_I2S2_TX,
-		[15] = DMACH_UART0_RX,
-		[16] = DMACH_UART0_TX,
-		[17] = DMACH_UART2_RX,
-		[18] = DMACH_UART2_TX,
-		[19] = DMACH_UART4_RX,
-		[20] = DMACH_UART4_TX,
-		[21] = DMACH_SLIMBUS0_RX,
-		[22] = DMACH_SLIMBUS0_TX,
-		[23] = DMACH_SLIMBUS2_RX,
-		[24] = DMACH_SLIMBUS2_TX,
-		[25] = DMACH_SLIMBUS4_RX,
-		[26] = DMACH_SLIMBUS4_TX,
-		[27] = DMACH_AC97_MICIN,
-		[28] = DMACH_AC97_PCMIN,
-		[29] = DMACH_AC97_PCMOUT,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
-	},
+struct dma_pl330_platdata exynos4_pdma0_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
+	.peri = pdma0_peri,
 };
 
-static struct platform_device exynos4_device_pdma0 = {
-	.name		= "s3c-pl330",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(exynos4_pdma0_resource),
-	.resource	= exynos4_pdma0_resource,
-	.dev		= {
+struct amba_device exynos4_device_pdma0 = {
+	.dev = {
+		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &exynos4_pdma0_pdata,
 	},
+	.res = {
+		.start = EXYNOS4_PA_PDMA0,
+		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_PDMA0, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
-static struct resource exynos4_pdma1_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_PDMA1,
-		.end	= EXYNOS4_PA_PDMA1 + SZ_4K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PDMA1,
-		.end	= IRQ_PDMA1,
-		.flags	= IORESOURCE_IRQ,
+struct dma_pl330_peri pdma1_peri[25] = {
+	{
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
+		.peri_id = (u8)DMACH_MSM_REQ1,
+	}, {
+		.peri_id = (u8)DMACH_MSM_REQ3,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SPI1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0S_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S0_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_I2S1_TX,
+		.rqtype = MEMTODEV,
+	}, {
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
+		.peri_id = (u8)DMACH_UART3_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_UART3_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS1_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS1_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS3_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS3_TX,
+		.rqtype = MEMTODEV,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS5_RX,
+		.rqtype = DEVTOMEM,
+	}, {
+		.peri_id = (u8)DMACH_SLIMBUS5_TX,
+		.rqtype = MEMTODEV,
 	},
 };
 
-static struct s3c_pl330_platdata exynos4_pdma1_pdata = {
-	.peri = {
-		[0] = DMACH_PCM0_RX,
-		[1] = DMACH_PCM0_TX,
-		[2] = DMACH_PCM1_RX,
-		[3] = DMACH_PCM1_TX,
-		[4] = DMACH_MSM_REQ1,
-		[5] = DMACH_MSM_REQ3,
-		[6] = DMACH_SPI1_RX,
-		[7] = DMACH_SPI1_TX,
-		[8] = DMACH_I2S0S_TX,
-		[9] = DMACH_I2S0_RX,
-		[10] = DMACH_I2S0_TX,
-		[11] = DMACH_I2S1_RX,
-		[12] = DMACH_I2S1_TX,
-		[13] = DMACH_UART0_RX,
-		[14] = DMACH_UART0_TX,
-		[15] = DMACH_UART1_RX,
-		[16] = DMACH_UART1_TX,
-		[17] = DMACH_UART3_RX,
-		[18] = DMACH_UART3_TX,
-		[19] = DMACH_SLIMBUS1_RX,
-		[20] = DMACH_SLIMBUS1_TX,
-		[21] = DMACH_SLIMBUS3_RX,
-		[22] = DMACH_SLIMBUS3_TX,
-		[23] = DMACH_SLIMBUS5_RX,
-		[24] = DMACH_SLIMBUS5_TX,
-		[25] = DMACH_SLIMBUS0AUX_RX,
-		[26] = DMACH_SLIMBUS0AUX_TX,
-		[27] = DMACH_SPDIF,
-		[28] = DMACH_MAX,
-		[29] = DMACH_MAX,
-		[30] = DMACH_MAX,
-		[31] = DMACH_MAX,
-	},
+struct dma_pl330_platdata exynos4_pdma1_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
+	.peri = pdma1_peri,
 };
 
-static struct platform_device exynos4_device_pdma1 = {
-	.name		= "s3c-pl330",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(exynos4_pdma1_resource),
-	.resource	= exynos4_pdma1_resource,
-	.dev		= {
+struct amba_device exynos4_device_pdma1 = {
+	.dev = {
+		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &exynos4_pdma1_pdata,
 	},
-};
-
-static struct platform_device *exynos4_dmacs[] __initdata = {
-	&exynos4_device_pdma0,
-	&exynos4_device_pdma1,
+	.res = {
+		.start = EXYNOS4_PA_PDMA1,
+		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_PDMA1, NO_IRQ},
+	.periphid = 0x00041330,
 };
 
 static int __init exynos4_dma_init(void)
 {
-	platform_add_devices(exynos4_dmacs, ARRAY_SIZE(exynos4_dmacs));
+	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
 
 	return 0;
 }
-- 
1.7.1
