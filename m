From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:37 +0100
Subject: [PATCH v4 53/58] mtd: nand: simplify nand_dt_init() usage
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-54-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nand_dt_init() function requires 3 arguments where it actually needs one
(dn and mtd can both be retrieved from chip). Drop these parameters.

Testing for dn != NULL inside nand_dt_init() also helps simplifying the
caller code.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 5aec154..ae3fd2a 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3937,11 +3937,17 @@ ident_done:
 	return type;
 }
 
-static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip,
-			struct device_node *dn)
+static int nand_dt_init(struct nand_chip *chip)
 {
+	struct device_node *dn = nand_get_flash_node(chip);
 	int ecc_mode, ecc_strength, ecc_step;
 
+	if (!dn)
+		return 0;
+
+	/* MTD can automatically handle DT partitions, etc. */
+	mtd_set_of_node(nand_to_mtd(chip), dn);
+
 	if (of_get_nand_bus_width(dn) == 16)
 		chip->options |= NAND_BUSWIDTH_16;
 
@@ -3989,14 +3995,9 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	struct nand_flash_dev *type;
 	int ret;
 
-	if (nand_get_flash_node(chip)) {
-		/* MTD can automatically handle DT partitions, etc. */
-		mtd_set_of_node(mtd, nand_get_flash_node(chip));
-
-		ret = nand_dt_init(mtd, chip, nand_get_flash_node(chip));
-		if (ret)
-			return ret;
-	}
+	ret = nand_dt_init(chip);
+	if (ret)
+		return ret;
 
 	/* Set the default functions */
 	nand_set_defaults(chip, chip->options & NAND_BUSWIDTH_16);
-- 
2.1.4
