From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Feb 2012 00:57:17 +0900
Subject: [PATCH 3/3] ARM: EXYNOS: Support DMA for EXYNOS5250 SoC
In-Reply-To: <1328025437-5396-1-git-send-email-kgene.kim@samsung.com>
References: <1328025437-5396-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328025437-5396-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |   18 ++--
 arch/arm/mach-exynos/Makefile                  |    2 +-
 arch/arm/mach-exynos/clock-exynos5.c           |   14 +-
 arch/arm/mach-exynos/dma.c                     |  143 ++++++++++++++++++------
 arch/arm/mach-exynos/include/mach/map.h        |   10 ++
 arch/arm/plat-samsung/Kconfig                  |    2 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    1 +
 7 files changed, 140 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0d8677e..745fdfd 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -65,6 +65,7 @@ config SOC_EXYNOS5250
 	bool "SAMSUNG EXYNOS5250"
 	default y
 	depends on ARCH_EXYNOS5
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS5250 SoC support
 
@@ -74,7 +75,7 @@ config EXYNOS4_MCT
 	help
 	  Use MCT (Multi Core Timer) as kernel timers
 
-config EXYNOS4_DEV_DMA
+config EXYNOS_DEV_DMA
 	bool
 	help
 	  Compile in amba device definitions for DMA controller
@@ -209,7 +210,7 @@ config MACH_SMDKV310
 	select SAMSUNG_DEV_BACKLIGHT
 	select EXYNOS4_DEV_AHCI
 	select SAMSUNG_DEV_KEYPAD
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_USB_OHCI
@@ -231,7 +232,7 @@ config MACH_ARMLEX4210
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select EXYNOS4_DEV_AHCI
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_SDHCI
 	help
@@ -257,7 +258,7 @@ config MACH_UNIVERSAL_C210
 	select S5P_DEV_MFC
 	select S5P_DEV_ONENAND
 	select S5P_DEV_TV
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
@@ -291,7 +292,7 @@ config MACH_NURI
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
 	select S5P_SETUP_MIPIPHY
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_FIMC
 	select EXYNOS4_SETUP_FIMD0
@@ -324,7 +325,7 @@ config MACH_ORIGEN
 	select S5P_DEV_USB_EHCI
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_USB_OHCI
 	select EXYNOS4_SETUP_FIMD0
@@ -348,7 +349,7 @@ config MACH_SMDK4212
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C7
@@ -363,7 +364,7 @@ config MACH_SMDK4412
 	bool "SMDK4412"
 	select SOC_EXYNOS4412
 	select MACH_SMDK4212
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	help
 	  Machine support for Samsung SMDK4412
 endif
@@ -375,6 +376,7 @@ comment "EXYNOS5250 Boards"
 config MACH_SMDK5250
 	bool "SMDK5250"
 	select SOC_EXYNOS5250
+	select EXYNOS_DEV_DMA
 	help
 	  Machine support for Samsung SMDK4412
 endif
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 1b12345..eccadc8 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
-obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
+obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
 obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index b0c4478..b43161b 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -681,8 +681,8 @@ static struct clk exynos5_init_clocks_on[] = {
 static struct clk exynos5_clk_pdma0 = {
 	.name		= "dma",
 	.devname	= "dma-pl330.0",
-	.enable		= exynos5_clk_ip_gen_ctrl,
-	.ctrlbit	= (1 << 4),
+	.enable		= exynos5_clk_ip_fsys_ctrl,
+	.ctrlbit	= (1 << 1),
 };
 
 static struct clk exynos5_clk_pdma1 = {
@@ -692,11 +692,11 @@ static struct clk exynos5_clk_pdma1 = {
 	.ctrlbit	= (1 << 1),
 };
 
-static struct clk exynos5_clk_pdma2 = {
+static struct clk exynos5_clk_mdma = {
 	.name		= "dma",
 	.devname	= "dma-pl330.2",
-	.enable		= exynos5_clk_ip_fsys_ctrl,
-	.ctrlbit	= (1 << 1),
+	.enable		= exynos5_clk_ip_gen_ctrl,
+	.ctrlbit	= (1 << 4),
 };
 
 struct clk *exynos5_clkset_group_list[] = {
@@ -982,7 +982,7 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 static struct clk *exynos5_clk_cdev[] = {
 	&exynos5_clk_pdma0,
 	&exynos5_clk_pdma1,
-	&exynos5_clk_pdma2,
+	&exynos5_clk_mdma,
 };
 
 static struct clksrc_clk *exynos5_clksrc_cdev[] = {
@@ -1007,7 +1007,7 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &exynos5_clk_sclk_mmc3.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
-	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_pdma2),
+	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma),
 };
 
 static unsigned long exynos5_epll_get_rate(struct clk *clk)
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index ce645ba..e88e41b 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -105,18 +105,53 @@ u8 exynos4212_pdma0_peri[] = {
 	DMACH_MIPI_HSI5,
 };
 
-struct dma_pl330_platdata exynos4_pdma0_pdata;
+u8 exynos5250_pdma0_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM2_RX,
+	DMACH_PCM2_TX,
+	DMACH_SPI0_RX,
+	DMACH_SPI0_TX,
+	DMACH_SPI2_RX,
+	DMACH_SPI2_TX,
+	DMACH_I2S0S_TX,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S2_RX,
+	DMACH_I2S2_TX,
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART2_RX,
+	DMACH_UART2_TX,
+	DMACH_UART4_RX,
+	DMACH_UART4_TX,
+	DMACH_SLIMBUS0_RX,
+	DMACH_SLIMBUS0_TX,
+	DMACH_SLIMBUS2_RX,
+	DMACH_SLIMBUS2_TX,
+	DMACH_SLIMBUS4_RX,
+	DMACH_SLIMBUS4_TX,
+	DMACH_AC97_MICIN,
+	DMACH_AC97_PCMIN,
+	DMACH_AC97_PCMOUT,
+	DMACH_MIPI_HSI0,
+	DMACH_MIPI_HSI2,
+	DMACH_MIPI_HSI4,
+	DMACH_MIPI_HSI6,
+};
 
-struct amba_device exynos4_device_pdma0 = {
+struct dma_pl330_platdata exynos_pdma0_pdata;
+
+struct amba_device exynos_device_pdma0 = {
 	.dev = {
 		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &exynos4_pdma0_pdata,
+		.platform_data = &exynos_pdma0_pdata,
 	},
 	.res = {
-		.start = EXYNOS4_PA_PDMA0,
-		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
+		.start = EXYNOS_PA_PDMA0,
+		.end = EXYNOS_PA_PDMA0 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_PDMA0, NO_IRQ},
@@ -184,18 +219,53 @@ u8 exynos4212_pdma1_peri[] = {
 	DMACH_MIPI_HSI7,
 };
 
-struct dma_pl330_platdata exynos4_pdma1_pdata;
+u8 exynos5250_pdma1_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM1_RX,
+	DMACH_PCM1_TX,
+	DMACH_SPI1_RX,
+	DMACH_SPI1_TX,
+	DMACH_PWM,
+	DMACH_SPDIF,
+	DMACH_I2S0S_TX,
+	DMACH_I2S0_RX,
+	DMACH_I2S0_TX,
+	DMACH_I2S1_RX,
+	DMACH_I2S1_TX,
+	DMACH_UART0_RX,
+	DMACH_UART0_TX,
+	DMACH_UART1_RX,
+	DMACH_UART1_TX,
+	DMACH_UART3_RX,
+	DMACH_UART3_TX,
+	DMACH_SLIMBUS1_RX,
+	DMACH_SLIMBUS1_TX,
+	DMACH_SLIMBUS3_RX,
+	DMACH_SLIMBUS3_TX,
+	DMACH_SLIMBUS5_RX,
+	DMACH_SLIMBUS5_TX,
+	DMACH_SLIMBUS0AUX_RX,
+	DMACH_SLIMBUS0AUX_TX,
+	DMACH_DISP1,
+	DMACH_MIPI_HSI1,
+	DMACH_MIPI_HSI3,
+	DMACH_MIPI_HSI5,
+	DMACH_MIPI_HSI7,
+};
+
+struct dma_pl330_platdata exynos_pdma1_pdata;
 
-struct amba_device exynos4_device_pdma1 = {
+struct amba_device exynos_device_pdma1 = {
 	.dev = {
 		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &exynos4_pdma1_pdata,
+		.platform_data = &exynos_pdma1_pdata,
 	},
 	.res = {
-		.start = EXYNOS4_PA_PDMA1,
-		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
+		.start = EXYNOS_PA_PDMA1,
+		.end = EXYNOS_PA_PDMA1 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_PDMA1, NO_IRQ},
@@ -213,59 +283,66 @@ u8 mdma_peri[] = {
 	DMACH_MTOM_7,
 };
 
-struct dma_pl330_platdata exynos4_mdma_pdata = {
+struct dma_pl330_platdata exynos_mdma_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
 	.peri_id = mdma_peri,
 };
 
-struct amba_device exynos4_device_mdma = {
+struct amba_device exynos_device_mdma = {
 	.dev = {
 		.init_name = "dma-pl330.2",
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &exynos4_mdma_pdata,
+		.platform_data = &exynos_mdma_pdata,
 	},
 	.res = {
-		.start = EXYNOS4_PA_MDMA1,
-		.end = EXYNOS4_PA_MDMA1 + SZ_4K,
+		.start = EXYNOS_PA_MDMA1,
+		.end = EXYNOS_PA_MDMA1 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_MDMA1, NO_IRQ},
 	.periphid = 0x00041330,
 };
 
-static int __init exynos4_dma_init(void)
+static int __init exynos_dma_init(void)
 {
 	if (of_have_populated_dt())
 		return 0;
 
 	if (soc_is_exynos4210()) {
-		exynos4_pdma0_pdata.nr_valid_peri =
+		exynos_pdma0_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4210_pdma0_peri);
-		exynos4_pdma0_pdata.peri_id = exynos4210_pdma0_peri;
-		exynos4_pdma1_pdata.nr_valid_peri =
+		exynos_pdma0_pdata.peri_id = exynos4210_pdma0_peri;
+		exynos_pdma1_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4210_pdma1_peri);
-		exynos4_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
+		exynos_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
 	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
-		exynos4_pdma0_pdata.nr_valid_peri =
+		exynos_pdma0_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4212_pdma0_peri);
-		exynos4_pdma0_pdata.peri_id = exynos4212_pdma0_peri;
-		exynos4_pdma1_pdata.nr_valid_peri =
+		exynos_pdma0_pdata.peri_id = exynos4212_pdma0_peri;
+		exynos_pdma1_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4212_pdma1_peri);
-		exynos4_pdma1_pdata.peri_id = exynos4212_pdma1_peri;
+		exynos_pdma1_pdata.peri_id = exynos4212_pdma1_peri;
+	} else if (soc_is_exynos5250()) {
+		exynos_pdma0_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos5250_pdma0_peri);
+		exynos_pdma0_pdata.peri_id = exynos5250_pdma0_peri;
+		exynos_pdma1_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos5250_pdma1_peri);
+		exynos_pdma1_pdata.peri_id = exynos5250_pdma1_peri;
 	}
 
-	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
-	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
-	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
+	dma_cap_set(DMA_SLAVE, exynos_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma0_pdata.cap_mask);
+	amba_device_register(&exynos_device_pdma0, &iomem_resource);
 
-	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
-	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
-	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
+	dma_cap_set(DMA_SLAVE, exynos_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma1_pdata.cap_mask);
+	amba_device_register(&exynos_device_pdma1, &iomem_resource);
 
-	dma_cap_set(DMA_MEMCPY, exynos4_mdma_pdata.cap_mask);
-	amba_device_register(&exynos4_device_mdma, &iomem_resource);
+	dma_cap_set(DMA_MEMCPY, exynos_mdma_pdata.cap_mask);
+	amba_device_register(&exynos_device_mdma, &iomem_resource);
 
 	return 0;
 }
-arch_initcall(exynos4_dma_init);
+arch_initcall(exynos_dma_init);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 0691ca8..35a696d 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -84,6 +84,10 @@
 #define EXYNOS4_PA_MDMA1		0x12840000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
+#define EXYNOS5_PA_MDMA0		0x10800000
+#define EXYNOS5_PA_MDMA1		0x11c10000
+#define EXYNOS5_PA_PDMA0		0x121a0000
+#define EXYNOS5_PA_PDMA1		0x121b0000
 
 #define EXYNOS4_PA_SYSMMU_MDMA		0x10A40000
 #define EXYNOS4_PA_SYSMMU_SSS		0x10A50000
@@ -206,10 +210,16 @@
 
 #ifdef CONFIG_ARCH_EXYNOS4
 #define S3C_PA_UART			EXYNOS4_PA_UART
+#define EXYNOS_PA_PDMA0			EXYNOS4_PA_PDMA0
+#define EXYNOS_PA_PDMA1			EXYNOS4_PA_PDMA1
+#define EXYNOS_PA_MDMA1			EXYNOS4_PA_MDMA1
 #endif
 
 #ifdef CONFIG_ARCH_EXYNOS5
 #define S3C_PA_UART			EXYNOS5_PA_UART
+#define EXYNOS_PA_PDMA0			EXYNOS5_PA_PDMA0
+#define EXYNOS_PA_PDMA1			EXYNOS5_PA_PDMA1
+#define EXYNOS_PA_MDMA1			EXYNOS5_PA_MDMA1
 #endif
 
 #define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 0a23b52..88e6a4f 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -298,7 +298,7 @@ config S3C_DMA
 config SAMSUNG_DMADEV
 	bool
 	select DMADEVICES
-	select PL330_DMA if (CPU_EXYNOS4210 || CPU_S5PV210 || CPU_S5PC100 || \
+	select PL330_DMA if (ARCH_EXYNOS5 || ARCH_EXYNOS4 || CPU_S5PV210 || CPU_S5PC100 || \
 					CPU_S5P6450 || CPU_S5P6440)
 	select ARM_AMBA
 	help
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index 0670f37..d384a80 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -90,6 +90,7 @@ enum dma_ch {
 	DMACH_MIPI_HSI5,
 	DMACH_MIPI_HSI6,
 	DMACH_MIPI_HSI7,
+	DMACH_DISP1,
 	DMACH_MTOM_0,
 	DMACH_MTOM_1,
 	DMACH_MTOM_2,
-- 
1.7.4.4
