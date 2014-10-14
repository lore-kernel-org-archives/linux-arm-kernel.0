From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Oct 2014 14:35:16 +0200
Subject: [PATCH 6/7] power: bq2415x_charger: Decrement the power supply's
 device reference counter
In-Reply-To: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1413290117-13082-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use power_supply_put() to decrement the power supply's device reference
counter (increased by power_supply_get_by_name() or
power_supply_get_by_phandle()).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/bq2415x_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 81a3a78b92d8..8bc9ca9e0275 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1684,6 +1684,8 @@ error_4:
 error_3:
 	bq2415x_power_supply_exit(bq);
 error_2:
+	if (!IS_ERR(bq->notify_psy))
+		power_supply_put(bq->notify_psy);
 	kfree(name);
 error_1:
 	mutex_lock(&bq2415x_id_mutex);
@@ -1699,8 +1701,10 @@ static int bq2415x_remove(struct i2c_client *client)
 {
 	struct bq2415x_device *bq = i2c_get_clientdata(client);
 
-	if (bq->notify_psy)
+	if (bq->notify_psy) {
 		power_supply_unreg_notifier(&bq->nb);
+		power_supply_put(bq->notify_psy);
+	}
 
 	bq2415x_sysfs_exit(bq);
 	bq2415x_power_supply_exit(bq);
-- 
1.9.1
