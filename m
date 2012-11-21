From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 21 Nov 2012 23:05:23 +0000 (UTC)
Subject: [PATCHv9 1/8] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
In-Reply-To: <1350552010-28760-2-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1211212259150.9132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2012, Tero Kristo wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> OMAP4 has module specific context lost registers which makes it now
> possible to have module level context loss count, instead of relying
> on the powerdomain level context count.
> 
> Add 2 private hwmod api's to update/clear the hwmod/module specific
> context lost counters/register.
> 
> Update the module specific context_lost_counter and clear the hardware
> bits just after enabling the module.
> 
> omap_hwmod_get_context_loss_count() now returns the hwmod context loss
> count them on platforms where they exist (OMAP4), else fall back on
> the pwrdm level counters for older platforms.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul at pwsan.com: added function kerneldoc, fixed structure kerneldoc,
>  rearranged structure to avoid memory waste, marked fns as OMAP4-specific,
>  prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
>  and clear, merged patches]
> [t-kristo at ti.com: added support for arch specific hwmod ops, and changed
>  the no context offset indicator to USHRT_MAX]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [paul at pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
>  convert unsigned context lost counter to int to match the return type;
>  get rid of hwmod_ops in favor of the existing soc_ops mechanism]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Here's an updated version of this one with the low-level PRM accesses 
moved out to the PRM code.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Wed, 21 Nov 2012 11:48:46 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: Add support for per hwmod/module context
 lost count

OMAP4 has module specific context lost registers which makes it now
possible to have module level context loss count, instead of relying
on the powerdomain level context count.

Add 2 private hwmod api's to update/clear the hwmod/module specific
context lost counters/register.

Update the module specific context_lost_counter and clear the hardware
bits just after enabling the module.

omap_hwmod_get_context_loss_count() now returns the hwmod context loss
count them on platforms where they exist (OMAP4), else fall back on
the pwrdm level counters for older platforms.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul at pwsan.com: added function kerneldoc, fixed structure kerneldoc,
 rearranged structure to avoid memory waste, marked fns as OMAP4-specific,
 prevent fn entry on non-OMAP4 chips, reduced indentation, merged update
 and clear, merged patches]
[t-kristo at ti.com: added support for arch specific hwmod ops, and changed
 the no context offset indicator to USHRT_MAX]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul at pwsan.com: use NO_CONTEXT_LOSS_BIT flag rather than USHRT_MAX;
 convert unsigned context lost counter to int to match the return type;
 get rid of hwmod_ops in favor of the existing soc_ops mechanism;
 move context loss low-level accesses to the PRM code]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   55 +++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod.h |   10 ++++---
 arch/arm/mach-omap2/prm.h        |   11 +++++++-
 arch/arm/mach-omap2/prm44xx.c    |   33 +++++++++++++++++++++++
 arch/arm/mach-omap2/prm_common.c |   45 +++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 68616b2..083adbe 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -187,6 +187,8 @@ struct omap_hwmod_soc_ops {
 	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri);
 	int (*init_clkdm)(struct omap_hwmod *oh);
+	void (*update_context_lost)(struct omap_hwmod *oh);
+	int (*get_context_lost)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1983,6 +1985,42 @@ static void _reconfigure_io_chain(void)
 }
 
 /**
+ * _omap4_update_context_lost - increment hwmod context loss counter if
+ * hwmod context was lost, and clear hardware context loss reg
+ * @oh: hwmod to check for context loss
+ *
+ * If the PRCM indicates that the hwmod @oh lost context, increment
+ * our in-memory context loss counter, and clear the RM_*_CONTEXT
+ * bits. No return value.
+ */
+static void _omap4_update_context_lost(struct omap_hwmod *oh)
+{
+	if (oh->prcm.omap4.flags & HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT)
+		return;
+
+	if (!prm_was_any_context_lost_old(oh->clkdm->pwrdm.ptr->prcm_partition,
+					  oh->clkdm->pwrdm.ptr->prcm_offs,
+					  oh->prcm.omap4.context_offs))
+		return;
+
+	oh->prcm.omap4.context_lost_counter++;
+	prm_clear_context_loss_flags_old(oh->clkdm->pwrdm.ptr->prcm_partition,
+					 oh->clkdm->pwrdm.ptr->prcm_offs,
+					 oh->prcm.omap4.context_offs);
+}
+
+/**
+ * _omap4_get_context_lost - get context loss counter for a hwmod
+ * @oh: hwmod to get context loss counter for
+ *
+ * Returns the in-memory context loss counter for a hwmod.
+ */
+static int _omap4_get_context_lost(struct omap_hwmod *oh)
+{
+	return oh->prcm.omap4.context_lost_counter;
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2065,6 +2103,9 @@ static int _enable(struct omap_hwmod *oh)
 	if (soc_ops.enable_module)
 		soc_ops.enable_module(oh);
 
+	if (soc_ops.update_context_lost)
+		soc_ops.update_context_lost(oh);
+
 	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 		-EINVAL;
 	if (!r) {
@@ -3907,17 +3948,21 @@ ohsps_unlock:
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
- * count for this device.
+ * Returns the context loss count of associated @oh
+ * upon success, or zero if no context loss data is available.
  *
- * Returns the context loss count of the powerdomain assocated with @oh
- * upon success, or zero if no powerdomain exists for @oh.
+ * On OMAP4, this queries the per-hwmod context loss register,
+ * assuming one exists.  If not, or on OMAP2/3, this queries the
+ * enclosing powerdomain context loss count.
  */
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 {
 	struct powerdomain *pwrdm;
 	int ret = 0;
 
+	if (soc_ops.get_context_lost)
+		return soc_ops.get_context_lost(oh);
+
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	if (pwrdm)
 		ret = pwrdm_get_context_loss_count(pwrdm);
@@ -4032,6 +4077,8 @@ void __init omap_hwmod_init(void)
 		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
+		soc_ops.update_context_lost = _omap4_update_context_lost;
+		soc_ops.get_context_lost = _omap4_get_context_lost;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _am33xx_enable_module;
 		soc_ops.disable_module = _am33xx_disable_module;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 87b59b4..421ff65 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -2,7 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2012 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno?t Cousson,
@@ -394,12 +394,15 @@ struct omap_hwmod_omap2_prcm {
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @clkctrl_reg: PRCM address of the clock control register
- * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @clkctrl_offs: offset of the PRCM clock control register
+ * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
+ * @context_offs: offset of the RM_*_CONTEXT register
  * @lostcontext_mask: bitmask for selecting bits from RM_*_CONTEXT register
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
+ * @modulemode: allowable modulemodes
+ * @context_lost_counter: Count of module level context lost
  *
  * If @lostcontext_mask is not defined, context loss check code uses
  * whole register without masking. @lostcontext_mask should only be
@@ -415,6 +418,7 @@ struct omap_hwmod_omap4_prcm {
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
 	u8		flags;
+	int		context_lost_counter;
 };
 
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index a1a266c..ac25ae6 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -114,16 +114,25 @@ struct prm_reset_src_map {
 
 /**
  * struct prm_ll_data - fn ptrs to per-SoC PRM function implementations
- * @read_reset_sources: ptr to the Soc PRM-specific get_reset_source impl
+ * @read_reset_sources: ptr to the SoC PRM-specific get_reset_source impl
+ * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
+ * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
+ *
+ * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
+ * deprecated.
  */
 struct prm_ll_data {
 	u32 (*read_reset_sources)(void);
+	bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
+	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
 extern int prm_unregister(struct prm_ll_data *pld);
 
 extern u32 prm_read_reset_sources(void);
+extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
+extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 9db1bd2..7498bc7 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -346,6 +346,37 @@ static u32 omap44xx_prm_read_reset_sources(void)
 	return r;
 }
 
+/**
+ * omap44xx_prm_was_any_context_lost_old - was module hardware context lost?
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Return 1 if any bits were set in the *_CONTEXT_* register
+ * identified by (@part, @inst, @idx), which means that some context
+ * was lost for that module; otherwise, return 0.
+ */
+static bool omap44xx_prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx)
+{
+	return (omap4_prminst_read_inst_reg(part, inst, idx)) ? 1 : 0;
+}
+
+/**
+ * omap44xx_prm_clear_context_lost_flags_old - clear context loss flags
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Clear hardware context loss bits for the module identified by
+ * (@part, @inst, @idx).  No return value.  XXX Writes to reserved bits;
+ * is there a way to avoid this?
+ */
+static void omap44xx_prm_clear_context_loss_flags_old(u8 part, s16 inst,
+						      u16 idx)
+{
+	omap4_prminst_write_inst_reg(0xffffffff, part, inst, idx);
+}
+
 /* Powerdomain low-level functions */
 
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
@@ -613,6 +644,8 @@ struct pwrdm_ops omap4_pwrdm_operations = {
  */
 static struct prm_ll_data omap44xx_prm_ll_data = {
 	.read_reset_sources = &omap44xx_prm_read_reset_sources,
+	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
+	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index d2e0798..c6ae53c 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -367,6 +367,51 @@ u32 prm_read_reset_sources(void)
 }
 
 /**
+ * prm_was_any_context_lost_old - was device context lost? (old API)
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Return 1 if any bits were set in the *_CONTEXT_* register
+ * identified by (@part, @inst, @idx), which means that some context
+ * was lost for that module; otherwise, return 0.  XXX Deprecated;
+ * callers need to use a less-SoC-dependent way to identify hardware
+ * IP blocks.
+ */
+bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx)
+{
+	bool ret = true;
+
+	if (prm_ll_data->was_any_context_lost_old)
+		ret = prm_ll_data->was_any_context_lost_old(part, inst, idx);
+	else
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+
+	return ret;
+}
+
+/**
+ * prm_clear_context_lost_flags_old - clear context loss flags (old API)
+ * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
+ * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
+ * @idx: CONTEXT register offset
+ *
+ * Clear hardware context loss bits for the module identified by
+ * (@part, @inst, @idx).  No return value.  XXX Deprecated; callers
+ * need to use a less-SoC-dependent way to identify hardware IP
+ * blocks.
+ */
+void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx)
+{
+	if (prm_ll_data->clear_context_loss_flags_old)
+		prm_ll_data->clear_context_loss_flags_old(part, inst, idx);
+	else
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.10.4
