From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Feb 2012 22:36:48 -0700
Subject: [PATCH v2 1/8] ARM: OMAP2+: hwmod: control all hardreset lines
 attached to a hwmod
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Message-ID: <20120228053643.16278.38085.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parts of the hwmod code test to see if a module has one and only one
hardreset line before taking an action.  It seems more appropriate
to control all hardreset lines associated with a hwmod, not just one.

It so happens that with the current hwmod data, this patch will not
change any behavior, since hwmods with hardreset lines have only one
hardreset line associated with them, and 'pseudo-hwmods' are used to
handle the other hardreset lines.  But future hwmod data patches to
remove the pseudo-hwmods will change this.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eba6cd3..543b0dd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1475,6 +1475,11 @@ static int _reset(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
 
+	/*
+	 * XXX We're not resetting modules with hardreset lines
+	 * automatically here.  Should we do this also, or just expect
+	 * those modules to define custom reset functions?
+	 */
 	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
 
 	return ret;
@@ -1490,7 +1495,7 @@ static int _reset(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-	int r;
+	int r, i;
 	int hwsup = 0;
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -1522,15 +1527,15 @@ static int _enable(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-
 	/*
-	 * If an IP contains only one HW reset line, then de-assert it in order
+	 * If an IP contains HW reset lines, then de-assert them in order
 	 * to allow the module state transition. Otherwise the PRCM will return
 	 * Intransition status, and the init will failed.
 	 */
-	if ((oh->_state == _HWMOD_STATE_INITIALIZED ||
-	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
-		_deassert_hardreset(oh, oh->rst_lines[0].name);
+	if (oh->_state == _HWMOD_STATE_INITIALIZED ||
+	    oh->_state == _HWMOD_STATE_DISABLED)
+		for (i = 0; i < oh->rst_lines_cnt; i++)
+			_deassert_hardreset(oh, oh->rst_lines[i].name);
 
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
@@ -1677,7 +1682,7 @@ int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle)
  */
 static int _shutdown(struct omap_hwmod *oh)
 {
-	int ret;
+	int ret, i;
 	u8 prev_state;
 
 	if (oh->_state != _HWMOD_STATE_IDLE &&
@@ -1718,12 +1723,8 @@ static int _shutdown(struct omap_hwmod *oh)
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-	/*
-	 * If an IP contains only one HW reset line, then assert it
-	 * after disabling the clocks and before shutting down the IP.
-	 */
-	if (oh->rst_lines_cnt == 1)
-		_assert_hardreset(oh, oh->rst_lines[0].name);
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		_assert_hardreset(oh, oh->rst_lines[i].name);
 
 	/* Mux pins to safe mode or use populated off mode values */
 	if (oh->mux)
@@ -1776,7 +1777,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	 * reset asserted. Exit without warning because that behavior is
 	 * expected.
 	 */
-	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt == 1)
+	if ((oh->flags & HWMOD_INIT_NO_RESET) && oh->rst_lines_cnt > 0)
 		return 0;
 
 	r = _enable(oh);
