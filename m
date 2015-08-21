From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Aug 2015 10:26:43 +0200
Subject: [PATCH v3 4/4] regmap: No multi_write support if bus->write does not
 exist
In-Reply-To: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
References: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440145603-9612-5-git-send-email-mpa@pengutronix.de>
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
index 75080774bf46..47fe0dfbbc46 100644
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
