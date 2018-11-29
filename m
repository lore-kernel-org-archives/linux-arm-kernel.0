From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 29 Nov 2018 14:29:54 +0800
Subject: [RESEND PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for parsing
 partitions
In-Reply-To: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
Message-ID: <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guochun Mao <guochun.mao@mediatek.com>

Replace mtd_device_register with mtd_device_parse_register for
parsing partitions and add ofpart support.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
Tested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 5442993..2278677 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -118,6 +118,8 @@ struct mtk_nor {
 	struct clk *nor_clk;
 };
 
+static const char * const probes[] = { "ofpart", NULL };
+
 static void mtk_nor_set_read_mode(struct mtk_nor *mtk_nor)
 {
 	struct spi_nor *nor = &mtk_nor->nor;
@@ -457,7 +459,7 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
 	if (ret)
 		return ret;
 
-	return mtd_device_register(&nor->mtd, NULL, 0);
+	return mtd_device_parse_register(&nor->mtd, probes, NULL, NULL, 0);
 }
 
 static int mtk_nor_drv_probe(struct platform_device *pdev)
-- 
1.9.1
