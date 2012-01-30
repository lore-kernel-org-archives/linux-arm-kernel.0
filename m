From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:18 -0700
Subject: [PATCH 7/7] ARM: OMAP2+: hwmod: split the _setup() function
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Message-ID: <20120130101818.10450.56384.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the interface clock setup from _setup() into
_setup_iclk_autoidle() and split the post-setup state code from
_setup() into _enter_postsetup_state().  Fix the existing, incorrect
documentation for _setup(), and add documentation for the other two
functions.  The goal is to shrink the size of the _setup() function to
make it easier to read and maintain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  154 +++++++++++++++++++++++++++-----------
 1 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f7bf759..41749bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1731,11 +1731,112 @@ static int _shutdown(struct omap_hwmod *oh)
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
+ */
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
+{
+	int i;
+
+	for (i = 0; i < oh->slaves_cnt; i++) {
+		struct omap_hwmod_ocp_if *os = oh->slaves[i];
+		struct clk *c = os->_clk;
+
+		if (!c)
+			continue;
+
+		if (os->flags & OCPIF_SWSUP_IDLE) {
+			/* XXX omap_iclk_deny_idle(c); */
+		} else {
+			/* XXX omap_iclk_allow_idle(c); */
+			clk_enable(c);
+		}
+	}
+}
+
+
+/**
+ * _enter_postsetup_state - transition to the appropriate state after _setup
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
+static void _enter_postsetup_state(struct omap_hwmod *oh)
+{
+	u8 postsetup_state;
+
+	postsetup_state = oh->_postsetup_state;
+	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
+		postsetup_state = _HWMOD_STATE_ENABLED;
+
+	/*
+	 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
+	 * it should be set by the core code as a runtime flag during startup
+	 */
+	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
+	    (postsetup_state == _HWMOD_STATE_IDLE)) {
+		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
+		postsetup_state = _HWMOD_STATE_ENABLED;
+	}
+
+	if (postsetup_state == _HWMOD_STATE_IDLE)
+		_idle(oh);
+	else if (postsetup_state == _HWMOD_STATE_DISABLED)
+		_shutdown(oh);
+	else if (postsetup_state != _HWMOD_STATE_ENABLED)
+		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
+		     oh->name, postsetup_state);
+}
+
+/**
+ * _setup - do initial configuration of an omap_hwmod
+ * @oh: struct omap_hwmod *
+ *
+ * Configure the IP block represented by @oh.  This may include
+ * enabling the IP block, resetting it, and placing it into a
+ * post-setup state, depending on the type of IP block and applicable
+ * flags.
+ *
+ * IP blocks are reset to prevent any previous configuration by the
+ * bootloader or previous operating system from interfering with power
+ * management or other parts of the system.  The reset can be avoided; see
+ * omap_hwmod_no_setup_reset().
+ *
+ * Returns 0.
  */
 static int _setup(struct omap_hwmod *oh, void *data)
 {
@@ -1746,22 +1847,8 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		return 0;
 
 	/* Set iclk autoidle mode */
-	if (oh->slaves_cnt > 0) {
-		for (i = 0; i < oh->slaves_cnt; i++) {
-			struct omap_hwmod_ocp_if *os = oh->slaves[i];
-			struct clk *c = os->_clk;
-
-			if (!c)
-				continue;
-
-			if (os->flags & OCPIF_SWSUP_IDLE) {
-				/* XXX omap_iclk_deny_idle(c); */
-			} else {
-				/* XXX omap_iclk_allow_idle(c); */
-				clk_enable(c);
-			}
-		}
-	}
+	if (oh->slaves_cnt > 0)
+		_setup_iclk_autoidle(oh);
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
@@ -1785,27 +1872,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		_reset(oh);
 
-	postsetup_state = oh->_postsetup_state;
-	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
-		postsetup_state = _HWMOD_STATE_ENABLED;
-
-	/*
-	 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
-	 * it should be set by the core code as a runtime flag during startup
-	 */
-	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
-	    (postsetup_state == _HWMOD_STATE_IDLE)) {
-		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
-		postsetup_state = _HWMOD_STATE_ENABLED;
-	}
-
-	if (postsetup_state == _HWMOD_STATE_IDLE)
-		_idle(oh);
-	else if (postsetup_state == _HWMOD_STATE_DISABLED)
-		_shutdown(oh);
-	else if (postsetup_state != _HWMOD_STATE_ENABLED)
-		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
-		     oh->name, postsetup_state);
+	_enter_postsetup_state(oh);
 
 	return 0;
 }
@@ -2660,9 +2727,10 @@ int omap_hwmod_for_each_by_class(const char *classname,
  *
  * Sets the hwmod state that @oh will enter at the end of _setup()
  * (called by omap_hwmod_setup_*()).  Only valid to call between
- * calling omap_hwmod_register() and omap_hwmod_setup_*().  Returns
- * 0 upon success or -EINVAL if there is a problem with the arguments
- * or if the hwmod is in the wrong state.
+ * calling omap_hwmod_register() and omap_hwmod_setup_*().  See also
+ * the documentation for _enter_postsetup_state(), above.  Returns 0
+ * upon success or -EINVAL if there is a problem with the arguments or
+ * if the hwmod is in the wrong state.
  */
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 {
