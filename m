From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 20 May 2015 20:03:09 +0200
Subject: [PATCH net-next 4/4] stmmac: drop unnecessary dt checks in
 stmmac_probe_config_dt
In-Reply-To: <1432144989-28283-1-git-send-email-manabian@gmail.com>
References: <1432144989-28283-1-git-send-email-manabian@gmail.com>
Message-ID: <1432144989-28283-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the caller already check the presence of a of_node there
is no need to repeat the check in stmmac_probe_config_dt.

There is also no point in checking the return value of the
of_match_device function since if there wasn't match in the
first place we would never be in this function.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 10de9351a1ec..d2bb7907bf61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -111,13 +111,7 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 	const struct of_device_id *device;
 	struct device *dev = &pdev->dev;
 
-	if (!np)
-		return -ENODEV;
-
 	device = of_match_device(dev->driver->of_match_table, dev);
-	if (!device)
-		return -ENODEV;
-
 	if (device->data) {
 		const struct stmmac_of_data *data = device->data;
 		plat->has_gmac = data->has_gmac;
-- 
1.8.0
