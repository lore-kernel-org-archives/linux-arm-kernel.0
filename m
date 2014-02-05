From: illia.smyrnov@globallogic.com (Illia Smyrnov)
Date: Wed,  5 Feb 2014 17:06:09 +0200
Subject: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
Message-ID: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
softreset bit cleaning right after set one. It is caused L3 error for
OMAP4 ISS because ISS register write occurs when ISS reset process is in
progress. Avoid this situation by cleaning softreset bit later, when reset
process is successfully finished.

Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 42d8188..1f33f5d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1947,29 +1947,31 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 		goto dis_opt_clks;
 
 	_write_sysconfig(v, oh);
-	ret = _clear_softreset(oh, &v);
-	if (ret)
-		goto dis_opt_clks;
-
-	_write_sysconfig(v, oh);
 
 	if (oh->class->sysc->srst_udelay)
 		udelay(oh->class->sysc->srst_udelay);
 
 	c = _wait_softreset_complete(oh);
-	if (c == MAX_MODULE_SOFTRESET_WAIT)
+	if (c == MAX_MODULE_SOFTRESET_WAIT) {
 		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
 			   oh->name, MAX_MODULE_SOFTRESET_WAIT);
-	else
+		ret = -ETIMEDOUT;
+		goto dis_opt_clks;
+	} else {
 		pr_debug("omap_hwmod: %s: softreset in %d usec\n", oh->name, c);
+	}
+
+	ret = _clear_softreset(oh, &v);
+	if (ret)
+		goto dis_opt_clks;
+
+	_write_sysconfig(v, oh);
 
 	/*
 	 * XXX add _HWMOD_STATE_WEDGED for modules that don't come back from
 	 * _wait_target_ready() or _reset()
 	 */
 
-	ret = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
-
 dis_opt_clks:
 	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
 		_disable_optional_clocks(oh);
-- 
1.8.5.3
