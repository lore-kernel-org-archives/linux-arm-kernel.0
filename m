From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Jan 2013 19:21:42 +0000 (UTC)
Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC
 active
In-Reply-To: <20130108204347.GC1876@animalcreek.com>
References: <alpine.DEB.2.00.1212301828590.8175@utopia.booyaka.com>
 <alpine.DEB.2.00.1301081916190.18536@utopia.booyaka.com>
 <20130108204347.GC1876@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1301171919420.14118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On Tue, 8 Jan 2013, Mark A. Greer wrote:

> Sorry to nag but I think the comment needs to be updated to remove the
> sentence about the missing EMAC hwmod.

You are absolutely right, and the correction is very much appreciated.  
Updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 30 Dec 2012 10:36:36 -0700
Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active

According to Mark Greer, on OMAP AM3517/3505 chips, the EMAC is unable
to wake the ARM up from WFI:

    http://www.spinics.net/lists/arm-kernel/msg174734.html

Further troubleshooting was unable to narrow the problem down.  So we
don't have much choice other than to block WFI when the EMAC is active
with the HWMOD_BLOCK_WFI flag.

Based on Mark's original patch.  We're removing the omap_device-based
pm_lats code, so a different approach was needed.

This third version contains some corrections thanks to Mark's review.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8bb2628..ac7e03e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3493,7 +3493,12 @@ static struct omap_hwmod am35xx_emac_hwmod = {
 	.name		= "davinci_emac",
 	.mpu_irqs	= am35xx_emac_mpu_irqs,
 	.class		= &am35xx_emac_class,
-	.flags		= HWMOD_NO_IDLEST,
+	/*
+	 * According to Mark Greer, the MPU will not return from WFI
+	 * when the EMAC signals an interrupt.
+	 * http://www.spinics.net/lists/arm-kernel/msg174734.html
+	 */
+	.flags		= (HWMOD_NO_IDLEST | HWMOD_BLOCK_WFI),
 };
 
 /* l3_core -> davinci emac interface */
-- 
1.7.10.4
