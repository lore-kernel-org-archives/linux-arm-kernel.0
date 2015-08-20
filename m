From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 11:12:36 +0200
Subject: [PATCH v2 5/5] regmap: No multi_write support if bus->write does not
 exist
In-Reply-To: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440061956-29064-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no multi_write support available if we cannot use raw_write.
This is the case if bus->write is not implemented.

This patch adds a condition that we need bus and bus->write so that
can_multi_write is true.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 66efe25d64c9..d43723bb3257 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -575,7 +575,7 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_stride = 1;
 	map->use_single_read = config->use_single_rw || !bus || !bus->read;
 	map->use_single_write = config->use_single_rw || !bus || !bus->write;
-	map->can_multi_write = config->can_multi_write;
+	map->can_multi_write = config->can_multi_write && bus && bus->write;
 	map->dev = dev;
 	map->bus = bus;
 	map->bus_context = bus_context;
-- 
2.4.6
