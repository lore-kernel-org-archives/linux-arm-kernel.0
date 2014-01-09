From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 9 Jan 2014 16:00:51 +0200
Subject: [PATCHv13 40/40] ARM: OMAP3: use DT clock init if DT data is available
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Message-ID: <1389276051-1326-41-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP3 platforms support both DT and non-DT boot at the moment, make
the clock init work according to the used setup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f28399f..b8097fe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -488,21 +488,29 @@ void __init omap3_init_early(void)
 void __init omap3430_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = omap3430_dt_clk_init;
 }
 
 void __init omap35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = omap3430_dt_clk_init;
 }
 
 void __init omap3630_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = omap3630_dt_clk_init;
 }
 
 void __init am35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = am35xx_dt_clk_init;
 }
 
 void __init ti81xx_init_early(void)
@@ -520,7 +528,10 @@ void __init ti81xx_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_soc_init = omap3xxx_clk_init;
+	if (of_have_populated_dt())
+		omap_clk_soc_init = ti81xx_dt_clk_init;
+	else
+		omap_clk_soc_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
-- 
1.7.9.5
