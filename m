From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 19:43:02 +0900
Subject: [PATCH 14/22] mtd: nand: mediatek: return error code of
 nand_scan_ident/tail() on error
In-Reply-To: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1478256190-7452-15-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand_scan_ident/tail() returns an appropriate error value when
it fails.  Use it instead of the fixed error code -ENODEV.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/mtk_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index 5223a21..6c3eed3 100644
--- a/drivers/mtd/nand/mtk_nand.c
+++ b/drivers/mtd/nand/mtk_nand.c
@@ -1297,7 +1297,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
-		return -ENODEV;
+		return ret;
 
 	/* store bbt magic in page, cause OOB is not protected */
 	if (nand->bbt_options & NAND_BBT_USE_FLASH)
@@ -1323,7 +1323,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	ret = nand_scan_tail(mtd);
 	if (ret)
-		return -ENODEV;
+		return ret;
 
 	ret = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
 	if (ret) {
-- 
1.9.1
