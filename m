From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Mon, 8 Aug 2016 18:44:21 +0300
Subject: [PATCH v2 1/2] regmap: Add a function to check if a regmap register
 is cached
In-Reply-To: <1470671062-25479-1-git-send-email-cristian.birsan@microchip.com>
References: <20160804154814.GA10383@sirena.org.uk>
 <1470671062-25479-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <1470671062-25479-2-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to check if a regmap register is cached. This will be used
in debugfs to dump the cached values of write only registers.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regmap.c   | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a038033..f4be4c1 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -173,6 +173,7 @@ struct regcache_ops {
 	int (*drop)(struct regmap *map, unsigned int min, unsigned int max);
 };
 
+bool regmap_cached(struct regmap *map, unsigned int reg);
 bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 51fa7d6..1f011f9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -93,6 +93,29 @@ bool regmap_writeable(struct regmap *map, unsigned int reg)
 	return true;
 }
 
+bool regmap_cached(struct regmap *map, unsigned int reg)
+{
+	int ret;
+	unsigned int val;
+
+	if (map->cache == REGCACHE_NONE)
+		return false;
+
+	if (!map->cache_ops)
+		return false;
+
+	if (map->max_register && reg > map->max_register)
+		return false;
+
+	map->lock(map->lock_arg);
+	ret = regcache_read(map, reg, &val);
+	map->unlock(map->lock_arg);
+	if (ret)
+		return false;
+
+	return true;
+}
+
 bool regmap_readable(struct regmap *map, unsigned int reg)
 {
 	if (!map->reg_read)
-- 
1.9.1
