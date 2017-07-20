From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 20 Jul 2017 16:42:17 +0800
Subject: [PATCH] regulator: fan53555: Use of_device_get_match_data() to
 simplify probe
Message-ID: <20170720084217.2584-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if fan53555_regulator_probe() is called and the "client->dev.of_node"
isn't NULL, it means OF registered a device with a valid compatible
string, so match cannot be NULL.

Use of_device_get_match_data() to retrieve the drvdata pointer.  No
functional change intended.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/regulator/fan53555.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 60f431831582..6b1c0e4672a2 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -407,14 +407,8 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 
 	di->regulator = pdata->regulator;
 	if (client->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_device(of_match_ptr(fan53555_dt_ids),
-					&client->dev);
-		if (!match)
-			return -ENODEV;
-
-		di->vendor = (unsigned long) match->data;
+		di->vendor =
+			(unsigned long)of_device_get_match_data(&client->dev);
 	} else {
 		/* if no ramp constraint set, get the pdata ramp_delay */
 		if (!di->regulator->constraints.ramp_delay) {
-- 
2.13.3
