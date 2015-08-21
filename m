From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Aug 2015 10:26:42 +0200
Subject: [PATCH v3 3/4] regmap: Split use_single_rw internally into
 use_single_read/write
In-Reply-To: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
References: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440145603-9612-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use_single_rw currently reflects the capabilities of the connected
device. The capabilities of the bus are currently missing for this
variable.

As there are read only and write only buses we need seperate values for
use_single_rw to also reflect tha capabilities of the bus.

This patch splits use_single_rw into use_single_read and
use_single_write. The initialization is changed to check the
configuration for use_single_rw and to check the capabilities of the
used bus.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/internal.h   | 6 ++++--
 drivers/base/regmap/regcache.c   | 2 +-
 drivers/base/regmap/regmap-irq.c | 4 ++--
 drivers/base/regmap/regmap.c     | 9 +++++----
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b2b2849fc6d3..d744ae3926dd 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -139,8 +139,10 @@ struct regmap {
 	struct reg_default *patch;
 	int patch_regs;
 
-	/* if set, converts bulk rw to single rw */
-	bool use_single_rw;
+	/* if set, converts bulk read to single read */
+	bool use_single_read;
+	/* if set, converts bulk read to single read */
+	bool use_single_write;
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
 
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index b9862d741a56..6f8a13ec32a4 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -729,7 +729,7 @@ int regcache_sync_block(struct regmap *map, void *block,
 			unsigned int block_base, unsigned int start,
 			unsigned int end)
 {
-	if (regmap_can_raw_write(map) && !map->use_single_rw)
+	if (regmap_can_raw_write(map) && !map->use_single_write)
 		return regcache_sync_block_raw(map, block, cache_present,
 					       block_base, start, end);
 	else
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 2597600a5d26..38d1f72d869c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -209,7 +209,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	 * Read in the statuses, using a single bulk read if possible
 	 * in order to reduce the I/O overheads.
 	 */
-	if (!map->use_single_rw && map->reg_stride == 1 &&
+	if (!map->use_single_read && map->reg_stride == 1 &&
 	    data->irq_reg_stride == 1) {
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
@@ -398,7 +398,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	else
 		d->irq_reg_stride = 1;
 
-	if (!map->use_single_rw && map->reg_stride == 1 &&
+	if (!map->use_single_read && map->reg_stride == 1 &&
 	    d->irq_reg_stride == 1) {
 		d->status_reg_buf = kmalloc(map->format.val_bytes *
 					    chip->num_regs, GFP_KERNEL);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e986e84b8871..75080774bf46 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -573,7 +573,8 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_stride = config->reg_stride;
 	else
 		map->reg_stride = 1;
-	map->use_single_rw = config->use_single_rw;
+	map->use_single_read = config->use_single_rw || !bus || !bus->read;
+	map->use_single_write = config->use_single_rw || !bus || !bus->write;
 	map->can_multi_write = config->can_multi_write;
 	map->dev = dev;
 	map->bus = bus;
@@ -763,7 +764,7 @@ struct regmap *regmap_init(struct device *dev,
 		if ((reg_endian != REGMAP_ENDIAN_BIG) ||
 		    (val_endian != REGMAP_ENDIAN_BIG))
 			goto err_map;
-		map->use_single_rw = true;
+		map->use_single_write = true;
 	}
 
 	if (!map->format.format_write &&
@@ -1718,7 +1719,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
-	} else if (map->use_single_rw) {
+	} else if (map->use_single_write) {
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			ret = _regmap_raw_write(map,
@@ -2315,7 +2316,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		 * Some devices does not support bulk read, for
 		 * them we have a series of single read operations.
 		 */
-		if (map->use_single_rw) {
+		if (map->use_single_read) {
 			for (i = 0; i < val_count; i++) {
 				ret = regmap_raw_read(map,
 						reg + (i * map->reg_stride),
-- 
2.4.6
