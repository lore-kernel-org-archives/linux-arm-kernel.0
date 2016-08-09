From: broonie@kernel.org (Mark Brown)
Date: Tue, 09 Aug 2016 13:44:34 +0100
Subject: Applied "regmap: Add a function to check if a regmap register is
 cached" to the regmap tree
In-Reply-To: <1470671062-25479-2-git-send-email-cristian.birsan@microchip.com>
Message-ID: <E1bX6OY-0003is-9X@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regmap: Add a function to check if a regmap register is cached

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

>From 1ea975cf1ef57b1e44c0aec4820f60bb3b60904b Mon Sep 17 00:00:00 2001
From: Cristian Birsan <cristian.birsan@microchip.com>
Date: Mon, 8 Aug 2016 18:44:21 +0300
Subject: [PATCH] regmap: Add a function to check if a regmap register is
 cached

Add a function to check if a regmap register is cached. This will be used
in debugfs to dump the cached values of write only registers.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regmap.c   | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a0380338946a..f4be4c19bb17 100644
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
index 51fa7d66a393..1f011f9d6dcb 100644
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
2.8.1
