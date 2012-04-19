From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Apr 2012 02:17:01 -0600 (MDT)
Subject: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
In-Reply-To: <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053651.16278.22844.stgit@dusk>
 <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 19 Apr 2012, Paul Walmsley wrote:

> - The changes to the _init function have been split into a separate patch
>   to make it easier to debug.

Here is the patch that deals specifically with _init().  It's the same 
code that was originally part of the patch mentioned in the subject line, 
split into a new patch for clarity.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 19 Apr 2012 00:58:22 -0600
Subject: [PATCH 2/3] ARM: OMAP2+: hwmod: reorganize and document the
 initialization process

Reorganize the code involved in initializing the internal data for
each hwmod to make it easier to read and maintain.  This involves
improving documentation and removing some duplicated and unnecessary
code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  137 ++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5b07ad0..253e942 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1769,6 +1769,56 @@ static int _shutdown(struct omap_hwmod *oh)
 }
 
 /**
+ * _init_mpu_rt_base - populate the virtual address for a hwmod
+ * @oh: struct omap_hwmod * to locate the virtual address
+ *
+ * Cache the virtual address used by the MPU to access this IP block's
+ * registers.  This address is needed early so the OCP registers that
+ * are part of the device's address space can be ioremapped properly.
+ * No return value.
+ */
+static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
+{
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return;
+
+	oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
+}
+
+/**
+ * _init - initialize internal data for the hwmod @oh
+ * @oh: struct omap_hwmod *
+ * @n: (unused)
+ *
+ * Look up the clocks and the address space used by the MPU to access
+ * registers belonging to the hwmod @oh.  @oh must already be
+ * registered at this point.  This is the first of two phases for
+ * hwmod initialization.  Code called here does not touch any hardware
+ * registers, it simply prepares internal data structures.  Returns 0
+ * upon success or if the hwmod isn't registered, or -EINVAL upon
+ * failure.
+ */
+static int __init _init(struct omap_hwmod *oh, void *n)
+{
+	int r;
+
+	if (oh->_state != _HWMOD_STATE_REGISTERED)
+		return 0;
+
+	_init_mpu_rt_base(oh, NULL);
+
+	r = _init_clocks(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
+		return -EINVAL;
+	}
+
+	oh->_state = _HWMOD_STATE_INITIALIZED;
+
+	return 0;
+}
+
+/**
  * _setup - do initial configuration of omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1780,7 +1830,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	int i, r;
 	u8 postsetup_state;
 
-	if (oh->_state != _HWMOD_STATE_CLKS_INITED)
+	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return 0;
 
 	/* Set iclk autoidle mode */
@@ -2052,96 +2102,69 @@ int __init omap_hwmod_register(struct omap_hwmod **ohs)
 	return 0;
 }
 
-/*
- * _populate_mpu_rt_base - populate the virtual address for a hwmod
+/**
+ * _ensure_mpu_hwmod_is_setup - ensure the MPU SS hwmod is init'ed and set up
+ * @oh: pointer to the hwmod currently being set up (usually not the MPU)
  *
- * Must be called only from omap_hwmod_setup_*() so ioremap works properly.
- * Assumes the caller takes care of locking if needed.
+ * If the hwmod data corresponding to the MPU subsystem IP block
+ * hasn't been initialized and set up yet, do so now.  This must be
+ * done first since sleep dependencies may be added from other hwmods
+ * to the MPU.  Intended to be called only by omap_hwmod_setup*().  No
+ * return value.
  */
-static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
+static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
 {
-	if (oh->_state != _HWMOD_STATE_REGISTERED)
-		return 0;
-
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-		return 0;
-
-	oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
-
-	return 0;
+	if (!mpu_oh || mpu_oh->_state == _HWMOD_STATE_UNKNOWN)
+		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
+		       __func__, MPU_INITIATOR_NAME);
+	else if (mpu_oh->_state == _HWMOD_STATE_REGISTERED && oh != mpu_oh)
+		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
 }
 
 /**
  * omap_hwmod_setup_one - set up a single hwmod
  * @oh_name: const char * name of the already-registered hwmod to set up
  *
- * Must be called after omap2_clk_init().  Resolves the struct clk
- * names to struct clk pointers for each registered omap_hwmod.  Also
- * calls _setup() on each hwmod.  Returns -EINVAL upon error or 0 upon
- * success.
+ * Initialize and set up a single hwmod.  Intended to be used for a
+ * small number of early devices, such as the timer IP blocks used for
+ * the scheduler clock.  Must be called after omap2_clk_init().
+ * Resolves the struct clk names to struct clk pointers for each
+ * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
+ * -EINVAL upon error or 0 upon success.
  */
 int __init omap_hwmod_setup_one(const char *oh_name)
 {
 	struct omap_hwmod *oh;
-	int r;
 
 	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
 
-	if (!mpu_oh) {
-		pr_err("omap_hwmod: %s: cannot setup_one: MPU initiator hwmod %s not yet registered\n",
-		       oh_name, MPU_INITIATOR_NAME);
-		return -EINVAL;
-	}
-
 	oh = _lookup(oh_name);
 	if (!oh) {
 		WARN(1, "omap_hwmod: %s: hwmod not yet registered\n", oh_name);
 		return -EINVAL;
 	}
 
-	if (mpu_oh->_state == _HWMOD_STATE_REGISTERED && oh != mpu_oh)
-		omap_hwmod_setup_one(MPU_INITIATOR_NAME);
-
-	r = _populate_mpu_rt_base(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't set mpu_rt_base\n", oh_name);
-		return -EINVAL;
-	}
-
-	r = _init_clocks(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh_name);
-		return -EINVAL;
-	}
+	_ensure_mpu_hwmod_is_setup(oh);
 
+	_init(oh, NULL);
 	_setup(oh, NULL);
 
 	return 0;
 }
 
 /**
- * omap_hwmod_setup - do some post-clock framework initialization
+ * omap_hwmod_setup_all - set up all registered IP blocks
  *
- * Must be called after omap2_clk_init().  Resolves the struct clk names
- * to struct clk pointers for each registered omap_hwmod.  Also calls
- * _setup() on each hwmod.  Returns 0 upon success.
+ * Initialize and set up all IP blocks registered with the hwmod code.
+ * Must be called after omap2_clk_init().  Resolves the struct clk
+ * names to struct clk pointers for each registered omap_hwmod.  Also
+ * calls _setup() on each hwmod.  Returns 0 upon success.
  */
 static int __init omap_hwmod_setup_all(void)
 {
-	int r;
-
-	if (!mpu_oh) {
-		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
-		       __func__, MPU_INITIATOR_NAME);
-		return -EINVAL;
-	}
-
-	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
-
-	r = omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(IS_ERR_VALUE(r),
-	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
+	_ensure_mpu_hwmod_is_setup(NULL);
 
+	omap_hwmod_for_each(_init, NULL);
 	omap_hwmod_for_each(_setup, NULL);
 
 	return 0;
-- 
1.7.10
