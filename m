From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Mon, 8 Aug 2016 18:44:22 +0300
Subject: [PATCH v2 2/2] regmap: debugfs: Add support for dumping write only
 device registers
In-Reply-To: <1470671062-25479-1-git-send-email-cristian.birsan@microchip.com>
References: <20160804154814.GA10383@sirena.org.uk>
 <1470671062-25479-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <1470671062-25479-3-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for dumping write only device registers in debugfs. This is
useful for audio codecs that have write only registers (like WM8731).
The logic that decides if a value can be printed is moved to
regmap_printable() function to allow for easier future updates.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/base/regmap/regmap-debugfs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 1ee3d40..36ce351 100644
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
-- 
1.9.1
