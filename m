From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Feb 2012 22:37:01 -0700
Subject: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Message-ID: <20120228053657.16278.76132.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code that reprograms the OCP_SYSCONFIG bits into the _reset()
function to ensure that it is called after every reset.  The code was
previously in the _setup() function.  So, before this patch, if
_reset() was called from another function, the SYSCONFIG register
won't be reprogrammed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index db4ad41..aeb6f4c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1490,13 +1490,22 @@ static int _reset(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
 
 	if (oh->class->reset)
-		return oh->class->reset(oh);
-
-	if (!oh->rst_lines_cnt)
-		return _ocp_softreset(oh);
+		oh->class->reset(oh);
+	else if (!oh->rst_lines_cnt)
+		_ocp_softreset(oh);
+	else
+		for (i = 0; i < oh->rst_lines_cnt; i++)
+			_assert_hardreset(oh, oh->rst_lines[i].name);
 
-	for (i = 0; i < oh->rst_lines_cnt; i++)
-		_assert_hardreset(oh, oh->rst_lines[i].name);
+	/*
+	 * OCP_SYSCONFIG bits need to be reprogrammed after a
+	 * softreset.  The _enable() function should be split to avoid
+	 * the rewrite of the OCP_SYSCONFIG register.
+	 */
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
 
 	return 0;
 }
@@ -1830,16 +1839,6 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		r = _reset(oh);
 
-	/*
-	 * OCP_SYSCONFIG bits need to be reprogrammed after a
-	 * softreset.  The _enable() function should be split to avoid
-	 * the rewrite of the OCP_SYSCONFIG register.
-	 */
-	if (oh->class->sysc) {
-		_update_sysc_cache(oh);
-		_enable_sysc(oh);
-	}
-
 	return r;
 }
 
