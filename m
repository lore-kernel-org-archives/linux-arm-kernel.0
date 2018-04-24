From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:45 +0200
Subject: [PATCH 05/11] platform: use a dedicated list_head for early devices
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-6-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The current implementation of early platform device support uses the
devres list head in struct device. This causes problems when adding
support for device tree based early devices. Use a dedicated list_head
which is included in struct device conditionally in order to avoid
adding bloat for all architectures.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c | 23 +++++++++++------------
 include/linux/device.h  |  4 ++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index af440d703f0b..90526acdcb84 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1264,12 +1264,10 @@ void __init early_platform_add_devices(struct platform_device **devs, int num)
 	for (i = 0; i < num; i++) {
 		dev = &devs[i]->dev;
 
-		if (!dev->devres_head.next) {
-			pm_runtime_early_init(dev);
-			INIT_LIST_HEAD(&dev->devres_head);
-			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
-		}
+		pm_runtime_early_init(dev);
+		INIT_LIST_HEAD(&dev->early_dev_head);
+		list_add_tail(&dev->early_dev_head,
+			      &early_platform_device_list);
 	}
 }
 
@@ -1310,7 +1308,7 @@ early_platform_match(struct early_platform_driver *epdrv, int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &early_platform_device_list, dev.early_dev_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id == id)
 				return pd;
@@ -1328,7 +1326,7 @@ static int __init early_platform_left(struct early_platform_driver *epdrv,
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &early_platform_device_list, dev.early_dev_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id >= id)
 				return 1;
@@ -1465,11 +1463,12 @@ void __init early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
-	/* clean up the devres list used to chain devices */
+	/* clean up the list used to chain devices */
 	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
-				 dev.devres_head) {
-		list_del(&pd->dev.devres_head);
-		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
+				 dev.early_dev_head) {
+		list_del(&pd->dev.early_dev_head);
+		memset(&pd->dev.early_dev_head, 0,
+		       sizeof(pd->dev.early_dev_head));
 	}
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99e1f25..4fadba0f9a35 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -979,6 +979,10 @@ struct device {
 	spinlock_t		devres_lock;
 	struct list_head	devres_head;
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+	struct list_head	early_dev_head;
+#endif
+
 	struct klist_node	knode_class;
 	struct class		*class;
 	const struct attribute_group **groups;	/* optional groups */
-- 
2.17.0
