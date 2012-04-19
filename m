From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Apr 2012 02:14:05 -0600 (MDT)
Subject: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
In-Reply-To: <20120228053651.16278.22844.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053651.16278.22844.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 27 Feb 2012, Paul Walmsley wrote:

> Reorganize the code involved in initializing and configuring an IP
> block to make it easier to read and maintain.  This involves improving
> documentation, splitting some large functions up into smaller ones to
> better conform with Documentation/CodingStyle, and removing some
> unnecessary code.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>

A few changes have been made to this patch:

- The reset changes have been consolidated with the changes in patch 5.

- The changes to the _init function have been split into a separate patch
  to make it easier to debug.

The updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 18 Apr 2012 19:10:03 -0600
Subject: [PATCH 3/3] ARM: OMAP2+: hwmod: reorganize and document the reset
 and configuration process

Reorganize the code involved in resetting and configuring an IP block
to make it easier to read and maintain.  This involves improving
documentation, splitting some large functions up into smaller ones to
better conform with Documentation/CodingStyle, and removing some
unnecessary code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  152 ++++++++++++++++++++++++++++++--------
 1 file changed, 120 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 253e942..0afbebc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1534,10 +1534,9 @@ static int _enable(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
 	/*
-	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left
-	 * in enabled state at init.
-	 * Now that someone is really trying to enable them,
-	 * just ensure that the hwmod mux is set.
+	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
+	 * state at init.  Now that someone is really trying to enable
+	 * them, just ensure that the hwmod mux is set.
 	 */
 	if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
 		/*
@@ -1819,46 +1818,60 @@ static int __init _init(struct omap_hwmod *oh, void *n)
 }
 
 /**
- * _setup - do initial configuration of omap_hwmod
+ * _setup_iclk_autoidle - configure an IP block's interface clocks
  * @oh: struct omap_hwmod *
  *
- * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Returns 0.
+ * Set up the module's interface clocks.  XXX This function is still mostly
+ * a stub; implementing this properly requires iclk autoidle usecounting in
+ * the clock code.   No return value.
  */
-static int _setup(struct omap_hwmod *oh, void *data)
+static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
-	int i, r;
-	u8 postsetup_state;
+	int i;
 
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
-		return 0;
+		return;
 
-	/* Set iclk autoidle mode */
-	if (oh->slaves_cnt > 0) {
-		for (i = 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os = oh->slaves[i];
-			struct clk *c = os->_clk;
+	for (i = 0; i < oh->slaves_cnt; i++) {
+		struct omap_hwmod_ocp_if *os = oh->slaves[i];
+		struct clk *c = os->_clk;
 
-			if (!c)
-				continue;
+		if (!c)
+			continue;
 
-			if (os->flags & OCPIF_SWSUP_IDLE) {
-				/* XXX omap_iclk_deny_idle(c); */
-			} else {
-				/* XXX omap_iclk_allow_idle(c); */
-				clk_enable(c);
-			}
+		if (os->flags & OCPIF_SWSUP_IDLE) {
+			/* XXX omap_iclk_deny_idle(c); */
+		} else {
+			/* XXX omap_iclk_allow_idle(c); */
+			clk_enable(c);
 		}
 	}
 
-	oh->_state = _HWMOD_STATE_INITIALIZED;
+	return;
+}
+
+/**
+ * _setup_reset - reset an IP block during the setup process
+ * @oh: struct omap_hwmod *
+ *
+ * Reset the IP block corresponding to the hwmod @oh during the setup
+ * process.  The IP block is first enabled so it can be successfully
+ * reset.  Returns 0 upon success or a negative error code upon
+ * failure.
+ */
+static int __init _setup_reset(struct omap_hwmod *oh)
+{
+	int r;
+
+	if (oh->_state != _HWMOD_STATE_INITIALIZED)
+		return -EINVAL;
 
 	/*
 	 * In the case of hwmod with hardreset that should not be
 	 * de-assert at boot time, we have to keep the module
 	 * initialized, because we cannot enable it properly with the
-	 * reset asserted. Exit without warning because that behavior is
-	 * expected.
+	 * reset asserted. Exit without warning because that behavior
+	 * is expected.
 	 */
 	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
 		return 0;
@@ -1871,7 +1884,53 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
-		_reset(oh);
+		r = _reset(oh);
+
+	return r;
+}
+
+/**
+ * _setup_postsetup - transition to the appropriate state after _setup
+ * @oh: struct omap_hwmod *
+ *
+ * Place an IP block represented by @oh into a "post-setup" state --
+ * either IDLE, ENABLED, or DISABLED.  ("post-setup" simply means that
+ * this function is called at the end of _setup().)  The postsetup
+ * state for an IP block can be changed by calling
+ * omap_hwmod_enter_postsetup_state() early in the boot process,
+ * before one of the omap_hwmod_setup*() functions are called for the
+ * IP block.
+ *
+ * The IP block stays in this state until a PM runtime-based driver is
+ * loaded for that IP block.  A post-setup state of IDLE is
+ * appropriate for almost all IP blocks with runtime PM-enabled
+ * drivers, since those drivers are able to enable the IP block.  A
+ * post-setup state of ENABLED is appropriate for kernels with PM
+ * runtime disabled.  The DISABLED state is appropriate for unusual IP
+ * blocks such as the MPU WDTIMER on kernels without WDTIMER drivers
+ * included, since the WDTIMER starts running on reset and will reset
+ * the MPU if left active.
+ *
+ * This post-setup mechanism is deprecated.  Once all of the OMAP
+ * drivers have been converted to use PM runtime, and all of the IP
+ * block data and interconnect data is available to the hwmod code, it
+ * should be possible to replace this mechanism with a "lazy reset"
+ * arrangement.  In a "lazy reset" setup, each IP block is enabled
+ * when the driver first probes, then all remaining IP blocks without
+ * drivers are either shut down or enabled after the drivers have
+ * loaded.  However, this cannot take place until the above
+ * preconditions have been met, since otherwise the late reset code
+ * has no way of knowing which IP blocks are in use by drivers, and
+ * which ones are unused.
+ *
+ * No return value.
+ */
+static void __init _setup_postsetup(struct omap_hwmod *oh)
+{
+	u8 postsetup_state;
+
+	if (oh->rst_lines_cnt > 0)
+		return;
 
 	postsetup_state = oh->_postsetup_state;
 	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
@@ -1895,6 +1954,35 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
 		     oh->name, postsetup_state);
 
+	return;
+}
+
+/**
+ * _setup - prepare IP block hardware for use
+ * @oh: struct omap_hwmod *
+ * @n: (unused, pass NULL)
+ *
+ * Configure the IP block represented by @oh.  This may include
+ * enabling the IP block, resetting it, and placing it into a
+ * post-setup state, depending on the type of IP block and applicable
+ * flags.  IP blocks are reset to prevent any previous configuration
+ * by the bootloader or previous operating system from interfering
+ * with power management or other parts of the system.  The reset can
+ * be avoided; see omap_hwmod_no_setup_reset().  This is the second of
+ * two phases for hwmod initialization.  Code called here generally
+ * affects the IP block hardware, or system integration hardware
+ * associated with the IP block.  Returns 0.
+ */
+static int __init _setup(struct omap_hwmod *oh, void *n)
+{
+	if (oh->_state != _HWMOD_STATE_INITIALIZED)
+		return 0;
+
+	_setup_iclk_autoidle(oh);
+
+	if (!_setup_reset(oh))
+		_setup_postsetup(oh);
+
 	return 0;
 }
 
@@ -2700,10 +2788,10 @@ int omap_hwmod_for_each_by_class(const char *classname,
  * @state: state that _setup() should leave the hwmod in
  *
  * Sets the hwmod state that @oh will enter at the end of _setup()
- * (called by omap_hwmod_setup_*()).  Only valid to call between
- * calling omap_hwmod_register() and omap_hwmod_setup_*().  Returns
- * 0 upon success or -EINVAL if there is a problem with the arguments
- * or if the hwmod is in the wrong state.
+ * (called by omap_hwmod_setup_*()).  See also the documentation
+ * for _setup_postsetup(), above.  Returns 0 upon success or
+ * -EINVAL if there is a problem with the arguments or if the hwmod is
+ * in the wrong state.
  */
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 {
-- 
1.7.10
