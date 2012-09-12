From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Sep 2012 19:46:32 +0000 (UTC)
Subject: [PATCHv7 03/12] ARM: OMAP4: hwmod: flag hwmods/modules not
 supporting module level context status
In-Reply-To: <1342704392-23657-4-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-4-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1209121943390.17903@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Thu, 19 Jul 2012, Tero Kristo wrote:

> On OMAP4 most modules/hwmods support module level context status. On
> OMAP3 and earlier, we relied on the power domain level context status.
> Identify all modules that don't support 'context_offs' by marking the
> offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
> .prcm structure already.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This one was changed here to use a separate flag rather than adding a 
magic value to the context_offs field -- mostly because I've been burnt by 
missing tests for those kinds of magic values in the past.  It should be 
possible to roll the .modulemode field into this .flags field in a future 
patch to eliminate any kernel object size changes.  

The modified patch is below, queued for 3.7.


- Paul

From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 12 Sep 2012 11:53:54 -0600
Subject: [PATCH] ARM: OMAP4: hwmod: flag hwmods/modules not supporting module
 level context status

On OMAP4 most modules/hwmods support module level context status. On
OMAP3 and earlier, we relied on the power domain level context status.
Identify all modules that don't support 'context_offs' by adding a
flag bit, HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT.  Rest have a valid
'context_offs' populated in .prcm structure already.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul at pwsan.com: add flag bit rather than overloading .context_offs;
 update changelog message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   46 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..e4b0177 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -203,6 +203,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
+			.flags	      = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
 };
@@ -259,6 +260,11 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 	.name		= "mpu_private",
 	.class		= &omap44xx_mpu_bus_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /*
@@ -447,6 +453,11 @@ static struct omap_hwmod omap44xx_ctrl_module_core_hwmod = {
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
 	.mpu_irqs	= omap44xx_ctrl_module_core_irqs,
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* ctrl_module_pad_core */
@@ -454,6 +465,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_core_hwmod = {
 	.name		= "ctrl_module_pad_core",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* ctrl_module_wkup */
@@ -461,6 +477,11 @@ static struct omap_hwmod omap44xx_ctrl_module_wkup_hwmod = {
 	.name		= "ctrl_module_wkup",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* ctrl_module_pad_wkup */
@@ -468,6 +489,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_wkup_hwmod = {
 	.name		= "ctrl_module_pad_wkup",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /*
@@ -2537,18 +2563,33 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
 	.name		= "prcm_mpu",
 	.class		= &omap44xx_prcm_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* cm_core_aon */
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
 	.name		= "cm_core_aon",
 	.class		= &omap44xx_prcm_hwmod_class,
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod = {
 	.name		= "cm_core",
 	.class		= &omap44xx_prcm_hwmod_class,
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /* prm */
@@ -2584,6 +2625,11 @@ static struct omap_hwmod omap44xx_scrm_hwmod = {
 	.name		= "scrm",
 	.class		= &omap44xx_scrm_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6132972..fd038be 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -2,7 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2012 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno?t Cousson,
@@ -384,6 +384,14 @@ struct omap_hwmod_omap2_prcm {
 	u8 idlest_stdby_bit;
 };
 
+/*
+ * Possible values for struct omap_hwmod_omap4_prcm.flags
+ *
+ * HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT: Some IP blocks don't have a PRCM
+ *     module-level context loss register associated with them; this
+ *     flag bit should be set in those cases
+ */
+#define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT		(1 << 0)
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
@@ -391,6 +399,7 @@ struct omap_hwmod_omap2_prcm {
  * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
+ * @flags: PRCM register capabilities for this IP block
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
@@ -399,6 +408,7 @@ struct omap_hwmod_omap4_prcm {
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
+	u8		flags;
 };
 
 
-- 
1.7.10.4
