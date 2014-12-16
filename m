From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 16 Dec 2014 18:20:55 +0200
Subject: [PATCH 10/11] ARM: OMAP3: use clock data from TI clock driver for
 legacy boot
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Message-ID: <1418746856-17173-11-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the clock data is now available for the legacy boot also from the
clock driver, use this rather than the data under the mach folder.
This allows us to get rid of the old clock data completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 03cbb16..7295943 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -459,7 +459,17 @@ void __init omap3_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_soc_init = omap3xxx_clk_init;
+	if (!of_have_populated_dt()) {
+		omap3_prcm_legacy_iomaps_init();
+		if (soc_is_am35xx())
+			omap_clk_soc_init = am35xx_clk_legacy_init;
+		else if (cpu_is_omap3630())
+			omap_clk_soc_init = omap36xx_clk_legacy_init;
+		else if (omap_rev() == OMAP3430_REV_ES1_0)
+			omap_clk_soc_init = omap3430es1_clk_legacy_init;
+		else
+			omap_clk_soc_init = omap3430_clk_legacy_init;
+	}
 }
 
 void __init omap3430_init_early(void)
@@ -507,8 +517,6 @@ void __init ti81xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = ti81xx_dt_clk_init;
-	else
-		omap_clk_soc_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
@@ -722,15 +730,17 @@ int __init omap_clk_init(void)
 
 	ti_clk_init_features();
 
-	ret = of_prcm_init();
-	if (ret)
-		return ret;
+	if (of_have_populated_dt()) {
+		ret = of_prcm_init();
+		if (ret)
+			return ret;
 
-	of_clk_init(NULL);
+		of_clk_init(NULL);
 
-	ti_dt_clk_init_retry_clks();
+		ti_dt_clk_init_retry_clks();
 
-	ti_dt_clockdomains_setup();
+		ti_dt_clockdomains_setup();
+	}
 
 	ret = omap_clk_soc_init();
 
-- 
1.7.9.5
