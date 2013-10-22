From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 15:27:37 +0800
Subject: [PATCH 1/1] mfd: syscon: return -ENXIO if CONFIG_MFD_SYSCON is not
 enabled
Message-ID: <1382426857-31975-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may not define CONFIG_MFD_SYSCON (or haven't syscon),
it can fix build error for those platforms.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/mfd/syscon.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index b473577..60bf0fb 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -17,10 +17,34 @@
 
 struct device_node;
 
+#if IS_ENABLED(CONFIG_MFD_SYSCON)
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+#else
+static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
+{
+	return ERR_PTR(-ENXIO);
+}
+
+static inline struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
+{
+	return ERR_PTR(-ENXIO);
+}
+
+static inline struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
+{
+	return ERR_PTR(-ENXIO);
+}
+static inline struct regmap *syscon_regmap_lookup_by_phandle(
+					struct device_node *np,
+					const char *property)
+{
+	return ERR_PTR(-ENXIO);
+}
+#endif
+
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
1.7.1
