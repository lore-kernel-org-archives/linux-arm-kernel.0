From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:31:31 +0900
Subject: [PATCH v2 1/3] ARM: EXYNOS: Enable MDMA driver
In-Reply-To: <1329345093-16180-1-git-send-email-kgene.kim@samsung.com>
References: <1329345093-16180-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329345093-16180-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds MDMA platform data and enables
MDMA for DMA memcpy operation for EXYNOS SoCs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4.c           |    8 ++++++++
 arch/arm/mach-exynos/dma.c                     |   22 ++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/irqs.h       |    2 ++
 arch/arm/mach-exynos/include/mach/map.h        |    3 ++-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    8 ++++++++
 5 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index c83da54..a61006d 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -785,6 +785,13 @@ static struct clk exynos4_clk_pdma1 = {
 	.ctrlbit	= (1 << 1),
 };
 
+static struct clk exynos4_clk_mdma1 = {
+	.name		= "dma",
+	.devname	= "dma-pl330.2",
+	.enable		= exynos4_clk_ip_image_ctrl,
+	.ctrlbit	= ((1 << 8) | (1 << 5) | (1 << 2)),
+};
+
 struct clk *exynos4_clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
@@ -1303,6 +1310,7 @@ static struct clksrc_clk *exynos4_sysclks[] = {
 static struct clk *exynos4_clk_cdev[] = {
 	&exynos4_clk_pdma0,
 	&exynos4_clk_pdma1,
+	&exynos4_clk_mdma1,
 };
 
 static struct clksrc_clk *exynos4_clksrc_cdev[] = {
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index 25f3ef2..17a2f90 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -113,6 +113,25 @@ static struct dma_pl330_platdata exynos4_pdma1_pdata = {
 static AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
 	EXYNOS4_PA_PDMA1, {IRQ_PDMA1}, &exynos4_pdma1_pdata);
 
+static u8 mdma_peri[] = {
+	DMACH_MTOM_0,
+	DMACH_MTOM_1,
+	DMACH_MTOM_2,
+	DMACH_MTOM_3,
+	DMACH_MTOM_4,
+	DMACH_MTOM_5,
+	DMACH_MTOM_6,
+	DMACH_MTOM_7,
+};
+
+static struct dma_pl330_platdata exynos4_mdma1_pdata = {
+	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
+	.peri_id = mdma_peri,
+};
+
+static AMBA_AHB_DEVICE(exynos4_mdma1,  "dma-pl330.2", 0x00041330,
+	EXYNOS4_PA_MDMA1, {IRQ_MDMA1}, &exynos4_mdma1_pdata);
+
 static int __init exynos4_dma_init(void)
 {
 	if (of_have_populated_dt())
@@ -126,6 +145,9 @@ static int __init exynos4_dma_init(void)
 	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
 	amba_device_register(&exynos4_pdma1_device, &iomem_resource);
 
+	dma_cap_set(DMA_MEMCPY, exynos4_mdma1_pdata.cap_mask);
+	amba_device_register(&exynos4_mdma1_device, &iomem_resource);
+
 	return 0;
 }
 arch_initcall(exynos4_dma_init);
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index f77bce0..1d401c9 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -43,6 +43,8 @@
 #define IRQ_EINT15		IRQ_SPI(31)
 #define IRQ_EINT16_31		IRQ_SPI(32)
 
+#define IRQ_MDMA0		IRQ_SPI(33)
+#define IRQ_MDMA1		IRQ_SPI(34)
 #define IRQ_PDMA0		IRQ_SPI(35)
 #define IRQ_PDMA1		IRQ_SPI(36)
 #define IRQ_TIMER0_VIC		IRQ_SPI(37)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c754a22..2ad4e9c 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -67,7 +67,8 @@
 #define EXYNOS4_PA_TWD			0x10500600
 #define EXYNOS4_PA_L2CC			0x10502000
 
-#define EXYNOS4_PA_MDMA			0x10810000
+#define EXYNOS4_PA_MDMA0		0x10810000
+#define EXYNOS4_PA_MDMA1		0x12840000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index c5eaad5..ecf23a8 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -82,6 +82,14 @@ enum dma_ch {
 	DMACH_SLIMBUS4_TX,
 	DMACH_SLIMBUS5_RX,
 	DMACH_SLIMBUS5_TX,
+	DMACH_MTOM_0,
+	DMACH_MTOM_1,
+	DMACH_MTOM_2,
+	DMACH_MTOM_3,
+	DMACH_MTOM_4,
+	DMACH_MTOM_5,
+	DMACH_MTOM_6,
+	DMACH_MTOM_7,
 	/* END Marker, also used to denote a reserved channel */
 	DMACH_MAX,
 };
-- 
1.7.4.4
