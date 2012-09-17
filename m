From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 17 Sep 2012 12:53:20 +0530
Subject: [PATCH v3 2/4] lis3: lis3lv02d_spi: Add lis3lv02d device tree init
In-Reply-To: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Message-ID: <1347866602-2088-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lis3lv02d device tree initialization code/API to take pdata
from device node. Also remove CONFIG_OF ifdef from the driver,
if CONFIG_OF is not defined then OF APIs returns 0.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/misc/lis3lv02d/lis3lv02d_spi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
index 23f3986..e1db6f4 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -84,10 +84,12 @@ static int __devinit lis302dl_spi_probe(struct spi_device *spi)
 	lis3_dev.ac		= lis3lv02d_axis_normal;
 	lis3_dev.pdata		= spi->dev.platform_data;
 
-#ifdef CONFIG_OF
-	if (of_match_device(lis302dl_spi_dt_ids, &spi->dev))
+	if (of_match_device(lis302dl_spi_dt_ids, &spi->dev)) {
 		lis3_dev.of_node = spi->dev.of_node;
-#endif
+		ret = lis3lv02d_init_dt(&lis3_dev);
+		if (ret)
+			return ret;
+	}
 
 	spi_set_drvdata(spi, &lis3_dev);
 
-- 
1.7.9.5
