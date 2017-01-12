From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Jan 2017 19:41:16 -0800
Subject: [PATCH net-next v2 05/10] drivers: base: Add device_find_class()
In-Reply-To: <20170112034121.27697-1-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
Message-ID: <20170112034121.27697-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper function to lookup a device reference given a class name.
This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
make it more generic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/base/core.c    | 19 +++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 020ea7f05520..3dd6047c10d8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2065,6 +2065,25 @@ struct device *device_find_child(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_find_child);
 
+static int dev_is_class(struct device *dev, void *class)
+{
+	if (dev->class != NULL && !strcmp(dev->class->name, class))
+		return 1;
+
+	return 0;
+}
+
+struct device *device_find_class(struct device *parent, char *class)
+{
+	if (dev_is_class(parent, class)) {
+		get_device(parent);
+		return parent;
+	}
+
+	return device_find_child(parent, class, dev_is_class);
+}
+EXPORT_SYMBOL_GPL(device_find_class);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 491b4c0ca633..8d37f5ecb972 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1120,6 +1120,7 @@ extern int device_for_each_child_reverse(struct device *dev, void *data,
 		     int (*fn)(struct device *dev, void *data));
 extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
+extern struct device *device_find_class(struct device *parent, char *class);
 extern int device_rename(struct device *dev, const char *new_name);
 extern int device_move(struct device *dev, struct device *new_parent,
 		       enum dpm_order dpm_order);
-- 
2.9.3
