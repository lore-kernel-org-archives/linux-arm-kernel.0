From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 12:00:04 +0200
Subject: [PATCH v2 1/4] regmap: Introduce max_raw_read/write for
 regmap_bulk_read/write
In-Reply-To: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
References: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440064807-26346-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some buses which have a limit on the maximum number of bytes
that can be send/received. An example for this is
I2C_FUNC_SMBUS_I2C_BLOCK which does not support any reads/writes of more
than 32 bytes. The regmap_bulk operations should still be able to
utilize the full 32 bytes in this case.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/internal.h |  4 ++
 drivers/base/regmap/regmap.c   | 85 ++++++++++++++++++++++++++++++++++--------
 include/linux/regmap.h         |  4 ++
 3 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index d744ae3926dd..fc554e357c5d 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -146,6 +146,10 @@ struct regmap {
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
 
+	/* if set, raw reads/writes are limited to this size */
+	size_t max_raw_read;
+	size_t max_raw_write;
+
 	struct rb_root range_tree;
 	void *selector_work_buf;	/* Scratch buffer used for selector */
 };
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d43723bb3257..bb2bfadfb4a3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -576,6 +576,8 @@ struct regmap *regmap_init(struct device *dev,
 	map->use_single_read = config->use_single_rw || !bus || !bus->read;
 	map->use_single_write = config->use_single_rw || !bus || !bus->write;
 	map->can_multi_write = config->can_multi_write && bus && bus->write;
+	map->max_raw_read = bus->max_raw_read;
+	map->max_raw_write = bus->max_raw_write;
 	map->dev = dev;
 	map->bus = bus;
 	map->bus_context = bus_context;
@@ -1671,6 +1673,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 {
 	int ret = 0, i;
 	size_t val_bytes = map->format.val_bytes;
+	size_t total_size = val_bytes * val_count;
 
 	if (map->bus && !map->format.parse_inplace)
 		return -EINVAL;
@@ -1713,20 +1716,41 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
-	} else if (map->use_single_write) {
+	} else if (map->use_single_write ||
+		   (map->max_raw_write && map->max_raw_write < total_size)) {
 		/*
 		 * We need to handle bus writes separate to support val_bytes
 		 * that are not powers of 2.
 		 */
+		int chunk_stride = map->reg_stride;
+		size_t chunk_size = val_bytes;
+		size_t chunk_count = val_count;
+
+		if (!map->use_single_write) {
+			chunk_size = map->max_raw_write;
+			if (chunk_size % val_bytes)
+				chunk_size -= chunk_size % val_bytes;
+			chunk_count = total_size / chunk_size;
+			chunk_stride *= chunk_size / val_bytes;
+		}
+
 		map->lock(map->lock_arg);
-		for (i = 0; i < val_count; i++) {
+		/* Write as many bytes as possible with chunk_size */
+		for (i = 0; i < chunk_count; i++) {
 			ret = _regmap_raw_write(map,
-						reg + (i * map->reg_stride),
-						val + (i * val_bytes),
-						val_bytes);
+						reg + (i * chunk_stride),
+						val + (i * chunk_size),
+						chunk_size);
 			if (ret)
 				break;
 		}
+
+		/* Write remaining bytes */
+		if (!ret && chunk_size * i < total_size) {
+			ret = _regmap_raw_write(map, reg + (i * chunk_stride),
+						val + (i * chunk_size),
+						total_size - i * chunk_size);
+		}
 		map->unlock(map->lock_arg);
 	} else {
 		void *wval;
@@ -2314,20 +2338,51 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		 * Some devices does not support bulk read, for
 		 * them we have a series of single read operations.
 		 */
-		if (map->use_single_read) {
-			for (i = 0; i < val_count; i++) {
-				ret = regmap_raw_read(map,
-						reg + (i * map->reg_stride),
-						val + (i * val_bytes),
-						val_bytes);
-				if (ret != 0)
-					return ret;
-			}
-		} else {
+		size_t total_size = val_bytes * val_count;
+
+		if (!map->use_single_read &&
+		    (!map->max_raw_read || map->max_raw_read > total_size)) {
 			ret = regmap_raw_read(map, reg, val,
 					      val_bytes * val_count);
 			if (ret != 0)
 				return ret;
+		} else {
+			/*
+			 * Some devices do not support bulk read or do not
+			 * support large bulk reads, for them we have a series
+			 * of read operations.
+			 */
+			int chunk_stride = map->reg_stride;
+			size_t chunk_size = val_bytes;
+			size_t chunk_count = val_count;
+
+			if (!map->use_single_read) {
+				chunk_size = map->max_raw_read;
+				if (chunk_size % val_bytes)
+					chunk_size -= chunk_size % val_bytes;
+				chunk_count = total_size / chunk_size;
+				chunk_stride *= chunk_size / val_bytes;
+			}
+
+			/* Read bytes that fit into a multiple of chunk_size */
+			for (i = 0; i < chunk_count; i++) {
+				ret = regmap_raw_read(map,
+						      reg + (i * chunk_stride),
+						      val + (i * chunk_size),
+						      chunk_size);
+				if (ret != 0)
+					return ret;
+			}
+
+			/* Read remaining bytes */
+			if (chunk_size * i < total_size) {
+				ret = regmap_raw_read(map,
+						      reg + (i * chunk_stride),
+						      val + (i * chunk_size),
+						      total_size - i * chunk_size);
+				if (ret != 0)
+					return ret;
+			}
 		}
 
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 915454a1b54e..6c9de3e8dd6e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -310,6 +310,8 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @val_format_endian_default: Default endianness for formatted register
  *     values. Used when the regmap_config specifies DEFAULT. If this is
  *     DEFAULT, BIG is assumed.
+ * @max_raw_read: Max raw read size that can be used on the bus.
+ * @max_raw_write: Max raw write size that can be used on the bus.
  */
 struct regmap_bus {
 	bool fast_io;
@@ -324,6 +326,8 @@ struct regmap_bus {
 	u8 read_flag_mask;
 	enum regmap_endian reg_format_endian_default;
 	enum regmap_endian val_format_endian_default;
+	size_t max_raw_read;
+	size_t max_raw_write;
 };
 
 struct regmap *regmap_init(struct device *dev,
-- 
2.4.6
