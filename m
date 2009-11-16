From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Nov 2009 06:36:55 -0700
Subject: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
In-Reply-To: <20091116133237.14128.39687.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
Message-ID: <20091116133654.14128.175.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix loop bailout off-by-one bugs reported by Juha Lepp?nen
<juha_motorsportcom@luukku.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Lepp?nen <juha_motorsportcom@luukku.com>
---
 arch/arm/mach-omap2/cm.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |   12 +++++-------
 arch/arm/mach-omap2/prcm.c       |    4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 8eb2dab..0766e52 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -65,6 +65,6 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	       (i++ < MAX_MODULE_READY_TIME))
 		udelay(1);
 
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	return (i <= MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 633b216..a4a9518 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -759,14 +759,12 @@ static int _reset(struct omap_hwmod *oh)
 	_write_sysconfig(v, oh);
 
 	c = 0;
-	while (c < MAX_MODULE_RESET_WAIT &&
-	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-		 SYSS_RESETDONE_MASK)) {
+	while (!(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+		 SYSS_RESETDONE_MASK) &&
+	       (c++ < MAX_MODULE_RESET_WAIT))
 		udelay(1);
-		c++;
-	}
 
-	if (c == MAX_MODULE_RESET_WAIT)
+	if (c > MAX_MODULE_RESET_WAIT)
 		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
 		     oh->name, MAX_MODULE_RESET_WAIT);
 	else
@@ -777,7 +775,7 @@ static int _reset(struct omap_hwmod *oh)
 	 * _wait_target_ready() or _reset()
 	 */
 
-	return (c == MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
+	return (c > MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 029d376..d486709 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -251,14 +251,14 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
 	       (i++ < MAX_MODULE_ENABLE_WAIT))
 		udelay(1);
 
-	if (i < MAX_MODULE_ENABLE_WAIT)
+	if (i <= MAX_MODULE_ENABLE_WAIT)
 		pr_debug("cm: Module associated with clock %s ready after %d "
 			 "loops\n", name, i);
 	else
 		pr_err("cm: Module associated with clock %s didn't enable in "
 		       "%d tries\n", name, MAX_MODULE_ENABLE_WAIT);
 
-	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
+	return (i <= MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
 };
 
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
