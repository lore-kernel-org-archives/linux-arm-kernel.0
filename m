From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 Oct 2012 10:59:54 +0100
Subject: [PATCH 2/4] ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of Exynos4210
 SOC
In-Reply-To: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1351504796-24788-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8214513 ("ARM: EXYNOS: fix address for EXYNOS4 MDMA1")
changed EXYNOS specific setup of PL330 DMA engine to use 'non-secure'
mdma1 address instead of 'secure' one (from 0x12840000 to 0x12850000)
to fix issue with some Exynos4212 SOCs.  Unfortunately it brakes
PL330 setup for revision 0 of Exynos4210 SOC (mdma1 device cannot
be found at 'non-secure' address):

[    0.566245] dma-pl330 dma-pl330.2: PERIPH_ID 0x0, PCELL_ID 0x0 !
[    0.566278] dma-pl330: probe of dma-pl330.2 failed with error -22

Fix it by using 'secure' mdma1 address on Exynos4210 revision 0 SOC.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/dma.c              | 5 ++++-
 arch/arm/mach-exynos/include/mach/map.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index 21d568b..dcc9f74 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -261,7 +261,7 @@ static struct dma_pl330_platdata exynos_mdma1_pdata = {
 };
 
 static AMBA_AHB_DEVICE(exynos_mdma1,  "dma-pl330.2", 0x00041330,
-	EXYNOS4_PA_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos_mdma1_pdata);
+	EXYNOS4_PA_NS_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos_mdma1_pdata);
 
 static int __init exynos_dma_init(void)
 {
@@ -275,6 +275,9 @@ static int __init exynos_dma_init(void)
 		exynos_pdma1_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4210_pdma1_peri);
 		exynos_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
+
+		if (samsung_rev() == EXYNOS4210_REV_0)
+			exynos_mdma1_device.res.start = EXYNOS4_PA_S_MDMA1;
 	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
 		exynos_pdma0_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4212_pdma0_peri);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 8480849..0abfe78 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -89,7 +89,8 @@
 #define EXYNOS4_PA_L2CC			0x10502000
 
 #define EXYNOS4_PA_MDMA0		0x10810000
-#define EXYNOS4_PA_MDMA1		0x12850000
+#define EXYNOS4_PA_NS_MDMA1		0x12850000
+#define EXYNOS4_PA_S_MDMA1		0x12840000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 #define EXYNOS5_PA_MDMA0		0x10800000
-- 
1.8.0
