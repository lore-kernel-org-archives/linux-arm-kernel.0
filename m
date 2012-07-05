From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 14:19:42 +0800
Subject: [PATCH] regulator: core: remove sysfs entry properly in regulator_put
In-Reply-To: <CAOMZO5BD_FcXVU18PauOFudod5FKd9MP-ZNUDJ4F9iQ6+EAjiA@mail.gmail.com>
References: <CAOMZO5BD_FcXVU18PauOFudod5FKd9MP-ZNUDJ4F9iQ6+EAjiA@mail.gmail.com>
Message-ID: <1341469182-5079-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With changes introduced by commit 222cc7b (regulator: core: Allow
multiple requests of a single supply mapping) on create_regulator,
regulator_put needs a corresponding update on sysfs entry removing.

Also regulator->dev still needs to get assigned in create_regulator,
otherwise, sysfs_remove_link call in regulator_put will get bypassed.

Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/regulator/core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ef07b62..3998d8f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1071,6 +1071,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	list_add(&regulator->list, &rdev->consumer_list);
 
 	if (dev) {
+		regulator->dev = dev;
+
 		/* Add a link to the device sysfs entry */
 		size = scnprintf(buf, REG_STR_SIZE, "%s-%s",
 				 dev->kobj.name, supply_name);
@@ -1367,11 +1369,8 @@ void regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	/* remove any sysfs entries */
-	if (regulator->dev) {
+	if (regulator->dev)
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-		device_remove_file(regulator->dev, &regulator->dev_attr);
-		kfree(regulator->dev_attr.attr.name);
-	}
 	kfree(regulator->supply_name);
 	list_del(&regulator->list);
 	kfree(regulator);
-- 
1.7.5.4
