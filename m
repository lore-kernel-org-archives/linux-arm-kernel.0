From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 24 Dec 2015 00:28:38 -0800
Subject: [PATCH] soc: qcom: smem_state: Add stubs for disabled smem_state
Message-ID: <1450945718-7384-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 include/linux/soc/qcom/smem_state.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/soc/qcom/smem_state.h b/include/linux/soc/qcom/smem_state.h
index f35e1512fcaa..7b88697929e9 100644
--- a/include/linux/soc/qcom/smem_state.h
+++ b/include/linux/soc/qcom/smem_state.h
@@ -1,12 +1,17 @@
 #ifndef __QCOM_SMEM_STATE__
 #define __QCOM_SMEM_STATE__
 
+#include <linux/errno.h>
+
+struct device_node;
 struct qcom_smem_state;
 
 struct qcom_smem_state_ops {
 	int (*update_bits)(void *, u32, u32);
 };
 
+#ifdef CONFIG_QCOM_SMEM_STATE
+
 struct qcom_smem_state *qcom_smem_state_get(struct device *dev, const char *con_id, unsigned *bit);
 void qcom_smem_state_put(struct qcom_smem_state *);
 
@@ -15,4 +20,34 @@ int qcom_smem_state_update_bits(struct qcom_smem_state *state, u32 mask, u32 val
 struct qcom_smem_state *qcom_smem_state_register(struct device_node *of_node, const struct qcom_smem_state_ops *ops, void *data);
 void qcom_smem_state_unregister(struct qcom_smem_state *state);
 
+#else
+
+static inline struct qcom_smem_state *qcom_smem_state_get(struct device *dev,
+	const char *con_id, unsigned *bit)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void qcom_smem_state_put(struct qcom_smem_state *state)
+{
+}
+
+static inline int qcom_smem_state_update_bits(struct qcom_smem_state *state,
+	u32 mask, u32 value)
+{
+	return -EINVAL;
+}
+
+static inline struct qcom_smem_state *qcom_smem_state_register(struct device_node *of_node,
+	const struct qcom_smem_state_ops *ops, void *data)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void qcom_smem_state_unregister(struct qcom_smem_state *state)
+{
+}
+
+#endif
+
 #endif
-- 
2.5.0
