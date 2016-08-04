From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Thu, 4 Aug 2016 17:55:58 +0300
Subject: [PATCH 2/2] regmap: debugfs: Add support for dumping write only
 device registers
In-Reply-To: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <1470322558-7501-3-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for dumping write only device registers in debugfs. This is
useful for audio codecs that have write only registers (like WM8731).
The logic that decides if a value can be printed is moved to
regmap_printable() function to allow for easier future updates.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/base/regmap/regmap-debugfs.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 3f0a7e2..8db10e9 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -77,6 +77,17 @@ static void regmap_debugfs_free_dump_cache(struct regmap *map)
 	}
 }
 
+static bool regmap_printable(struct regmap *map, unsigned int reg)
+{
+	if (regmap_precious(map, reg))
+		return false;
+
+	if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
+		return false;
+
+	return true;
+}
+
 /*
  * Work out where the start offset maps into register numbers, bearing
  * in mind that we suppress hidden registers.
@@ -105,8 +116,7 @@ static unsigned int regmap_debugfs_get_dump_start(struct regmap *map,
 	if (list_empty(&map->debugfs_off_cache)) {
 		for (; i <= map->max_register; i += map->reg_stride) {
 			/* Skip unprinted registers, closing off cache entry */
-			if (!regmap_readable(map, i) ||
-			    regmap_precious(map, i)) {
+			if (!regmap_printable(map, i)) {
 				if (c) {
 					c->max = p - 1;
 					c->max_reg = i - map->reg_stride;
@@ -204,7 +214,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
 
 	for (i = start_reg; i <= to; i += map->reg_stride) {
-		if (!regmap_readable(map, i))
+		if (!regmap_readable(map, i) && !regmap_cached(map, i))
 			continue;
 
 		if (regmap_precious(map, i))
@@ -222,7 +232,11 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 			buf_pos += map->debugfs_reg_len + 2;
 
 			/* Format the value, write all X if we can't read */
-			ret = regmap_read(map, i, &val);
+			if (regmap_readable(map, i))
+				ret = regmap_read(map, i, &val);
+			else
+				ret = regcache_read(map, i, &val);
+
 			if (ret == 0)
 				snprintf(buf + buf_pos, count - buf_pos,
 					 "%.*x", map->debugfs_val_len, val);
-- 
1.9.1
