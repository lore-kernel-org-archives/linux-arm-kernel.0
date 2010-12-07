From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 06 Dec 2010 18:25:11 -0700
Subject: [PATCH 08/14] OMAP2+: clockdomains: move clockdomain static data to
	.c files
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Message-ID: <20101207012510.3708.52087.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Static data should be declared in .c files, not .h files.  It should be
possible to #include .h files at any point without creating multiple
copies of the same data.

We converted the clock data to .c files some time ago.  This patch does
the same for the clockdomain data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                     |   10 +++-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   58 +++-------------------
 arch/arm/mach-omap2/clockdomains44xx_data.c      |   42 ++++++++++++++--
 arch/arm/mach-omap2/io.c                         |   10 ++--
 arch/arm/plat-omap/include/plat/clockdomain.h    |   11 +++-
 5 files changed, 66 insertions(+), 65 deletions(-)
 rename arch/arm/mach-omap2/{clockdomains.h => clockdomains2xxx_3xxx_data.c} (95%)
 rename arch/arm/mach-omap2/{clockdomains44xx.h => clockdomains44xx_data.c} (90%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 609fa78..78a2a5d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -10,8 +10,7 @@ omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
-					  clockdomain.o clkt_dpll.o \
-					  clkt_clksel.o
+					  clkt_dpll.o clkt_clksel.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common)
@@ -82,6 +81,13 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
 
+# PRCM clockdomain control
+obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
+					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
+					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
+					   clockdomains44xx_data.o
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
 					   clkt2xxx_sys.o \
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
similarity index 95%
rename from arch/arm/mach-omap2/clockdomains.h
rename to arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 2a3b10a..8dadf75 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2008-2009 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  *
- * Written by Paul Walmsley and Jouni H?gander
+ * Paul Walmsley, Jouni H?gander
  *
  * This file contains clockdomains and clockdomain wakeup/sleep
  * dependencies for the OMAP2/3 chips.  Some notes:
@@ -32,8 +32,8 @@
  *    from the Power domain framework
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
+#include <linux/kernel.h>
+#include <linux/io.h>
 
 #include <plat/clockdomain.h>
 #include "cm.h"
@@ -89,8 +89,6 @@ static struct clkdm_dep gfx_sgx_wkdeps[] = {
 
 /* 24XX-specific possible dependencies */
 
-#ifdef CONFIG_ARCH_OMAP2
-
 /* Wakeup dependency source arrays */
 
 /* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
@@ -170,8 +168,6 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 	{ NULL },
 };
 
-#endif
-
 
 /* 2430-specific possible wakeup dependencies */
 
@@ -430,8 +426,6 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] = {
  * sys_clkout/sys_clkout2.
  */
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
 /* This is an implicit clockdomain - it is never defined as such in TRM */
 static struct clockdomain wkup_clkdm = {
 	.name		= "wkup_clkdm",
@@ -452,8 +446,6 @@ static struct clockdomain cm_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
-#endif
-
 /*
  * 2420-only clockdomains
  */
@@ -836,8 +828,6 @@ static struct clockdomain dpll5_clkdm = {
 
 #endif   /* CONFIG_ARCH_OMAP3 */
 
-#include "clockdomains44xx.h"
-
 /*
  * Clockdomain hwsup dependencies (OMAP3 only)
  */
@@ -856,17 +846,10 @@ static struct clkdm_autodep clkdm_autodeps[] = {
 	}
 };
 
-/*
- * List of clockdomain pointers per platform
- */
-
-static struct clockdomain *clockdomains_omap[] = {
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+static struct clockdomain *clockdomains_omap2[] __initdata = {
 	&wkup_clkdm,
 	&cm_clkdm,
 	&prm_clkdm,
-#endif
 
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,
@@ -908,35 +891,10 @@ static struct clockdomain *clockdomains_omap[] = {
 	&dpll4_clkdm,
 	&dpll5_clkdm,
 #endif
-
-#ifdef CONFIG_ARCH_OMAP4
-	&l4_cefuse_44xx_clkdm,
-	&l4_cfg_44xx_clkdm,
-	&tesla_44xx_clkdm,
-	&l3_gfx_44xx_clkdm,
-	&ivahd_44xx_clkdm,
-	&l4_secure_44xx_clkdm,
-	&l4_per_44xx_clkdm,
-	&abe_44xx_clkdm,
-	&l3_instr_44xx_clkdm,
-	&l3_init_44xx_clkdm,
-	&mpuss_44xx_clkdm,
-	&mpu0_44xx_clkdm,
-	&mpu1_44xx_clkdm,
-	&l3_emif_44xx_clkdm,
-	&l4_ao_44xx_clkdm,
-	&ducati_44xx_clkdm,
-	&l3_2_44xx_clkdm,
-	&l3_1_44xx_clkdm,
-	&l3_d2d_44xx_clkdm,
-	&iss_44xx_clkdm,
-	&l3_dss_44xx_clkdm,
-	&l4_wkup_44xx_clkdm,
-	&emu_sys_44xx_clkdm,
-	&l3_dma_44xx_clkdm,
-#endif
-
 	NULL,
 };
 
-#endif
+void __init omap2_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap2, clkdm_autodeps);
+}
diff --git a/arch/arm/mach-omap2/clockdomains44xx.h b/arch/arm/mach-omap2/clockdomains44xx_data.c
similarity index 90%
rename from arch/arm/mach-omap2/clockdomains44xx.h
rename to arch/arm/mach-omap2/clockdomains44xx_data.c
index 7e5ba0f..c847a8b 100644
--- a/arch/arm/mach-omap2/clockdomains44xx.h
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -23,12 +23,15 @@
  * -> Populate the Sleep/Wakeup dependencies for the domains
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS44XX_H
+#include <linux/kernel.h>
+#include <linux/io.h>
 
 #include <plat/clockdomain.h>
 
-#if defined(CONFIG_ARCH_OMAP4)
+#include "cm44xx.h"
+#include "prm44xx.h"
+#include "cm-regbits-44xx.h"
+#include "prm-regbits-44xx.h"
 
 static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.name		  = "l4_cefuse_clkdm",
@@ -245,6 +248,35 @@ static struct clockdomain l3_dma_44xx_clkdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-#endif
+static struct clockdomain *clockdomains_omap44xx[] __initdata = {
+	&l4_cefuse_44xx_clkdm,
+	&l4_cfg_44xx_clkdm,
+	&tesla_44xx_clkdm,
+	&l3_gfx_44xx_clkdm,
+	&ivahd_44xx_clkdm,
+	&l4_secure_44xx_clkdm,
+	&l4_per_44xx_clkdm,
+	&abe_44xx_clkdm,
+	&l3_instr_44xx_clkdm,
+	&l3_init_44xx_clkdm,
+	&mpuss_44xx_clkdm,
+	&mpu0_44xx_clkdm,
+	&mpu1_44xx_clkdm,
+	&l3_emif_44xx_clkdm,
+	&l4_ao_44xx_clkdm,
+	&ducati_44xx_clkdm,
+	&l3_2_44xx_clkdm,
+	&l3_1_44xx_clkdm,
+	&l3_d2d_44xx_clkdm,
+	&iss_44xx_clkdm,
+	&l3_dss_44xx_clkdm,
+	&l4_wkup_44xx_clkdm,
+	&emu_sys_44xx_clkdm,
+	&l3_dma_44xx_clkdm,
+	NULL,
+};
 
-#endif
+void __init omap44xx_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap44xx, NULL);
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6336044..d05638ac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -42,8 +42,6 @@
 #include <plat/powerdomain.h>
 
 #include <plat/clockdomain.h>
-#include "clockdomains.h"
-
 #include <plat/omap_hwmod.h>
 
 /*
@@ -317,19 +315,19 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
 		omap2xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap2_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
-		clkdm_init(clockdomains_omap, clkdm_autodeps);
+		omap44xx_clockdomains_init();
 		omap44xx_hwmod_init();
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index ba0a6c0..a5f8579 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -4,18 +4,22 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX This should be moved to mach-omap2/ at the earliest opportunity.
  */
 
 #ifndef __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
 #define __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
 
+#include <linux/init.h>
+
 #include <plat/powerdomain.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -138,4 +142,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 
+extern void __init omap2_clockdomains_init(void);
+extern void __init omap44xx_clockdomains_init(void);
+
 #endif
