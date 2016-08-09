From: broonie@kernel.org (Mark Brown)
Date: Tue, 09 Aug 2016 13:44:31 +0100
Subject: Applied "regmap: debugfs: Add support for dumping write only device
 registers" to the regmap tree
In-Reply-To: <1470671062-25479-3-git-send-email-cristian.birsan@microchip.com>
Message-ID: <E1bX6OV-0003hs-C1@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regmap: debugfs: Add support for dumping write only device registers

has been applied to the regmap tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 359a2f17604e2c1c8938be2bba32a8cef9cf6303 Mon Sep 17 00:00:00 2001
From: Cristian Birsan <cristian.birsan@microchip.com>
Date: Mon, 8 Aug 2016 18:44:22 +0300
Subject: [PATCH] regmap: debugfs: Add support for dumping write only device
 registers

Add support for dumping write only device registers in debugfs. This is
useful for audio codecs that have write only registers (like WM8731).
The logic that decides if a value can be printed is moved to
regmap_printable() function to allow for easier future updates.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 1ee3d40861c7..36ce3511c733 100644
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
2.8.1
