From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Tue, 15 Dec 2009 19:22:57 +0530
Subject: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4
	features.
In-Reply-To: <1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
References: <1260885177-25665-1-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-2-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-3-git-send-email-abhijitpagare@ti.com>
	<1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
Message-ID: <1260885177-25665-5-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Port the APIs to support the OMAP4 clockdomain framework.
Also take care of the compiling requirements for the same.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/clockdomain.c |   19 +++++++++++--------
 arch/arm/mach-omap2/io.c          |    2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4a54e5a..64de2fd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -13,7 +13,7 @@ clock-common				= clock.o clock_common_data.o clockdomain.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(omap-3-4-common)
-obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) $(prcm-common) clock.o
+obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) $(prcm-common) $(clock-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5366a10..f768d37 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,10 +1,11 @@
 /*
- * OMAP2/3 clockdomain framework functions
+ * OMAP2/3/4 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H????gander
+ * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -152,7 +153,7 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 			bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
 		else
 			bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
 		if (enable)
 			bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
 		else
@@ -213,10 +214,12 @@ void clkdm_init(struct clockdomain **clkdms,
 		for (c = clkdms; *c; c++)
 			clkdm_register(*c);
 
-	autodeps = init_autodeps;
-	if (autodeps)
-		for (autodep = autodeps; autodep->pwrdm.ptr; autodep++)
-			_autodep_lookup(autodep);
+	if (!cpu_is_omap44xx()) {
+		autodeps = init_autodeps;
+		if (autodeps)
+			for (autodep = autodeps; autodep->pwrdm.ptr; autodep++)
+				_autodep_lookup(autodep);
+	}
 }
 
 /**
@@ -419,7 +422,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
 			 __ffs(clkdm->clktrctrl_mask));
@@ -463,7 +466,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
 			 __ffs(clkdm->clktrctrl_mask));
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c4ffdaf..f2ad80b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -314,12 +314,12 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		hwmods = omap34xx_hwmods;
 
 	pwrdm_init(powerdomains_omap);
+	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 #endif
 	omap2_clk_init();
 	omap_serial_early_init();
-- 
1.5.4.7
