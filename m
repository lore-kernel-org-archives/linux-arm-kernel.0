From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Thu, 4 Aug 2016 17:55:57 +0300
Subject: [PATCH 1/2] regmap: Add a function to check if a regmap register is
 cached
In-Reply-To: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <1470322558-7501-2-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to check if a regmap register is cached. This will be used
in debugfs to dump the cached values of write only registers.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regmap.c   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 3df9770..cae04f4 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -171,6 +171,7 @@ struct regcache_ops {
 	int (*drop)(struct regmap *map, unsigned int min, unsigned int max);
 };
 
+bool regmap_cached(struct regmap *map, unsigned int reg);
 bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4ac63c0..e07f3a9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -92,6 +92,20 @@ bool regmap_writeable(struct regmap *map, unsigned int reg)
 	return true;
 }
 
+bool regmap_cached(struct regmap *map, unsigned int reg)
+{
+	if (map->cache == REGCACHE_NONE)
+		return false;
+
+	if (!map->cache_ops)
+		return false;
+
+	if (map->max_register && reg > map->max_register)
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
