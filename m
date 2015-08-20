From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 11:12:35 +0200
Subject: [PATCH v2 4/5] regmap: regmap_raw_read return error on !bus->read
In-Reply-To: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440061956-29064-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return -ENOTSUPP if map->bus->read is not implemented and we do not use
the cache. This code path would directly use bus->read would run into an
NULL pointer for the read function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bb4e65e7a950..66efe25d64c9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2201,6 +2201,11 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
 	    map->cache_type == REGCACHE_NONE) {
+		if (!map->bus->read) {
+			ret = -ENOTSUPP;
+			goto out;
+		}
+
 		/* Physical block read if there's no cache involved */
 		ret = _regmap_raw_read(map, reg, val, val_len);
 
-- 
2.4.6
