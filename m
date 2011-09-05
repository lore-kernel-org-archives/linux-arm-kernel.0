From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 4 Sep 2011 19:50:36 -0600 (MDT)
Subject: [PATCH 4/4] OMAP: powerdomain: remove omap_chip bitmasks
In-Reply-To: <20110902021917.8185.87157.stgit@dusk>
References: <20110902021321.8185.63172.stgit@dusk>
	<20110902021917.8185.87157.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1109041949280.9056@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Sep 2011, Paul Walmsley wrote:

> At Tony's request, remove the omap_chip bitmasks from the powerdomain
> definitions.  Instead, initialize powerdomains based on one or more
> lists that are applicable to a particular SoC family, variant, and
> silicon revision.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This patch had a similar problem; it didn't work as intended on OMAP3
chips that weren't OMAP34xx.  Updated version below.  The git branch
has been updated.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 1 Sep 2011 20:08:25 -0600
Subject: [PATCH] OMAP: powerdomain: remove omap_chip bitmasks

At Tony's request, remove the omap_chip bitmasks from the powerdomain
definitions.  Instead, initialize powerdomains based on one or more
lists that are applicable to a particular SoC family, variant, and
silicon revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                         |    4 +-
 arch/arm/mach-omap2/powerdomain-common.c         |    7 +-
 arch/arm/mach-omap2/powerdomain.c                |    3 -
 arch/arm/mach-omap2/powerdomain.h                |    5 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   19 +-----
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   42 +++++++-----
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   79 +++++++++++++---------
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   16 -----
 8 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d098c87..40b6d47 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -341,11 +341,11 @@ void __init omap2_init_common_infrastructure(void)
 	u8 postsetup_state;
 
 	if (cpu_is_omap242x()) {
-		omap2xxx_powerdomains_init();
+		omap242x_powerdomains_init();
 		omap242x_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
-		omap2xxx_powerdomains_init();
+		omap243x_powerdomains_init();
 		omap243x_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index 171fccd..f97afff 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -1,9 +1,8 @@
 /*
- *  linux/arch/arm/mach-omap2/powerdomain-common.c
- *  Contains common powerdomain framework functions
+ * Common powerdomain framework functions
  *
- *  Copyright (C) 2010 Texas Instruments, Inc.
- *  Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
  *
  * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
  *
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3483537..896cb4c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -81,9 +81,6 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	if (!pwrdm || !pwrdm->name)
 		return -EINVAL;
 
-	if (!omap_chip_is(pwrdm->omap_chip))
-		return -EINVAL;
-
 	if (cpu_is_omap44xx() &&
 	    pwrdm->prcm_partition == OMAP4430_INVALID_PRCM_PARTITION) {
 		pr_err("powerdomain: %s: missing OMAP4 PRCM partition ID\n",
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 489e1c5..8febd84 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -78,7 +78,6 @@ struct powerdomain;
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
- * @omap_chip: represents the OMAP chip types containing this pwrdm
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
  * @pwrsts: Possible powerdomain power states
@@ -98,7 +97,6 @@ struct powerdomain;
  */
 struct powerdomain {
 	const char *name;
-	const struct omap_chip_id omap_chip;
 	const s16 prcm_offs;
 	const u8 pwrsts;
 	const u8 pwrsts_logic_ret;
@@ -212,7 +210,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
-extern void omap2xxx_powerdomains_init(void);
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
 
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 4210c33..bf30483 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2/3 common powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H?gander
@@ -12,20 +12,6 @@
  */
 
 /*
- * To Do List
- * -> Move the Sleep/Wakeup dependencies from Power Domain framework to
- *    Clock Domain Framework
- */
-
-/*
- * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34xx chips.
- *
- * This is not an exhaustive listing of powerdomains on the chips; only
- * powerdomains that can be controlled in software.
- */
-
-/*
  * The names for the DSP/IVA2 powerdomains are confusing.
  *
  * Most OMAP chips have an on-board DSP.
@@ -59,8 +45,6 @@
 struct powerdomain gfx_omap2_pwrdm = {
 	.name		  = "gfx_pwrdm",
 	.prcm_offs	  = GFX_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					   CHIP_IS_OMAP3430ES1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 1,
@@ -75,6 +59,5 @@ struct powerdomain gfx_omap2_pwrdm = {
 struct powerdomain wkup_omap2_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 	.pwrsts		= PWRSTS_ON,
 };
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 71c4fd7..bb4394e 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2XXX powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H?gander
@@ -28,7 +28,6 @@
 static struct powerdomain dsp_pwrdm = {
 	.name		  = "dsp_pwrdm",
 	.prcm_offs	  = OMAP24XX_DSP_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 1,
@@ -43,7 +42,6 @@ static struct powerdomain dsp_pwrdm = {
 static struct powerdomain mpu_24xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -58,7 +56,6 @@ static struct powerdomain mpu_24xx_pwrdm = {
 static struct powerdomain core_24xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.banks		  = 3,
 	.pwrsts_mem_ret	  = {
@@ -78,14 +75,11 @@ static struct powerdomain core_24xx_pwrdm = {
  * 2430-specific powerdomains
  */
 
-#ifdef CONFIG_SOC_OMAP2430
-
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
 
 static struct powerdomain mdm_pwrdm = {
 	.name		  = "mdm_pwrdm",
 	.prcm_offs	  = OMAP2430_MDM_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 1,
@@ -97,29 +91,41 @@ static struct powerdomain mdm_pwrdm = {
 	},
 };
 
-#endif     /* CONFIG_SOC_OMAP2430 */
-
-/* As powerdomains are added or removed above, this list must also be changed */
-static struct powerdomain *powerdomains_omap2xxx[] __initdata = {
+/*
+ *
+ */
 
+static struct powerdomain *powerdomains_omap24xx[] __initdata = {
 	&wkup_omap2_pwrdm,
 	&gfx_omap2_pwrdm,
-
-#ifdef CONFIG_ARCH_OMAP2
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
-#endif
+	NULL
+};
 
-#ifdef CONFIG_SOC_OMAP2430
+static struct powerdomain *powerdomains_omap2430[] __initdata = {
 	&mdm_pwrdm,
-#endif
 	NULL
 };
 
-void __init omap2xxx_powerdomains_init(void)
+void __init omap242x_powerdomains_init(void)
 {
+	if (!cpu_is_omap2420())
+		return;
+
+	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_omap24xx);
+	pwrdm_complete_init();
+}
+
+void __init omap243x_powerdomains_init(void)
+{
+	if (!cpu_is_omap2430())
+		return;
+
 	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
-	pwrdm_register_pwrdms(powerdomains_omap2xxx);
+	pwrdm_register_pwrdms(powerdomains_omap24xx);
+	pwrdm_register_pwrdms(powerdomains_omap2430);
 	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 9d355fc..219f770 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP3 powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H?gander
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
+#include <plat/cpu.h>
+
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
 
@@ -27,8 +29,6 @@
  * 34XX-specific powerdomains, dependencies
  */
 
-#ifdef CONFIG_ARCH_OMAP3
-
 /*
  * Powerdomains
  */
@@ -36,7 +36,6 @@
 static struct powerdomain iva2_pwrdm = {
 	.name		  = "iva2_pwrdm",
 	.prcm_offs	  = OMAP3430_IVA2_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 4,
@@ -57,7 +56,6 @@ static struct powerdomain iva2_pwrdm = {
 static struct powerdomain mpu_3xxx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_MPU_QUIRK,
@@ -83,10 +81,6 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-					   CHIP_IS_OMAP3430ES2 |
-					   CHIP_IS_OMAP3430ES3_0 |
-					   CHIP_IS_OMAP3630ES1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -103,8 +97,6 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
-					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	/*
@@ -125,7 +117,6 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 
 static struct powerdomain dss_pwrdm = {
 	.name		  = "dss_pwrdm",
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  = OMAP3430_DSS_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
@@ -146,7 +137,6 @@ static struct powerdomain dss_pwrdm = {
 static struct powerdomain sgx_pwrdm = {
 	.name		  = "sgx_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
@@ -161,7 +151,6 @@ static struct powerdomain sgx_pwrdm = {
 
 static struct powerdomain cam_pwrdm = {
 	.name		  = "cam_pwrdm",
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  = OMAP3430_CAM_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
@@ -177,7 +166,6 @@ static struct powerdomain cam_pwrdm = {
 static struct powerdomain per_pwrdm = {
 	.name		  = "per_pwrdm",
 	.prcm_offs	  = OMAP3430_PER_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -192,13 +180,11 @@ static struct powerdomain per_pwrdm = {
 static struct powerdomain emu_pwrdm = {
 	.name		= "emu_pwrdm",
 	.prcm_offs	= OMAP3430_EMU_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct powerdomain neon_pwrdm = {
 	.name		  = "neon_pwrdm",
 	.prcm_offs	  = OMAP3430_NEON_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 };
@@ -206,7 +192,6 @@ static struct powerdomain neon_pwrdm = {
 static struct powerdomain usbhost_pwrdm = {
 	.name		  = "usbhost_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	/*
@@ -228,62 +213,92 @@ static struct powerdomain usbhost_pwrdm = {
 static struct powerdomain dpll1_pwrdm = {
 	.name		= "dpll1_pwrdm",
 	.prcm_offs	= MPU_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct powerdomain dpll2_pwrdm = {
 	.name		= "dpll2_pwrdm",
 	.prcm_offs	= OMAP3430_IVA2_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct powerdomain dpll3_pwrdm = {
 	.name		= "dpll3_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct powerdomain dpll4_pwrdm = {
 	.name		= "dpll4_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static struct powerdomain dpll5_pwrdm = {
 	.name		= "dpll5_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 /* As powerdomains are added or removed above, this list must also be changed */
-static struct powerdomain *powerdomains_omap3xxx[] __initdata = {
-
+static struct powerdomain *powerdomains_omap3430_common[] __initdata = {
 	&wkup_omap2_pwrdm,
-	&gfx_omap2_pwrdm,
 	&iva2_pwrdm,
 	&mpu_3xxx_pwrdm,
 	&neon_pwrdm,
-	&core_3xxx_pre_es3_1_pwrdm,
-	&core_3xxx_es3_1_pwrdm,
 	&cam_pwrdm,
 	&dss_pwrdm,
 	&per_pwrdm,
 	&emu_pwrdm,
-	&sgx_pwrdm,
-	&usbhost_pwrdm,
 	&dpll1_pwrdm,
 	&dpll2_pwrdm,
 	&dpll3_pwrdm,
 	&dpll4_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_omap3430es1[] __initdata = {
+	&gfx_omap2_pwrdm,
+	&core_3xxx_pre_es3_1_pwrdm,
+	NULL
+};
+
+/* also includes 3630ES1.0 */
+static struct powerdomain *powerdomains_omap3430es2_es3_0[] __initdata = {
+	&core_3xxx_pre_es3_1_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
 	&dpll5_pwrdm,
-#endif
 	NULL
 };
 
+/* also includes 3630ES1.1+ */
+static struct powerdomain *powerdomains_omap3430es3_1plus[] __initdata = {
+	&core_3xxx_es3_1_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
+	&dpll5_pwrdm,
+	NULL
+};
 
 void __init omap3xxx_powerdomains_init(void)
 {
+	if (!cpu_is_omap34xx())
+		return;
+
 	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
-	pwrdm_register_pwrdms(powerdomains_omap3xxx);
+	pwrdm_register_pwrdms(powerdomains_omap3430_common);
+
+	if (omap_rev() == OMAP3430_REV_ES1_0)
+		pwrdm_register_pwrdms(powerdomains_omap3430es1);
+	else if (omap_rev() == OMAP3430_REV_ES2_0 ||
+		 omap_rev() == OMAP3430_REV_ES2_1 ||
+		 omap_rev() == OMAP3430_REV_ES3_0 ||
+		 omap_rev() == OMAP3630_REV_ES1_0)
+		pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
+	else if (omap_rev() == OMAP3430_REV_ES3_1 ||
+		 omap_rev() == OMAP3430_REV_ES3_1_2 ||
+		 omap_rev() & OMAP3505_REV(0) ||
+		 omap_rev() == OMAP3630_REV_ES1_1 ||
+		 omap_rev() == OMAP3630_REV_ES1_2)
+		pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
+	else
+		WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
+
 	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 67ac24b..cbce0c9 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -35,7 +35,6 @@ static struct powerdomain core_44xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
@@ -61,7 +60,6 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.name		  = "gfx_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_GFX_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -78,7 +76,6 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.name		  = "abe_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ABE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
@@ -98,7 +95,6 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.name		  = "dss_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_DSS_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
@@ -116,7 +112,6 @@ static struct powerdomain tesla_44xx_pwrdm = {
 	.name		  = "tesla_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_TESLA_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -138,7 +133,6 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.name		  = "wkup_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_WKUP_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -154,7 +148,6 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.name		  = "cpu0_pwrdm",
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -171,7 +164,6 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.name		  = "cpu1_pwrdm",
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -188,7 +180,6 @@ static struct powerdomain emu_44xx_pwrdm = {
 	.name		  = "emu_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_EMU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -204,7 +195,6 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -225,7 +215,6 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.name		  = "ivahd_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
@@ -249,7 +238,6 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.name		  = "cam_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -266,7 +254,6 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -284,7 +271,6 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.name		  = "l4per_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -307,7 +293,6 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_ON,
 };
 
@@ -316,7 +301,6 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.name		  = "cefuse_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
-- 
1.7.5.4
