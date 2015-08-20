From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 12:00:06 +0200
Subject: [PATCH v2 3/4] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
In-Reply-To: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
References: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440064807-26346-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check in regmap_raw_read() and regmap_raw_write() for correct maximum
sizes of the operations. Return -E2BIG if this size is not supported
because it is too big.

Also this patch causes an uninitialized variable warning so it
initializes ret (although not necessary).

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 99f5f1165b60..77c9f235bf3d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1581,6 +1581,8 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
+	if (map->max_raw_write && map->max_raw_write > val_len)
+		return -E2BIG;
 
 	map->lock(map->lock_arg);
 
@@ -2251,6 +2253,10 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 			ret = -ENOTSUPP;
 			goto out;
 		}
+		if (map->max_raw_read && map->max_raw_read < val_len) {
+			ret = -E2BIG;
+			goto out;
+		}
 
 		/* Physical block read if there's no cache involved */
 		ret = _regmap_raw_read(map, reg, val, val_len);
-- 
2.4.6
