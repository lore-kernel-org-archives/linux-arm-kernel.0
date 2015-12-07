From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:15 +0000
Subject: [PATCH 02/19] mfd: ab3100-core.c: Fix multiple warnings reported by
 Checkpatch
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Missing a blank line after declarations
+       struct ab3100 *ab3100 = dev_get_drvdata(dev->parent);
+       if (!ab3100->startup_events_read)

WARNING: Possible unnecessary 'out of memory' message
+       if (!ab3100) {
+               dev_err(&client->dev, "could not allocate AB3100 device\n");

WARNING: else is not generally useful after a break or return
+                               break;
+                       } else {

total: 0 errors, 3 warnings, 996 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab3100-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index f0afb44..6a5a988 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -381,9 +381,11 @@ static int ab3100_event_registers_startup_state_get(struct device *dev,
 					     u8 *event)
 {
 	struct ab3100 *ab3100 = dev_get_drvdata(dev->parent);
+
 	if (!ab3100->startup_events_read)
 		return -EAGAIN; /* Try again later */
 	memcpy(event, ab3100->startup_events, 3);
+
 	return 0;
 }
 
@@ -858,10 +860,8 @@ static int ab3100_probe(struct i2c_client *client,
 	int i;
 
 	ab3100 = devm_kzalloc(&client->dev, sizeof(struct ab3100), GFP_KERNEL);
-	if (!ab3100) {
-		dev_err(&client->dev, "could not allocate AB3100 device\n");
+	if (!ab3100)
 		return -ENOMEM;
-	}
 
 	/* Initialize data structure */
 	mutex_init(&ab3100->access_mutex);
@@ -883,20 +883,17 @@ static int ab3100_probe(struct i2c_client *client,
 
 	for (i = 0; ids[i].id != 0x0; i++) {
 		if (ids[i].id == ab3100->chip_id) {
-			if (ids[i].name != NULL) {
-				snprintf(&ab3100->chip_name[0],
-					 sizeof(ab3100->chip_name) - 1,
-					 "AB3100 %s",
-					 ids[i].name);
+			if (ids[i].name)
 				break;
-			} else {
-				dev_err(&client->dev,
-					"AB3000 is not supported\n");
-				goto exit_no_detect;
-			}
+
+			dev_err(&client->dev, "AB3000 is not supported\n");
+			goto exit_no_detect;
 		}
 	}
 
+	snprintf(&ab3100->chip_name[0],
+		 sizeof(ab3100->chip_name) - 1, "AB3100 %s", ids[i].name);
+
 	if (ids[i].id == 0x0) {
 		dev_err(&client->dev, "unknown analog baseband chip id: 0x%x\n",
 			ab3100->chip_id);
-- 
1.9.1
