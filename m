From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Nov 2010 03:18:08 -0700
Subject: [PATCH 4/8] OMAP2+: hwmod: add support for per-class custom device
	reset functions
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Message-ID: <20101116101807.22777.72371.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The standard omap_hwmod.c _reset() code relies on an IP block's
OCP_SYSCONFIG.SOFTRESET register bit to reset the IP block.  This
works for most IP blocks on the chip, but unfortunately not all.  For
example, initiator-only IP blocks often don't have any MPU-accessible
OCP-header registers, and therefore the MPU can't write to any
OCP_SYSCONFIG registers in that block.  Other IP blocks, such as the
IVA, require a specialized reset sequence.

Since we need to be able to reset these IP blocks as well, allow
custom IP block reset functions to be passed into the hwmod code via a
per-hwmod-class reset function pointer, struct omap_hwmod_class.reset.
If .reset is non-null, then the hwmod _reset() code will call the custom
function instead of the standard OCP SOFTRESET-based code.

As part of this change, rename most of the existing _reset() function
code to _ocp_softreset(), to indicate more clearly that it does not work
for all cases.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Paul Hunt <hunt@ti.com>
Cc: Stanley Liu <stanley_liu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   38 +++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++++-
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 683428f..12a0b9a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1089,7 +1089,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 }
 
 /**
- * _reset - reset an omap_hwmod
+ * _ocp_softreset - reset an omap_hwmod via the OCP_SYSCONFIG bit
  * @oh: struct omap_hwmod *
  *
  * Resets an omap_hwmod @oh via the OCP_SYSCONFIG bit.  hwmod must be
@@ -1098,12 +1098,13 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
  * the module did not reset in time, or 0 upon success.
  *
  * In OMAP3 a specific SYSSTATUS register is used to get the reset status.
- * Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
+ * Starting in OMAP4, some IPs do not have SYSSTATUS registers and instead
  * use the SYSCONFIG softreset bit to provide the status.
  *
- * Note that some IP like McBSP does have a reset control but no reset status.
+ * Note that some IP like McBSP do have reset control but don't have
+ * reset status.
  */
-static int _reset(struct omap_hwmod *oh)
+static int _ocp_softreset(struct omap_hwmod *oh)
 {
 	u32 v;
 	int c = 0;
@@ -1124,7 +1125,7 @@ static int _reset(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
 		_enable_optional_clocks(oh);
 
-	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
+	pr_debug("omap_hwmod: %s: resetting via OCP SOFTRESET\n", oh->name);
 
 	v = oh->_sysc_cache;
 	ret = _set_softreset(oh, &v);
@@ -1164,6 +1165,33 @@ dis_opt_clks:
 }
 
 /**
+ * _reset - reset an omap_hwmod
+ * @oh: struct omap_hwmod *
+ *
+ * Resets an omap_hwmod @oh.  The default software reset mechanism for
+ * most OMAP IP blocks is triggered via the OCP_SYSCONFIG.SOFTRESET
+ * bit.  However, some hwmods cannot be reset via this method: some
+ * are not targets and therefore have no OCP header registers to
+ * access; others (like the IVA) have idiosyncratic reset sequences.
+ * So for these relatively rare cases, custom reset code can be
+ * supplied in the struct omap_hwmod_class .reset function pointer.
+ * Passes along the return value from either _reset() or the custom
+ * reset function - these must return -EINVAL if the hwmod cannot be
+ * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
+ * the module did not reset in time, or 0 upon success.
+ */
+static int _reset(struct omap_hwmod *oh)
+{
+	int ret;
+
+	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
+
+	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
+
+	return ret;
+}
+
+/**
  * _omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index b445ecd..e4c4fd4 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -364,7 +364,7 @@ struct omap_hwmod_omap4_prcm {
  *     when module is enabled, rather than the default, which is to
  *     enable autoidle
  * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup
- * HWMOD_NO_IDLEST : this module does not have idle status - this is the case
+ * HWMOD_NO_IDLEST: this module does not have idle status - this is the case
  *     only for few initiator modules on OMAP2 & 3.
  * HWMOD_CONTROL_OPT_CLKS_IN_RESET: Enable all optional clocks during reset.
  *     This is needed for devices like DSS that require optional clocks enabled
@@ -416,6 +416,7 @@ struct omap_hwmod_omap4_prcm {
  * @sysc: device SYSCONFIG/SYSSTATUS register data
  * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device shutdown
+ * @reset: ptr to fn to be executed in place of the standard hwmod reset fn
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -427,12 +428,18 @@ struct omap_hwmod_omap4_prcm {
  * or some negative error upon failure.  Returning an error will cause
  * omap_hwmod_shutdown() to abort the device shutdown and return an
  * error.
+ *
+ * If @reset is defined, then the function it points to will be
+ * executed in place of the standard hwmod _reset() code in
+ * mach-omap2/omap_hwmod.c.  This is needed for IP blocks which have
+ * unusual reset sequences - usually processor IP blocks like the IVA.
  */
 struct omap_hwmod_class {
 	const char				*name;
 	struct omap_hwmod_class_sysconfig	*sysc;
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
+	int					(*reset)(struct omap_hwmod *oh);
 };
 
 /**
