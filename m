From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 May 2017 15:51:35 -0700
Subject: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Message-ID: <20170531225139.30723-8-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -334,20 +334,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
 	p.errata = configure_dma_errata();
 
-	if (!of_have_populated_dt()) {
-		if (soc_is_omap24xx()) {
-			p.slave_map = omap24xx_sdma_map;
-			p.slavecnt = ARRAY_SIZE(omap24xx_sdma_map);
-		} else if (soc_is_omap34xx() || soc_is_omap3630()) {
-			p.slave_map = omap3xxx_sdma_map;
-			p.slavecnt = ARRAY_SIZE(omap3xxx_sdma_map);
-		} else {
-			pr_err("%s: The legacy DMA map is not provided!\n",
-			       __func__);
-			return -ENODEV;
-		}
-	}
-
 	pdev = omap_device_build(name, 0, oh, &p, sizeof(p));
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
@@ -389,21 +375,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 static int __init omap2_system_dma_init(void)
 {
-	struct platform_device *pdev;
-	int res;
-
-	res = omap_hwmod_for_each_by_class("dma",
+	return omap_hwmod_for_each_by_class("dma",
 			omap2_system_dma_init_dev, NULL);
-	if (res)
-		return res;
-
-	if (of_have_populated_dt())
-		return res;
-
-	pdev = platform_device_register_full(&omap_dma_dev_info);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return res;
 }
 omap_arch_initcall(omap2_system_dma_init);
-- 
2.13.0
