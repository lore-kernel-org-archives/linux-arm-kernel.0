From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 19:48:34 +0100
Subject: Applied "regmap: Support bulk writes for devices without raw
 formatting" to the regmap tree
In-Reply-To: <1465870678-30128-2-git-send-email-wens@csie.org>
Message-ID: <E1bIKXK-0005rN-JW@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regmap: Support bulk writes for devices without raw formatting

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

>From 5bf75b44972a7edffa9f52cddb291d66bc16a4d6 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 20 Jun 2016 10:52:11 +0800
Subject: [PATCH] regmap: Support bulk writes for devices without raw
 formatting

When doing a bulk writes from a device which lacks raw I/O support we
fall back to doing register at a time reads but we still use the raw
formatters in order to render the data into the word size used by the
device (since bulk reads still operate on the device word size rather
than unsigned ints).  This means that devices without raw formatting
such as those that provide reg_read() are not supported.  Provide
handling for them by copying the values read into native endian values
of the appropriate size.

This complements commit d5b98eb12420 ("regmap: Support bulk reads for
devices without raw formatting").

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index df2d2ef5d6b3..51fa7d66a393 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1777,8 +1777,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	size_t val_bytes = map->format.val_bytes;
 	size_t total_size = val_bytes * val_count;
 
-	if (map->bus && !map->format.parse_inplace)
-		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
@@ -1789,7 +1787,8 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	 *
 	 * The first if block is used for memory mapped io. It does not allow
 	 * val_bytes of 3 for example.
-	 * The second one is used for busses which do not have this limitation
+	 * The second one is for busses that do not provide raw I/O.
+	 * The third one is used for busses which do not have these limitations
 	 * and can write arbitrary value lengths.
 	 */
 	if (!map->bus) {
@@ -1825,6 +1824,32 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
+	} else if (map->bus && !map->format.parse_inplace) {
+		const u8 *u8 = val;
+		const u16 *u16 = val;
+		const u32 *u32 = val;
+		unsigned int ival;
+
+		for (i = 0; i < val_count; i++) {
+			switch (map->format.val_bytes) {
+			case 4:
+				ival = u32[i];
+				break;
+			case 2:
+				ival = u16[i];
+				break;
+			case 1:
+				ival = u8[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			ret = regmap_write(map, reg + (i * map->reg_stride),
+					   ival);
+			if (ret)
+				return ret;
+		}
 	} else if (map->use_single_write ||
 		   (map->max_raw_write && map->max_raw_write < total_size)) {
 		int chunk_stride = map->reg_stride;
-- 
2.8.1
