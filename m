From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 25 Sep 2014 18:05:34 +0300
Subject: [RFC PATCH 1/4] PM / clock_ops: Add pm_clk_add_clk()
In-Reply-To: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
References: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1411657537-25238-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing pm_clk_add() allows to pass a clock by con_id. However,
when referring to a specific clock from DT, no con_id is available.

Add pm_clk_add_clk(), which allows to specify the struct clk * directly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/power/clock_ops.c | 41 +++++++++++++++++++++++++++++++----------
 include/linux/pm_clock.h       |  8 ++++++++
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index b99e6c0..4ac586d 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -53,7 +53,8 @@ static inline int __pm_clk_enable(struct device *dev, struct clk *clk)
  */
 static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 {
-	ce->clk = clk_get(dev, ce->con_id);
+	if (!ce->clk)
+		ce->clk = clk_get(dev, ce->con_id);
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 	} else {
@@ -63,15 +64,8 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	}
 }
 
-/**
- * pm_clk_add - Start using a device clock for power management.
- * @dev: Device whose clock is going to be used for power management.
- * @con_id: Connection ID of the clock.
- *
- * Add the clock represented by @con_id to the list of clocks used for
- * the power management of @dev.
- */
-int pm_clk_add(struct device *dev, const char *con_id)
+static int __pm_clk_add(struct device *dev, const char *con_id,
+			struct clk *clk)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
 	struct pm_clock_entry *ce;
@@ -93,6 +87,8 @@ int pm_clk_add(struct device *dev, const char *con_id)
 			kfree(ce);
 			return -ENOMEM;
 		}
+	} else {
+		ce->clk = clk;
 	}
 
 	pm_clk_acquire(dev, ce);
@@ -104,6 +100,31 @@ int pm_clk_add(struct device *dev, const char *con_id)
 }
 
 /**
+ * pm_clk_add - Start using a device clock for power management.
+ * @dev: Device whose clock is going to be used for power management.
+ * @con_id: Connection ID of the clock.
+ *
+ * Add the clock represented by @con_id to the list of clocks used for
+ * the power management of @dev.
+ */
+int pm_clk_add(struct device *dev, const char *con_id)
+{
+	return __pm_clk_add(dev, con_id, NULL);
+}
+
+/**
+ * pm_clk_add_clk - Start using a device clock for power management.
+ * @dev: Device whose clock is going to be used for power management.
+ * @clk: Clock pointer
+ *
+ * Add the clock to the list of clocks used for the power management of @dev.
+ */
+int pm_clk_add_clk(struct device *dev, struct clk *clk)
+{
+	return __pm_clk_add(dev, NULL, clk);
+}
+
+/**
  * __pm_clk_remove - Destroy PM clock entry.
  * @ce: PM clock entry to destroy.
  */
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 8348866..0b00396 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -18,6 +18,8 @@ struct pm_clk_notifier_block {
 	char *con_ids[];
 };
 
+struct clk;
+
 #ifdef CONFIG_PM_CLK
 static inline bool pm_clk_no_clocks(struct device *dev)
 {
@@ -29,6 +31,7 @@ extern void pm_clk_init(struct device *dev);
 extern int pm_clk_create(struct device *dev);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
+extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
 extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
@@ -51,6 +54,11 @@ static inline int pm_clk_add(struct device *dev, const char *con_id)
 {
 	return -EINVAL;
 }
+
+static inline int pm_clk_add_clk(struct device *dev, struct clk *clk)
+{
+	return -EINVAL;
+}
 static inline void pm_clk_remove(struct device *dev, const char *con_id)
 {
 }
-- 
1.9.1
