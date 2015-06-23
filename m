From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Jun 2015 11:15:11 -0500
Subject: [PATCH V2 2/5] drivers/rtc/rtc-ds1307.c: Switch to managed irq
 allocation
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Message-ID: <1435076114-12416-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are not doing anything fancy in remove function that requires
us to sequence IRQ free operation, we might as well switch over to devm_
equivalent of managed IRQ allocation and remove the explicit free_irq
since it'd be done automatically at remove.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/rtc/rtc-ds1307.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8ea496e54a2e..0a98d8a52791 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1156,9 +1156,10 @@ read_rtc:
 	}
 
 	if (want_irq) {
-		err = request_threaded_irq(client->irq, NULL, irq_handler,
-					   IRQF_SHARED | IRQF_ONESHOT,
-					   ds1307->rtc->name, client);
+		err = devm_request_threaded_irq(&client->dev,
+						client->irq, NULL, irq_handler,
+						IRQF_SHARED | IRQF_ONESHOT,
+						ds1307->rtc->name, client);
 		if (err) {
 			client->irq = 0;
 			dev_err(&client->dev, "unable to request IRQ!\n");
@@ -1212,9 +1213,6 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (test_and_clear_bit(HAS_ALARM, &ds1307->flags))
-		free_irq(client->irq, client);
-
 	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
 		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
 
-- 
1.7.9.5
