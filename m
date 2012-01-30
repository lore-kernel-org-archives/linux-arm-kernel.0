From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:15 -0700
Subject: [PATCH 3/7] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Message-ID: <20120130101815.10450.6214.stgit@dusk>
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
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 0ef2710..c991bd7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1482,6 +1482,16 @@ static int _reset(struct omap_hwmod *oh)
 	 */
 	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
 
+	/*
+	 * OCP_SYSCONFIG bits need to be reprogrammed after a
+	 * softreset.  The _enable() function should be split to avoid
+	 * the rewrite of the OCP_SYSCONFIG register.
+	 */
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
+
 	return ret;
 }
 
@@ -1787,20 +1797,9 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		return 0;
 	}
 
-	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		_reset(oh);
 
-		/*
-		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
-		 * The _enable() function should be split to
-		 * avoid the rewrite of the OCP_SYSCONFIG register.
-		 */
-		if (oh->class->sysc) {
-			_update_sysc_cache(oh);
-			_enable_sysc(oh);
-		}
-	}
-
 	postsetup_state = oh->_postsetup_state;
 	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
 		postsetup_state = _HWMOD_STATE_ENABLED;
