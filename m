From: nm@ti.com (Nishanth Menon)
Date: Tue, 1 Dec 2015 09:34:48 -0600
Subject: [PATCH] reset: Introduce static inline dummy function when
 CONFIG_RESET_CONTROLLER
Message-ID: <1448984088-31904-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_RESET_CONTROLLER is not defined (example COMPILE_TEST),
provide a dummy static inline implementation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 include/linux/reset-controller.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ce6b962ffed4..4badecb2619e 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -48,7 +48,16 @@ struct reset_controller_dev {
 	unsigned int nr_resets;
 };
 
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
+#else
+static inline int reset_controller_register(struct reset_controller_dev *r)
+{
+	return -EINVAL;
+}
 
+static inline void reset_controller_unregister(struct reset_controller_dev *r)
+{
+}
 #endif
-- 
2.6.2.402.g2635c2b
