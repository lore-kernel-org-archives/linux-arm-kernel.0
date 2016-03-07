From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:13 +0100
Subject: [PATCH v4 23/52] mtd: nand: sharpsl: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-24-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-pxa/spitz.c   | 55 ++++++++++++++++++++++++++++++++++++---------
 drivers/mtd/nand/sharpsl.c  |  2 +-
 include/linux/mtd/sharpsl.h |  2 +-
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 825f903..165a8db 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -763,14 +763,49 @@ static struct nand_bbt_descr spitz_nand_bbt = {
 	.pattern	= scan_ff_pattern
 };
 
-static struct nand_ecclayout akita_oobinfo = {
-	.oobfree	= { {0x08, 0x09} },
-	.eccbytes	= 24,
-	.eccpos		= {
-			0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
-			0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
-			0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
-	},
+static int akita_ooblayout_ecc(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section > 12)
+		return -ERANGE;
+
+	switch (section % 3) {
+	case 0:
+		oobregion->offset = 5;
+		oobregion->length = 1;
+		break;
+
+	case 1:
+		oobregion->offset = 1;
+		oobregion->length = 3;
+		break;
+
+	case 2:
+		oobregion->offset = 6;
+		oobregion->length = 2;
+		break;
+	}
+
+	oobregion->offset += (section / 3) * 0x10;
+
+	return 0;
+}
+
+static int akita_ooblayout_free(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 8;
+	oobregion->length = 9;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops akita_ooblayout_ops = {
+	.ecc = akita_ooblayout_ecc,
+	.free = akita_ooblayout_free,
 };
 
 static struct sharpsl_nand_platform_data spitz_nand_pdata = {
@@ -804,11 +839,11 @@ static void __init spitz_nand_init(void)
 	} else if (machine_is_akita()) {
 		spitz_nand_partitions[1].size = 58 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	} else if (machine_is_borzoi()) {
 		spitz_nand_partitions[1].size = 32 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	}
 
 	platform_device_register(&spitz_nand_device);
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index b7d1b55..064ca17 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -148,6 +148,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Link the private data with the MTD structure */
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
+	mtd_set_ooblayout(mtd, data->ecc_layout);
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -170,7 +171,6 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.bytes = 3;
 	this->ecc.strength = 1;
 	this->badblock_pattern = data->badblock_pattern;
-	this->ecc.layout = data->ecc_layout;
 	this->ecc.hwctl = sharpsl_nand_enable_hwecc;
 	this->ecc.calculate = sharpsl_nand_calculate_ecc;
 	this->ecc.correct = nand_correct_data;
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 25f4d2a..65e91d0 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -14,7 +14,7 @@
 
 struct sharpsl_nand_platform_data {
 	struct nand_bbt_descr	*badblock_pattern;
-	struct nand_ecclayout	*ecc_layout;
+	const struct mtd_ooblayout_ops *ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 };
-- 
2.1.4
