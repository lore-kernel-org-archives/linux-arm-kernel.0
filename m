From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:49 +0100
Subject: [PATCH 1/7] reset: Reorder inline reset_control_get*() wrappers
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to split the current API into two, where consumers will
be forced to be explicit when requesting reset lines.  The choice
will be to either the call the *_exclusive or *_shared variant
depending on whether they can actually tolorate not being asserted
when that request is made.

The new API will look like this once reorded and complete:

  reset_control_get_exclusive()
  reset_control_get_shared()
  reset_control_get_optional_exclusive()
  reset_control_get_optional_shared()
  of_reset_control_get_exclusive()
  of_reset_control_get_shared()
  of_reset_control_get_exclusive_by_index()
  of_reset_control_get_shared_by_index()
  devm_reset_control_get_exclusive()
  devm_reset_control_get_shared()
  devm_reset_control_get_optional_exclusive()
  devm_reset_control_get_optional_shared()
  devm_reset_control_get_exclusive_by_index()
  devm_reset_control_get_shared_by_index()

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/reset.h | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index ec0306ce..33eaf11 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -107,12 +107,6 @@ static inline struct reset_control *__must_check reset_control_get(
 	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
 }
 
-static inline struct reset_control *reset_control_get_optional(
-					struct device *dev, const char *id)
-{
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
-}
-
 /**
  * reset_control_get_shared - Lookup and obtain a shared reference to a
  *                            reset controller.
@@ -141,6 +135,12 @@ static inline struct reset_control *reset_control_get_shared(
 	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 1);
 }
 
+static inline struct reset_control *reset_control_get_optional(
+					struct device *dev, const char *id)
+{
+	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
+}
+
 /**
  * of_reset_control_get - Lookup and obtain an exclusive reference to a
  *                        reset controller.
@@ -191,6 +191,21 @@ static inline struct reset_control *__must_check devm_reset_control_get(
 	return __devm_reset_control_get(dev, id, 0, 0);
 }
 
+/**
+ * devm_reset_control_get_shared - resource managed reset_control_get_shared()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_shared(). For reset controllers returned from
+ * this function, reset_control_put() is called automatically on driver detach.
+ * See reset_control_get_shared() for more information.
+ */
+static inline struct reset_control *devm_reset_control_get_shared(
+					struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, 1);
+}
+
 static inline struct reset_control *devm_reset_control_get_optional(
 					struct device *dev, const char *id)
 {
@@ -213,21 +228,6 @@ static inline struct reset_control *devm_reset_control_get_by_index(
 }
 
 /**
- * devm_reset_control_get_shared - resource managed reset_control_get_shared()
- * @dev: device to be reset by the controller
- * @id: reset line name
- *
- * Managed reset_control_get_shared(). For reset controllers returned from
- * this function, reset_control_put() is called automatically on driver detach.
- * See reset_control_get_shared() for more information.
- */
-static inline struct reset_control *devm_reset_control_get_shared(
-					struct device *dev, const char *id)
-{
-	return __devm_reset_control_get(dev, id, 0, 1);
-}
-
-/**
  * devm_reset_control_get_shared_by_index - resource managed
  * reset_control_get_shared
  * @dev: device to be reset by the controller
-- 
2.8.3
