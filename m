From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Feb 2012 20:33:40 +0900
Subject: [PATCH v2] ARM: EXYNOS: Support DMA for Exynos5250 SoC
Message-ID: <00b801ccf08c$a902ea50$fb08bef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

mach-exynos/dma.c is updated to support both exynos4 and exynos5.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- updated latest for-next and arm-soc/depends/rmk/for-armsoc

 arch/arm/mach-exynos/Kconfig                   |    8 +-
 arch/arm/mach-exynos/Makefile                  |    2 +-
 arch/arm/mach-exynos/dma.c                     |  143 +++++++++++++++++++-----
 arch/arm/mach-exynos/include/mach/map.h        |    4 +
 arch/arm/plat-samsung/Kconfig                  |    2 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    1 +
 6 files changed, 126 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 88c0a4d..ad705b4 100644
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
@@ -231,7 +232,7 @@ config MACH_ARMLEX4210
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select EXYNOS4_DEV_AHCI
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_SDHCI
 	help
@@ -348,7 +349,7 @@ config MACH_SMDK4212
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select EXYNOS4_DEV_DMA
+	select EXYNOS_DEV_DMA
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C7
@@ -374,6 +375,7 @@ comment "EXYNOS5250 Boards"
 config MACH_SMDK5250
 	bool "SMDK5250"
 	select SOC_EXYNOS5250
+	select EXYNOS_DEV_DMA
 	help
 	  Machine support for Samsung SMDK5250
 endif
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 32676af..08b4eb1 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -54,7 +54,7 @@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
-obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
+obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
 obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index 13607c4..ded6ff1 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -35,8 +35,6 @@
 #include <mach/irqs.h>
 #include <mach/dma.h>
 
-static u64 dma_dmamask = DMA_BIT_MASK(32);
-
 static u8 exynos4210_pdma0_peri[] = {
 	DMACH_PCM0_RX,
 	DMACH_PCM0_TX,
@@ -105,10 +103,45 @@ static u8 exynos4212_pdma0_peri[] = {
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
 
-static AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
-	EXYNOS4_PA_PDMA0, {IRQ_PDMA0}, &exynos4_pdma0_pdata);
+static AMBA_AHB_DEVICE(exynos_pdma0, "dma-pl330.0", 0x00041330, 0,
+	{IRQ_PDMA0}, &exynos_pdma0_pdata);
 
 static u8 exynos4210_pdma1_peri[] = {
 	DMACH_PCM0_RX,
@@ -171,10 +204,45 @@ static u8 exynos4212_pdma1_peri[] = {
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
 
-static AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
-	EXYNOS4_PA_PDMA1, {IRQ_PDMA1}, &exynos4_pdma1_pdata);
+static AMBA_AHB_DEVICE(exynos_pdma1,  "dma-pl330.1", 0x00041330, 0,
+	{IRQ_PDMA1}, &exynos_pdma1_pdata);
 
 static u8 mdma_peri[] = {
 	DMACH_MTOM_0,
@@ -187,46 +255,63 @@ static u8 mdma_peri[] = {
 	DMACH_MTOM_7,
 };
 
-static struct dma_pl330_platdata exynos4_mdma1_pdata = {
+static struct dma_pl330_platdata exynos_mdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
 	.peri_id = mdma_peri,
 };
 
-static AMBA_AHB_DEVICE(exynos4_mdma1,  "dma-pl330.2", 0x00041330,
-	EXYNOS4_PA_MDMA1, {IRQ_MDMA1}, &exynos4_mdma1_pdata);
+static AMBA_AHB_DEVICE(exynos_mdma1,  "dma-pl330.2", 0x00041330, 0,
+	{IRQ_MDMA1}, &exynos_mdma1_pdata);
 
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
-	amba_device_register(&exynos4_pdma0_device, &iomem_resource);
+	exynos_pdma0_device.res.start = soc_is_exynos5250() ?
+		EXYNOS5_PA_PDMA0 : EXYNOS4_PA_PDMA0;
+	exynos_pdma0_device.res.end = exynos_pdma0_device.res.start + SZ_4K;
+	exynos_pdma1_device.res.start = soc_is_exynos5250() ?
+		EXYNOS5_PA_PDMA1 : EXYNOS4_PA_PDMA1;
+	exynos_pdma1_device.res.end = exynos_pdma1_device.res.start + SZ_4K;
+	exynos_mdma1_device.res.start = soc_is_exynos5250() ?
+		EXYNOS5_PA_MDMA1 : EXYNOS4_PA_MDMA1;
+	exynos_mdma1_device.res.end = exynos_mdma1_device.res.start + SZ_4K;
+
+	dma_cap_set(DMA_SLAVE, exynos_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma0_pdata.cap_mask);
+	amba_device_register(&exynos_pdma0_device, &iomem_resource);
 
-	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
-	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
-	amba_device_register(&exynos4_pdma1_device, &iomem_resource);
+	dma_cap_set(DMA_SLAVE, exynos_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_CYCLIC, exynos_pdma1_pdata.cap_mask);
+	amba_device_register(&exynos_pdma1_device, &iomem_resource);
 
-	dma_cap_set(DMA_MEMCPY, exynos4_mdma1_pdata.cap_mask);
-	amba_device_register(&exynos4_mdma1_device, &iomem_resource);
+	dma_cap_set(DMA_MEMCPY, exynos_mdma1_pdata.cap_mask);
+	amba_device_register(&exynos_mdma1_device, &iomem_resource);
 
 	return 0;
 }
-arch_initcall(exynos4_dma_init);
+arch_initcall(exynos_dma_init);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index bf90bb0..2fe7d7c 100644
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
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 6a2abe6..50efefe 100644
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
1.7.1
