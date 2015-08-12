From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:12:34 +0200
Subject: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without write()
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some busses don't have a write() function defined. However we can use
reg_write() in special cases.

This patch adds support for reg_write() and throws errors if it was
unsuccessful.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 510dab052a95..78eb96288a68 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 		}
 	}
 
+	if (!map->bus->write && val_len == map->format.val_bytes) {
+		ret = _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
+		return ret;
+	}
+
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
 		int val_num = val_len / map->format.val_bytes;
@@ -1340,7 +1345,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	 * send the work_buf directly, otherwise try to do a gather
 	 * write.
 	 */
-	if (val == work_val) {
+	if (val == work_val && map->bus->write) {
 		ret = map->bus->write(map->bus_context, map->work_buf,
 				      map->format.reg_bytes +
 				      map->format.pad_bytes +
@@ -1354,7 +1359,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 						     val, val_len);
 
 		/* If that didn't work fall back on linearising by hand. */
-		if (ret == -ENOTSUPP) {
+		if (ret == -ENOTSUPP && map->bus->write) {
 			len = map->format.reg_bytes + map->format.pad_bytes +
 				val_len;
 			buf = kzalloc(len, GFP_KERNEL);
-- 
2.4.6
