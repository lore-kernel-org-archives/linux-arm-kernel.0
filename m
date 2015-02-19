From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 08:40:55 +0000
Subject: [PATCH 2/2] regmap: Add range check in _regmap_raw_write()
In-Reply-To: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424335255-7517-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_bulk_write() ends up using the path that invokes _regmap_raw_write(),
however _regmap_raw_write() never checks if the registers that are accessed
are actually within the accessible range. This results in kernel crashes when
trying to access registers beyond max_registers.

This patch just adds check before accessing the register range.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d480e49..32ce7b3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1202,16 +1202,14 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	void *buf;
 	int ret = -ENOTSUPP;
 	size_t len;
-	int i;
+	int i, count = val_len/map->format.val_bytes;
 
 	WARN_ON(!map->bus);
 
 	/* Check for unwritable registers before we start */
-	if (map->writeable_reg)
-		for (i = 0; i < val_len / map->format.val_bytes; i++)
-			if (!map->writeable_reg(map->dev,
-						reg + (i * map->reg_stride)))
-				return -EINVAL;
+	for (i = 0; i < count; i++)
+		if (!regmap_writeable(map, reg + (i * map->reg_stride)))
+			return -EINVAL;
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
-- 
1.9.1
