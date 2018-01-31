From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 31 Jan 2018 14:44:34 +0100
Subject: [RFC PATCH v2 4/5] extcon: add possibility to get extcon device by
 OF node
In-Reply-To: <20180131134435.12216-1-a.hajda@samsung.com>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134459eucas1p15c0dd76f5173816b949e72cde93c0a6c@eucas1p1.samsung.com>
Message-ID: <20180131134435.12216-5-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since extcon property is not allowed in DT, extcon subsystem requires
another way to get extcon device. Lets try the simplest approach - get
edev by of_node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
v2: changed label to follow local convention (Chanwoo)
---
 drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
 include/linux/extcon.h  |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index cb38c2747684..c4972c4cb3bd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
 #ifdef CONFIG_OF
+
+/*
+ * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
+ * @node	: OF node identyfying edev
+ *
+ * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
+ */
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	struct extcon_dev *edev;
+
+	mutex_lock(&extcon_dev_list_lock);
+	list_for_each_entry(edev, &extcon_dev_list, entry)
+		if (edev->dev.parent && edev->dev.parent->of_node == node)
+			goto out;
+	edev = ERR_PTR(-EPROBE_DEFER);
+out:
+	mutex_unlock(&extcon_dev_list_lock);
+
+	return edev;
+}
+
 /*
  * extcon_get_edev_by_phandle - Get the extcon device from devicetree.
  * @dev		: the instance to the given device
@@ -1363,25 +1385,27 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	mutex_lock(&extcon_dev_list_lock);
-	list_for_each_entry(edev, &extcon_dev_list, entry) {
-		if (edev->dev.parent && edev->dev.parent->of_node == node) {
-			mutex_unlock(&extcon_dev_list_lock);
-			of_node_put(node);
-			return edev;
-		}
-	}
-	mutex_unlock(&extcon_dev_list_lock);
+	edev = extcon_get_edev_by_of_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return edev;
 }
+
 #else
+
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
+
 #endif /* CONFIG_OF */
+
+EXPORT_SYMBOL_GPL(extcon_get_edev_by_of_node);
 EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
 
 /**
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 6d94e82c8ad9..b47e0c7f01fe 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -230,6 +230,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
  * Following APIs get the extcon_dev from devicetree or by through extcon name.
  */
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+extern struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node);
 extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
@@ -283,6 +284,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 				int index)
 {
-- 
2.15.1
