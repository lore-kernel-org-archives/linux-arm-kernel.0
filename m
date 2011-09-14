From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 16:45:09 -0600
Subject: [PATCH v2 2/4] OMAP: clockdomain code/data: remove omap_chip bitmask
	from struct clockdomain
In-Reply-To: <20110914220723.12067.99495.stgit@dusk>
References: <20110914220723.12067.99495.stgit@dusk>
Message-ID: <20110914224505.12067.37503.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tony's request, remove the omap_chip bitmasks from the clockdomain
and clockdomain dependency definitions.  Instead, initialize
clockdomains based on one or more lists that are applicable to a
particular SoC family, variant, and silicon revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                     |    5 
 arch/arm/mach-omap2/clockdomain.c                |   19 -
 arch/arm/mach-omap2/clockdomain.h                |   15 
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |    4 
 arch/arm/mach-omap2/clockdomain44xx.c            |    2 
 arch/arm/mach-omap2/clockdomains2420_data.c      |  155 ++++
 arch/arm/mach-omap2/clockdomains2430_data.c      |  181 +++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |  812 ----------------------
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |  398 +++++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |  404 ++---------
 arch/arm/mach-omap2/io.c                         |    4 
 11 files changed, 843 insertions(+), 1156 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains3xxx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..5a6fe73 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -116,9 +116,12 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= clockdomains2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clockdomains2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
 					   clockdomain2xxx_3xxx.o \
-					   clockdomains2xxx_3xxx_data.o
+					   clockdomains2xxx_3xxx_data.o \
+					   clockdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b73a1dc..8480ee4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -73,9 +73,6 @@ static int _clkdm_register(struct clockdomain *clkdm)
 	if (!clkdm || !clkdm->name)
 		return -EINVAL;
 
-	if (!omap_chip_is(clkdm->omap_chip))
-		return -EINVAL;
-
 	pwrdm = pwrdm_lookup(clkdm->pwrdm.name);
 	if (!pwrdm) {
 		pr_err("clockdomain: %s: powerdomain %s does not exist\n",
@@ -105,13 +102,10 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 {
 	struct clkdm_dep *cd;
 
-	if (!clkdm || !deps || !omap_chip_is(clkdm->omap_chip))
+	if (!clkdm || !deps)
 		return ERR_PTR(-EINVAL);
 
 	for (cd = deps; cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
-
 		if (!cd->clkdm && cd->clkdm_name)
 			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
 
@@ -148,9 +142,6 @@ static void _autodep_lookup(struct clkdm_autodep *autodep)
 	if (!autodep)
 		return;
 
-	if (!omap_chip_is(autodep->omap_chip))
-		return;
-
 	clkdm = clkdm_lookup(autodep->clkdm.name);
 	if (!clkdm) {
 		pr_err("clockdomain: autodeps: clockdomain %s does not exist\n",
@@ -182,9 +173,6 @@ void _clkdm_add_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
-		if (!omap_chip_is(autodep->omap_chip))
-			continue;
-
 		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
 			 "clkdm %s\n", autodep->clkdm.ptr->name,
 			 clkdm->name);
@@ -216,9 +204,6 @@ void _clkdm_del_autodeps(struct clockdomain *clkdm)
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
-		if (!omap_chip_is(autodep->omap_chip))
-			continue;
-
 		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
 			 "clkdm %s\n", autodep->clkdm.ptr->name,
 			 clkdm->name);
@@ -243,8 +228,6 @@ static void _resolve_clkdm_deps(struct clockdomain *clkdm,
 	struct clkdm_dep *cd;
 
 	for (cd = clkdm_deps; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
 		if (cd->clkdm)
 			continue;
 		cd->clkdm = _clkdm_lookup(cd->clkdm_name);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 0d879ff..f7b5860 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -45,7 +45,6 @@
 /**
  * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
  * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
- * @omap_chip: OMAP chip types that this autodep is valid on
  *
  * A clockdomain that should have wkdeps and sleepdeps added when a
  * clockdomain should stay active in hwsup mode; and conversely,
@@ -60,14 +59,12 @@ struct clkdm_autodep {
 		const char *name;
 		struct clockdomain *ptr;
 	} clkdm;
-	const struct omap_chip_id omap_chip;
 };
 
 /**
  * struct clkdm_dep - encode dependencies between clockdomains
  * @clkdm_name: clockdomain name
  * @clkdm: pointer to the struct clockdomain of @clkdm_name
- * @omap_chip: OMAP chip types that this dependency is valid on
  * @wkdep_usecount: Number of wakeup dependencies causing this clkdm to wake
  * @sleepdep_usecount: Number of sleep deps that could prevent clkdm from idle
  *
@@ -81,7 +78,6 @@ struct clkdm_dep {
 	struct clockdomain *clkdm;
 	atomic_t wkdep_usecount;
 	atomic_t sleepdep_usecount;
-	const struct omap_chip_id omap_chip;
 };
 
 /* Possible flags for struct clockdomain._flags */
@@ -101,7 +97,6 @@ struct clkdm_dep {
  * @clkdm_offs: (OMAP4 only) CM clockdomain register offset
  * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
  * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
- * @omap_chip: OMAP chip types that this clockdomain is valid on
  * @usecount: Usecount tracking
  * @node: list_head to link all clockdomains together
  *
@@ -126,7 +121,6 @@ struct clockdomain {
 	const u16 clkdm_offs;
 	struct clkdm_dep *wkdep_srcs;
 	struct clkdm_dep *sleepdep_srcs;
-	const struct omap_chip_id omap_chip;
 	atomic_t usecount;
 	struct list_head node;
 	spinlock_t lock;
@@ -198,7 +192,8 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 
-extern void __init omap2xxx_clockdomains_init(void);
+extern void __init omap242x_clockdomains_init(void);
+extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void _clkdm_add_autodeps(struct clockdomain *clkdm);
@@ -208,4 +203,10 @@ extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
 extern struct clkdm_ops omap4_clkdm_operations;
 
+extern struct clkdm_dep gfx_24xx_wkdeps[];
+extern struct clkdm_dep dsp_24xx_wkdeps[];
+extern struct clockdomain wkup_common_clkdm;
+extern struct clockdomain prm_common_clkdm;
+extern struct clockdomain cm_common_clkdm;
+
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index f740edb..a0d68db 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -52,8 +52,6 @@ static int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 	u32 mask = 0;
 
 	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
 		if (!cd->clkdm)
 			continue; /* only happens if data is erroneous */
 
@@ -98,8 +96,6 @@ static int omap3_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 	u32 mask = 0;
 
 	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
 		if (!cd->clkdm)
 			continue; /* only happens if data is erroneous */
 
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index b43706a..935c7f0 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -52,8 +52,6 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 	u32 mask = 0;
 
 	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
 		if (!cd->clkdm)
 			continue; /* only happens if data is erroneous */
 
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
new file mode 100644
index 0000000..8895bba
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -0,0 +1,155 @@
+/*
+ * OMAP2420 clockdomains
+ *
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H?gander
+ *
+ * This file contains clockdomains and clockdomain wakeup dependencies
+ * for OMAP2420 chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs must have a dep_bit assigned.  So
+ * wkdep_srcs are really just software-controllable dependencies.
+ * Non-software-controllable dependencies do exist, but they are not
+ * encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* Wakeup dependency source arrays */
+
+/* 2420-specific possible wakeup dependencies */
+
+/* 2420 PM_WKDEP_MPU: CORE, DSP, WKUP */
+static struct clkdm_dep mpu_2420_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "dsp_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/* 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP */
+static struct clkdm_dep core_2420_wkdeps[] = {
+	{ .clkdm_name = "dsp_clkdm" },
+	{ .clkdm_name = "gfx_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ .clkdm_name = "mdm_clkdm" },
+	{ NULL },
+};
+
+/*
+ * 2420-only clockdomains
+ */
+
+static struct clockdomain mpu_2420_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm		= { .name = "mpu_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.wkdep_srcs	= mpu_2420_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
+};
+
+static struct clockdomain iva1_2420_clkdm = {
+	.name		= "iva1_clkdm",
+	.pwrdm		= { .name = "dsp_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	= dsp_24xx_wkdeps,
+	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
+};
+
+static struct clockdomain dsp_2420_clkdm = {
+	.name		= "dsp_clkdm",
+	.pwrdm		= { .name = "dsp_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
+};
+
+static struct clockdomain gfx_2420_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= gfx_24xx_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
+};
+
+static struct clockdomain core_l3_2420_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.wkdep_srcs	= core_2420_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
+};
+
+static struct clockdomain core_l4_2420_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.wkdep_srcs	= core_2420_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
+};
+
+static struct clockdomain dss_2420_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
+};
+
+static struct clockdomain *clockdomains_omap242x[] __initdata = {
+	&wkup_common_clkdm,
+	&cm_common_clkdm,
+	&prm_common_clkdm,
+	&mpu_2420_clkdm,
+	&iva1_2420_clkdm,
+	&dsp_2420_clkdm,
+	&gfx_2420_clkdm,
+	&core_l3_2420_clkdm,
+	&core_l4_2420_clkdm,
+	&dss_2420_clkdm,
+	NULL,
+};
+
+void __init omap242x_clockdomains_init(void)
+{
+	if (!cpu_is_omap242x())
+		return;
+
+	clkdm_register_platform_funcs(&omap2_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_omap242x);
+	clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
new file mode 100644
index 0000000..3645ed0
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -0,0 +1,181 @@
+/*
+ * OMAP2xxx clockdomains
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H?gander
+ *
+ * This file contains clockdomains and clockdomain wakeup dependencies
+ * for OMAP2xxx chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs must have a dep_bit assigned.  So
+ * wkdep_srcs are really just software-controllable dependencies.
+ * Non-software-controllable dependencies do exist, but they are not
+ * encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* Wakeup dependency source arrays */
+
+/* 2430-specific possible wakeup dependencies */
+
+/* 2430 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP, MDM */
+static struct clkdm_dep core_2430_wkdeps[] = {
+	{ .clkdm_name = "dsp_clkdm" },
+	{ .clkdm_name = "gfx_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ .clkdm_name = "mdm_clkdm" },
+	{ NULL },
+};
+
+/* 2430 PM_WKDEP_MPU: CORE, DSP, WKUP, MDM */
+static struct clkdm_dep mpu_2430_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "dsp_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ .clkdm_name = "mdm_clkdm" },
+	{ NULL },
+};
+
+/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
+static struct clkdm_dep mdm_2430_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/*
+ * 2430-only clockdomains
+ */
+
+static struct clockdomain mpu_2430_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm		= { .name = "mpu_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= mpu_2430_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
+};
+
+/* Another case of bit name collisions between several registers: EN_MDM */
+static struct clockdomain mdm_clkdm = {
+	.name		= "mdm_clkdm",
+	.pwrdm		= { .name = "mdm_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+	.wkdep_srcs	= mdm_2430_wkdeps,
+	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
+};
+
+static struct clockdomain dsp_2430_clkdm = {
+	.name		= "dsp_clkdm",
+	.pwrdm		= { .name = "dsp_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	= dsp_24xx_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
+};
+
+static struct clockdomain gfx_2430_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= gfx_24xx_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l3_2430_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	= core_2430_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l4_2430_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	= core_2430_wkdeps,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
+};
+
+static struct clockdomain dss_2430_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
+};
+
+static struct clockdomain *clockdomains_omap243x[] __initdata = {
+	&wkup_common_clkdm,
+	&cm_common_clkdm,
+	&prm_common_clkdm,
+	&mpu_2430_clkdm,
+	&mdm_clkdm,
+	&dsp_2430_clkdm,
+	&gfx_2430_clkdm,
+	&core_l3_2430_clkdm,
+	&core_l4_2430_clkdm,
+	&dss_2430_clkdm,
+	NULL,
+};
+
+void __init omap243x_clockdomains_init(void)
+{
+	if (!cpu_is_omap243x())
+		return;
+
+	clkdm_register_platform_funcs(&omap2_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_omap243x);
+	clkdm_complete_init();
+}
+
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 148a3e8..0a6a048 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -1,7 +1,7 @@
 /*
- * OMAP2/3 clockdomains
+ * OMAP2/3 clockdomain common data
  *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Paul Walmsley, Jouni H?gander
@@ -51,374 +51,28 @@
  * changed in software) are not included here yet, but should be.
  */
 
-/* OMAP2/3-common wakeup dependencies */
-
-/*
- * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
- * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
- * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
- * These can share data since they will never be present simultaneously
- * on the same device.
- */
-static struct clkdm_dep gfx_sgx_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* 24XX-specific possible dependencies */
-
-#ifdef CONFIG_ARCH_OMAP2
-
 /* Wakeup dependency source arrays */
 
-/* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
-static struct clkdm_dep dsp_24xx_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
- * 2430 adds MDM
- */
-static struct clkdm_dep mpu_24xx_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "dsp_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "mdm_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
- * 2430 adds MDM
- */
-static struct clkdm_dep core_24xx_wkdeps[] = {
-	{
-		.clkdm_name = "dsp_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "gfx_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "mdm_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-#endif /* CONFIG_ARCH_OMAP2 */
-
-/* 2430-specific possible wakeup dependencies */
+/* 2xxx-specific possible dependencies */
 
-#ifdef CONFIG_SOC_OMAP2430
-
-/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
-static struct clkdm_dep mdm_2430_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{ NULL },
-};
-
-#endif /* CONFIG_SOC_OMAP2430 */
-
-
-/* OMAP3-specific possible dependencies */
-
-#ifdef CONFIG_ARCH_OMAP3
-
-/* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
-static struct clkdm_dep per_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
-static struct clkdm_dep usbhost_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
+/* 2xxx PM_WKDEP_GFX: CORE, MPU, WKUP */
+struct clkdm_dep gfx_24xx_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
 	{ NULL },
 };
 
-/* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
-static struct clkdm_dep mpu_3xxx_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "dss_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "per_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
+/* 2xxx PM_WKDEP_DSP: CORE, MPU, WKUP */
+struct clkdm_dep dsp_24xx_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
 	{ NULL },
 };
 
-/* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
-static struct clkdm_dep iva2_wkdeps[] = {
-	{
-		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "dss_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "per_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* 3430 PM_WKDEP_CAM: IVA2, MPU, WKUP */
-static struct clkdm_dep cam_wkdeps[] = {
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430 PM_WKDEP_DSS: IVA2, MPU, WKUP */
-static struct clkdm_dep dss_wkdeps[] = {
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430: PM_WKDEP_NEON: MPU */
-static struct clkdm_dep neon_wkdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* Sleep dependency source arrays for OMAP3-specific clkdms */
-
-/* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
-static struct clkdm_dep dss_sleepdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430: CM_SLEEPDEP_PER: MPU, IVA */
-static struct clkdm_dep per_sleepdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
-static struct clkdm_dep usbhost_sleepdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430: CM_SLEEPDEP_CAM: MPU */
-static struct clkdm_dep cam_sleepdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430ES1: CM_SLEEPDEP_GFX: MPU
- * 3430ES2: CM_SLEEPDEP_SGX: MPU
- * These can share data since they will never be present simultaneously
- * on the same device.
- */
-static struct clkdm_dep gfx_sgx_sleepdeps[] = {
-	{
-		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-#endif /* CONFIG_ARCH_OMAP3 */
-
 
 /*
  * OMAP2/3-common clockdomains
@@ -430,448 +84,18 @@ static struct clkdm_dep gfx_sgx_sleepdeps[] = {
  */
 
 /* This is an implicit clockdomain - it is never defined as such in TRM */
-static struct clockdomain wkup_clkdm = {
+struct clockdomain wkup_common_clkdm = {
 	.name		= "wkup_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
-static struct clockdomain prm_clkdm = {
+struct clockdomain prm_common_clkdm = {
 	.name		= "prm_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
-static struct clockdomain cm_clkdm = {
+struct clockdomain cm_common_clkdm = {
 	.name		= "cm_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-};
-
-/*
- * 2420-only clockdomains
- */
-
-#if defined(CONFIG_SOC_OMAP2420)
-
-static struct clockdomain mpu_2420_clkdm = {
-	.name		= "mpu_clkdm",
-	.pwrdm		= { .name = "mpu_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.wkdep_srcs	= mpu_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain iva1_2420_clkdm = {
-	.name		= "iva1_clkdm",
-	.pwrdm		= { .name = "dsp_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	= dsp_24xx_wkdeps,
-	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain dsp_2420_clkdm = {
-	.name		= "dsp_clkdm",
-	.pwrdm		= { .name = "dsp_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain gfx_2420_clkdm = {
-	.name		= "gfx_clkdm",
-	.pwrdm		= { .name = "gfx_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain core_l3_2420_clkdm = {
-	.name		= "core_l3_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.wkdep_srcs	= core_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain core_l4_2420_clkdm = {
-	.name		= "core_l4_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.wkdep_srcs	= core_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-static struct clockdomain dss_2420_clkdm = {
-	.name		= "dss_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-};
-
-#endif   /* CONFIG_SOC_OMAP2420 */
-
-
-/*
- * 2430-only clockdomains
- */
-
-#if defined(CONFIG_SOC_OMAP2430)
-
-static struct clockdomain mpu_2430_clkdm = {
-	.name		= "mpu_clkdm",
-	.pwrdm		= { .name = "mpu_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= mpu_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/* Another case of bit name collisions between several registers: EN_MDM */
-static struct clockdomain mdm_clkdm = {
-	.name		= "mdm_clkdm",
-	.pwrdm		= { .name = "mdm_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-	.wkdep_srcs	= mdm_2430_wkdeps,
-	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain dsp_2430_clkdm = {
-	.name		= "dsp_clkdm",
-	.pwrdm		= { .name = "dsp_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	= dsp_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain gfx_2430_clkdm = {
-	.name		= "gfx_clkdm",
-	.pwrdm		= { .name = "gfx_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l3_2430_clkdm = {
-	.name		= "core_l3_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
-	.wkdep_srcs	= core_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l4_2430_clkdm = {
-	.name		= "core_l4_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
-	.wkdep_srcs	= core_24xx_wkdeps,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-static struct clockdomain dss_2430_clkdm = {
-	.name		= "dss_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-};
-
-#endif    /* CONFIG_SOC_OMAP2430 */
-
-
-/*
- * OMAP3 clockdomains
- */
-
-#if defined(CONFIG_ARCH_OMAP3)
-
-static struct clockdomain mpu_3xxx_clkdm = {
-	.name		= "mpu_clkdm",
-	.pwrdm		= { .name = "mpu_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
-	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
-	.wkdep_srcs	= mpu_3xxx_wkdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
-
-static struct clockdomain neon_clkdm = {
-	.name		= "neon_clkdm",
-	.pwrdm		= { .name = "neon_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= neon_wkdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain iva2_clkdm = {
-	.name		= "iva2_clkdm",
-	.pwrdm		= { .name = "iva2_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
-	.wkdep_srcs	= iva2_wkdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain gfx_3430es1_clkdm = {
-	.name		= "gfx_clkdm",
-	.pwrdm		= { .name = "gfx_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.sleepdep_srcs	= gfx_sgx_sleepdeps,
-	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
-};
-
-static struct clockdomain sgx_clkdm = {
-	.name		= "sgx_clkdm",
-	.pwrdm		= { .name = "sgx_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.sleepdep_srcs	= gfx_sgx_sleepdeps,
-	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-/*
- * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
- * then that information was removed from the 34xx ES2+ TRM.  It is
- * unclear whether the core is still there, but the clockdomain logic
- * is there, and must be programmed to an appropriate state if the
- * CORE clockdomain is to become inactive.
- */
-static struct clockdomain d2d_clkdm = {
-	.name		= "d2d_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l3_3xxx_clkdm = {
-	.name		= "core_l3_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * XXX add usecounting for clkdm dependencies, otherwise the presence
- * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
- * could cause trouble
- */
-static struct clockdomain core_l4_3xxx_clkdm = {
-	.name		= "core_l4_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP,
-	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/* Another case of bit name collisions between several registers: EN_DSS */
-static struct clockdomain dss_3xxx_clkdm = {
-	.name		= "dss_clkdm",
-	.pwrdm		= { .name = "dss_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
-	.wkdep_srcs	= dss_wkdeps,
-	.sleepdep_srcs	= dss_sleepdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain cam_clkdm = {
-	.name		= "cam_clkdm",
-	.pwrdm		= { .name = "cam_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= cam_wkdeps,
-	.sleepdep_srcs	= cam_sleepdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain usbhost_clkdm = {
-	.name		= "usbhost_clkdm",
-	.pwrdm		= { .name = "usbhost_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.wkdep_srcs	= usbhost_wkdeps,
-	.sleepdep_srcs	= usbhost_sleepdeps,
-	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-static struct clockdomain per_clkdm = {
-	.name		= "per_clkdm",
-	.pwrdm		= { .name = "per_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.dep_bit	= OMAP3430_EN_PER_SHIFT,
-	.wkdep_srcs	= per_wkdeps,
-	.sleepdep_srcs	= per_sleepdeps,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-/*
- * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
- * switched of even if sdti is in use
- */
-static struct clockdomain emu_clkdm = {
-	.name		= "emu_clkdm",
-	.pwrdm		= { .name = "emu_pwrdm" },
-	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
-	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll1_clkdm = {
-	.name		= "dpll1_clkdm",
-	.pwrdm		= { .name = "dpll1_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll2_clkdm = {
-	.name		= "dpll2_clkdm",
-	.pwrdm		= { .name = "dpll2_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll3_clkdm = {
-	.name		= "dpll3_clkdm",
-	.pwrdm		= { .name = "dpll3_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll4_clkdm = {
-	.name		= "dpll4_clkdm",
-	.pwrdm		= { .name = "dpll4_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-};
-
-static struct clockdomain dpll5_clkdm = {
-	.name		= "dpll5_clkdm",
-	.pwrdm		= { .name = "dpll5_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-};
-
-#endif   /* CONFIG_ARCH_OMAP3 */
-
-/*
- * Clockdomain hwsup dependencies (OMAP3 only)
- */
-
-static struct clkdm_autodep clkdm_autodeps[] = {
-	{
-		.clkdm	   = { .name = "mpu_clkdm" },
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm	   = { .name = "iva2_clkdm" },
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.clkdm	   = { .name = NULL },
-	}
-};
-
-static struct clockdomain *clockdomains_omap2[] __initdata = {
-	&wkup_clkdm,
-	&cm_clkdm,
-	&prm_clkdm,
-
-#ifdef CONFIG_SOC_OMAP2420
-	&mpu_2420_clkdm,
-	&iva1_2420_clkdm,
-	&dsp_2420_clkdm,
-	&gfx_2420_clkdm,
-	&core_l3_2420_clkdm,
-	&core_l4_2420_clkdm,
-	&dss_2420_clkdm,
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-	&mpu_2430_clkdm,
-	&mdm_clkdm,
-	&dsp_2430_clkdm,
-	&gfx_2430_clkdm,
-	&core_l3_2430_clkdm,
-	&core_l4_2430_clkdm,
-	&dss_2430_clkdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-	&mpu_3xxx_clkdm,
-	&neon_clkdm,
-	&iva2_clkdm,
-	&gfx_3430es1_clkdm,
-	&sgx_clkdm,
-	&d2d_clkdm,
-	&core_l3_3xxx_clkdm,
-	&core_l4_3xxx_clkdm,
-	&dss_3xxx_clkdm,
-	&cam_clkdm,
-	&usbhost_clkdm,
-	&per_clkdm,
-	&emu_clkdm,
-	&dpll1_clkdm,
-	&dpll2_clkdm,
-	&dpll3_clkdm,
-	&dpll4_clkdm,
-	&dpll5_clkdm,
-#endif
-	NULL,
-};
-
-static void __init omap2_3_clockdomains_init(void)
-{
-	clkdm_register_clkdms(clockdomains_omap2);
-	clkdm_register_autodeps(clkdm_autodeps);
-	clkdm_complete_init();
-}
-
-void __init omap2xxx_clockdomains_init(void)
-{
-	clkdm_register_platform_funcs(&omap2_clkdm_operations);
-	omap2_3_clockdomains_init();
-}
-
-void __init omap3xxx_clockdomains_init(void)
-{
-	clkdm_register_platform_funcs(&omap3_clkdm_operations);
-	omap2_3_clockdomains_init();
-}
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
new file mode 100644
index 0000000..b84e138
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -0,0 +1,398 @@
+/*
+ * OMAP3xxx clockdomains
+ *
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H?gander
+ *
+ * This file contains clockdomains and clockdomain wakeup/sleep
+ * dependencies for the OMAP3xxx chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs or sleepdep_srcs array must have a
+ * dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are really just
+ * software-controllable dependencies.  Non-software-controllable
+ * dependencies do exist, but they are not encoded below (yet).
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
+ */
+
+/*
+ * To-Do List
+ * -> Port the Sleep/Wakeup dependencies for the domains
+ *    from the Power domain framework
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prm2xxx_3xxx.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+
+/*
+ * Clockdomain dependencies for wkdeps/sleepdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* OMAP3-specific possible dependencies */
+
+/*
+ * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
+ * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ */
+static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] = {
+	{ .clkdm_name = "iva2_clkdm", },
+	{ .clkdm_name = "mpu_clkdm", },
+	{ .clkdm_name = "wkup_clkdm", },
+	{ NULL },
+};
+
+/* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep per_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep usbhost_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
+static struct clkdm_dep mpu_3xxx_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "dss_clkdm" },
+	{ .clkdm_name = "per_clkdm" },
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
+static struct clkdm_dep iva2_wkdeps[] = {
+	{ .clkdm_name = "core_l3_clkdm" },
+	{ .clkdm_name = "core_l4_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ .clkdm_name = "dss_clkdm" },
+	{ .clkdm_name = "per_clkdm" },
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_CAM: IVA2, MPU, WKUP */
+static struct clkdm_dep cam_wkdeps[] = {
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_DSS: IVA2, MPU, WKUP */
+static struct clkdm_dep dss_wkdeps[] = {
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
+	{ NULL },
+};
+
+/* 3430: PM_WKDEP_NEON: MPU */
+static struct clkdm_dep neon_wkdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ NULL },
+};
+
+/* Sleep dependency source arrays for OMAP3-specific clkdms */
+
+/* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
+static struct clkdm_dep dss_sleepdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ NULL },
+};
+
+/* 3430: CM_SLEEPDEP_PER: MPU, IVA */
+static struct clkdm_dep per_sleepdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ NULL },
+};
+
+/* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
+static struct clkdm_dep usbhost_sleepdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ NULL },
+};
+
+/* 3430: CM_SLEEPDEP_CAM: MPU */
+static struct clkdm_dep cam_sleepdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ NULL },
+};
+
+/*
+ * 3430ES1: CM_SLEEPDEP_GFX: MPU
+ * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ * These can share data since they will never be present simultaneously
+ * on the same device.
+ */
+static struct clkdm_dep gfx_sgx_sleepdeps[] = {
+	{ .clkdm_name = "mpu_clkdm" },
+	{ NULL },
+};
+
+/*
+ * OMAP3 clockdomains
+ */
+
+static struct clockdomain mpu_3xxx_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm		= { .name = "mpu_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
+	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
+	.wkdep_srcs	= mpu_3xxx_wkdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
+};
+
+static struct clockdomain neon_clkdm = {
+	.name		= "neon_clkdm",
+	.pwrdm		= { .name = "neon_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= neon_wkdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
+};
+
+static struct clockdomain iva2_clkdm = {
+	.name		= "iva2_clkdm",
+	.pwrdm		= { .name = "iva2_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
+	.wkdep_srcs	= iva2_wkdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
+};
+
+static struct clockdomain gfx_3430es1_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= gfx_sgx_3xxx_wkdeps,
+	.sleepdep_srcs	= gfx_sgx_sleepdeps,
+	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
+};
+
+static struct clockdomain sgx_clkdm = {
+	.name		= "sgx_clkdm",
+	.pwrdm		= { .name = "sgx_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= gfx_sgx_3xxx_wkdeps,
+	.sleepdep_srcs	= gfx_sgx_sleepdeps,
+	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
+};
+
+/*
+ * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
+ * then that information was removed from the 34xx ES2+ TRM.  It is
+ * unclear whether the core is still there, but the clockdomain logic
+ * is there, and must be programmed to an appropriate state if the
+ * CORE clockdomain is to become inactive.
+ */
+static struct clockdomain d2d_clkdm = {
+	.name		= "d2d_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l3_3xxx_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
+};
+
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_3xxx_clkdm and core_l4_3xxx_clkdm
+ * could cause trouble
+ */
+static struct clockdomain core_l4_3xxx_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
+};
+
+/* Another case of bit name collisions between several registers: EN_DSS */
+static struct clockdomain dss_3xxx_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm		= { .name = "dss_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
+	.wkdep_srcs	= dss_wkdeps,
+	.sleepdep_srcs	= dss_sleepdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
+};
+
+static struct clockdomain cam_clkdm = {
+	.name		= "cam_clkdm",
+	.pwrdm		= { .name = "cam_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= cam_wkdeps,
+	.sleepdep_srcs	= cam_sleepdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
+};
+
+static struct clockdomain usbhost_clkdm = {
+	.name		= "usbhost_clkdm",
+	.pwrdm		= { .name = "usbhost_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.wkdep_srcs	= usbhost_wkdeps,
+	.sleepdep_srcs	= usbhost_sleepdeps,
+	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
+};
+
+static struct clockdomain per_clkdm = {
+	.name		= "per_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.dep_bit	= OMAP3430_EN_PER_SHIFT,
+	.wkdep_srcs	= per_wkdeps,
+	.sleepdep_srcs	= per_sleepdeps,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
+};
+
+/*
+ * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
+ * switched of even if sdti is in use
+ */
+static struct clockdomain emu_clkdm = {
+	.name		= "emu_clkdm",
+	.pwrdm		= { .name = "emu_pwrdm" },
+	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
+	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
+};
+
+static struct clockdomain dpll1_clkdm = {
+	.name		= "dpll1_clkdm",
+	.pwrdm		= { .name = "dpll1_pwrdm" },
+};
+
+static struct clockdomain dpll2_clkdm = {
+	.name		= "dpll2_clkdm",
+	.pwrdm		= { .name = "dpll2_pwrdm" },
+};
+
+static struct clockdomain dpll3_clkdm = {
+	.name		= "dpll3_clkdm",
+	.pwrdm		= { .name = "dpll3_pwrdm" },
+};
+
+static struct clockdomain dpll4_clkdm = {
+	.name		= "dpll4_clkdm",
+	.pwrdm		= { .name = "dpll4_pwrdm" },
+};
+
+static struct clockdomain dpll5_clkdm = {
+	.name		= "dpll5_clkdm",
+	.pwrdm		= { .name = "dpll5_pwrdm" },
+};
+
+/*
+ * Clockdomain hwsup dependencies
+ */
+
+static struct clkdm_autodep clkdm_autodeps[] = {
+	{
+		.clkdm = { .name = "mpu_clkdm" },
+	},
+	{
+		.clkdm = { .name = "iva2_clkdm" },
+	},
+	{
+		.clkdm = { .name = NULL },
+	}
+};
+
+/*
+ *
+ */
+
+static struct clockdomain *clockdomains_omap3430_common[] __initdata = {
+	&wkup_common_clkdm,
+	&cm_common_clkdm,
+	&prm_common_clkdm,
+	&mpu_3xxx_clkdm,
+	&neon_clkdm,
+	&iva2_clkdm,
+	&d2d_clkdm,
+	&core_l3_3xxx_clkdm,
+	&core_l4_3xxx_clkdm,
+	&dss_3xxx_clkdm,
+	&cam_clkdm,
+	&per_clkdm,
+	&emu_clkdm,
+	&dpll1_clkdm,
+	&dpll2_clkdm,
+	&dpll3_clkdm,
+	&dpll4_clkdm,
+	NULL
+};
+
+static struct clockdomain *clockdomains_omap3430es1[] __initdata = {
+	&gfx_3430es1_clkdm,
+	NULL,
+};
+
+static struct clockdomain *clockdomains_omap3430es2plus[] __initdata = {
+	&sgx_clkdm,
+	&dpll5_clkdm,
+	&usbhost_clkdm,
+	NULL,
+};
+
+void __init omap3xxx_clockdomains_init(void)
+{
+	struct clockdomain **sc;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	clkdm_register_platform_funcs(&omap3_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_omap3430_common);
+
+	sc = (omap_rev() == OMAP3430_REV_ES1_0) ? clockdomains_omap3430es1 :
+		clockdomains_omap3430es2plus;
+
+	clkdm_register_clkdms(sc);
+
+	clkdm_register_autodeps(clkdm_autodeps);
+	clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index c75411a..9299ac2 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -34,350 +34,122 @@
 /* Static Dependencies for OMAP4 Clock Domains */
 
 static struct clkdm_dep d2d_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_2_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l3_init_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep ducati_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_gfx_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "tesla_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_2_clkdm" },
+	{ .clkdm_name = "l3_dss_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l3_gfx_clkdm" },
+	{ .clkdm_name = "l3_init_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
+	{ .clkdm_name = "l4_secure_clkdm" },
+	{ .clkdm_name = "l4_wkup_clkdm" },
+	{ .clkdm_name = "tesla_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep iss_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep ivahd_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep l3_dma_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ducati_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ducati_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_dss_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l3_init_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
+	{ .clkdm_name = "l4_secure_clkdm" },
+	{ .clkdm_name = "l4_wkup_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep l3_dss_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_2_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep l3_gfx_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep l3_init_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
+	{ .clkdm_name = "l4_secure_clkdm" },
+	{ .clkdm_name = "l4_wkup_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep l4_secure_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep mpu_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ducati_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_dss_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_gfx_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_secure_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "tesla_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ducati_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_2_clkdm" },
+	{ .clkdm_name = "l3_dss_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l3_gfx_clkdm" },
+	{ .clkdm_name = "l3_init_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
+	{ .clkdm_name = "l4_secure_clkdm" },
+	{ .clkdm_name = "l4_wkup_clkdm" },
+	{ .clkdm_name = "tesla_clkdm" },
 	{ NULL },
 };
 
 static struct clkdm_dep tesla_wkup_sleep_deps[] = {
-	{
-		.clkdm_name	 = "abe_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "ivahd_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_1_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_2_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_emif_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l3_init_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_cfg_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_per_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
-	{
-		.clkdm_name	 = "l4_wkup_clkdm",
-		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
-	},
+	{ .clkdm_name = "abe_clkdm" },
+	{ .clkdm_name = "ivahd_clkdm" },
+	{ .clkdm_name = "l3_1_clkdm" },
+	{ .clkdm_name = "l3_2_clkdm" },
+	{ .clkdm_name = "l3_emif_clkdm" },
+	{ .clkdm_name = "l3_init_clkdm" },
+	{ .clkdm_name = "l4_cfg_clkdm" },
+	{ .clkdm_name = "l4_per_clkdm" },
+	{ .clkdm_name = "l4_wkup_clkdm" },
 	{ NULL },
 };
 
@@ -388,7 +160,6 @@ static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_CEFUSE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CEFUSE_CEFUSE_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l4_cfg_44xx_clkdm = {
@@ -399,7 +170,6 @@ static struct clockdomain l4_cfg_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L4CFG_CDOFFS,
 	.dep_bit	  = OMAP4430_L4CFG_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain tesla_44xx_clkdm = {
@@ -412,7 +182,6 @@ static struct clockdomain tesla_44xx_clkdm = {
 	.wkdep_srcs	  = tesla_wkup_sleep_deps,
 	.sleepdep_srcs	  = tesla_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_gfx_44xx_clkdm = {
@@ -425,7 +194,6 @@ static struct clockdomain l3_gfx_44xx_clkdm = {
 	.wkdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain ivahd_44xx_clkdm = {
@@ -438,7 +206,6 @@ static struct clockdomain ivahd_44xx_clkdm = {
 	.wkdep_srcs	  = ivahd_wkup_sleep_deps,
 	.sleepdep_srcs	  = ivahd_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l4_secure_44xx_clkdm = {
@@ -451,7 +218,6 @@ static struct clockdomain l4_secure_44xx_clkdm = {
 	.wkdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l4_per_44xx_clkdm = {
@@ -462,7 +228,6 @@ static struct clockdomain l4_per_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4PER_CDOFFS,
 	.dep_bit	  = OMAP4430_L4PER_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain abe_44xx_clkdm = {
@@ -473,7 +238,6 @@ static struct clockdomain abe_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM1_ABE_ABE_CDOFFS,
 	.dep_bit	  = OMAP4430_ABE_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_instr_44xx_clkdm = {
@@ -482,7 +246,6 @@ static struct clockdomain l3_instr_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3INSTR_CDOFFS,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_init_44xx_clkdm = {
@@ -495,7 +258,6 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain d2d_44xx_clkdm = {
@@ -507,7 +269,6 @@ static struct clockdomain d2d_44xx_clkdm = {
 	.wkdep_srcs	  = d2d_wkup_sleep_deps,
 	.sleepdep_srcs	  = d2d_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain mpu0_44xx_clkdm = {
@@ -517,7 +278,6 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain mpu1_44xx_clkdm = {
@@ -527,7 +287,6 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_emif_44xx_clkdm = {
@@ -538,7 +297,6 @@ static struct clockdomain l3_emif_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_MEMIF_CDOFFS,
 	.dep_bit	  = OMAP4430_MEMIF_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l4_ao_44xx_clkdm = {
@@ -548,7 +306,6 @@ static struct clockdomain l4_ao_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_CM2_ALWAYS_ON_INST,
 	.clkdm_offs	  = OMAP4430_CM2_ALWAYS_ON_ALWON_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain ducati_44xx_clkdm = {
@@ -561,7 +318,6 @@ static struct clockdomain ducati_44xx_clkdm = {
 	.wkdep_srcs	  = ducati_wkup_sleep_deps,
 	.sleepdep_srcs	  = ducati_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain mpu_44xx_clkdm = {
@@ -573,7 +329,6 @@ static struct clockdomain mpu_44xx_clkdm = {
 	.wkdep_srcs	  = mpu_wkup_sleep_deps,
 	.sleepdep_srcs	  = mpu_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_2_44xx_clkdm = {
@@ -584,7 +339,6 @@ static struct clockdomain l3_2_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_2_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_2_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_1_44xx_clkdm = {
@@ -595,7 +349,6 @@ static struct clockdomain l3_1_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_1_CDOFFS,
 	.dep_bit	  = OMAP4430_L3_1_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain iss_44xx_clkdm = {
@@ -607,7 +360,6 @@ static struct clockdomain iss_44xx_clkdm = {
 	.wkdep_srcs	  = iss_wkup_sleep_deps,
 	.sleepdep_srcs	  = iss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_dss_44xx_clkdm = {
@@ -620,7 +372,6 @@ static struct clockdomain l3_dss_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l4_wkup_44xx_clkdm = {
@@ -631,7 +382,6 @@ static struct clockdomain l4_wkup_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 	.dep_bit	  = OMAP4430_L4WKUP_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain emu_sys_44xx_clkdm = {
@@ -641,7 +391,6 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
@@ -653,7 +402,6 @@ static struct clockdomain l3_dma_44xx_clkdm = {
 	.wkdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* As clockdomains are added or removed above, this list must also be changed */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..d098c87 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -342,11 +342,11 @@ void __init omap2_init_common_infrastructure(void)
 
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
-		omap2xxx_clockdomains_init();
+		omap242x_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
 		omap2xxx_powerdomains_init();
-		omap2xxx_clockdomains_init();
+		omap243x_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
