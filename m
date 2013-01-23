From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 Jan 2013 20:47:11 +0800
Subject: [PATCH 4/5] MTD: atmel_nand: make pmecc-cap,
 pmecc-sector-size in dts is optional.
In-Reply-To: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358945232-2282-5-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If those two are not specified in dts file, driver will report an error.

TODO: in this case, driver will find ecc requirement in NAND ONFI parameters.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   52 ++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 1d989db..f186a37 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -101,6 +101,8 @@ struct atmel_nand_host {
 	u8			pmecc_corr_cap;
 	u16			pmecc_sector_size;
 	u32			pmecc_lookup_table_offset;
+	u32			pmecc_lookup_table_offset_512;
+	u32			pmecc_lookup_table_offset_1024;
 
 	int			pmecc_bytes_per_sector;
 	int			pmecc_sector_number;
@@ -916,8 +918,16 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 	struct resource *regs, *regs_pmerr, *regs_rom;
 	int cap, sector_size, err_no;
 
+	if (host->pmecc_corr_cap == 0 || host->pmecc_sector_size == 0)
+		/* TODO: Should use ONFI ecc parameters. */
+		return -EINVAL;
+
 	cap = host->pmecc_corr_cap;
 	sector_size = host->pmecc_sector_size;
+	host->pmecc_lookup_table_offset = (sector_size == 512) ?
+			host->pmecc_lookup_table_offset_512 :
+			host->pmecc_lookup_table_offset_1024;
+
 	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
 		 cap, sector_size);
 
@@ -1259,29 +1269,29 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 
 	/* use PMECC, get correction capability, sector size and lookup
 	 * table offset.
+	 * If correction bits and sector size are not specified, then find
+	 * them from NAND ONFI parameters.
 	 */
-	if (of_property_read_u32(np, "atmel,pmecc-cap", &val) != 0) {
-		dev_err(host->dev, "Cannot decide PMECC Capability\n");
-		return -EINVAL;
-	} else if ((val != 2) && (val != 4) && (val != 8) && (val != 12) &&
-	    (val != 24)) {
-		dev_err(host->dev,
-			"Unsupported PMECC correction capability: %d; should be 2, 4, 8, 12 or 24\n",
-			val);
-		return -EINVAL;
+	if (of_property_read_u32(np, "atmel,pmecc-cap", &val) == 0) {
+		if ((val != 2) && (val != 4) && (val != 8) && (val != 12) &&
+				(val != 24)) {
+			dev_err(host->dev,
+				"Unsupported PMECC correction capability: %d; should be 2, 4, 8, 12 or 24\n",
+				val);
+			return -EINVAL;
+		}
+		host->pmecc_corr_cap = (u8)val;
 	}
-	host->pmecc_corr_cap = (u8)val;
 
-	if (of_property_read_u32(np, "atmel,pmecc-sector-size", &val) != 0) {
-		dev_err(host->dev, "Cannot decide PMECC Sector Size\n");
-		return -EINVAL;
-	} else if ((val != 512) && (val != 1024)) {
-		dev_err(host->dev,
-			"Unsupported PMECC sector size: %d; should be 512 or 1024 bytes\n",
-			val);
-		return -EINVAL;
+	if (of_property_read_u32(np, "atmel,pmecc-sector-size", &val) == 0) {
+		if ((val != 512) && (val != 1024)) {
+			dev_err(host->dev,
+				"Unsupported PMECC sector size: %d; should be 512 or 1024 bytes\n",
+				val);
+			return -EINVAL;
+		}
+		host->pmecc_sector_size = (u16)val;
 	}
-	host->pmecc_sector_size = (u16)val;
 
 	if (of_property_read_u32_array(np, "atmel,pmecc-lookup-table-offset",
 			offset, 2) != 0) {
@@ -1292,8 +1302,8 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 		dev_err(host->dev, "Invalid PMECC lookup table offset\n");
 		return -EINVAL;
 	}
-	host->pmecc_lookup_table_offset =
-		(host->pmecc_sector_size == 512) ? offset[0] : offset[1];
+	host->pmecc_lookup_table_offset_512 = offset[0];
+	host->pmecc_lookup_table_offset_1024 = offset[1];
 
 	return 0;
 }
-- 
1.7.9.5
