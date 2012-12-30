From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 30 Dec 2012 18:31:38 +0000 (UTC)
Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC
 active
Message-ID: <alpine.DEB.2.00.1212301828590.8175@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


According to Mark Greer, on OMAP AM3517/3505 chips, the EMAC is unable
to wake the ARM up from WFI:

    http://www.spinics.net/lists/arm-kernel/msg174734.html

Further troubleshooting was unable to narrow the problem down.  So we
don't have much choice other than to block WFI when the EMAC is active
with the HWMOD_BLOCK_WFI flag.  However, for some reason, we don't
have an EMAC hwmod -- probably some bug in the data -- so set the flag
on the MDIO hwmod data instead.

Based on Mark's original patch.  We're removing the omap_device-based
pm_lats code, so a different approach was needed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
---

Applies after the WFI cleanup series -- intended for a post-cleanup fixes
pull request or a new feature pull request.

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8bb2628..4a68735 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3439,7 +3439,13 @@ static struct omap_hwmod_class am35xx_mdio_class = {
 static struct omap_hwmod am35xx_mdio_hwmod = {
 	.name		= "davinci_mdio",
 	.class		= &am35xx_mdio_class,
-	.flags		= HWMOD_NO_IDLEST,
+	/*
+	 * According to Mark Greer, the MPU will not return from WFI
+	 * when the EMAC signals an interrupt.  We're missing an EMAC
+	 * hwmod for some reason, so add the flag to the MDIO instead.
+	 * http://www.spinics.net/lists/arm-kernel/msg174734.html
+	 */
+	.flags		= (HWMOD_NO_IDLEST | HWMOD_BLOCK_WFI),
 };
 
 /*
-- 
1.7.10.4
