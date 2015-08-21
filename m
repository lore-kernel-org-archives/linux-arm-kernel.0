From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Aug 2015 10:26:41 +0200
Subject: [PATCH v3 2/4] regmap: Fix regmap_bulk_write for bus writes
In-Reply-To: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
References: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440145603-9612-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regmap config does not prohibit val_bytes that are not powers of
two. But the current code of regmap_bulk_write for use_single_rw does
limit the possible val_bytes to 1, 2 and 4.

This patch fixes the behaviour to allow bus writes with non-standard
val_bytes sizes.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 375fec92dc7e..e986e84b8871 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1678,9 +1678,15 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 
 	/*
 	 * Some devices don't support bulk write, for
-	 * them we have a series of single write operations.
+	 * them we have a series of single write operations in the first two if
+	 * blocks.
+	 *
+	 * The first if block is used for memory mapped io. It does not allow
+	 * val_bytes of 3 for example.
+	 * The second one is used for busses which do not have this limitation
+	 * and can write arbitrary value lengths.
 	 */
-	if (!map->bus || map->use_single_rw) {
+	if (!map->bus) {
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
@@ -1712,6 +1718,17 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
+	} else if (map->use_single_rw) {
+		map->lock(map->lock_arg);
+		for (i = 0; i < val_count; i++) {
+			ret = _regmap_raw_write(map,
+						reg + (i * map->reg_stride),
+						val + (i * val_bytes),
+						val_bytes);
+			if (ret)
+				break;
+		}
+		map->unlock(map->lock_arg);
 	} else {
 		void *wval;
 
-- 
2.4.6
