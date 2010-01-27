From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 26 Jan 2010 20:17:11 -0700 (MST)
Subject: [PATCH] OMAP2+ powerdomains/clockdomains: prepare for multi-OMAP
	configs
Message-ID: <alpine.DEB.2.00.1001262015210.18597@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Convert CONFIG_ARCH_OMAP34XX to CONFIG_ARCH_OMAP3, and
CONFIG_ARCH_OMAP24XX to CONFIG_ARCH_OMAP2, in preparation for Tony's
multi-OMAP patches.

While here, update some copyrights, convert instances of "34xx" to
"3xxx" where applicable, and convert preprocessor directives of the
form

    #if defined(CONFIG_ARCH_OMAP2) | defined(CONFIG_ARCH_OMAP3)

to

    #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)

for standardization.

This patch is queued for 2.6.34.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomains.h     |   50 ++++++++++++++++----------------
 arch/arm/mach-omap2/powerdomains.h     |   16 +++++-----
 arch/arm/mach-omap2/powerdomains34xx.h |   14 ++++----
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index fb026da..7db6298 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 clockdomains
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H?gander
  *
@@ -196,9 +196,9 @@ static struct clkdm_dep mdm_2430_wkdeps[] = {
 #endif /* CONFIG_ARCH_OMAP2430 */
 
 
-/* 34XX-specific possible dependencies */
+/* OMAP3-specific possible dependencies */
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 
 /* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
 static struct clkdm_dep per_wkdeps[] = {
@@ -251,7 +251,7 @@ static struct clkdm_dep usbhost_wkdeps[] = {
 };
 
 /* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
-static struct clkdm_dep mpu_34xx_wkdeps[] = {
+static struct clkdm_dep mpu_3xxx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -349,7 +349,7 @@ static struct clkdm_dep neon_wkdeps[] = {
 };
 
 
-/* Sleep dependency source arrays for 34xx-specific clkdms - 34XX only */
+/* Sleep dependency source arrays for OMAP3-specific clkdms */
 
 /* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
 static struct clkdm_dep dss_sleepdeps[] = {
@@ -413,7 +413,7 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] = {
 	{ NULL },
 };
 
-#endif /* CONFIG_ARCH_OMAP34XX */
+#endif /* CONFIG_ARCH_OMAP3 */
 
 
 /*
@@ -425,7 +425,7 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] = {
  * sys_clkout/sys_clkout2.
  */
 
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
 /* This is an implicit clockdomain - it is never defined as such in TRM */
 static struct clockdomain wkup_clkdm = {
@@ -626,18 +626,18 @@ static struct clockdomain dss_2430_clkdm = {
 
 
 /*
- * 34xx clockdomains
+ * OMAP3 clockdomains
  */
 
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP3)
 
-static struct clockdomain mpu_34xx_clkdm = {
+static struct clockdomain mpu_3xxx_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
-	.wkdep_srcs	= mpu_34xx_wkdeps,
+	.wkdep_srcs	= mpu_3xxx_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -706,10 +706,10 @@ static struct clockdomain d2d_clkdm = {
 
 /*
  * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
  * could cause trouble
  */
-static struct clockdomain core_l3_34xx_clkdm = {
+static struct clockdomain core_l3_3xxx_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
@@ -721,10 +721,10 @@ static struct clockdomain core_l3_34xx_clkdm = {
 
 /*
  * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
  * could cause trouble
  */
-static struct clockdomain core_l4_34xx_clkdm = {
+static struct clockdomain core_l4_3xxx_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
@@ -735,7 +735,7 @@ static struct clockdomain core_l4_34xx_clkdm = {
 };
 
 /* Another case of bit name collisions between several registers: EN_DSS */
-static struct clockdomain dss_34xx_clkdm = {
+static struct clockdomain dss_3xxx_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "dss_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
@@ -829,12 +829,12 @@ static struct clockdomain dpll5_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
-#endif   /* CONFIG_ARCH_OMAP34XX */
+#endif   /* CONFIG_ARCH_OMAP3 */
 
 #include "clockdomains44xx.h"
 
 /*
- * Clockdomain hwsup dependencies (34XX only)
+ * Clockdomain hwsup dependencies (OMAP3 only)
  */
 
 static struct clkdm_autodep clkdm_autodeps[] = {
@@ -857,7 +857,7 @@ static struct clkdm_autodep clkdm_autodeps[] = {
 
 static struct clockdomain *clockdomains_omap[] = {
 
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	&wkup_clkdm,
 	&cm_clkdm,
 	&prm_clkdm,
@@ -883,16 +883,16 @@ static struct clockdomain *clockdomains_omap[] = {
 	&dss_2430_clkdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
-	&mpu_34xx_clkdm,
+#ifdef CONFIG_ARCH_OMAP3
+	&mpu_3xxx_clkdm,
 	&neon_clkdm,
 	&iva2_clkdm,
 	&gfx_3430es1_clkdm,
 	&sgx_clkdm,
 	&d2d_clkdm,
-	&core_l3_34xx_clkdm,
-	&core_l4_34xx_clkdm,
-	&dss_34xx_clkdm,
+	&core_l3_3xxx_clkdm,
+	&core_l4_3xxx_clkdm,
+	&dss_3xxx_clkdm,
 	&cam_clkdm,
 	&usbhost_clkdm,
 	&per_clkdm,
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index faa8fc9..105cbca 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -23,7 +23,7 @@
 
 /*
  * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34XX chips.
+ * of software control for the OMAP24xx and OMAP34xx chips.
  *
  * This is not an exhaustive listing of powerdomains on the chips; only
  * powerdomains that can be controlled in software.
@@ -60,7 +60,7 @@
 
 /* OMAP2/3-common powerdomains */
 
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
 /*
  * The GFX powerdomain is not present on 3430ES2, but currently we do not
@@ -94,12 +94,12 @@ static struct powerdomain wkup_omap2_pwrdm = {
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap[] __initdata = {
 
-#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	&wkup_omap2_pwrdm,
 	&gfx_omap2_pwrdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#ifdef CONFIG_ARCH_OMAP2
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
@@ -109,12 +109,12 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&mdm_pwrdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 	&iva2_pwrdm,
-	&mpu_34xx_pwrdm,
+	&mpu_3xxx_pwrdm,
 	&neon_pwrdm,
-	&core_34xx_pre_es3_1_pwrdm,
-	&core_34xx_es3_1_pwrdm,
+	&core_3xxx_pre_es3_1_pwrdm,
+	&core_3xxx_es3_1_pwrdm,
 	&cam_pwrdm,
 	&dss_pwrdm,
 	&per_pwrdm,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 28228ef..186c013 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -1,8 +1,8 @@
 /*
- * OMAP34XX powerdomain definitions
+ * OMAP3 powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H?gander
@@ -32,7 +32,7 @@
  * 34XX-specific powerdomains, dependencies
  */
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#ifdef CONFIG_ARCH_OMAP3
 
 /*
  * Powerdomains
@@ -59,7 +59,7 @@ static struct powerdomain iva2_pwrdm = {
 	},
 };
 
-static struct powerdomain mpu_34xx_pwrdm = {
+static struct powerdomain mpu_3xxx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -75,7 +75,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	},
 };
 
-static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
+static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -93,7 +93,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 	},
 };
 
-static struct powerdomain core_34xx_es3_1_pwrdm = {
+static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
@@ -243,7 +243,7 @@ static struct powerdomain dpll5_pwrdm = {
 };
 
 
-#endif    /* CONFIG_ARCH_OMAP34XX */
+#endif    /* CONFIG_ARCH_OMAP3 */
 
 
 #endif
-- 
1.6.6.rc2.5.g49666
