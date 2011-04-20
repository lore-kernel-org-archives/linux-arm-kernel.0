From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Apr 2011 16:05:14 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
Message-ID: <1303308314-3213-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

early platform device may do not have a device name as the slab is not yet
available. So to search a clock base on the dev_id we need to search first the
device base name and then the id

we need this on AT91 to use the early device for the GPIO drivers and serial
at least, SH Mobile and SH could also use it for serial and other drivers

for this purpose this patch introduce two new API

clk_get_sys_id(dev_base_name, id, con_id)
and clk_get_pdev(pdev, con_id)

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/clk/clkdev.c |   43 +++++++++++++++++++++++++++++++++++++------
 include/linux/clk.h  |   41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index b9b949c2..8b50509 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -11,7 +11,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -33,8 +33,11 @@ static DEFINE_MUTEX(clocks_mutex);
  *  If an entry has a connection ID, it must match
  * Then we take the most specific entry - with the following
  * order of precedence: dev+con > dev only > con only.
+ *
+ * if id > 0 the dev_id will just contain the base name of the device
+ * it's need to search dev_id before slab is available
  */
-static struct clk *clk_find(const char *dev_id, const char *con_id)
+static struct clk *clk_find(const char *dev_id, int id, const char *con_id)
 {
 	struct clk_lookup *p;
 	struct clk *clk = NULL;
@@ -43,8 +46,19 @@ static struct clk *clk_find(const char *dev_id, const char *con_id)
 	list_for_each_entry(p, &clocks, node) {
 		match = 0;
 		if (p->dev_id) {
-			if (!dev_id || strcmp(p->dev_id, dev_id))
+			if (!dev_id) {
+				continue;
+			} else if (id < 0 && strcmp(p->dev_id, dev_id)) {
 				continue;
+			} else {
+				int len = strlen(dev_id);
+
+				if (strncmp(p->dev_id, dev_id, len))
+					continue;
+
+				if (simple_strtoul(p->dev_id + len + 1, NULL, 10) != id)
+					continue;
+			}
 			match += 2;
 		}
 		if (p->con_id) {
@@ -64,19 +78,36 @@ static struct clk *clk_find(const char *dev_id, const char *con_id)
 	return clk;
 }
 
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+struct clk *clk_get_sys_id(const char *dev_id, int id, const char *con_id)
 {
 	struct clk *clk;
 
 	mutex_lock(&clocks_mutex);
-	clk = clk_find(dev_id, con_id);
+	clk = clk_find(dev_id, id, con_id);
 	if (clk && !__clk_get(clk))
 		clk = NULL;
 	mutex_unlock(&clocks_mutex);
 
 	return clk ? clk : ERR_PTR(-ENOENT);
 }
-EXPORT_SYMBOL(clk_get_sys);
+EXPORT_SYMBOL(clk_get_sys_id);
+
+struct clk *clk_get_pdev(struct platform_device *pdev, const char *con_id)
+{
+	const char *dev_id;
+
+	if (!pdev)
+		return clk_get_sys(NULL, con_id);
+
+	dev_id = dev_name(&pdev->dev);
+
+	/* if the slub is not available dev_id is NULL */
+	if (is_early_platform_device(pdev) && !dev_id)
+		return clk_get_sys_id(pdev->name, pdev->id, NULL);
+
+	return clk_get_sys(dev_id, con_id);
+}
+EXPORT_SYMBOL(clk_get_pdev);
 
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1d37f42..31d1341 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -127,6 +127,42 @@ struct clk *clk_get_parent(struct clk *clk);
 
 /**
  * clk_get_sys - get a clock based upon the device name
+ * @dev_id: device base name
+ * @id:     device id
+ * @con_id: connection ID
+ *
+ * Returns a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev_id and @con_id to determine the clock consumer, and
+ * thereby the clock producer. In contrast to clk_get() this function
+ * takes the device name instead of the device itself for identification.
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_get_sys should not be called from within interrupt context.
+ */
+struct clk *clk_get_sys_id(const char *dev_id, int id, const char *con_id);
+
+/**
+ * clk_get_pdev - lookup and obtain a reference to a clock producer.
+ * @pdev: platform device for clock "consumer"
+ * @id: clock comsumer ID
+ *
+ * Returns a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  (IOW, @id may be identical strings, but
+ * clk_get may return different clock producers depending on @dev.)
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_get_pdev should not be called from within interrupt context.
+ */
+struct platform_device;
+struct clk *clk_get_pdev(struct platform_device *pdev, const char *con_id);
+
+/**
+ * clk_get_sys - get a clock based upon the device name
  * @dev_id: device name
  * @con_id: connection ID
  *
@@ -140,7 +176,10 @@ struct clk *clk_get_parent(struct clk *clk);
  *
  * clk_get_sys should not be called from within interrupt context.
  */
-struct clk *clk_get_sys(const char *dev_id, const char *con_id);
+static inline  struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+{
+	return clk_get_sys_id(dev_id, -1, con_id);
+}
 
 /**
  * clk_add_alias - add a new clock alias
-- 
1.7.4.1
