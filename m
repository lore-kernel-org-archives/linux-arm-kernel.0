From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 29 Jul 2015 16:39:40 +0530
Subject: [PATCH 10/17] mmc: host: omap_hsmmc: avoid pbias regulator enable on
 power off
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Message-ID: <1438168187-1614-11-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix omap_hsmmc_set_power so that pbias regulator is not enabled
during power off.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8bb3f60..2e5c7cd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -386,16 +386,16 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		ret = omap_hsmmc_enable_supply(mmc, vdd);
 		if (ret)
 			return ret;
+
+		ret = omap_hsmmc_set_pbias(host, true, vdd);
+		if (ret)
+			goto err_set_voltage;
 	} else {
 		ret = omap_hsmmc_disable_supply(mmc);
 		if (ret)
 			return ret;
 	}
 
-	ret = omap_hsmmc_set_pbias(host, true, vdd);
-	if (ret)
-		goto err_set_voltage;
-
 	if (mmc_pdata(host)->after_set_reg)
 		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
 
-- 
1.7.9.5
