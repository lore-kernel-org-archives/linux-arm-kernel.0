From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:18 -0700
Subject: [PATCH 01/21] of: device: Support loading a module with OF based
 modalias
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of ULPI devices, we want to be able to load the
driver before registering the device so that we don't get stuck
in a loop waiting for the phy module to appear and failing usb
controller probe. Currently we request the ulpi module via the
ulpi ids, but in the DT case we might need to request it with the
OF based modalias instead. Add a common function that allows
anyone to request a module with the OF based modalias.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/device.c       | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_device.h |  6 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index fd5cfad7c403..f275e5beb736 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -226,6 +226,56 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 	return tsize;
 }
 
+static ssize_t of_device_modalias_size(struct device *dev)
+{
+	const char *compat;
+	int cplen, i;
+	ssize_t csize;
+
+	if ((!dev) || (!dev->of_node))
+		return -ENODEV;
+
+	/* Name & Type */
+	csize = 5 + strlen(dev->of_node->name) + strlen(dev->of_node->type);
+
+	/* Get compatible property if any */
+	compat = of_get_property(dev->of_node, "compatible", &cplen);
+	if (!compat)
+		return csize;
+
+	/* Find true end (we tolerate multiple \0 at the end */
+	for (i = (cplen - 1); i >= 0 && !compat[i]; i--)
+		cplen--;
+	if (!cplen)
+		return csize;
+	cplen++;
+
+	/* Check space (need cplen+1 chars including final \0) */
+	return csize + cplen;
+}
+
+int of_device_request_module(struct device *dev)
+{
+	char *str;
+	ssize_t size;
+	int ret;
+
+	size = of_device_modalias_size(dev);
+	if (size < 0)
+		return size;
+
+	str = kmalloc(size + 1, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+
+	of_device_get_modalias(dev, str, size);
+	str[size] = '\0';
+	ret = request_module(str);
+	kfree(str);
+
+	return ret;
+}
+
 /**
  * of_device_uevent - Display OF related uevent information
  */
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687a89d..e9afbcc8de12 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -37,6 +37,7 @@ extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_get_modalias(struct device *dev,
 					char *str, ssize_t len);
+extern int of_device_request_module(struct device *dev);
 
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
@@ -78,6 +79,11 @@ static inline int of_device_get_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int of_device_request_module(struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline int of_device_uevent_modalias(struct device *dev,
 				   struct kobj_uevent_env *env)
 {
-- 
2.9.0.rc2.8.ga28705d
