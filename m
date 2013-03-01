From: dianders@chromium.org (Doug Anderson)
Date: Fri,  1 Mar 2013 08:57:31 -0800
Subject: [PATCH v4 1/2] i2c-core: dt: Pick i2c bus number from i2c alias if
 present
In-Reply-To: <1362157052-16738-1-git-send-email-dianders@chromium.org>
References: <1360630085-26874-1-git-send-email-dianders@chromium.org>
 <1362157052-16738-1-git-send-email-dianders@chromium.org>
Message-ID: <1362157052-16738-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows you to get the equivalent functionality of
i2c_add_numbered_adapter() with all data in the device tree and no
special case code in your driver.  This is a common device tree
technique.

For quick reference, the FDT syntax for using an alias to provide an
ID looks like:
  aliases {
    i2c0 = &i2c_0;
    i2c1 = &i2c_1;
  };

Signed-off-by: Doug Anderson <dianders@chromium.org>

---
Changes in v4:
- Rebased atop the removal of MAX_IDR_MASK.

Changes in v3:
- Addressed Wolfram's feedback; rebased atop idr-cleanup series.

Changes in v2: None

 drivers/i2c/i2c-core.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 991d38d..66c5252 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -921,13 +921,38 @@ out_list:
 }
 
 /**
+ * __i2c_add_numbered_adapter - i2c_add_numbered_adapter where nr is never -1
+ * @adap: the adapter to register (with adap->nr initialized)
+ * Context: can sleep
+ *
+ * See i2c_add_numbered_adapter() for details.
+ */
+static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
+{
+	int	id;
+
+	/* Handled by wrappers */
+	if (WARN_ON(adap->nr == -1))
+		return -EINVAL;
+
+	mutex_lock(&core_lock);
+	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
+		       GFP_KERNEL);
+	mutex_unlock(&core_lock);
+	if (id < 0)
+		return id == -ENOSPC ? -EBUSY : id;
+	return i2c_register_adapter(adap);
+}
+
+/**
  * i2c_add_adapter - declare i2c adapter, use dynamic bus number
  * @adapter: the adapter to add
  * Context: can sleep
  *
  * This routine is used to declare an I2C adapter when its bus number
- * doesn't matter.  Examples: for I2C adapters dynamically added by
- * USB links or PCI plugin cards.
+ * doesn't matter or when its bus number is specified by an dt alias.
+ * Examples of bases when the bus number doesn't matter: I2C adapters
+ * dynamically added by USB links or PCI plugin cards.
  *
  * When this returns zero, a new bus number was allocated and stored
  * in adap->nr, and the specified adapter became available for clients.
@@ -935,8 +960,17 @@ out_list:
  */
 int i2c_add_adapter(struct i2c_adapter *adapter)
 {
+	struct device *dev = &adapter->dev;
 	int id;
 
+	if (dev->of_node) {
+		id = of_alias_get_id(dev->of_node, "i2c");
+		if (id >= 0) {
+			adapter->nr = id;
+			return __i2c_add_numbered_adapter(adapter);
+		}
+	}
+
 	mutex_lock(&core_lock);
 	id = idr_alloc(&i2c_adapter_idr, adapter,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
@@ -975,18 +1009,9 @@ EXPORT_SYMBOL(i2c_add_adapter);
  */
 int i2c_add_numbered_adapter(struct i2c_adapter *adap)
 {
-	int	id;
-
 	if (adap->nr == -1) /* -1 means dynamically assign bus id */
 		return i2c_add_adapter(adap);
-
-	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1,
-		       GFP_KERNEL);
-	mutex_unlock(&core_lock);
-	if (id < 0)
-		return id == -ENOSPC ? -EBUSY : id;
-	return i2c_register_adapter(adap);
+	return __i2c_add_numbered_adapter(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_add_numbered_adapter);
 
-- 
1.8.1.3
