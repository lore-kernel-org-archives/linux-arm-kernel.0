From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:12:35 +0200
Subject: [PATCH 10/20] regmap: _regmap_raw_multi_reg_write: Add reg_write()
 support
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a fallback for busses which do not define a write() function.
Instead we write one register at a time using reg_write().

Without this patch, _regmap_raw_multi_reg_write would break as it tries
to call bus->write() without checking if it exists before.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 78eb96288a68..87f15fb60bc5 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1778,6 +1778,20 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	if (!len)
 		return -EINVAL;
 
+	/*
+	 * If bus->write is not supported we have to use reg_write for each
+	 * register value.
+	 */
+	if (!map->bus->write) {
+		for (i = 0; i < num_regs; i++) {
+			ret = map->reg_write(map, regs[i].reg, regs[i].def);
+			if (ret)
+				return ret;
+		}
+
+		return 0;
+	}
+
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.4.6
