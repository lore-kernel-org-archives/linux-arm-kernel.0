From: J.Kilb@phytec.de (Juergen Kilb)
Date: Mon, 7 Nov 2011 22:30:16 +0100
Subject: [PATCH 1/2] ARM:OMAP:hwmod: Fix handling of return value in
 omap3xx_hwmod_init.
In-Reply-To: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
References: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Message-ID: <1320701417-16818-2-git-send-email-J.Kilb@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because omap_hwmod_register() always return '0', checking the
return value as followed:

	r = omap_hwmod_register(omap3xxx_hwmods);
	if (!r)
		return r;

leads to exiting the omap3xxx_hwmod_init() function right after
adding the omap3xxx_hwmods which are common to all omap3 variants.

Therefore hwmods special to other revisions will not be
registered.

Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3008e16..30ec4bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3261,14 +3261,11 @@ static __initdata struct omap_hwmod *am35xx_hwmods[] = {
 
 int __init omap3xxx_hwmod_init(void)
 {
-	int r;
 	struct omap_hwmod **h = NULL;
 	unsigned int rev;
 
 	/* Register hwmods common to all OMAP3 */
-	r = omap_hwmod_register(omap3xxx_hwmods);
-	if (!r)
-		return r;
+	omap_hwmod_register(omap3xxx_hwmods);
 
 	rev = omap_rev();
 
@@ -3291,9 +3288,7 @@ int __init omap3xxx_hwmod_init(void)
 		return -EINVAL;
 	};
 
-	r = omap_hwmod_register(h);
-	if (!r)
-		return r;
+	omap_hwmod_register(h);
 
 	/*
 	 * Register hwmods specific to certain ES levels of a
@@ -3309,7 +3304,7 @@ int __init omap3xxx_hwmod_init(void)
 	};
 
 	if (h)
-		r = omap_hwmod_register(h);
+		omap_hwmod_register(h);
 
-	return r;
+	return 0;
 }
-- 
1.7.0.4
