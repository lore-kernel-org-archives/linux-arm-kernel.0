From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 27 Nov 2017 13:11:39 +0100
Subject: [PATCH] ARM: imx: don't abort MMDC probe if power saving status
 doesn't match
Message-ID: <20171127121139.15584-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power saving status bit will not signal if the MMDC is under load,
which is likely during kernel boot. There is no point in checking this
bit and aborting the probe, as there is nothing depending on power
saving being enabled, so we can trust the memory controller to enable
power saving when we allow it.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/mmdc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 78262899a590..5fb1d2254b5e 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -547,7 +547,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
 	u32 val;
-	int timeout = 0x400;
 
 	mmdc_base = of_iomap(np, 0);
 	WARN_ON(!mmdc_base);
@@ -565,16 +564,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	val &= ~(1 << BP_MMDC_MAPSR_PSD);
 	writel_relaxed(val, reg);
 
-	/* Ensure it's successfully enabled */
-	while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --timeout)
-		cpu_relax();
-
-	if (unlikely(!timeout)) {
-		pr_warn("%s: failed to enable automatic power saving\n",
-			__func__);
-		return -EBUSY;
-	}
-
 	return imx_mmdc_perf_init(pdev, mmdc_base);
 }
 
-- 
2.11.0
