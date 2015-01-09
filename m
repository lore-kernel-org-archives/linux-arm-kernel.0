From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:20 -0700
Subject: [PATCH 09/11] coresight: Fixing wrong #ifdef/#endif placement
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Fixing problem reported by:
        https://lkml.org/lkml/2015/1/6/86

The #ifdef/#endif is wrong and prevents the stub of function
of_get_coresight_platform_data() from being visible when
CONFIG_OF is not defined.

Moving CONFIG_OF condition out of CONFIG_CORESIGHT, making
them both independent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7cbfecbfa643..cd6d4c384ca3 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -230,10 +230,6 @@ extern void coresight_disable(struct coresight_device *csdev);
 extern int coresight_is_bit_set(u32 val, int position, int value);
 extern int coresight_timeout(void __iomem *addr, u32 offset,
 			     int position, int value);
-#ifdef CONFIG_OF
-extern struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node);
-#endif
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
@@ -245,10 +241,14 @@ static inline int coresight_is_bit_set(u32 val, int position, int value)
 					 { return 0; }
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
 				     int position, int value) { return 1; }
+#endif
+
 #ifdef CONFIG_OF
+extern struct coresight_platform_data *of_get_coresight_platform_data(
+				struct device *dev, struct device_node *node);
+#else
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, struct device_node *node) { return NULL; }
 #endif
-#endif
 
 #endif
-- 
1.9.1
