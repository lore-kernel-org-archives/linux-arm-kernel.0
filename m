From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Jan 2010 21:45:21 -0700 (MST)
Subject: [PATCH 05/10] OMAP clockdomains: add usecounting for wakeup and
	sleep dependencies
In-Reply-To: <20100112010537.6275.74977.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
	<20100112010537.6275.74977.stgit@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1001202141090.24456@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Kevin identified two bugs in this patch (and the one that immediately 
followed it) during PM branch testing.  These bugs, and the fixes 
implemented for them, are described below in the revised patch. In the 
process of fixing it, this patch and the next one were combined.

This patch has taken the place of the previously-posted 05/10 and 06/10 
patches in the for_2.6.34 branch.

regards,

- Paul


From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP clockdomains: add usecounting for wakeup and sleep dependencies

Add usecounting for wakeup and sleep dependencies.  In the current
situation, if several functions add dependencies on the same
clockdomains, when the first dependency removal function is called,
the dependency will be incorrectly removed from the hardware.

Add clkdm_clear_all_wkdeps() and clkdm_clear_all_sleepdeps(), which
provide a fast and usecounting-consistent way to clear all hardware
clockdomain dependencies, since accesses to these registers can be
quite slow.  pm{2,3}4xx.c has been updated to use these new functions.
The original version of this patch did not touch these files, which
previously wrote directly to the wkdep registers, and thus confused
the usecounting code.  This problem was found by Kevin Hilman
<khilman@deeprootsystems.com>.

N.B.: This patch introduces one significant functional difference over
the previous pm34xx.c code: sleepdeps are now cleared during
clockdomain initialization, whereas previously they were left
untouched.  This has been tested by Kevin and confirmed to work.

The original version of this patch also did not take into
consideration that some clockdomains do not have sleep or wakeup
dependency sources, which caused NULL pointer dereferences.  This
problem was debugged and fixed by Kevin Hilman
<khilman@deeprootsystems.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jouni H?gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  216 ++++++++++++++++++++++---
 arch/arm/mach-omap2/pm24xx.c                  |   49 ++++---
 arch/arm/mach-omap2/pm34xx.c                  |    3 +
 arch/arm/plat-omap/include/plat/clockdomain.h |    8 +
 4 files changed, 237 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2af9996..6eaa931 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -113,7 +113,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 		return ERR_PTR(-EINVAL);
 
 	for (cd = deps; cd->clkdm_name; cd++) {
-
 		if (!omap_chip_is(cd->omap_chip))
 			continue;
 
@@ -122,7 +121,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 
 		if (cd->clkdm == clkdm)
 			break;
-
 	}
 
 	if (!cd->clkdm_name)
@@ -254,6 +252,96 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 
 }
 
+/**
+ * _init_wkdep_usecount - initialize wkdep usecounts to match hardware
+ * @clkdm: clockdomain to initialize wkdep usecounts
+ *
+ * Initialize the wakeup dependency usecount variables for clockdomain @clkdm.
+ * If a wakeup dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software wakeup dependencies prior to calling this function if it wishes
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_wkdep_usecount(struct clockdomain *clkdm)
+{
+	u32 v;
+	struct clkdm_dep *cd;
+
+	if (!clkdm->wkdep_srcs)
+		return;
+
+	for (cd = clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
+		if (!cd->clkdm) {
+			WARN(!cd->clkdm, "clockdomain: %s: wkdep clkdm %s not "
+			     "found\n", clkdm->name, cd->clkdm_name);
+			continue;
+		}
+
+		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+					    PM_WKDEP,
+					    (1 << cd->clkdm->dep_bit));
+
+		if (v)
+			pr_debug("clockdomain: %s: wakeup dependency already "
+				 "set to wake up when %s wakes\n",
+				 clkdm->name, cd->clkdm->name);
+
+		atomic_set(&cd->wkdep_usecount, (v) ? 1 : 0);
+	}
+}
+
+/**
+ * _init_sleepdep_usecount - initialize sleepdep usecounts to match hardware
+ * @clkdm: clockdomain to initialize sleepdep usecounts
+ *
+ * Initialize the sleep dependency usecount variables for clockdomain @clkdm.
+ * If a sleep dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software sleep dependencies prior to calling this function if it wishes
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_sleepdep_usecount(struct clockdomain *clkdm)
+{
+	u32 v;
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!clkdm->sleepdep_srcs)
+		return;
+
+	for (cd = clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
+		if (!cd->clkdm) {
+			WARN(!cd->clkdm, "clockdomain: %s: sleepdep clkdm %s "
+			     "not found\n", clkdm->name, cd->clkdm_name);
+			continue;
+		}
+
+		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+					    OMAP3430_CM_SLEEPDEP,
+					    (1 << cd->clkdm->dep_bit));
+
+		if (v)
+			pr_debug("clockdomain: %s: sleep dependency already "
+				 "set to prevent from idling until %s "
+				 "idles\n", clkdm->name, cd->clkdm->name);
+
+		atomic_set(&cd->sleepdep_usecount, (v) ? 1 : 0);
+	}
+};
 
 /* Public functions */
 
@@ -272,6 +360,7 @@ void clkdm_init(struct clockdomain **clkdms,
 		struct clkdm_autodep *init_autodeps)
 {
 	struct clockdomain **c = NULL;
+	struct clockdomain *clkdm;
 	struct clkdm_autodep *autodep = NULL;
 
 	if (clkdms)
@@ -282,6 +371,15 @@ void clkdm_init(struct clockdomain **clkdms,
 	if (autodeps)
 		for (autodep = autodeps; autodep->clkdm.ptr; autodep++)
 			_autodep_lookup(autodep);
+
+	/*
+	 * Ensure that the *dep_usecount registers reflect the current
+	 * state of the PRCM.
+	 */
+	list_for_each_entry(clkdm, &clkdm_list, node) {
+		_init_wkdep_usecount(clkdm);
+		_init_sleepdep_usecount(clkdm);
+	}
 }
 
 /**
@@ -387,11 +485,13 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
-		 clkdm1->name, clkdm2->name);
+	if (atomic_inc_return(&cd->wkdep_usecount) == 1) {
+		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
+			 "up\n", clkdm1->name, clkdm2->name);
 
-	prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-			     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	}
 
 	return 0;
 }
@@ -420,11 +520,13 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: hardware will no longer wake up %s after %s "
-		 "wakes up\n", clkdm1->name, clkdm2->name);
+	if (atomic_dec_return(&cd->wkdep_usecount) == 0) {
+		pr_debug("clockdomain: hardware will no longer wake up %s "
+			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-	prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-			       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	}
 
 	return 0;
 }
@@ -457,11 +559,44 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
+	/* XXX It's faster to return the atomic wkdep_usecount */
 	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
 				       (1 << clkdm2->dep_bit));
 }
 
 /**
+ * clkdm_clear_all_wkdeps - remove all wakeup dependencies from target clkdm
+ * @clkdm: struct clockdomain * to remove all wakeup dependencies from
+ *
+ * Remove all inter-clockdomain wakeup dependencies that could cause
+ * @clkdm to wake.  Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->wkdep_usecount, 0);
+	}
+
+	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
  * clkdm_add_sleepdep - add a sleep dependency from clkdm2 to clkdm1
  * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
  * @clkdm2: when this struct clockdomain * is active (source)
@@ -491,12 +626,14 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: will prevent %s from sleeping if %s is active\n",
-		 clkdm1->name, clkdm2->name);
+	if (atomic_inc_return(&cd->sleepdep_usecount) == 1) {
+		pr_debug("clockdomain: will prevent %s from sleeping if %s "
+			 "is active\n", clkdm1->name, clkdm2->name);
 
-	cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-			    clkdm1->pwrdm.ptr->prcm_offs,
-			    OMAP3430_CM_SLEEPDEP);
+		cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				    clkdm1->pwrdm.ptr->prcm_offs,
+				    OMAP3430_CM_SLEEPDEP);
+	}
 
 	return 0;
 }
@@ -531,12 +668,15 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: will no longer prevent %s from sleeping if "
-		 "%s is active\n", clkdm1->name, clkdm2->name);
+	if (atomic_dec_return(&cd->sleepdep_usecount) == 0) {
+		pr_debug("clockdomain: will no longer prevent %s from "
+			 "sleeping if %s is active\n", clkdm1->name,
+			 clkdm2->name);
 
-	cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-			      clkdm1->pwrdm.ptr->prcm_offs,
-			      OMAP3430_CM_SLEEPDEP);
+		cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				      clkdm1->pwrdm.ptr->prcm_offs,
+				      OMAP3430_CM_SLEEPDEP);
+	}
 
 	return 0;
 }
@@ -575,11 +715,47 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
+	/* XXX It's faster to return the atomic sleepdep_usecount */
 	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
 				       OMAP3430_CM_SLEEPDEP,
 				       (1 << clkdm2->dep_bit));
 }
 
+/**
+ * clkdm_clear_all_sleepdeps - remove all sleep dependencies from target clkdm
+ * @clkdm: struct clockdomain * to remove all sleep dependencies from
+ *
+ * Remove all inter-clockdomain sleep dependencies that could prevent
+ * @clkdm from idling.  Intended to be used during boot to initialize the
+ * PRCM to a known state, after all clockdomains are put into swsup idle
+ * and woken up.  Returns -EINVAL if @clkdm pointer is invalid, or
+ * 0 upon success.
+ */
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->sleepdep_usecount, 0);
+	}
+
+	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+			       OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
 
 /**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 7543818..374299e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -57,11 +57,8 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 				  void __iomem *sdrc_power);
 
-static struct powerdomain *mpu_pwrdm;
-static struct powerdomain *core_pwrdm;
-
-static struct clockdomain *dsp_clkdm;
-static struct clockdomain *gfx_clkdm;
+static struct powerdomain *mpu_pwrdm, *core_pwrdm;
+static struct clockdomain *dsp_clkdm, *mpu_clkdm, *wkup_clkdm, *gfx_clkdm;
 
 static struct clk *osc_ck, *emul_ck;
 
@@ -334,9 +331,17 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm, void *unused)
+/* XXX This function should be shareable between OMAP2xxx and OMAP3 */
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-	omap2_clkdm_allow_idle(clkdm);
+	clkdm_clear_all_wkdeps(clkdm);
+	clkdm_clear_all_sleepdeps(clkdm);
+
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		omap2_clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+		 atomic_read(&clkdm->usecount) == 0)
+		omap2_clkdm_sleep(clkdm);
 	return 0;
 }
 
@@ -349,14 +354,6 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
-	/* Set all domain wakeup dependencies */
-	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, CORE_MOD, PM_WKDEP);
-	if (cpu_is_omap2430())
-		prm_write_mod_reg(0, OMAP2430_MDM_MOD, PM_WKDEP);
-
 	/*
 	 * Set CORE powerdomain memory banks to retain their contents
 	 * during RETENTION
@@ -385,8 +382,12 @@ static void __init prcm_setup_regs(void)
 	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
 	omap2_clkdm_sleep(gfx_clkdm);
 
-	/* Enable clockdomain hardware-supervised control for all clkdms */
-	clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
+	/*
+	 * Clear clockdomain wakeup dependencies and enable
+	 * hardware-supervised idle for all clkdms
+	 */
+	clkdm_for_each(clkdms_setup, NULL);
+	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
@@ -482,7 +483,7 @@ static int __init omap2_pm_init(void)
 	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
-	/* Look up important powerdomains, clockdomains */
+	/* Look up important powerdomains */
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (!mpu_pwrdm)
@@ -492,9 +493,19 @@ static int __init omap2_pm_init(void)
 	if (!core_pwrdm)
 		pr_err("PM: core_pwrdm not found\n");
 
+	/* Look up important clockdomains */
+
+	mpu_clkdm = clkdm_lookup("mpu_clkdm");
+	if (!mpu_clkdm)
+		pr_err("PM: mpu_clkdm not found\n");
+
+	wkup_clkdm = clkdm_lookup("wkup_clkdm");
+	if (!wkup_clkdm)
+		pr_err("PM: wkup_clkdm not found\n");
+
 	dsp_clkdm = clkdm_lookup("dsp_clkdm");
 	if (!dsp_clkdm)
-		pr_err("PM: mpu_clkdm not found\n");
+		pr_err("PM: dsp_clkdm not found\n");
 
 	gfx_clkdm = clkdm_lookup("gfx_clkdm");
 	if (!gfx_clkdm)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c34c92e..d8c3b9a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -993,6 +993,9 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
  */
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
+	clkdm_clear_all_wkdeps(clkdm);
+	clkdm_clear_all_sleepdeps(clkdm);
+
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
 		omap2_clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index 2286971..45b5deb 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -70,6 +70,12 @@ struct clkdm_dep {
 	/* Clockdomain pointer - resolved by the clockdomain code */
 	struct clockdomain *clkdm;
 
+	/* Number of wakeup dependencies causing this clkdm to wake  */
+	atomic_t wkdep_usecount;
+
+	/* Number of sleep dependencies that could prevent clkdm from idle */
+	atomic_t sleepdep_usecount;
+
 	/* Flags to mark OMAP chip restrictions, etc. */
 	const struct omap_chip_id omap_chip;
 
@@ -126,9 +132,11 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
 int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
-- 
1.6.6.rc2.5.g49666
