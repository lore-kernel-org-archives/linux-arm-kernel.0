From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 11:12:33 +0200
Subject: [PATCH v2 2/5] regmap: Fix regmap_bulk_write for bus writes
In-Reply-To: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440061956-29064-3-git-send-email-mpa@pengutronix.de>
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
 drivers/base/regmap/regmap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index a778cf943628..66a2fd42d77f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1680,7 +1680,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	 * Some devices don't support bulk write, for
 	 * them we have a series of single write operations.
 	 */
-	if (!map->bus || map->use_single_rw) {
+	if (!map->bus) {
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
@@ -1712,6 +1712,21 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
+	} else if (map->use_single_rw) {
+		/*
+		 * We need to handle bus writes separate to support val_bytes
+		 * that are not powers of 2.
+		 */
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
