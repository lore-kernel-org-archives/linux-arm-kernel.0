From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:07 +0530
Subject: [PATCH 07/41] mmc: host: omap_hsmmc: Allow io voltage switch even for
 fixed vdd
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-8-kishon@ti.com>
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
index d8970a7ff4be..d47ef51fbe51 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -416,13 +416,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	if (mmc_pdata(host)->set_power)
 		return mmc_pdata(host)->set_power(host->dev, power_on, iov);
 
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (!mmc->supply.vmmc)
-		return 0;
-
 	if (mmc_pdata(host)->before_set_reg)
 		mmc_pdata(host)->before_set_reg(host->dev, power_on, iov);
 
-- 
2.11.0
