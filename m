From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:41 -0700
Subject: [PATCH 01/10] OMAP3 hwmod: reprogram OCP_SYSCONFIG register after
	setting SOFTRESET
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134940.17146.90982.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reprogram the module's OCP_SYSCONFIG register after module reset (SOFTRESET
= 1).  This may not be needed, but the definition of the reset performed by
the SOFTRESET bit is unclear.

Kevin Hilman <khilman@deeprootsystems.com> tested an earlier version of
this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..4aab1b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -948,11 +948,19 @@ static int _setup(struct omap_hwmod *oh)
 
 	_enable(oh);
 
-	if (!(oh->flags & HWMOD_INIT_NO_RESET))
-		_reset(oh);
-
-	/* XXX OCP AUTOIDLE bit? */
-	/* XXX OCP ENAWAKEUP bit? */
+	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+		/*
+		 * XXX Do the OCP_SYSCONFIG bits need to be
+		 * reprogrammed after a reset?  If not, then this can
+		 * be removed.  If they do, then probably the
+		 * _enable() function should be split to avoid the
+		 * rewrite of the OCP_SYSCONFIG register.
+		 */
+		if (oh->sysconfig) {
+			_update_sysc_cache(oh);
+			_sysc_enable(oh);
+		}
+	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
 		_idle(oh);
