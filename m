From: mporter@ti.com (Matt Porter)
Date: Thu, 20 Sep 2012 10:43:39 -0400
Subject: [RFC PATCH 06/13] ARM: omap: add hsmmc am33xx specific init
In-Reply-To: <1348152226-13588-1-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
Message-ID: <1348152226-13588-7-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM33xx requires special handling in hsmmc initialization
platform glue.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9675d8..679fb43 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -364,7 +364,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (!soc_is_am35xx())
+	if (!soc_is_am35xx() && !soc_is_am33xx())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -387,7 +387,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (soc_is_am35xx())
+		if (soc_is_am35xx() || soc_is_am33xx())
 			mmc->slots[0].set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
@@ -488,7 +488,8 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	if (res < 0)
 		goto free_mmc;
 
-	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
+	if (!soc_is_am33xx())
+		omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
 
 	name = "omap_hsmmc";
 	res = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
-- 
1.7.9.5
