From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:31:33 +0900
Subject: [PATCH v2 3/3] ARM: EXYNOS: add support DMA for EXYNOS4X12 SoC
In-Reply-To: <1329345093-16180-1-git-send-email-kgene.kim@samsung.com>
References: <1329345093-16180-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329345093-16180-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |    3 +
 arch/arm/mach-exynos/dma.c                     |   95 ++++++++++++++++++++++--
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    8 ++
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 5d602f6..5e0a456 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -41,6 +41,7 @@ config SOC_EXYNOS4212
 	bool "SAMSUNG EXYNOS4212"
 	default y
 	depends on ARCH_EXYNOS4
+	select SAMSUNG_DMADEV
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	help
@@ -50,6 +51,7 @@ config SOC_EXYNOS4412
 	bool "SAMSUNG EXYNOS4412"
 	default y
 	depends on ARCH_EXYNOS4
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4412 SoC support
 
@@ -333,6 +335,7 @@ config MACH_SMDK4212
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C7
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index 17a2f90..13607c4 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -29,6 +29,7 @@
 #include <asm/irq.h>
 #include <plat/devs.h>
 #include <plat/irqs.h>
+#include <plat/cpu.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
@@ -36,7 +37,7 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-static u8 pdma0_peri[] = {
+static u8 exynos4210_pdma0_peri[] = {
 	DMACH_PCM0_RX,
 	DMACH_PCM0_TX,
 	DMACH_PCM2_RX,
@@ -69,15 +70,47 @@ static u8 pdma0_peri[] = {
 	DMACH_AC97_PCMOUT,
 };
 
-static struct dma_pl330_platdata exynos4_pdma0_pdata = {
-	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
-	.peri_id = pdma0_peri,
+static u8 exynos4212_pdma0_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM2_RX,
+	DMACH_PCM2_TX,
+	DMACH_MIPI_HSI0,
+	DMACH_MIPI_HSI1,
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
+	DMACH_MIPI_HSI4,
+	DMACH_MIPI_HSI5,
 };
 
+struct dma_pl330_platdata exynos4_pdma0_pdata;
+
 static AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
 	EXYNOS4_PA_PDMA0, {IRQ_PDMA0}, &exynos4_pdma0_pdata);
 
-static u8 pdma1_peri[] = {
+static u8 exynos4210_pdma1_peri[] = {
 	DMACH_PCM0_RX,
 	DMACH_PCM0_TX,
 	DMACH_PCM1_RX,
@@ -105,11 +138,41 @@ static u8 pdma1_peri[] = {
 	DMACH_SLIMBUS5_TX,
 };
 
-static struct dma_pl330_platdata exynos4_pdma1_pdata = {
-	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
-	.peri_id = pdma1_peri,
+static u8 exynos4212_pdma1_peri[] = {
+	DMACH_PCM0_RX,
+	DMACH_PCM0_TX,
+	DMACH_PCM1_RX,
+	DMACH_PCM1_TX,
+	DMACH_MIPI_HSI2,
+	DMACH_MIPI_HSI3,
+	DMACH_SPI1_RX,
+	DMACH_SPI1_TX,
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
+	DMACH_SPDIF,
+	DMACH_MIPI_HSI6,
+	DMACH_MIPI_HSI7,
 };
 
+static struct dma_pl330_platdata exynos4_pdma1_pdata;
+
 static AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
 	EXYNOS4_PA_PDMA1, {IRQ_PDMA1}, &exynos4_pdma1_pdata);
 
@@ -137,6 +200,22 @@ static int __init exynos4_dma_init(void)
 	if (of_have_populated_dt())
 		return 0;
 
+	if (soc_is_exynos4210()) {
+		exynos4_pdma0_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos4210_pdma0_peri);
+		exynos4_pdma0_pdata.peri_id = exynos4210_pdma0_peri;
+		exynos4_pdma1_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos4210_pdma1_peri);
+		exynos4_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
+	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
+		exynos4_pdma0_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos4212_pdma0_peri);
+		exynos4_pdma0_pdata.peri_id = exynos4212_pdma0_peri;
+		exynos4_pdma1_pdata.nr_valid_peri =
+			ARRAY_SIZE(exynos4212_pdma1_peri);
+		exynos4_pdma1_pdata.peri_id = exynos4212_pdma1_peri;
+	}
+
 	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
 	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos4_pdma0_device, &iomem_resource);
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index ecf23a8..0670f37 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -82,6 +82,14 @@ enum dma_ch {
 	DMACH_SLIMBUS4_TX,
 	DMACH_SLIMBUS5_RX,
 	DMACH_SLIMBUS5_TX,
+	DMACH_MIPI_HSI0,
+	DMACH_MIPI_HSI1,
+	DMACH_MIPI_HSI2,
+	DMACH_MIPI_HSI3,
+	DMACH_MIPI_HSI4,
+	DMACH_MIPI_HSI5,
+	DMACH_MIPI_HSI6,
+	DMACH_MIPI_HSI7,
 	DMACH_MTOM_0,
 	DMACH_MTOM_1,
 	DMACH_MTOM_2,
-- 
1.7.4.4
