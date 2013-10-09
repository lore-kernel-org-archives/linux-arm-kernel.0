From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 9 Oct 2013 18:31:04 +0300
Subject: [PATCHv8 33/36] ARM: OMAP3: use DT clock init if DT data is available
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Message-ID: <1381332668-962-34-git-send-email-t-kristo@ti.com>
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
index 7aaf673..a9896ea 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -488,21 +488,29 @@ void __init omap3_init_early(void)
 void __init omap3430_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3430_dt_clk_init;
 }
 
 void __init omap35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3430_dt_clk_init;
 }
 
 void __init omap3630_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = omap3630_dt_clk_init;
 }
 
 void __init am35xx_init_early(void)
 {
 	omap3_init_early();
+	if (of_have_populated_dt())
+		omap_clk_init = am35xx_dt_clk_init;
 }
 
 void __init ti81xx_init_early(void)
@@ -520,7 +528,10 @@ void __init ti81xx_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap3xxx_clk_init;
+	if (of_have_populated_dt())
+		omap_clk_init = ti81xx_dt_clk_init;
+	else
+		omap_clk_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
-- 
1.7.9.5
