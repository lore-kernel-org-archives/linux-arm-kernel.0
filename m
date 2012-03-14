From: mvs@tigris.de (Maximilian Schwerin)
Date: Wed, 14 Mar 2012 18:38:15 +0100
Subject: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to add
 IVA OPP
Message-ID: <1331746695-24372-1-git-send-email-mvs@tigris.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Sakoman <steve@sakoman.com>

Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
subsystem, as this would make omap_init_opp_table fail.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
---
 arch/arm/mach-omap2/opp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 9262a6b..414f2ec 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 				__func__, i);
 			return -EINVAL;
 		}
+
+		if ((strcmp(opp_def->hwmod_name,"iva") == 0) && !omap3_has_iva())
+			continue;
+
 		oh = omap_hwmod_lookup(opp_def->hwmod_name);
 		if (!oh || !oh->od) {
 			pr_warn("%s: no hwmod or odev for %s, [%d] "
-- 
1.7.0.4
