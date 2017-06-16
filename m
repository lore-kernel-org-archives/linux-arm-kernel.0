From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 18:15:35 +0530
Subject: [PATCH 07/16] mmc: host: omap_hsmmc: Allow io voltage switch even for
 fixed vdd
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Message-ID: <20170616124544.15046-8-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that vmmc regulator is made optional, do not bail out if vmmc
regulator is not found.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f64148b119df..f1d5e8385591 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -415,13 +415,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	if (mmc_pdata(host)->set_power)
 		return mmc_pdata(host)->set_power(host->dev, power_on, iov);
 
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (IS_ERR(mmc->supply.vmmc))
-		return 0;
-
 	if (mmc_pdata(host)->before_set_reg)
 		mmc_pdata(host)->before_set_reg(host->dev, power_on, iov);
 
-- 
2.11.0
