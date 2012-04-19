From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Apr 2012 00:53:51 -0600 (MDT)
Subject: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
In-Reply-To: <20120228053654.16278.73632.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053654.16278.73632.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Mon, 27 Feb 2012, Paul Walmsley wrote:

> Change the way that hardreset lines are handled by the hwmod code.
> Hardreset lines are generally associated with initiator IP blocks.
> Prior to this change, the hwmod code expected to control hardreset
> lines itself, asserting them on shutdown and deasserting them upon
> enable.  But driver authors inside TI have commented to us that their
> drivers require direct control over these lines.  Unfortunately, these
> drivers haven't been posted publicly yet, so it's hard to determine
> exactly what is needed, a priori.  This change attempts to set forth
> some reasonable semantics that should be an improvement over the
> current code.

I took another look at this patch, and upon further thought, there are 
some aspects of this design that really don't make sense.

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5b368ee..db4ad41 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -805,6 +805,9 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  				    oh->clkdm->clkdm_offs,
>  				    oh->prcm.omap4.clkctrl_offs);
>  
> +	if (oh->rst_lines_cnt >= 0)
> +		return 0;

This change prevents any IP block from waiting for the target to disable 
-- which is not what we want.  The na?ve fix would be to only skip the 
disable-wait if oh->rst_lines_cnt is greater than zero.  But if there are 
no hardreset lines asserted, then we should probably wait for the disable 
in that case.

>  	v = _omap4_wait_target_disable(oh);
>  	if (v)
>  		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",

[...]

> @@ -1575,7 +1568,19 @@ static int _enable(struct omap_hwmod *oh)
>  	_enable_clocks(oh);
>  	_enable_module(oh);
>  
> -	r = _wait_target_ready(oh);
> +	/*
> +	 * If an IP contains HW reset lines, we leave them
> +	 * asserted.  But this will block the module's idle state
> +	 * transition - the PRCM will return Intransition status.  So
> +	 * we need to avoid the target ready-wait in this case.  XXX
> +	 * We also need to give the drivers a way to wait for the
> +	 * target to become ready once they decide to deassert some
> +	 * hardreset lines.  XXX Is this strategy going to break PM
> +	 * because the clockdomain may not be able to enter idle while
> +	 * the module's idle status is in-transition?  We may just need
> +	 * custom reset blocks for all IPs with hardreset lines.
> +	 */
> +	r = (oh->rst_lines_cnt == 0) ? _wait_target_ready(oh) : 1;

And this part is at odds with the patch description.  If there are 
hardreset lines associated with an IP block, then this code will cause the 
following code to unconditionally disable the module clocks.  Considering 
that this is the _enable() function, this seems counterproductive.

I looked into changing this code to align with the original semantics we 
discussed.  It seems quite challenging.  With the current codebase, we'd 
have to bail out in the middle of the enable sequence.  Then we'd lose the 
clockdomain state (the 'hwsup' variable).

So I've updated the patch to essentially bail out early from all hwmod 
enable, idle, and shutdown code, if any hardreset lines associated with 
the IP block are asserted.  It will then be the driver integration code's 
responsibility for enabling the IP block when the hardreset lines are 
asserted.  When the hardreset lines are deasserted, the usual hwmod code 
will be executed -- I'd assume this would be the case during normal 
operation of the device.  I think this is probably the best we can do 
until we actually hear back from the people responsible for drivers for 
these special IP blocks.

A revised patch is below.  Care to take a look and see if it makes sense 
to you?


regards,

- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 18 Apr 2012 19:10:04 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: revise hardreset behavior

Change the way that hardreset lines are handled by the hwmod code.
Hardreset lines are generally associated with initiator IP blocks.
Prior to this change, the hwmod code expected to control hardreset
lines itself, asserting them on shutdown and deasserting them upon
enable.  But driver authors inside TI have commented to us that their
drivers require direct control over these lines.  Unfortunately, these
drivers haven't been posted publicly yet, so it's hard to determine
exactly what is needed, a priori.  This change attempts to set forth
some reasonable semantics that should be an improvement over the
current code.

The semantics implemented by this patch are as follows:

- If the hwmod is not marked with HWMOD_INIT_NO_RESET, then assert all
  associated hardreset lines during IP block setup.  This is intended
  to place the IP blocks into a known state that will not interfere
  with other devices during kernel boot.

- IP blocks with hardreset lines will not be automatically enabled or
  idled during setup.  Instead, they will be left in the INITIALIZED
  state.

- When the hwmod code is asked to enable, idle, or shutdown an IP
  block with asserted hardreset lines, the hwmod code will do nothing.
  The driver integration code must do the remaining work needed to
  control these IP blocks.  Once this driver integration code is posted
  to the lists, hopefully we can consolidate it and move it inside the
  hwmod code.

Custom reset functions for IP blocks with hardreset lines still should
be supported and are strongly endorsed.  It is intended that every
subsystem with hardreset lines should have a custom reset function
that can place their subsystem into quiescent idle with the hardreset
lines deasserted.

This reverts most of commit 5365efbe29250a227502256cc912351fe2157b42
("OMAP: hwmod: Add hardreset management support").  Later code
reorganizations caused the sequencing of the code from this patch to
be changed, anyway.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  140 ++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e6aa14f..a5c3a9a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -781,39 +781,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 }
 
 /**
- * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
- * @oh: struct omap_hwmod *
- *
- * Disable the PRCM module mode related to the hwmod @oh.
- * Return EINVAL if the modulemode is not supported and 0 in case of success.
- */
-static int _omap4_disable_module(struct omap_hwmod *oh)
-{
-	int v;
-
-	/* The module mode does not exist prior OMAP4 */
-	if (!cpu_is_omap44xx())
-		return -EINVAL;
-
-	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-		return -EINVAL;
-
-	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
-
-	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
-				    oh->clkdm->cm_inst,
-				    oh->clkdm->clkdm_offs,
-				    oh->prcm.omap4.clkctrl_offs);
-
-	v = _omap4_wait_target_disable(oh);
-	if (v)
-		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
-			oh->name);
-
-	return 0;
-}
-
-/**
  * _count_mpu_irqs - count the number of MPU IRQ lines associated with @oh
  * @oh: struct omap_hwmod *oh
  *
@@ -1378,6 +1345,66 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 }
 
 /**
+ * _are_any_hardreset_lines_asserted - return true if part of @oh is hard-reset
+ * @oh: struct omap_hwmod *
+ *
+ * If any hardreset line associated with @oh is asserted, then return true.
+ * Otherwise, if @oh has no hardreset lines associated with it, or if
+ * no hardreset lines associated with @oh are asserted, then return false.
+ * This function is used to avoid executing some parts of the IP block
+ * enable/disable sequence if a hardreset line is set.
+ */
+static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
+{
+	int i;
+
+	if (oh->rst_lines_cnt == 0)
+		return false;
+
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		if (_read_hardreset(oh, oh->rst_lines[i].name) > 0)
+			return true;
+
+	return false;
+}
+
+/**
+ * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
+ * @oh: struct omap_hwmod *
+ *
+ * Disable the PRCM module mode related to the hwmod @oh.
+ * Return EINVAL if the modulemode is not supported and 0 in case of success.
+ */
+static int _omap4_disable_module(struct omap_hwmod *oh)
+{
+	int v;
+
+	/* The module mode does not exist prior OMAP4 */
+	if (!cpu_is_omap44xx())
+		return -EINVAL;
+
+	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+		return -EINVAL;
+
+	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
+
+	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
+				    oh->clkdm->cm_inst,
+				    oh->clkdm->clkdm_offs,
+				    oh->prcm.omap4.clkctrl_offs);
+
+	if (_are_any_hardreset_lines_asserted(oh))
+		return 0;
+
+	v = _omap4_wait_target_disable(oh);
+	if (v)
+		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+			oh->name);
+
+	return 0;
+}
+
+/**
  * _ocp_softreset - reset an omap_hwmod via the OCP_SYSCONFIG bit
  * @oh: struct omap_hwmod *
  *
@@ -1519,7 +1546,7 @@ static int _reset(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-	int r, i;
+	int r;
 	int hwsup = 0;
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -1551,14 +1578,16 @@ static int _enable(struct omap_hwmod *oh)
 	}
 
 	/*
-	 * If an IP contains HW reset lines, then de-assert them in order
-	 * to allow the module state transition. Otherwise the PRCM will return
-	 * Intransition status, and the init will failed.
+	 * If an IP block contains HW reset lines and any of them are
+	 * asserted, we let integration code associated with that
+	 * block handle the enable.  We've received very little
+	 * information on what those driver authors need, and until
+	 * detailed information is provided and the driver code is
+	 * posted to the public lists, this is probably the best we
+	 * can do.
 	 */
-	if (oh->_state == _HWMOD_STATE_INITIALIZED ||
-	    oh->_state == _HWMOD_STATE_DISABLED)
-		for (i = 0; i < oh->rst_lines_cnt; i++)
-			_deassert_hardreset(oh, oh->rst_lines[i].name);
+	if (_are_any_hardreset_lines_asserted(oh))
+		return 0;
 
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
@@ -1633,6 +1662,9 @@ static int _idle(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
+	if (_are_any_hardreset_lines_asserted(oh))
+		return 0;
+
 	if (oh->class->sysc)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
@@ -1715,6 +1747,9 @@ static int _shutdown(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
+	if (_are_any_hardreset_lines_asserted(oh))
+		return 0;
+
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
 
 	if (oh->class->pre_shutdown) {
@@ -1824,27 +1859,18 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
 
-	/*
-	 * In the case of hwmod with hardreset that should not be
-	 * de-assert at boot time, we have to keep the module
-	 * initialized, because we cannot enable it properly with the
-	 * reset asserted. Exit without warning because that behavior
-	 * is expected.
-	 */
-	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
-		return 0;
-
-	r = _enable(oh);
-	if (r) {
-		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
-			   oh->name, oh->_state);
-		return 0;
+	if (oh->rst_lines_cnt == 0) {
+		r = _enable(oh);
+		if (r) {
+			pr_warning("omap_hwmod: %s: cannot be enabled for reset (%d)\n",
+				   oh->name, oh->_state);
+			return -EINVAL;
+		}
 	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		r = _reset(oh);
 
-
 	return r;
 }
 /**
-- 
1.7.10
