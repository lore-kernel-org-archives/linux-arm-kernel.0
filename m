From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:28 +0100
Subject: [PATCH v4 38/52] mtd: nand: hisi504: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-39-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/hisi504_nand.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 96502b6..7bf844c 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -631,8 +631,28 @@ static void hisi_nfc_host_init(struct hinfc_host *host)
 	hinfc_write(host, HINFC504_INTEN_DMA, HINFC504_INTEN);
 }
 
-static struct nand_ecclayout nand_ecc_2K_16bits = {
-	.oobfree = { {2, 6} },
+static int hisi_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	/* FIXME: add ECC bytes position */
+	return -ENOTSUPP;
+}
+
+static int hisi_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = 6;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hisi_ooblayout_ops = {
+	.ecc = hisi_ooblayout_ecc,
+	.free = hisi_ooblayout_free,
 };
 
 static int hisi_nfc_ecc_probe(struct hinfc_host *host)
@@ -668,7 +688,7 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
 	case 16:
 		ecc_bits = 6;
 		if (mtd->writesize == 2048)
-			chip->ecc.layout = &nand_ecc_2K_16bits;
+			mtd_set_ooblayout(mtd, &hisi_ooblayout_ops);
 
 		/* TODO: add more page size support */
 		break;
-- 
2.1.4
