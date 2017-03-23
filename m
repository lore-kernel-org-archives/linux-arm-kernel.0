From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 23 Mar 2017 12:53:19 +0800
Subject: [PATCH v2 2/8] soc: imx: gpc: fix the wrong using of regmap cache
In-Reply-To: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
References: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490244805-3921-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without providing the proper reg_defaults, the regmap registers first
read out may be always 0 if enabling cache, which results in the
following issue we met.
e.g. During driver probe in imx6_pm_domain_power_on():
regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
The PGC_PUPSCR register val is always 0 but it's actually 0xf01 in HW.

Since GPC registers are tightly related to CPU bring up and may be
changed in bootloader, we don't want to provide defaults.
And the cache really does not save too much for GPC module.

Therefore, simply disable cache to fix the issue and make life easy.

Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/gpc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index c9bfdfd..7e6a672 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -289,22 +289,12 @@ static bool imx_gpc_readable_reg(struct device *dev, unsigned int reg)
 	return (reg % 4 == 0) && (reg <= 0x2ac);
 }
 
-static bool imx_gpc_volatile_reg(struct device *dev, unsigned int reg)
-{
-	if (reg == GPC_CNTR)
-		return true;
-
-	return false;
-}
-
 static const struct regmap_config imx_gpc_regmap_config = {
-	.cache_type = REGCACHE_FLAT,
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 
 	.readable_reg = imx_gpc_readable_reg,
-	.volatile_reg = imx_gpc_volatile_reg,
 
 	.max_register = 0x2ac,
 };
-- 
2.7.4
