From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:51 +0100
Subject: [PATCH 3/7] reset: Supply *_shared variant calls when using of_* API
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-4-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consumers need to be able to specify whether they are requesting an
'exclusive' or 'shared' reset line no matter which API (of_*, devm_*,
etc) they are using.  This change allows users of the of_* API in
particular to specify that their request is for a 'shared' line.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/reset.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 9cf4cf3..fd69240 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -158,6 +158,31 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 }
 
 /**
+ * of_reset_control_get_shared - Lookup and obtain an shared reference
+ *                               to a reset controller.
+ * @node: device to be reset by the controller
+ * @id: reset line name
+ *
+ * When a reset-control is shared, the behavior of reset_control_assert /
+ * deassert is changed, the reset-core will keep track of a deassert_count
+ * and only (re-)assert the reset after reset_control_assert has been called
+ * as many times as reset_control_deassert was called. Also see the remark
+ * about shared reset-controls in the reset_control_assert docs.
+ *
+ * Calling reset_control_assert without first calling reset_control_deassert
+ * is not allowed on a shared reset control. Calling reset_control_reset is
+ * also not allowed on a shared reset control.
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *of_reset_control_get_shared(
+				struct device_node *node, const char *id)
+{
+	return __of_reset_control_get(node, id, 0, 1);
+}
+
+/**
  * of_reset_control_get_exclusive_by_index - Lookup and obtain an exclusive
  *                                           reference to a reset controller
  *                                           by index.
@@ -175,6 +200,34 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 }
 
 /**
+ * of_reset_control_get_shared_by_index - Lookup and obtain an shared
+ *                                        reference to a reset controller
+ *                                        by index.
+ * @node: device to be reset by the controller
+ * @index: index of the reset controller
+ *
+ * When a reset-control is shared, the behavior of reset_control_assert /
+ * deassert is changed, the reset-core will keep track of a deassert_count
+ * and only (re-)assert the reset after reset_control_assert has been called
+ * as many times as reset_control_deassert was called. Also see the remark
+ * about shared reset-controls in the reset_control_assert docs.
+ *
+ * Calling reset_control_assert without first calling reset_control_deassert
+ * is not allowed on a shared reset control. Calling reset_control_reset is
+ * also not allowed on a shared reset control.
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * This is to be used to perform a list of resets for a device or power domain
+ * in whatever order. Returns a struct reset_control or IS_ERR() condition
+ * containing errno.
+ */
+static inline struct reset_control *of_reset_control_get_shared_by_index(
+					struct device_node *node, int index)
+{
+	return __of_reset_control_get(node, NULL, index, 1);
+}
+
+/**
  * devm_reset_control_get_exclusive - resource managed
  *                                    reset_control_get_exclusive()
  * @dev: device to be reset by the controller
-- 
2.8.3
