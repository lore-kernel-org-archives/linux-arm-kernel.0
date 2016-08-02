From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 02 Aug 2016 12:34:18 +0900
Subject: [PATCH] extcon: Split out the extcon APIs for extcon provider driver
Message-ID: <1470108858-28178-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchs split out the extcon APIs of extcon provider driver in order to
prevent the direct access of struct extcon_dev by extcon consumer driver.
The extcon consumer driver don't need to handle the extcon provider APIs.

The extcon subsystem has two type of extcon drivers as following:
- extcon provider driver
: Detect the external connector and identify the state/property of
  each external connector. And it send the notification to synchronize
  the information between provider and consumer driver.
- extcon consumer driver
: Receive the notifcation from extcon provider driver. When receving the noti,
  it can get the both state and property of specific external connector.

Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches at opensource.wolfsonmicro.com
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/devres.c          |   2 +-
 drivers/extcon/extcon-adc-jack.c |   2 +-
 drivers/extcon/extcon-arizona.c  |   2 +-
 drivers/extcon/extcon-axp288.c   |   2 +-
 drivers/extcon/extcon-gpio.c     |   2 +-
 drivers/extcon/extcon-max14577.c |   2 +-
 drivers/extcon/extcon-max3355.c  |   2 +-
 drivers/extcon/extcon-max77693.c |   2 +-
 drivers/extcon/extcon-max77843.c |   2 +-
 drivers/extcon/extcon-max8997.c  |   2 +-
 drivers/extcon/extcon-palmas.c   |   1 +
 drivers/extcon/extcon-rt8973a.c  |   2 +-
 drivers/extcon/extcon-sm5502.c   |   2 +-
 drivers/extcon/extcon-usb-gpio.c |   2 +-
 drivers/extcon/extcon.c          |   2 +-
 drivers/phy/phy-rcar-gen3-usb2.c |   2 +-
 drivers/phy/phy-sun4i-usb.c      |   2 +-
 drivers/usb/phy/phy-tahvo.c      |   2 +-
 include/linux/extcon-provider.h  | 262 +++++++++++++++++++++++++++++++++++++++
 include/linux/extcon.h           | 169 +------------------------
 20 files changed, 284 insertions(+), 182 deletions(-)
 create mode 100644 include/linux/extcon-provider.h

diff --git a/drivers/extcon/devres.c b/drivers/extcon/devres.c
index e686acd1c459..1b7dce13b21b 100644
--- a/drivers/extcon/devres.c
+++ b/drivers/extcon/devres.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 static int devm_extcon_dev_match(struct device *dev, void *res, void *data)
 {
diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index e62e6cd7e00a..7340b03487fb 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -26,7 +26,7 @@
 #include <linux/workqueue.h>
 #include <linux/iio/consumer.h>
 #include <linux/extcon/extcon-adc-jack.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 /**
  * struct adc_jack_data - internal data for adc_jack device driver
diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 493bd9fe5f67..bf35697f7278 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -27,7 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 #include <sound/soc.h>
 
diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index fd55c2f2080a..2ba1a14a51fa 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -23,7 +23,7 @@
 #include <linux/property.h>
 #include <linux/usb/phy.h>
 #include <linux/notifier.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/regmap.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index b1b0264eb12d..835488ea7dbb 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -17,7 +17,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/extcon/extcon-gpio.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 852a7112f451..d0a01490649b 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/max14577.h>
 #include <linux/mfd/max14577-private.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 #define	DELAY_MS_DEFAULT		17000		/* unit: millisecond */
 
diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
index c24abec5d06c..ec94c2ff8f6f 100644
--- a/drivers/extcon/extcon-max3355.c
+++ b/drivers/extcon/extcon-max3355.c
@@ -9,7 +9,7 @@
  * may be copied, distributed, and modified under those terms.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index f17cb76b567c..9729b1fc402c 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -26,7 +26,7 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/regmap.h>
 #include <linux/irqdomain.h>
 
diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index b188bd650efa..7b9c8aa750ea 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -11,7 +11,7 @@
  * (at your option) any later version.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9a89320d09a8..dd1c002bf07d 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -25,7 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/mfd/max8997.h>
 #include <linux/mfd/max8997-private.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/irqdomain.h>
 
 #define	DEV_NAME			"max8997-muic"
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index caff46c0e214..e729c8312a69 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/extcon-provider.h>
 #include <linux/mfd/palmas.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index 97e074d70eca..4739eae81c22 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 #include "extcon-rt8973a.h"
 
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index df769a17e736..d41c7344fb1d 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 
 #include "extcon-sm5502.h"
 
diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 2512660dc4b9..9e0dce615219 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 4e7ef66543f6..efafb41e9ffd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -30,7 +30,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/err.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
index 76bb88f0700a..81b3b009aef8 100644
--- a/drivers/phy/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/phy-rcar-gen3-usb2.c
@@ -12,7 +12,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index bae54f7a1f48..6ca64725f1e6 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index ab5d364f6e8c..1343bff004eb 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/usb.h>
-#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb/otg.h>
diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
new file mode 100644
index 000000000000..e91dc028184b
--- /dev/null
+++ b/include/linux/extcon-provider.h
@@ -0,0 +1,262 @@
+/*
+ * linux/include/linux/extcon-provider.h
+ *
+ * Copyright (C) 2016 Samsung Electronics
+ * Author: Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_EXTCON_PROVIDER_H__
+#define __LINUX_EXTCON_PROVIDER_H__
+
+#include <linux/extcon.h>
+
+/**
+ * struct extcon_dev - An extcon device represents one external connector.
+ * @name:		The name of this extcon device. Parent device name is
+ *			used if NULL.
+ * @supported_cable:	Array of supported cable names ending with EXTCON_NONE.
+ *			If supported_cable is NULL, cable name related APIs
+ *			are disabled.
+ * @mutually_exclusive:	Array of mutually exclusive set of cables that cannot
+ *			be attached simultaneously. The array should be
+ *			ending with NULL or be NULL (no mutually exclusive
+ *			cables). For example, if it is { 0x7, 0x30, 0}, then,
+ *			{0, 1}, {0, 1, 2}, {0, 2}, {1, 2}, or {4, 5} cannot
+ *			be attached simulataneously. {0x7, 0} is equivalent to
+ *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
+ *			can be no simultaneous connections.
+ * @dev:		Device of this extcon.
+ * @state:		Attach/detach state of this extcon. Do not provide at
+ *			register-time.
+ * @nh:			Notifier for the state change events from this extcon
+ * @entry:		To support list of extcon devices so that users can
+ *			search for extcon devices based on the extcon name.
+ * @lock:
+ * @max_supported:	Internal value to store the number of cables.
+ * @extcon_dev_type:	Device_type struct to provide attribute_groups
+ *			customized for each extcon device.
+ * @cables:		Sysfs subdirectories. Each represents one cable.
+ *
+ * In most cases, users only need to provide "User initializing data" of
+ * this struct when registering an extcon. In some exceptional cases,
+ * optional callbacks may be needed. However, the values in "internal data"
+ * are overwritten by register function.
+ */
+struct extcon_dev {
+	/* Optional user initializing data */
+	const char *name;
+	const unsigned int *supported_cable;
+	const u32 *mutually_exclusive;
+
+	/* Internal data. Please do not set. */
+	struct device dev;
+	struct raw_notifier_head *nh;
+	struct list_head entry;
+	int max_supported;
+	spinlock_t lock;	/* could be called by irq handler */
+	u32 state;
+
+	/* /sys/class/extcon/.../cable.n/... */
+	struct device_type extcon_dev_type;
+	struct extcon_cable *cables;
+
+	/* /sys/class/extcon/.../mutually_exclusive/... */
+	struct attribute_group attr_g_muex;
+	struct attribute **attrs_muex;
+	struct device_attribute *d_attrs_muex;
+};
+
+#if IS_ENABLED(CONFIG_EXTCON)
+
+/*
+ * Following APIs are for notifiers or configurations.
+ * Notifiers are the external port and connection devices.
+ */
+extern int extcon_dev_register(struct extcon_dev *edev);
+extern void extcon_dev_unregister(struct extcon_dev *edev);
+extern int devm_extcon_dev_register(struct device *dev,
+				    struct extcon_dev *edev);
+extern void devm_extcon_dev_unregister(struct device *dev,
+				       struct extcon_dev *edev);
+
+/*
+ * Following APIs control the memory of extcon device.
+ */
+extern struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
+extern void extcon_dev_free(struct extcon_dev *edev);
+extern struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
+						   const unsigned int *cable);
+extern void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
+
+/*
+ * set_state access each bit of the 32b encoded state value.
+ * They are used to access the status of each cable based on the cable id.
+ */
+extern int extcon_set_state(struct extcon_dev *edev, unsigned int id,
+				   bool cable_state);
+extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
+				bool cable_state);
+
+/*
+ * Synchronize the state and property data for a specific external connector.
+ */
+extern int extcon_sync(struct extcon_dev *edev, unsigned int id);
+
+/*
+ * set_property access the property value of each external connector.
+ * They are used to access the property of each cable based on the property id.
+ */
+extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
+				unsigned int prop,
+				union extcon_property_value prop_val);
+extern int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
+				unsigned int prop,
+				union extcon_property_value prop_val);
+
+/*
+ * set_property_capability set the capability of the property for each
+ * external connector. They are used to set the capability of the property
+ * of each external connector based on the id and property.
+ */
+extern int extcon_set_property_capability(struct extcon_dev *edev,
+				unsigned int id, unsigned int prop);
+
+/*
+ * Following APIs are to monitor every action of a notifier.
+ * Registrar gets notified for every external port of a connection device.
+ * Probably this could be used to debug an action of notifier; however,
+ * we do not recommend to use this for normal 'notifiee' device drivers who
+ * want to be notified by a specific external port of the notifier.
+ */
+extern int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
+				    struct notifier_block *nb);
+extern int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
+				    struct notifier_block *nb);
+extern int devm_extcon_register_notifier(struct device *dev,
+				struct extcon_dev *edev, unsigned int id,
+				struct notifier_block *nb);
+extern void devm_extcon_unregister_notifier(struct device *dev,
+				struct extcon_dev *edev, unsigned int id,
+				struct notifier_block *nb);
+
+/*
+ * Following API get the extcon device from devicetree.
+ * This function use phandle of devicetree to get extcon device directly.
+ */
+extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
+						     int index);
+
+/* Following API to get information of extcon device */
+extern const char *extcon_get_edev_name(struct extcon_dev *edev);
+
+
+#else /* CONFIG_EXTCON */
+static inline int extcon_dev_register(struct extcon_dev *edev)
+{
+	return 0;
+}
+
+static inline void extcon_dev_unregister(struct extcon_dev *edev) { }
+
+static inline int devm_extcon_dev_register(struct device *dev,
+					   struct extcon_dev *edev)
+{
+	return -EINVAL;
+}
+
+static inline void devm_extcon_dev_unregister(struct device *dev,
+					      struct extcon_dev *edev) { }
+
+static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void extcon_dev_free(struct extcon_dev *edev) { }
+
+static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
+						const unsigned int *cable)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void devm_extcon_dev_free(struct extcon_dev *edev) { }
+
+static inline int extcon_set_state(struct extcon_dev *edev, unsigned int id,
+				bool cable_state)
+{
+	return 0;
+}
+
+static inline int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
+				bool cable_state)
+{
+	return 0;
+}
+
+static inline int extcon_sync(struct extcon_dev *edev, unsigned int id)
+{
+	return 0;
+}
+
+static inline int extcon_set_property(struct extcon_dev *edev, unsigned int id,
+					unsigned int prop,
+					union extcon_property_value prop_val)
+{
+	return 0;
+}
+
+static inline int extcon_set_property_sync(struct extcon_dev *edev,
+					unsigned int id, unsigned int prop,
+					union extcon_property_value prop_val)
+{
+	return 0;
+}
+
+static inline int extcon_set_property_capability(struct extcon_dev *edev,
+					unsigned int id, unsigned int prop)
+{
+	return 0;
+}
+
+static inline int extcon_register_notifier(struct extcon_dev *edev,
+					unsigned int id,
+					struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int extcon_unregister_notifier(struct extcon_dev *edev,
+					unsigned int id,
+					struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int devm_extcon_register_notifier(struct device *dev,
+				struct extcon_dev *edev, unsigned int id,
+				struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline  void devm_extcon_unregister_notifier(struct device *dev,
+				struct extcon_dev *edev, unsigned int id,
+				struct notifier_block *nb) { }
+#endif /* CONFIG_EXTCON */
+
+/*
+ * Following API are deprecated. EXTCON remains the function definition
+ * to prevent the build break.
+ */
+static inline int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
+				   bool cable_state)
+{
+	return extcon_set_state_sync(edev, id, cable_state);
+}
+#endif /* __LINUX_EXTCON_PROVIDER_H__ */
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 950f8491fa6a..926887853422 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -146,62 +146,7 @@ union extcon_property_value {
 };
 
 struct extcon_cable;
-
-/**
- * struct extcon_dev - An extcon device represents one external connector.
- * @name:		The name of this extcon device. Parent device name is
- *			used if NULL.
- * @supported_cable:	Array of supported cable names ending with EXTCON_NONE.
- *			If supported_cable is NULL, cable name related APIs
- *			are disabled.
- * @mutually_exclusive:	Array of mutually exclusive set of cables that cannot
- *			be attached simultaneously. The array should be
- *			ending with NULL or be NULL (no mutually exclusive
- *			cables). For example, if it is { 0x7, 0x30, 0}, then,
- *			{0, 1}, {0, 1, 2}, {0, 2}, {1, 2}, or {4, 5} cannot
- *			be attached simulataneously. {0x7, 0} is equivalent to
- *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
- *			can be no simultaneous connections.
- * @dev:		Device of this extcon.
- * @state:		Attach/detach state of this extcon. Do not provide at
- *			register-time.
- * @nh:			Notifier for the state change events from this extcon
- * @entry:		To support list of extcon devices so that users can
- *			search for extcon devices based on the extcon name.
- * @lock:
- * @max_supported:	Internal value to store the number of cables.
- * @extcon_dev_type:	Device_type struct to provide attribute_groups
- *			customized for each extcon device.
- * @cables:		Sysfs subdirectories. Each represents one cable.
- *
- * In most cases, users only need to provide "User initializing data" of
- * this struct when registering an extcon. In some exceptional cases,
- * optional callbacks may be needed. However, the values in "internal data"
- * are overwritten by register function.
- */
-struct extcon_dev {
-	/* Optional user initializing data */
-	const char *name;
-	const unsigned int *supported_cable;
-	const u32 *mutually_exclusive;
-
-	/* Internal data. Please do not set. */
-	struct device dev;
-	struct raw_notifier_head *nh;
-	struct list_head entry;
-	int max_supported;
-	spinlock_t lock;	/* could be called by irq handler */
-	u32 state;
-
-	/* /sys/class/extcon/.../cable.n/... */
-	struct device_type extcon_dev_type;
-	struct extcon_cable *cables;
-
-	/* /sys/class/extcon/.../mutually_exclusive/... */
-	struct attribute_group attr_g_muex;
-	struct attribute **attrs_muex;
-	struct device_attribute *d_attrs_muex;
-};
+struct extcon_dev;
 
 #if IS_ENABLED(CONFIG_EXTCON)
 
@@ -209,61 +154,29 @@ struct extcon_dev {
  * Following APIs are for notifiers or configurations.
  * Notifiers are the external port and connection devices.
  */
-extern int extcon_dev_register(struct extcon_dev *edev);
-extern void extcon_dev_unregister(struct extcon_dev *edev);
-extern int devm_extcon_dev_register(struct device *dev,
-				    struct extcon_dev *edev);
-extern void devm_extcon_dev_unregister(struct device *dev,
-				       struct extcon_dev *edev);
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
 
 /*
- * Following APIs control the memory of extcon device.
- */
-extern struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
-extern void extcon_dev_free(struct extcon_dev *edev);
-extern struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
-						   const unsigned int *cable);
-extern void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
-
-/*
- * get/set_state access each bit of the 32b encoded state value.
+ * get_state access each bit of the 32b encoded state value.
  * They are used to access the status of each cable based on the cable id.
  */
 extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
-extern int extcon_set_state(struct extcon_dev *edev, unsigned int id,
-				   bool cable_state);
-extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
-				bool cable_state);
 
 /*
- * Synchronize the state and property data for a specific external connector.
- */
-extern int extcon_sync(struct extcon_dev *edev, unsigned int id);
-
-/*
- * get/set_property access the property value of each external connector.
+ * get_property access the property value of each external connector.
  * They are used to access the property of each cable based on the property id.
  */
 extern int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value *prop_val);
-extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
-				unsigned int prop,
-				union extcon_property_value prop_val);
-extern int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
-				unsigned int prop,
-				union extcon_property_value prop_val);
 
 /*
- * get/set_property_capability set the capability of the property for each
+ * get_property_capability set the capability of the property for each
  * external connector. They are used to set the capability of the property
  * of each external connector based on the id and property.
  */
 extern int extcon_get_property_capability(struct extcon_dev *edev,
 				unsigned int id, unsigned int prop);
-extern int extcon_set_property_capability(struct extcon_dev *edev,
-				unsigned int id, unsigned int prop);
 
 /*
  * Following APIs are to monitor every action of a notifier.
@@ -293,81 +206,19 @@ extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 /* Following API to get information of extcon device */
 extern const char *extcon_get_edev_name(struct extcon_dev *edev);
 
-
 #else /* CONFIG_EXTCON */
-static inline int extcon_dev_register(struct extcon_dev *edev)
-{
-	return 0;
-}
-
-static inline void extcon_dev_unregister(struct extcon_dev *edev) { }
-
-static inline int devm_extcon_dev_register(struct device *dev,
-					   struct extcon_dev *edev)
-{
-	return -EINVAL;
-}
-
-static inline void devm_extcon_dev_unregister(struct device *dev,
-					      struct extcon_dev *edev) { }
-
-static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void extcon_dev_free(struct extcon_dev *edev) { }
-
-static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
-						const unsigned int *cable)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void devm_extcon_dev_free(struct extcon_dev *edev) { }
-
 
 static inline int extcon_get_state(struct extcon_dev *edev, unsigned int id)
 {
 	return 0;
 }
 
-static inline int extcon_set_state(struct extcon_dev *edev, unsigned int id,
-				bool cable_state)
-{
-	return 0;
-}
-
-static inline int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
-				bool cable_state)
-{
-	return 0;
-}
-
-static inline int extcon_sync(struct extcon_dev *edev, unsigned int id)
-{
-	return 0;
-}
-
 static inline int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 					unsigned int prop,
 					union extcon_property_value *prop_val)
 {
 	return 0;
 }
-static inline int extcon_set_property(struct extcon_dev *edev, unsigned int id,
-					unsigned int prop,
-					union extcon_property_value prop_val)
-{
-	return 0;
-}
-
-static inline int extcon_set_property_sync(struct extcon_dev *edev,
-					unsigned int id, unsigned int prop,
-					union extcon_property_value prop_val)
-{
-	return 0;
-}
 
 static inline int extcon_get_property_capability(struct extcon_dev *edev,
 					unsigned int id, unsigned int prop)
@@ -375,12 +226,6 @@ static inline int extcon_get_property_capability(struct extcon_dev *edev,
 	return 0;
 }
 
-static inline int extcon_set_property_capability(struct extcon_dev *edev,
-					unsigned int id, unsigned int prop)
-{
-	return 0;
-}
-
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
 	return NULL;
@@ -446,10 +291,4 @@ static inline int extcon_get_cable_state_(struct extcon_dev *edev, unsigned int
 {
 	return extcon_get_state(edev, id);
 }
-
-static inline int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
-				   bool cable_state)
-{
-	return extcon_set_state_sync(edev, id, cable_state);
-}
 #endif /* __LINUX_EXTCON_H__ */
-- 
1.9.1
