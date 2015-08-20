From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 12:00:05 +0200
Subject: [PATCH v2 2/4] regmap: regmap max_raw_read/write getter functions
In-Reply-To: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
References: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440064807-26346-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add functions to access the maximum size we can read/write using
regmap_raw_read/write().

This helps drivers that need to know how much they can write with the
raw functions without problems. There are some devices (e.g. bmc150)
that have fifos as registers which need to be read in specific chunks
otherwise samples are dropped.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 22 ++++++++++++++++++++++
 include/linux/regmap.h       |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bb2bfadfb4a3..99f5f1165b60 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1390,6 +1390,28 @@ bool regmap_can_raw_write(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_can_raw_write);
 
+/**
+ * regmap_get_raw_read_max - Get the maximum size we can read
+ *
+ * @map: Map to check.
+ */
+size_t regmap_get_raw_read_max(struct regmap *map)
+{
+	return map->max_raw_read;
+}
+EXPORT_SYMBOL_GPL(regmap_get_raw_read_max);
+
+/**
+ * regmap_get_raw_write_max - Get the maximum size we can read
+ *
+ * @map: Map to check.
+ */
+size_t regmap_get_raw_write_max(struct regmap *map)
+{
+	return map->max_raw_write;
+}
+EXPORT_SYMBOL_GPL(regmap_get_raw_write_max);
+
 static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 				       unsigned int val)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 6c9de3e8dd6e..9a49a2e22cc0 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -443,6 +443,8 @@ int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
 int regmap_async_complete(struct regmap *map);
 bool regmap_can_raw_write(struct regmap *map);
+size_t regmap_get_raw_read_max(struct regmap *map);
+size_t regmap_get_raw_write_max(struct regmap *map);
 
 int regcache_sync(struct regmap *map);
 int regcache_sync_region(struct regmap *map, unsigned int min,
-- 
2.4.6
