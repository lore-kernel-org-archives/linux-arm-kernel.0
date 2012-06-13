From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Jun 2012 17:43:52 -0600 (MDT)
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
In-Reply-To: <4FD73847.5050205@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
 <1339433225-30042-2-git-send-email-b-cousson@ti.com>
 <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
 <4FD65F12.2050805@ti.com> <4FD73847.5050205@ti.com>
Message-ID: <alpine.DEB.2.00.1206131646420.30212@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Beno?t and I discussed this today, at length.  Our views still differ.  

In an attempt to move on to more useful work, a compromise was agreed.  
The following patch removes the requirement for hwmods to have a 
clkdm_name, and removes the PRM and CM clockdomains from the data.  
It is intended for 3.6.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 13 Jun 2012 17:16:05 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: remove prm_clkdm, cm_clkdm; allow hwmods
 to have no clockdomain

Remove prm_clkdm and cm_clkdm and allow hwmods to have no clockdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile                   |    1 -
 arch/arm/mach-omap2/clockdomain.h              |    2 --
 arch/arm/mach-omap2/clockdomains2420_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains2430_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains3xxx_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains44xx_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains_common_data.c |   24 ------------------------
 arch/arm/mach-omap2/omap_hwmod.c               |    9 ++++-----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c     |    3 ---
 9 files changed, 4 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..bc7d239 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
-clockdomain-common			+= clockdomains_common_data.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomains2xxx_3xxx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..349dcbb 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -206,7 +206,5 @@ extern struct clkdm_ops omap4_clkdm_operations;
 extern struct clkdm_dep gfx_24xx_wkdeps[];
 extern struct clkdm_dep dsp_24xx_wkdeps[];
 extern struct clockdomain wkup_common_clkdm;
-extern struct clockdomain prm_common_clkdm;
-extern struct clockdomain cm_common_clkdm;
 
 #endif
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
index 0ab8e46..5c74185 100644
--- a/arch/arm/mach-omap2/clockdomains2420_data.c
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -131,8 +131,6 @@ static struct clockdomain dss_2420_clkdm = {
 
 static struct clockdomain *clockdomains_omap242x[] __initdata = {
 	&wkup_common_clkdm,
-	&cm_common_clkdm,
-	&prm_common_clkdm,
 	&mpu_2420_clkdm,
 	&iva1_2420_clkdm,
 	&dsp_2420_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
index 3645ed0..f096175 100644
--- a/arch/arm/mach-omap2/clockdomains2430_data.c
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -157,8 +157,6 @@ static struct clockdomain dss_2430_clkdm = {
 
 static struct clockdomain *clockdomains_omap243x[] __initdata = {
 	&wkup_common_clkdm,
-	&cm_common_clkdm,
-	&prm_common_clkdm,
 	&mpu_2430_clkdm,
 	&mdm_clkdm,
 	&dsp_2430_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 6038adb..2cdc17c 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -347,8 +347,6 @@ static struct clkdm_autodep clkdm_autodeps[] = {
 
 static struct clockdomain *clockdomains_omap3430_common[] __initdata = {
 	&wkup_common_clkdm,
-	&cm_common_clkdm,
-	&prm_common_clkdm,
 	&mpu_3xxx_clkdm,
 	&neon_clkdm,
 	&iva2_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index c534258..bd7ed13 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -430,8 +430,6 @@ static struct clockdomain *clockdomains_omap44xx[] __initdata = {
 	&l4_wkup_44xx_clkdm,
 	&emu_sys_44xx_clkdm,
 	&l3_dma_44xx_clkdm,
-	&prm_common_clkdm,
-	&cm_common_clkdm,
 	NULL
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains_common_data.c b/arch/arm/mach-omap2/clockdomains_common_data.c
deleted file mode 100644
index 615b1f0..0000000
--- a/arch/arm/mach-omap2/clockdomains_common_data.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * OMAP2+-common clockdomain data
- *
- * Copyright (C) 2008-2012 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
- *
- * Paul Walmsley, Jouni H?gander
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-
-#include "clockdomain.h"
-
-/* These are implicit clockdomains - they are never defined as such in TRM */
-struct clockdomain prm_common_clkdm = {
-	.name		= "prm_clkdm",
-	.pwrdm		= { .name = "wkup_pwrdm" },
-};
-
-struct clockdomain cm_common_clkdm = {
-	.name		= "cm_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-};
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bf86f7e..3bba881 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1285,23 +1285,22 @@ static struct omap_hwmod *_lookup(const char *name)
 
 	return oh;
 }
+
 /**
  * _init_clkdm - look up a clockdomain name, store pointer in omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Convert a clockdomain name stored in a struct omap_hwmod into a
  * clockdomain pointer, and save it into the struct omap_hwmod.
- * return -EINVAL if clkdm_name does not exist or if the lookup failed.
+ * Return -EINVAL if the clkdm_name lookup failed.
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return 0;
 
-	if (!oh->clkdm_name) {
-		pr_warning("omap_hwmod: %s: no clkdm_name\n", oh->name);
-		return -EINVAL;
-	}
+	if (!oh->clkdm_name)
+		return 0;
 
 	oh->clkdm = clkdm_lookup(oh->clkdm_name);
 	if (!oh->clkdm) {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..e9e9ec0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2540,14 +2540,12 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
 	.name		= "cm_core_aon",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "cm_clkdm",
 };
 
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod = {
 	.name		= "cm_core",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "cm_clkdm",
 };
 
 /* prm */
@@ -2564,7 +2562,6 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
 static struct omap_hwmod omap44xx_prm_hwmod = {
 	.name		= "prm",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "prm_clkdm",
 	.mpu_irqs	= omap44xx_prm_irqs,
 	.rst_lines	= omap44xx_prm_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
-- 
1.7.10
