From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 18:05:34 -0700
Subject: [PATCH 01/10] OMAP2/3 clkdm/pwrdm: move wkdep/sleepdep handling from
	pwrdm to clkdm
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Message-ID: <20100112010531.6275.88841.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move clockdomain wakeup dependency and sleep dependency data
structures from the powerdomain layer to the clockdomain layer, where
they belong.  These dependencies were originally placed in the
powerdomain layer due to unclear documentation; however, it is clear
now that these dependencies are between clockdomains.  For OMAP2/3,
this is not such a big problem, but for OMAP4 this needs to be fixed.

Thanks to Beno?t Cousson <b-cousson@ti.com> for his advice on this
patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  368 ++++++++++++++++++++----
 arch/arm/mach-omap2/clockdomains.h            |  378 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                      |    2 
 arch/arm/mach-omap2/omap_hwmod.c              |   10 -
 arch/arm/mach-omap2/pm34xx.c                  |   10 +
 arch/arm/mach-omap2/powerdomain.c             |  259 -----------------
 arch/arm/mach-omap2/powerdomains.h            |   88 +-----
 arch/arm/mach-omap2/powerdomains24xx.h        |   87 ------
 arch/arm/mach-omap2/powerdomains34xx.h        |  145 ----------
 arch/arm/mach-omap2/prcm.c                    |   12 +
 arch/arm/plat-omap/include/plat/clockdomain.h |   50 +++
 arch/arm/plat-omap/include/plat/powerdomain.h |   34 --
 arch/arm/plat-omap/include/plat/prcm.h        |    8 +
 13 files changed, 761 insertions(+), 690 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8c9e78c..a70ba29 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -27,14 +27,14 @@
 
 #include <linux/bitops.h>
 
-#include <plat/clock.h>
-
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "cm.h"
 
+#include <plat/clock.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/prcm.h>
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
@@ -42,28 +42,75 @@ static LIST_HEAD(clkdm_list);
 /* clkdm_mutex protects clkdm_list add and del ops */
 static DEFINE_MUTEX(clkdm_mutex);
 
-/* array of powerdomain deps to be added/removed when clkdm in hwsup mode */
-static struct clkdm_pwrdm_autodep *autodeps;
+/* array of clockdomain deps to be added/removed when clkdm in hwsup mode */
+static struct clkdm_autodep *autodeps;
 
 
 /* Private functions */
 
+static struct clockdomain *_clkdm_lookup(const char *name)
+{
+	struct clockdomain *clkdm, *temp_clkdm;
+
+	if (!name)
+		return NULL;
+
+	clkdm = NULL;
+
+	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
+		if (!strcmp(name, temp_clkdm->name)) {
+			clkdm = temp_clkdm;
+			break;
+		}
+	}
+
+	return clkdm;
+}
+
+/* _clkdm_deps_lookup - look up the specified clockdomain in a clkdm list */
+static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
+					    struct clkdm_dep *deps)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm || !deps || !omap_chip_is(clkdm->omap_chip))
+		return ERR_PTR(-EINVAL);
+
+	for (cd = deps; cd->clkdm_name; cd++) {
+
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
+		if (cd->clkdm == clkdm)
+			break;
+
+	}
+
+	if (!cd->clkdm_name)
+		return ERR_PTR(-ENOENT);
+
+	return cd;
+}
+
 /*
- * _autodep_lookup - resolve autodep pwrdm names to pwrdm pointers; store
- * @autodep: struct clkdm_pwrdm_autodep * to resolve
+ * _autodep_lookup - resolve autodep clkdm names to clkdm pointers; store
+ * @autodep: struct clkdm_autodep * to resolve
  *
- * Resolve autodep powerdomain names to powerdomain pointers via
- * pwrdm_lookup() and store the pointers in the autodep structure.  An
- * "autodep" is a powerdomain sleep/wakeup dependency that is
+ * Resolve autodep clockdomain names to clockdomain pointers via
+ * clkdm_lookup() and store the pointers in the autodep structure.  An
+ * "autodep" is a clockdomain sleep/wakeup dependency that is
  * automatically added and removed whenever clocks in the associated
  * clockdomain are enabled or disabled (respectively) when the
  * clockdomain is in hardware-supervised mode.	Meant to be called
  * once at clockdomain layer initialization, since these should remain
  * fixed for a particular architecture.  No return value.
  */
-static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
+static void _autodep_lookup(struct clkdm_autodep *autodep)
 {
-	struct powerdomain *pwrdm;
+	struct clockdomain *clkdm;
 
 	if (!autodep)
 		return;
@@ -71,13 +118,13 @@ static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
 	if (!omap_chip_is(autodep->omap_chip))
 		return;
 
-	pwrdm = pwrdm_lookup(autodep->pwrdm.name);
-	if (!pwrdm) {
-		pr_err("clockdomain: autodeps: powerdomain %s does not exist\n",
-			 autodep->pwrdm.name);
-		pwrdm = ERR_PTR(-ENOENT);
+	clkdm = clkdm_lookup(autodep->clkdm.name);
+	if (!clkdm) {
+		pr_err("clockdomain: autodeps: clockdomain %s does not exist\n",
+			 autodep->clkdm.name);
+		clkdm = ERR_PTR(-ENOENT);
 	}
-	autodep->pwrdm.ptr = pwrdm;
+	autodep->clkdm.ptr = clkdm;
 }
 
 /*
@@ -90,21 +137,21 @@ static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
  */
 static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
-	struct clkdm_pwrdm_autodep *autodep;
+	struct clkdm_autodep *autodep;
 
-	for (autodep = autodeps; autodep->pwrdm.ptr; autodep++) {
-		if (IS_ERR(autodep->pwrdm.ptr))
+	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
+		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
 		if (!omap_chip_is(autodep->omap_chip))
 			continue;
 
 		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
-			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
-			 clkdm->pwrdm.ptr->name);
+			 "clkdm %s\n", autodep->clkdm.ptr->name,
+			 clkdm->name);
 
-		pwrdm_add_sleepdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
-		pwrdm_add_wkdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
+		clkdm_add_sleepdep(clkdm, autodep->clkdm.ptr);
+		clkdm_add_wkdep(clkdm, autodep->clkdm.ptr);
 	}
 }
 
@@ -118,21 +165,21 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
  */
 static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
-	struct clkdm_pwrdm_autodep *autodep;
+	struct clkdm_autodep *autodep;
 
-	for (autodep = autodeps; autodep->pwrdm.ptr; autodep++) {
-		if (IS_ERR(autodep->pwrdm.ptr))
+	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
+		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
 
 		if (!omap_chip_is(autodep->omap_chip))
 			continue;
 
 		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
-			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
-			 clkdm->pwrdm.ptr->name);
+			 "clkdm %s\n", autodep->clkdm.ptr->name,
+			 clkdm->name);
 
-		pwrdm_del_sleepdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
-		pwrdm_del_wkdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
+		clkdm_del_sleepdep(clkdm, autodep->clkdm.ptr);
+		clkdm_del_wkdep(clkdm, autodep->clkdm.ptr);
 	}
 }
 
@@ -171,25 +218,6 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 
 }
 
-static struct clockdomain *_clkdm_lookup(const char *name)
-{
-	struct clockdomain *clkdm, *temp_clkdm;
-
-	if (!name)
-		return NULL;
-
-	clkdm = NULL;
-
-	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
-		if (!strcmp(name, temp_clkdm->name)) {
-			clkdm = temp_clkdm;
-			break;
-		}
-	}
-
-	return clkdm;
-}
-
 
 /* Public functions */
 
@@ -200,26 +228,24 @@ static struct clockdomain *_clkdm_lookup(const char *name)
  *
  * Set up internal state.  If a pointer to an array of clockdomains
  * was supplied, loop through the list of clockdomains, register all
- * that are available on the current platform.	Similarly, if a
- * pointer to an array of clockdomain-powerdomain autodependencies was
- * provided, register those.  No return value.
+ * that are available on the current platform. Similarly, if a pointer
+ * to an array of clockdomain autodependencies was provided, register
+ * those.  No return value.
  */
 void clkdm_init(struct clockdomain **clkdms,
-		struct clkdm_pwrdm_autodep *init_autodeps)
+		struct clkdm_autodep *init_autodeps)
 {
 	struct clockdomain **c = NULL;
-	struct clkdm_pwrdm_autodep *autodep = NULL;
+	struct clkdm_autodep *autodep = NULL;
 
 	if (clkdms)
 		for (c = clkdms; *c; c++)
 			clkdm_register(*c);
 
-	if (!cpu_is_omap44xx()) {
-		autodeps = init_autodeps;
-		if (autodeps)
-			for (autodep = autodeps; autodep->pwrdm.ptr; autodep++)
-				_autodep_lookup(autodep);
-	}
+	autodeps = init_autodeps;
+	if (autodeps)
+		for (autodep = autodeps; autodep->clkdm.ptr; autodep++)
+			_autodep_lookup(autodep);
 }
 
 /**
@@ -374,6 +400,226 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
 /* Hardware clockdomain control */
 
 /**
+ * clkdm_add_wkdep - add a wakeup dependency from clkdm2 to clkdm1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * When the clockdomain represented by @clkdm2 wakes up, wake up
+ * @clkdm1. Implemented in hardware on the OMAP, this feature is
+ * designed to reduce wakeup latency of the dependent clockdomain @clkdm1.
+ * Returns -EINVAL if presented with invalid clockdomain pointers,
+ * -ENOENT if @clkdm2 cannot wake up clkdm1 in hardware, or 0 upon
+ * success.
+ */
+int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
+		 clkdm1->name, clkdm2->name);
+
+	prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+			     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_del_wkdep - remove a wakeup dependency from clkdm2 to clkdm1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * Remove a wakeup dependency causing @clkdm1 to wake up when @clkdm2
+ * wakes up.  Returns -EINVAL if presented with invalid clockdomain
+ * pointers, -ENOENT if @clkdm2 cannot wake up clkdm1 in hardware, or
+ * 0 upon success.
+ */
+int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: hardware will no longer wake up %s after %s "
+		 "wakes up\n", clkdm1->name, clkdm2->name);
+
+	prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+			       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_read_wkdep - read wakeup dependency state from clkdm2 to clkdm1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * Return 1 if a hardware wakeup dependency exists wherein @clkdm1 will be
+ * awoken when @clkdm2 wakes up; 0 if dependency is not set; -EINVAL
+ * if either clockdomain pointer is invalid; or -ENOENT if the hardware
+ * is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controllable
+ * wakeup dependencies.  Wakeup dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
+				       (1 << clkdm2->dep_bit));
+}
+
+/**
+ * clkdm_add_sleepdep - add a sleep dependency from clkdm2 to clkdm1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Prevent @clkdm1 from automatically going inactive (and then to
+ * retention or off) if @clkdm2 is active.  Returns -EINVAL if
+ * presented with invalid clockdomain pointers or called on a machine
+ * that does not support software-configurable hardware sleep
+ * dependencies, -ENOENT if the specified dependency cannot be set in
+ * hardware, or 0 upon success.
+ */
+int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: will prevent %s from sleeping if %s is active\n",
+		 clkdm1->name, clkdm2->name);
+
+	cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+			    clkdm1->pwrdm.ptr->prcm_offs,
+			    OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_del_sleepdep - remove a sleep dependency from clkdm2 to clkdm1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Allow @clkdm1 to automatically go inactive (and then to retention or
+ * off), independent of the activity state of @clkdm2.  Returns -EINVAL
+ * if presented with invalid clockdomain pointers or called on a machine
+ * that does not support software-configurable hardware sleep dependencies,
+ * -ENOENT if the specified dependency cannot be cleared in hardware, or
+ * 0 upon success.
+ */
+int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: will no longer prevent %s from sleeping if "
+		 "%s is active\n", clkdm1->name, clkdm2->name);
+
+	cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+			      clkdm1->pwrdm.ptr->prcm_offs,
+			      OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_read_sleepdep - read sleep dependency state from clkdm2 to clkdm1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Return 1 if a hardware sleep dependency exists wherein @clkdm1 will
+ * not be allowed to automatically go inactive if @clkdm2 is active;
+ * 0 if @clkdm1's automatic power state inactivity transition is independent
+ * of @clkdm2's; -EINVAL if either clockdomain pointer is invalid or called
+ * on a machine that does not support software-configurable hardware sleep
+ * dependencies; or -ENOENT if the hardware is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controllable
+ * sleep dependencies.	Sleep dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				       OMAP3430_CM_SLEEPDEP,
+				       (1 << clkdm2->dep_bit));
+}
+
+
+/**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
  * @clk: struct clk * of a clockdomain
  *
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 6dc5ddc..ff216f2 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -2,9 +2,28 @@
  * OMAP2/3 clockdomains
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Written by Paul Walmsley and Jouni H?gander
+ *
+ * This file contains clockdomains and clockdomain wakeup/sleep
+ * dependencies for the OMAP2/3 chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs or sleepdep_srcs array must have a
+ * dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are really just
+ * software-controllable dependencies.  Non-software-controllable
+ * dependencies do exist, but they are not encoded below (yet).
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
  */
 
 /*
@@ -21,6 +40,287 @@
 #include "prm.h"
 
 /*
+ * Clockdomain dependencies for wkdeps/sleepdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* OMAP2/3-common wakeup dependencies */
+
+/*
+ * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
+ * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
+ * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ */
+static struct clkdm_dep gfx_sgx_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
+					    CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
+					    CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* 24XX-specific possible dependencies */
+
+#ifdef CONFIG_ARCH_OMAP24XX
+
+/* Wakeup dependency source arrays */
+
+/*
+ * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
+ * 2420/2430 PM_WKDEP_MDM: same as DSP
+ */
+static struct clkdm_dep dsp_mdm_24xx_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2430 adds MDM
+ */
+static struct clkdm_dep mpu_24xx_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "dsp_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "mdm_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
+ * 2430 adds MDM
+ */
+static struct clkdm_dep core_24xx_wkdeps[] = {
+	{
+		.clkdm_name = "dsp_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "gfx_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "mdm_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+#endif
+
+/* 34XX-specific possible dependencies */
+
+#ifdef CONFIG_ARCH_OMAP34XX
+
+/*
+ * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
+ * (USBHOST is ES2 only)
+ */
+static struct clkdm_dep per_usbhost_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
+ */
+static struct clkdm_dep mpu_34xx_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "dss_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "per_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
+ */
+static struct clkdm_dep iva2_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "dss_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "per_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
+static struct clkdm_dep cam_dss_wkdeps[] = {
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430: PM_WKDEP_NEON: MPU */
+static struct clkdm_dep neon_wkdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* Sleep dependency source arrays for 34xx-specific clkdms - 34XX only */
+
+/*
+ * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
+ * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
+ */
+static struct clkdm_dep dss_per_usbhost_sleepdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430: CM_SLEEPDEP_CAM: MPU
+ * 3430ES1: CM_SLEEPDEP_GFX: MPU
+ * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ */
+static struct clkdm_dep cam_gfx_sleepdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+#endif /* CONFIG_ARCH_OMAP34XX */
+
+
+/*
  * OMAP2/3-common clockdomains
  *
  * Even though the 2420 has a single PRCM module from the
@@ -35,6 +335,7 @@
 static struct clockdomain wkup_clkdm = {
 	.name		= "wkup_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
+	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
@@ -63,6 +364,7 @@ static struct clockdomain mpu_2420_clkdm = {
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= mpu_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -73,6 +375,8 @@ static struct clockdomain iva1_2420_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -92,6 +396,7 @@ static struct clockdomain gfx_2420_clkdm = {
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -101,6 +406,7 @@ static struct clockdomain core_l3_2420_clkdm = {
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -110,6 +416,7 @@ static struct clockdomain core_l4_2420_clkdm = {
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -138,16 +445,20 @@ static struct clockdomain mpu_2430_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(MPU_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= mpu_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* Another case of bit name collisions between several registers: EN_MDM */
 static struct clockdomain mdm_clkdm = {
 	.name		= "mdm_clkdm",
 	.pwrdm		= { .name = "mdm_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -158,6 +469,8 @@ static struct clockdomain dsp_2430_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -167,24 +480,39 @@ static struct clockdomain gfx_2430_clkdm = {
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l3_2430_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l4_2430_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -212,6 +540,8 @@ static struct clockdomain mpu_34xx_clkdm = {
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
+	.wkdep_srcs	= mpu_34xx_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -222,6 +552,7 @@ static struct clockdomain neon_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_NEON_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= neon_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -232,6 +563,8 @@ static struct clockdomain iva2_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
+	.wkdep_srcs	= iva2_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -241,6 +574,8 @@ static struct clockdomain gfx_3430es1_clkdm = {
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= gfx_sgx_wkdeps,
+	.sleepdep_srcs	= cam_gfx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
@@ -251,6 +586,8 @@ static struct clockdomain sgx_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= gfx_sgx_wkdeps,
+	.sleepdep_srcs	= cam_gfx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -271,30 +608,46 @@ static struct clockdomain d2d_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l3_34xx_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l4_34xx_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* Another case of bit name collisions between several registers: EN_DSS */
 static struct clockdomain dss_34xx_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "dss_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
+	.wkdep_srcs	= cam_dss_wkdeps,
+	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -305,6 +658,8 @@ static struct clockdomain cam_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= cam_dss_wkdeps,
+	.sleepdep_srcs	= cam_gfx_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -315,6 +670,8 @@ static struct clockdomain usbhost_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	= per_usbhost_wkdeps,
+	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -325,6 +682,9 @@ static struct clockdomain per_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	= OMAP3430_EN_PER_SHIFT,
+	.wkdep_srcs	= per_usbhost_wkdeps,
+	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -378,25 +738,21 @@ static struct clockdomain dpll5_clkdm = {
 #include "clockdomains44xx.h"
 
 /*
- * Clockdomain-powerdomain hwsup dependencies (34XX only)
+ * Clockdomain hwsup dependencies (34XX only)
  */
 
-static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
-
-#ifdef CONFIG_ARCH_OMAP34XX
+static struct clkdm_autodep clkdm_autodeps[] = {
 	{
-		.pwrdm	   = { .name = "mpu_pwrdm" },
+		.clkdm	   = { .name = "mpu_clkdm" },
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 	},
 	{
-		.pwrdm	   = { .name = "iva2_pwrdm" },
+		.clkdm	   = { .name = "iva2_clkdm" },
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 	},
 	{
-		.pwrdm	   = { .name = NULL },
+		.clkdm	   = { .name = NULL },
 	}
-#endif
-
 };
 
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 51d7453..8c58699 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -313,7 +313,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		hwmods = omap34xx_hwmods;
 
 	pwrdm_init(powerdomains_omap);
-	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
+	clkdm_init(clockdomains_omap, clkdm_autodeps);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d8c8545..88d91de 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -298,15 +298,14 @@ static int _disable_wakeup(struct omap_hwmod *oh)
  * be accessed by the IVA, there should be a sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
  * mode.  Returns -EINVAL upon error or passes along
- * pwrdm_add_sleepdep() value upon success.
+ * clkdm_add_sleepdep() value upon success.
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
 
-	return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
-				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
 
 /**
@@ -319,15 +318,14 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * be accessed by the IVA, there should be no sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
  * mode.  Returns -EINVAL upon error or passes along
- * pwrdm_add_sleepdep() value upon success.
+ * clkdm_del_sleepdep() value upon success.
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
 
-	return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
-				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3189acc..ab110b4 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1013,6 +1013,7 @@ void omap_push_sram_idle(void)
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
+	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
 	int ret;
 
 	if (!cpu_is_omap34xx())
@@ -1052,6 +1053,11 @@ static int __init omap3_pm_init(void)
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
+	neon_clkdm = clkdm_lookup("neon_clkdm");
+	mpu_clkdm = clkdm_lookup("mpu_clkdm");
+	per_clkdm = clkdm_lookup("per_clkdm");
+	core_clkdm = clkdm_lookup("core_clkdm");
+
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
@@ -1060,14 +1066,14 @@ static int __init omap3_pm_init(void)
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
-	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	/*
 	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
 	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
 	 * waking up PER with every CORE wakeup - see
 	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
 	*/
-	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+	clkdm_add_wkdep(per_clkdm, core_clkdm);
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index c0de050..e8e8d88 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -2,7 +2,7 @@
  * OMAP powerdomain control
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -36,6 +36,7 @@
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/prcm.h>
 
 #include "pm.h"
 
@@ -88,17 +89,6 @@ static DEFINE_RWLOCK(pwrdm_rwlock);
 
 /* Private functions */
 
-static u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = prm_read_mod_reg(domain, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
 static struct powerdomain *_pwrdm_lookup(const char *name)
 {
 	struct powerdomain *pwrdm, *temp_pwrdm;
@@ -115,34 +105,6 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
 	return pwrdm;
 }
 
-/* _pwrdm_deps_lookup - look up the specified powerdomain in a pwrdm list */
-static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
-					      struct pwrdm_dep *deps)
-{
-	struct pwrdm_dep *pd;
-
-	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
-		return ERR_PTR(-EINVAL);
-
-	for (pd = deps; pd->pwrdm_name; pd++) {
-
-		if (!omap_chip_is(pd->omap_chip))
-			continue;
-
-		if (!pd->pwrdm && pd->pwrdm_name)
-			pd->pwrdm = pwrdm_lookup(pd->pwrdm_name);
-
-		if (pd->pwrdm == pwrdm)
-			break;
-
-	}
-
-	if (!pd->pwrdm_name)
-		return ERR_PTR(-ENOENT);
-
-	return pd->pwrdm;
-}
-
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
@@ -502,223 +464,6 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 	return ret;
 }
 
-
-/**
- * pwrdm_add_wkdep - add a wakeup dependency from pwrdm2 to pwrdm1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * When the powerdomain represented by pwrdm2 wakes up (due to an
- * interrupt), wake up pwrdm1.	Implemented in hardware on the OMAP,
- * this feature is designed to reduce wakeup latency of the dependent
- * powerdomain.  Returns -EINVAL if presented with invalid powerdomain
- * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
- * 0 upon success.
- */
-int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: hardware will wake up %s when %s wakes up\n",
-		 pwrdm1->name, pwrdm2->name);
-
-	prm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
-			     pwrdm1->prcm_offs, PM_WKDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_del_wkdep - remove a wakeup dependency from pwrdm2 to pwrdm1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * Remove a wakeup dependency that causes pwrdm1 to wake up when pwrdm2
- * wakes up.  Returns -EINVAL if presented with invalid powerdomain
- * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
- * 0 upon success.
- */
-int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: hardware will no longer wake up %s after %s "
-		 "wakes up\n", pwrdm1->name, pwrdm2->name);
-
-	prm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
-			       pwrdm1->prcm_offs, PM_WKDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_read_wkdep - read wakeup dependency state from pwrdm2 to pwrdm1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * Return 1 if a hardware wakeup dependency exists wherein pwrdm1 will be
- * awoken when pwrdm2 wakes up; 0 if dependency is not set; -EINVAL
- * if either powerdomain pointer is invalid; or -ENOENT if the hardware
- * is incapable.
- *
- * REVISIT: Currently this function only represents software-controllable
- * wakeup dependencies.  Wakeup dependencies fixed in hardware are not
- * yet handled here.
- */
-int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, PM_WKDEP,
-					(1 << pwrdm2->dep_bit));
-}
-
-/**
- * pwrdm_add_sleepdep - add a sleep dependency from pwrdm2 to pwrdm1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Prevent pwrdm1 from automatically going inactive (and then to
- * retention or off) if pwrdm2 is still active.	 Returns -EINVAL if
- * presented with invalid powerdomain pointers or called on a machine
- * that does not support software-configurable hardware sleep dependencies,
- * -ENOENT if the specified dependency cannot be set in hardware, or
- * 0 upon success.
- */
-int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: will prevent %s from sleeping if %s is active\n",
-		 pwrdm1->name, pwrdm2->name);
-
-	cm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
-			    pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_del_sleepdep - remove a sleep dependency from pwrdm2 to pwrdm1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Allow pwrdm1 to automatically go inactive (and then to retention or
- * off), independent of the activity state of pwrdm2.  Returns -EINVAL
- * if presented with invalid powerdomain pointers or called on a machine
- * that does not support software-configurable hardware sleep dependencies,
- * -ENOENT if the specified dependency cannot be cleared in hardware, or
- * 0 upon success.
- */
-int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: will no longer prevent %s from sleeping if "
-		 "%s is active\n", pwrdm1->name, pwrdm2->name);
-
-	cm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
-			      pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_read_sleepdep - read sleep dependency state from pwrdm2 to pwrdm1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Return 1 if a hardware sleep dependency exists wherein pwrdm1 will
- * not be allowed to automatically go inactive if pwrdm2 is active;
- * 0 if pwrdm1's automatic power state inactivity transition is independent
- * of pwrdm2's; -EINVAL if either powerdomain pointer is invalid or called
- * on a machine that does not support software-configurable hardware sleep
- * dependencies; or -ENOENT if the hardware is incapable.
- *
- * REVISIT: Currently this function only represents software-controllable
- * sleep dependencies.	Sleep dependencies fixed in hardware are not
- * yet handled here.
- */
-int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP,
-					(1 << pwrdm2->dep_bit));
-}
-
 /**
  * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
  * @pwrdm: struct powerdomain *
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index d646c99..faa8fc9 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 common powerdomain definitions
  *
- * Copyright (C) 2007-8 Texas Instruments, Inc.
- * Copyright (C) 2007-8 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H?gander
@@ -25,19 +25,8 @@
  * This file contains all of the powerdomains that have some element
  * of software control for the OMAP24xx and OMAP34XX chips.
  *
- * A few notes:
- *
  * This is not an exhaustive listing of powerdomains on the chips; only
  * powerdomains that can be controlled in software.
- *
- * A useful validation rule for struct powerdomain:
- * Any powerdomain referenced by a wkdep_srcs or sleepdep_srcs array
- * must have a dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are really
- * just software-controllable dependencies.  Non-software-controllable
- * dependencies do exist, but they are not encoded below (yet).
- *
- * 24xx does not support programmable sleep dependencies (SLEEPDEP)
- *
  */
 
 /*
@@ -47,26 +36,17 @@
  *
  * On the 2420, this is a 'C55 DSP called, simply, the DSP.  Its
  * powerdomain is called the "DSP power domain."  On the 2430, the
- * on-board DSP is a 'C64 DSP, now called the IVA2 or IVA2.1.  Its
- * powerdomain is still called the "DSP power domain."	On the 3430,
- * the DSP is a 'C64 DSP like the 2430, also known as the IVA2; but
- * its powerdomain is now called the "IVA2 power domain."
+ * on-board DSP is a 'C64 DSP, now called (along with its hardware
+ * accelerators) the IVA2 or IVA2.1.  Its powerdomain is still called
+ * the "DSP power domain." On the 3430, the DSP is a 'C64 DSP like the
+ * 2430, also known as the IVA2; but its powerdomain is now called the
+ * "IVA2 power domain."
  *
  * The 2420 also has something called the IVA, which is a separate ARM
  * core, and has nothing to do with the DSP/IVA2.
  *
  * Ideally the DSP/IVA2 could just be the same powerdomain, but the PRCM
  * address offset is different between the C55 and C64 DSPs.
- *
- * The overly-specific dep_bit names are due to a bit name collision
- * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP shift
- * value are the same for all powerdomains: 2
- */
-
-/*
- * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
- * sanity check?
- * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
  */
 
 #include <plat/powerdomain.h>
@@ -74,60 +54,11 @@
 #include "prcm-common.h"
 #include "prm.h"
 #include "cm.h"
-
-/* OMAP2/3-common powerdomains and wakeup dependencies */
-
-#ifndef CONFIG_ARCH_OMAP4
-/*
- * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
- * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
- * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
- */
-static struct pwrdm_dep gfx_sgx_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "iva2_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430: CM_SLEEPDEP_CAM: MPU
- * 3430ES1: CM_SLEEPDEP_GFX: MPU
- * 3430ES2: CM_SLEEPDEP_SGX: MPU
- */
-static struct pwrdm_dep cam_gfx_sleepdeps[] = {
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-#endif
-
-
 #include "powerdomains24xx.h"
 #include "powerdomains34xx.h"
 #include "powerdomains44xx.h"
 
-
-/*
- * OMAP2/3 common powerdomains
- */
+/* OMAP2/3-common powerdomains */
 
 #if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
 
@@ -140,8 +71,6 @@ static struct powerdomain gfx_omap2_pwrdm = {
 	.prcm_offs	  = GFX_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
 					   CHIP_IS_OMAP3430ES1),
-	.wkdep_srcs	  = gfx_sgx_wkdeps,
-	.sleepdep_srcs	  = cam_gfx_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
@@ -157,7 +86,6 @@ static struct powerdomain wkup_omap2_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 };
 
 #endif
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-omap2/powerdomains24xx.h
index bd249a4..652a01b 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -2,7 +2,7 @@
  * OMAP24XX powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H?gander
@@ -32,90 +32,12 @@
 
 #ifdef CONFIG_ARCH_OMAP24XX
 
-
-/* Wakeup dependency source arrays */
-
-/*
- * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
- * 2430 PM_WKDEP_MDM: same as above
- */
-static struct pwrdm_dep dsp_mdm_24xx_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
- * 2430 adds MDM
- */
-static struct pwrdm_dep mpu_24xx_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "dsp_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "mdm_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
- * 2430 adds MDM
- */
-static struct pwrdm_dep core_24xx_wkdeps[] = {
-	{
-		.pwrdm_name = "dsp_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "gfx_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name = "mdm_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-
 /* Powerdomains */
 
 static struct powerdomain dsp_pwrdm = {
 	.name		  = "dsp_pwrdm",
 	.prcm_offs	  = OMAP24XX_DSP_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.dep_bit	  = OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	  = dsp_mdm_24xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
@@ -131,8 +53,6 @@ static struct powerdomain mpu_24xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.dep_bit	  = OMAP24XX_EN_MPU_SHIFT,
-	.wkdep_srcs	  = mpu_24xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -148,9 +68,7 @@ static struct powerdomain core_24xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.wkdep_srcs	  = core_24xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.dep_bit	  = OMAP24XX_EN_CORE_SHIFT,
 	.banks		  = 3,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -176,13 +94,10 @@ static struct powerdomain core_24xx_pwrdm = {
 
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
 
-/* Another case of bit name collisions between several registers: EN_MDM */
 static struct powerdomain mdm_pwrdm = {
 	.name		  = "mdm_pwrdm",
 	.prcm_offs	  = OMAP2430_MDM_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-	.dep_bit	  = OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-	.wkdep_srcs	  = dsp_mdm_24xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 588f7e0..28228ef 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -2,7 +2,7 @@
  * OMAP34XX powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H?gander
@@ -35,127 +35,6 @@
 #ifdef CONFIG_ARCH_OMAP34XX
 
 /*
- * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
- * (USBHOST is ES2 only)
- */
-static struct pwrdm_dep per_usbhost_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "iva2_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
- */
-static struct pwrdm_dep mpu_34xx_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "iva2_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "dss_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "per_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
- */
-static struct pwrdm_dep iva2_wkdeps[] = {
-	{
-		.pwrdm_name = "core_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "dss_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "per_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
-static struct pwrdm_dep cam_dss_wkdeps[] = {
-	{
-		.pwrdm_name = "iva2_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "wkup_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430: PM_WKDEP_NEON: MPU */
-static struct pwrdm_dep neon_wkdeps[] = {
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* Sleep dependency source arrays for 34xx-specific pwrdms - 34XX only */
-
-/*
- * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
- * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
- */
-static struct pwrdm_dep dss_per_usbhost_sleepdeps[] = {
-	{
-		.pwrdm_name = "mpu_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name = "iva2_pwrdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/*
  * Powerdomains
  */
 
@@ -163,8 +42,6 @@ static struct powerdomain iva2_pwrdm = {
 	.name		  = "iva2_pwrdm",
 	.prcm_offs	  = OMAP3430_IVA2_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
-	.wkdep_srcs	  = iva2_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 4,
@@ -186,8 +63,6 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  = OMAP3430_EN_MPU_SHIFT,
-	.wkdep_srcs	  = mpu_34xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_MPU_QUIRK,
@@ -200,7 +75,6 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	},
 };
 
-/* No wkdeps or sleepdeps for 34xx core apparently */
 static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
@@ -208,7 +82,6 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -220,13 +93,11 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 	},
 };
 
-/* No wkdeps or sleepdeps for 34xx core apparently */
 static struct powerdomain core_34xx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
@@ -239,14 +110,10 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 	},
 };
 
-/* Another case of bit name collisions between several registers: EN_DSS */
 static struct powerdomain dss_pwrdm = {
 	.name		  = "dss_pwrdm",
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  = OMAP3430_DSS_MOD,
-	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
-	.wkdep_srcs	  = cam_dss_wkdeps,
-	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
@@ -267,8 +134,6 @@ static struct powerdomain sgx_pwrdm = {
 	.name		  = "sgx_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-	.wkdep_srcs	  = gfx_sgx_wkdeps,
-	.sleepdep_srcs	  = cam_gfx_sleepdeps,
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
@@ -285,8 +150,6 @@ static struct powerdomain cam_pwrdm = {
 	.name		  = "cam_pwrdm",
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  = OMAP3430_CAM_MOD,
-	.wkdep_srcs	  = cam_dss_wkdeps,
-	.sleepdep_srcs	  = cam_gfx_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
@@ -302,9 +165,6 @@ static struct powerdomain per_pwrdm = {
 	.name		  = "per_pwrdm",
 	.prcm_offs	  = OMAP3430_PER_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  = OMAP3430_EN_PER_SHIFT,
-	.wkdep_srcs	  = per_usbhost_wkdeps,
-	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -326,7 +186,6 @@ static struct powerdomain neon_pwrdm = {
 	.name		  = "neon_pwrdm",
 	.prcm_offs	  = OMAP3430_NEON_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.wkdep_srcs	  = neon_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 };
@@ -335,8 +194,6 @@ static struct powerdomain usbhost_pwrdm = {
 	.name		  = "usbhost_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-	.wkdep_srcs	  = per_usbhost_wkdeps,
-	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	/*
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index cc621e2..63330d2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -202,6 +202,18 @@ u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 	return v;
 }
 
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index 4806e2c..f77ca72 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -4,7 +4,7 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -41,26 +41,40 @@
 #define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
 
 /*
- * struct clkdm_pwrdm_autodep - a powerdomain that should have wkdeps
- * and sleepdeps added when a powerdomain should stay active in hwsup mode;
- * and conversely, removed when the powerdomain should be allowed to go
+ * struct clkdm_autodep - a clockdomain that should have wkdeps
+ * and sleepdeps added when a clockdomain should stay active in hwsup mode;
+ * and conversely, removed when the clockdomain should be allowed to go
  * inactive in hwsup mode.
  */
-struct clkdm_pwrdm_autodep {
+struct clkdm_autodep {
 
 	union {
-		/* Name of the powerdomain to add a wkdep/sleepdep on */
+		/* Name of the clockdomain to add a wkdep/sleepdep on */
 		const char *name;
 
-		/* Powerdomain pointer (looked up at clkdm_init() time) */
-		struct powerdomain *ptr;
-	} pwrdm;
+		/* Clockdomain pointer (looked up at clkdm_init() time) */
+		struct clockdomain *ptr;
+	} clkdm;
 
 	/* OMAP chip types that this clockdomain dep is valid on */
 	const struct omap_chip_id omap_chip;
 
 };
 
+/* Encodes dependencies between clockdomains - statically defined */
+struct clkdm_dep {
+
+	/* Clockdomain name */
+	const char *clkdm_name;
+
+	/* Clockdomain pointer - resolved by the clockdomain code */
+	struct clockdomain *clkdm;
+
+	/* Flags to mark OMAP chip restrictions, etc. */
+	const struct omap_chip_id omap_chip;
+
+};
+
 struct clockdomain {
 
 	/* Clockdomain name */
@@ -83,6 +97,15 @@ struct clockdomain {
 	/* Clockdomain capability flags */
 	const u8 flags;
 
+	/* Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit */
+	const u8 dep_bit;
+
+	/* Clockdomains that can be told to wake this powerdomain up */
+	struct clkdm_dep *wkdep_srcs;
+
+	/* Clockdomains that can be told to keep this clkdm from inactivity */
+	struct clkdm_dep *sleepdep_srcs;
+
 	/* OMAP chip types that this clockdomain is valid on */
 	const struct omap_chip_id omap_chip;
 
@@ -93,7 +116,7 @@ struct clockdomain {
 
 };
 
-void clkdm_init(struct clockdomain **clkdms, struct clkdm_pwrdm_autodep *autodeps);
+void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *autodeps);
 int clkdm_register(struct clockdomain *clkdm);
 int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
@@ -102,6 +125,13 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 			void *user);
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 
+int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index bac378e..dd5f79d 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 powerdomain control
  *
- * Copyright (C) 2007-8 Texas Instruments, Inc.
- * Copyright (C) 2007-8 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -68,20 +68,6 @@
 struct clockdomain;
 struct powerdomain;
 
-/* Encodes dependencies between powerdomains - statically defined */
-struct pwrdm_dep {
-
-	/* Powerdomain name */
-	const char *pwrdm_name;
-
-	/* Powerdomain pointer - resolved by the powerdomain code */
-	struct powerdomain *pwrdm;
-
-	/* Flags to mark OMAP chip restrictions, etc. */
-	const struct omap_chip_id omap_chip;
-
-};
-
 struct powerdomain {
 
 	/* Powerdomain name */
@@ -93,15 +79,6 @@ struct powerdomain {
 	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
 
-	/* Powerdomains that can be told to wake this powerdomain up */
-	struct pwrdm_dep *wkdep_srcs;
-
-	/* Powerdomains that can be told to keep this pwrdm from inactivity */
-	struct pwrdm_dep *sleepdep_srcs;
-
-	/* Bit shift of this powerdomain's PM_WKDEP/CM_SLEEPDEP bit */
-	const u8 dep_bit;
-
 	/* Possible powerdomain power states */
 	const u8 pwrsts;
 
@@ -152,13 +129,6 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 			 int (*fn)(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm));
 
-int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
-
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index e63e94e..66938a9 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -33,6 +33,14 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
 void omap3_prcm_save_context(void);
 void omap3_prcm_restore_context(void);
 
+u32 prm_read_mod_reg(s16 module, u16 idx);
+void prm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 cm_read_mod_reg(s16 module, u16 idx);
+void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
 #endif
 
 
