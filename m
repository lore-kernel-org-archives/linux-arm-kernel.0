From: tony@atomide.com (Tony Lindgren)
Date: Thu,  6 Aug 2015 22:19:03 -0700
Subject: [PATCH 1/1] ARM: OMAP2+: Fix power domain operations regression
 caused by 81xx
Message-ID: <1438924743-30025-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I managed to mess up omap3 power domain operations with commit
7c80a3f89c51 ("ARM: OMAP2+: Add custom prwdm_operations for 81xx
to support dm814x"), by default we should keep on using the
omap3_pwrdm_operations, only 81xx needs custom handling.

This causes omap3 PM to break so we won't hit off mode any longer
causing idle power consumption go up from less than 10mW to over
50 mW.

Fixs: 7c80a3f89c51 ("ARM: OMAP2+: Add custom prwdm_operations for
81xx to support dm814x")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -580,7 +580,9 @@ void __init omap3xxx_powerdomains_init(void)
 	if (!cpu_is_omap34xx() && !cpu_is_ti81xx())
 		return;
 
-	pwrdm_register_platform_funcs(&ti81xx_pwrdm_operations);
+	/* Only 81xx needs custom pwrdm_operations */
+	if (!cpu_is_ti81xx())
+		pwrdm_register_platform_funcs(&omap3_pwrdm_operations);;
 
 	rev = omap_rev();
 
@@ -588,9 +590,11 @@ void __init omap3xxx_powerdomains_init(void)
 		pwrdm_register_pwrdms(powerdomains_am35x);
 	} else if (rev == TI8148_REV_ES1_0 || rev == TI8148_REV_ES2_0 ||
 		   rev == TI8148_REV_ES2_1) {
+		pwrdm_register_platform_funcs(&ti81xx_pwrdm_operations);
 		pwrdm_register_pwrdms(powerdomains_ti814x);
 	} else if (rev == TI8168_REV_ES1_0 || rev == TI8168_REV_ES1_1
 			|| rev == TI8168_REV_ES2_0 || rev == TI8168_REV_ES2_1) {
+		pwrdm_register_platform_funcs(&ti81xx_pwrdm_operations);
 		pwrdm_register_pwrdms(powerdomains_ti816x);
 	} else {
 		pwrdm_register_pwrdms(powerdomains_omap3430_common);
-- 
2.1.4
