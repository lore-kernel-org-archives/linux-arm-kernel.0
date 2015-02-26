From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 26 Feb 2015 18:06:00 +0200
Subject: [PATCH] ARM: OMAP2+: hwmod: fix deassert hardreset clkdm usecounting
Message-ID: <1424966760-30917-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deasserting hardreset increases the usecount for the hwmod parent clockdomain
always, however usecount is only decreased at end in certain error cases.
This causes software supervised clockdomains to remain always on, preventing
idle. Fixed by always releasing the hwmods clockdomain parent when exiting
the function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Carlos Hernandez <ceh@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 92afb72..3be4783 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1692,16 +1692,15 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (ret == -EBUSY)
 		pr_warn("omap_hwmod: %s: failed to hardreset\n", oh->name);
 
-	if (!ret) {
+	if (oh->clkdm) {
 		/*
 		 * Set the clockdomain to HW_AUTO, assuming that the
 		 * previous state was HW_AUTO.
 		 */
-		if (oh->clkdm && hwsup)
+		if (hwsup)
 			clkdm_allow_idle(oh->clkdm);
-	} else {
-		if (oh->clkdm)
-			clkdm_hwmod_disable(oh->clkdm, oh);
+
+		clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 
 	return ret;
-- 
1.7.9.5
