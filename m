From: sjg@chromium.org (Simon Glass)
Date: Tue, 18 Sep 2012 11:21:53 -0700
Subject: [PATCH 1/7] PM / Domains: add generic function
 'pm_genpd_of_add_device_by_name'
In-Reply-To: <1347992519-6904-1-git-send-email-sjg@chromium.org>
References: <1347992519-6904-1-git-send-email-sjg@chromium.org>
Message-ID: <1347992519-6904-2-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prathyush K <prathyush.k@samsung.com>

A new function pm_genpd_of_add_device_by_name is added to the pm_domain
file. This function takes three parameters - target device to be added to
genpd, a device node and the name of the property. This function reads
the "propname" property from the device node and finds the corresponding
genpd device node. The target device is then added to this genpd by
calling __pm_genpd_of_add_device.

of_property_read_u32(dev_node, propname, &val);
genpd_node = of_find_node_by_phandle(val);
__pm_genpd_of_add_device(genpd_node, dev, NULL);

Signed-off-by: Prathyush K <prathyush.k@samsung.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
Tested-by: Prathyush Kalashwaram <prathyush@chromium.org>
---
 include/linux/pm_domain.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 30f794e..c733ece 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -137,6 +137,18 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 	return __pm_genpd_add_device(genpd, dev, NULL);
 }
 
+static inline int pm_genpd_of_add_device_by_name(
+					struct device_node *dev_node,
+					struct device *dev,
+					char *propname)
+{
+	u32 val;
+	struct device_node *genpd_node;
+	of_property_read_u32(dev_node, propname, &val);
+	genpd_node = of_find_node_by_phandle(val);
+	return __pm_genpd_of_add_device(genpd_node, dev, NULL);
+}
+
 static inline int pm_genpd_of_add_device(struct device_node *genpd_node,
 					 struct device *dev)
 {
@@ -184,6 +196,13 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_of_add_device_by_name(
+					struct device_node *dev_node,
+					struct device *dev,
+					char *propname)
+{
+	return -ENOSYS;
+}
 static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 					 struct device *dev)
 {
-- 
1.7.7.3
