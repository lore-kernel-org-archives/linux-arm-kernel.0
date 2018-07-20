From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 17:15:20 +0200
Subject: [PATCH v4 28/35] mtd: rawnand: allow exiting immediately
 nand_scan_ident()
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Message-ID: <20180720151527.16038-29-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some driver (eg. docg4) will need to handle themselves the
identification phase. As part of the migration to use nand_scan()
everywhere (which will unconditionnaly call nand_scan_ident()), we add
a condition at the start of nand_scan_ident() to just "do nothing" if
the maxchips parameters is zero, meaning that the driver does not want
the core to handle this phase.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index dea41fa25be1..e7f135c100c2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5926,7 +5926,7 @@ static int nand_dt_init(struct nand_chip *chip)
 /**
  * nand_scan_ident - [NAND Interface] Scan for the NAND device
  * @mtd: MTD device structure
- * @maxchips: number of chips to scan for
+ * @maxchips: number of chips to scan for, returns immediately if 0
  * @table: alternative NAND ID table
  *
  * This is the first phase of the normal nand_scan() function. It reads the
@@ -5940,6 +5940,14 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
+	/*
+	 * If the number of chips to scan for is null, just return silently.
+	 * This is for specific drivers that must handle this part of the
+	 * probe process themselves (e.g docg4).
+	 */
+	if (!maxchips)
+		return 0;
+
 	/* Enforce the right timings for reset/detection */
 	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
 
-- 
2.14.1
