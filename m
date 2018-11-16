From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 16 Nov 2018 17:23:59 +0100
Subject: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get battery
 version
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Message-ID: <20181116162403.49854-14-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using the x86 OLPC platform specific call to get the board
version. It won't work on FDT-based ARM MMP2 platform.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Sort the new include a bit higher

 drivers/power/supply/olpc_battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 5a97e42a3547..5323987d9284 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/jiffies.h>
@@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
 	if (IS_ERR(olpc_ac))
 		return PTR_ERR(olpc_ac);
-
-	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
+	if (of_property_match_string(pdev->dev.of_node, "compatible",
+					"olpc,xo1.5-battery") >= 0) {
+		/* XO-1.5 */
 		olpc_bat_desc.properties = olpc_xo15_bat_props;
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
-	} else { /* XO-1 */
+	} else {
+		/* XO-1 */
 		olpc_bat_desc.properties = olpc_xo1_bat_props;
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
@@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
 
 static const struct of_device_id olpc_battery_ids[] = {
 	{ .compatible = "olpc,xo1-battery" },
+	{ .compatible = "olpc,xo1.5-battery" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, olpc_battery_ids);
-- 
2.19.1
