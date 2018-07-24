From: Sven.Schmitt@mixed-mode.de (Sven Schmitt)
Date: Tue, 24 Jul 2018 09:46:03 +0000
Subject: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Message-ID: <1532425558626.11533@mixed-mode.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6_pm_domain_power_off() reads iso and iso2sw from GPC_PGC_PUPSCR_OFFS 
which stores the power up delays. 
So use GPC_PGC_PDNSCR_OFFS for the correct delays.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 0097a939487f..5126185e68c6 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -73,7 +73,7 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 		return -EBUSY;
 
 	/* Read ISO and ISO2SW power down delays */
-	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
+	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PDNSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
-- 
2.17.1
