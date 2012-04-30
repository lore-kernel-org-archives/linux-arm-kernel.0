From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:12 -0700
Subject: [PATCH 02/20] ARM: EXYNOS: Support DMA for EXYNOS5250 SoC
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

mach-exynos/dma.c is updated to support both exynos4 and exynos5.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
[kgene.kim at samsung.com: re-worked on top of v3.4-rc3]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |    7 +-
 arch/arm/mach-exynos/Makefile                  |    2 +-
 arch/arm/mach-exynos/dma.c                     |  129 ++++++++++++++++++++----
 arch/arm/plat-samsung/Kconfig                  |    2 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    1 +
 5 files changed, 115 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e81c35f..fbad6f1 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -61,6 +61,7 @@ config SOC_EXYNOS5250
 	bool "SAMSUNG EXYNOS5250"
 	default y
 	depends on ARCH_EXYNOS5
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS5250 SoC support
 
@@ -70,7 +71,7 @@ config EXYNOS4_MCT
 	help
 	  Use MCT (Multi Core Timer) as kernel timers
 
-config EXYNOS4_DEV_DMA
+config EXYNOS_DEV_DMA
 	bool
 	help
 	  Compile in amba device definitions for DMA controller
@@ -223,7 +224,7 @@ config MACH_ARMLEX4210
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select EXYNOS4_DEV_AHCI
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_SDHCI
 	help
@@ -345,7 +346,7 @@ config MACH_SMDK4212
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C7
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 8631840..839e78f 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
-obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
+obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
 obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index 69aaa45..4ebe2ab 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -103,10 +103,45 @@ static u8 exynos4212_pdma0_peri[] = {
 	DMACH_MIPI_HSI5,
 };
 
-struct dma_pl330_platdata exynos4_pdma0_pdata;
+static u8 exynos5250_pdma0_peri[] = {
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
+
+static struct dma_pl330_platdata exynos_pdma0_pdata;
 
 static AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
-	EXYNOS4_PA_PDMA0, {EXYNOS4_IRQ_PDMA0}, &exynos4_pdma0_pdata);
+	EXYNOS4_PA_PDMA0, {EXYNOS4_IRQ_PDMA0}, &exynos_pdma0_pdata);
 
 static u8 exynos4210_pdma1_peri[] = {
 	DMACH_PCM0_RX,
@@ -169,10 +204,45 @@ static u8 exynos4212_pdma1_peri[] = {
 	DMACH_MIPI_HSI7,
 };
 
-static struct dma_pl330_platdata exynos4_pdma1_pdata;
+static u8 exynos5250_pdma1_peri[] = {
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
+static struct dma_pl330_platdata exynos_pdma1_pdata;
 
 static AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
-	EXYNOS4_PA_PDMA1, {EXYNOS4_IRQ_PDMA1}, &exynos4_pdma1_pdata);
+	EXYNOS4_PA_PDMA1, {EXYNOS4_IRQ_PDMA1}, &exynos_pdma1_pdata);
 
 static u8 mdma_peri[] = {
 	DMACH_MTOM_0,
@@ -185,46 +255,63 @@ static u8 mdma_peri[] = {
 	DMACH_MTOM_7,
 };
 
-static struct dma_pl330_platdata exynos4_mdma1_pdata = {
+static struct dma_pl330_platdata exynos_mdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
 	.peri_id = mdma_peri,
 };
 
 static AMBA_AHB_DEVICE(exynos4_mdma1,  "dma-pl330.2", 0x00041330,
-	EXYNOS4_PA_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos4_mdma1_pdata);
+	EXYNOS4_PA_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos_mdma1_pdata);
 
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
+
+		exynos4_pdma0_device.res.start = EXYNOS5_PA_PDMA0;
+		exynos4_pdma0_device.res.end = EXYNOS5_PA_PDMA0 + SZ_4K;
+		exynos4_pdma0_device.irq[0] = EXYNOS5_IRQ_PDMA0;
+		exynos4_pdma1_device.res.start = EXYNOS5_PA_PDMA1;
+		exynos4_pdma1_device.res.end = EXYNOS5_PA_PDMA1 + SZ_4K;
+		exynos4_pdma0_device.irq[0] = EXYNOS5_IRQ_PDMA1;
+		exynos4_mdma1_device.res.start = EXYNOS5_PA_MDMA1;
+		exynos4_mdma1_device.res.end = EXYNOS5_PA_MDMA1 + SZ_4K;
+		exynos4_pdma0_device.irq[0] = EXYNOS5_IRQ_MDMA1;
 	}
 
-	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
-	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_SLAVE, exynos_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos4_pdma0_device, &iomem_resource);
 
-	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
-	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_SLAVE, exynos_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma1_pdata.cap_mask);
 	amba_device_register(&exynos4_pdma1_device, &iomem_resource);
 
-	dma_cap_set(DMA_MEMCPY, exynos4_mdma1_pdata.cap_mask);
+	dma_cap_set(DMA_MEMCPY, exynos_mdma1_pdata.cap_mask);
 	amba_device_register(&exynos4_mdma1_device, &iomem_resource);
 
 	return 0;
 }
-arch_initcall(exynos4_dma_init);
+arch_initcall(exynos_dma_init);
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a0ffc77d..77e65b4 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -291,7 +291,7 @@ config S3C_DMA
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
1.7.5.4
