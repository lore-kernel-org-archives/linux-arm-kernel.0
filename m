From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:50 +0100
Subject: [PATCH 2/7] reset: Ensure drivers are explicit when requesting reset
 lines
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phasing out generic reset line requests enables us to make some better
decisions on when and how to (de)assert said lines.  If an 'exclusive'
line is requested, we know a device *requires* a reset and that it's
preferable to act upon a request right away.  However, if a 'shared'
reset line is requested, we can reasonably assume sure that placing a
device into reset isn't a hard requirement, but probably a measure to
save power and is thus able to cope with not being asserted if another
device is still in use.

In order allow gentle adoption and not to forcing all consumers to
move to the API immediately, causing administration headache between
subsystems, this patch adds some temporary stand-in shim-calls.  This
will ease the burden at merge time and allow subsystems to migrate over
to the new API in a more realistic time-frame.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/reset.h | 106 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 24 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 33eaf11..9cf4cf3 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -84,8 +84,8 @@ static inline struct reset_control *__devm_reset_control_get(
 #endif /* CONFIG_RESET_CONTROLLER */
 
 /**
- * reset_control_get - Lookup and obtain an exclusive reference to a
- *                     reset controller.
+ * reset_control_get_exclusive - Lookup and obtain an exclusive reference
+ *                               to a reset controller.
  * @dev: device to be reset by the controller
  * @id: reset line name
  *
@@ -98,8 +98,8 @@ static inline struct reset_control *__devm_reset_control_get(
  *
  * Use of id names is optional.
  */
-static inline struct reset_control *__must_check reset_control_get(
-					struct device *dev, const char *id)
+static inline struct reset_control *
+__must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
 #ifndef CONFIG_RESET_CONTROLLER
 	WARN_ON(1);
@@ -135,15 +135,15 @@ static inline struct reset_control *reset_control_get_shared(
 	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 1);
 }
 
-static inline struct reset_control *reset_control_get_optional(
+static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
 	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
 }
 
 /**
- * of_reset_control_get - Lookup and obtain an exclusive reference to a
- *                        reset controller.
+ * of_reset_control_get_exclusive - Lookup and obtain an exclusive reference
+ *                                  to a reset controller.
  * @node: device to be reset by the controller
  * @id: reset line name
  *
@@ -151,15 +151,16 @@ static inline struct reset_control *reset_control_get_optional(
  *
  * Use of id names is optional.
  */
-static inline struct reset_control *of_reset_control_get(
+static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
 	return __of_reset_control_get(node, id, 0, 0);
 }
 
 /**
- * of_reset_control_get_by_index - Lookup and obtain an exclusive reference to
- *                                 a reset controller by index.
+ * of_reset_control_get_exclusive_by_index - Lookup and obtain an exclusive
+ *                                           reference to a reset controller
+ *                                           by index.
  * @node: device to be reset by the controller
  * @index: index of the reset controller
  *
@@ -167,23 +168,27 @@ static inline struct reset_control *of_reset_control_get(
  * in whatever order. Returns a struct reset_control or IS_ERR() condition
  * containing errno.
  */
-static inline struct reset_control *of_reset_control_get_by_index(
+static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 					struct device_node *node, int index)
 {
 	return __of_reset_control_get(node, NULL, index, 0);
 }
 
 /**
- * devm_reset_control_get - resource managed reset_control_get()
+ * devm_reset_control_get_exclusive - resource managed
+ *                                    reset_control_get_exclusive()
  * @dev: device to be reset by the controller
  * @id: reset line name
  *
- * Managed reset_control_get(). For reset controllers returned from this
- * function, reset_control_put() is called automatically on driver detach.
- * See reset_control_get() for more information.
+ * Managed reset_control_get_exclusive(). For reset controllers returned
+ * from this function, reset_control_put() is called automatically on driver
+ * detach.
+ *
+ * See reset_control_get_exclusive() for more information.
  */
-static inline struct reset_control *__must_check devm_reset_control_get(
-					struct device *dev, const char *id)
+static inline struct reset_control *
+__must_check devm_reset_control_get_exclusive(struct device *dev,
+					      const char *id)
 {
 #ifndef CONFIG_RESET_CONTROLLER
 	WARN_ON(1);
@@ -206,23 +211,26 @@ static inline struct reset_control *devm_reset_control_get_shared(
 	return __devm_reset_control_get(dev, id, 0, 1);
 }
 
-static inline struct reset_control *devm_reset_control_get_optional(
+static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
 	return __devm_reset_control_get(dev, id, 0, 0);
 }
 
 /**
- * devm_reset_control_get_by_index - resource managed reset_control_get
+ * devm_reset_control_get_exclusive_by_index - resource managed
+ *                                             reset_control_get_exclusive()
  * @dev: device to be reset by the controller
  * @index: index of the reset controller
  *
- * Managed reset_control_get(). For reset controllers returned from this
- * function, reset_control_put() is called automatically on driver detach.
- * See reset_control_get() for more information.
+ * Managed reset_control_get_exclusive(). For reset controllers returned from
+ * this function, reset_control_put() is called automatically on driver
+ * detach.
+ *
+ * See reset_control_get_exclusive() for more information.
  */
-static inline struct reset_control *devm_reset_control_get_by_index(
-					struct device *dev, int index)
+static inline struct reset_control *
+devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
 	return __devm_reset_control_get(dev, NULL, index, 0);
 }
@@ -243,4 +251,54 @@ static inline struct reset_control *devm_reset_control_get_shared_by_index(
 	return __devm_reset_control_get(dev, NULL, index, 1);
 }
 
+/*
+ * TEMPORARY calls to use during transition:
+ *
+ *   of_reset_control_get() => of_reset_control_get_exclusive()
+ *
+ * These inline function calls will be removed once all consumers
+ * have been moved over to the new explicit API.
+ */
+static inline struct reset_control *reset_control_get(
+				struct device *dev, const char *id)
+{
+	return reset_control_get_exclusive(dev, id);
+}
+
+static inline struct reset_control *reset_control_get_optional(
+					struct device *dev, const char *id)
+{
+	return reset_control_get_optional_exclusive(dev, id);
+}
+
+static inline struct reset_control *of_reset_control_get(
+				struct device_node *node, const char *id)
+{
+	return of_reset_control_get_exclusive(node, id);
+}
+
+static inline struct reset_control *of_reset_control_get_by_index(
+				struct device_node *node, int index)
+{
+	return of_reset_control_get_exclusive_by_index(node, index);
+}
+
+static inline struct reset_control *devm_reset_control_get(
+				struct device *dev, const char *id)
+{
+	return devm_reset_control_get_exclusive(dev, id);
+}
+
+static inline struct reset_control *devm_reset_control_get_optional(
+				struct device *dev, const char *id)
+{
+	return devm_reset_control_get_optional_exclusive(dev, id);
+
+}
+
+static inline struct reset_control *devm_reset_control_get_by_index(
+				struct device *dev, int index)
+{
+	return devm_reset_control_get_exclusive_by_index(dev, index);
+}
 #endif
-- 
2.8.3
