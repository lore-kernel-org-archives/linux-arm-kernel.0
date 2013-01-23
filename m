From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 Jan 2013 20:47:12 +0800
Subject: [PATCH 5/5] MTD: at91: atmel_nand: for PMECC,
 add code to check the ONFI parameter ECC requirement.
In-Reply-To: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358945232-2282-6-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will check NAND flash's ecc minimum requirement in ONFI parameter.

1. if pmecc-cap, pmecc-sector-size is set in dts. then use it. Driver will
   print out a WARNING if the values are different from ONFI parameters.
2. if pmecc-cap, pmecc-sector-size is not set in dts, then use the value
   from ONFI parameters.
    * If ONFI ECC parameters are in ONFI extended parameter page, since we are
      not support it, so assume the minimum ecc requirement is 2 bits in 512
      bytes.
    * For non-ONFI support nand flash, also assume the minimum ecc requirement is
      2 bits in 512 bytes.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index f186a37..ffcbcca 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -910,6 +910,84 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
 }
 
+/*
+ * Get ECC requirement in ONFI parameters, returns -1 if ONFI
+ * parameters is not supported.
+ * return 0 if success to get the ECC requirement.
+ */
+static int get_onfi_ecc_param(struct nand_chip *chip,
+		int *ecc_bits, int *sector_size)
+{
+	*ecc_bits = *sector_size = 0;
+
+	if (chip->onfi_params.ecc_bits == 0xff)
+		/* TODO: the sector_size and ecc_bits need to be find in
+		 * extended ecc parameter, currently we don't support it.
+		 */
+		return -1;
+
+	*ecc_bits = chip->onfi_params.ecc_bits;
+
+	/* The default sector size (ecc codeword size) is 512 */
+	*sector_size = 512;
+
+	return 0;
+}
+
+/*
+ * Get ecc requirement from ONFI parameters ecc requirement.
+ * If pmecc-cap, pmecc-sector-size in DTS are not specified, this function
+ * will set them according to ONFI ecc requirement. Otherwise, use the
+ * value in DTS file.
+ * return 0 if success. otherwise return error code.
+ */
+static int pmecc_choose_ecc(struct atmel_nand_host *host,
+		int *cap, int *sector_size)
+{
+	/* Get ECC requirement from ONFI parameters */
+	*cap = *sector_size = 0;
+	if (host->nand_chip.onfi_version) {
+		if (!get_onfi_ecc_param(&host->nand_chip, cap, sector_size))
+			dev_info(host->dev, "ONFI params, minimum required ECC: %d bits in %d bytes\n",
+				*cap, *sector_size);
+		else
+			dev_info(host->dev, "NAND chip ECC reqirement is in Extended ONFI parameter, we don't support yet.\n");
+	} else {
+		dev_info(host->dev, "NAND chip is not ONFI compliant, assume ecc_bits is 2 in 512 bytes");
+	}
+	if (*cap == 0 && *sector_size == 0) {
+		*cap = 2;
+		*sector_size = 512;
+	}
+
+	/* If dts file doesn't specify then use the one in ONFI parameters */
+	if (host->pmecc_corr_cap == 0) {
+		/* use the most fitable ecc bits (the near bigger one ) */
+		if (*cap <= 2)
+			host->pmecc_corr_cap = 2;
+		else if (*cap <= 4)
+			host->pmecc_corr_cap = 4;
+		else if (*cap < 8)
+			host->pmecc_corr_cap = 8;
+		else if (*cap < 12)
+			host->pmecc_corr_cap = 12;
+		else if (*cap < 24)
+			host->pmecc_corr_cap = 24;
+		else
+			return -EINVAL;
+	}
+	if (host->pmecc_sector_size == 0) {
+		/* use the most fitable sector size (the near smaller one ) */
+		if (*sector_size >= 1024)
+			host->pmecc_sector_size = 1024;
+		else if (*sector_size >= 512)
+			host->pmecc_sector_size = 512;
+		else
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
@@ -918,9 +996,15 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 	struct resource *regs, *regs_pmerr, *regs_rom;
 	int cap, sector_size, err_no;
 
-	if (host->pmecc_corr_cap == 0 || host->pmecc_sector_size == 0)
-		/* TODO: Should use ONFI ecc parameters. */
-		return -EINVAL;
+	err_no = pmecc_choose_ecc(host, &cap, &sector_size);
+	if (err_no) {
+		dev_err(host->dev, "The NAND flash's ECC requirement are not support!");
+		return err_no;
+	}
+
+	if (cap != host->pmecc_corr_cap ||
+			sector_size != host->pmecc_sector_size)
+		dev_info(host->dev, "WARNING: Be Caution! Using different PMECC parameters from Nand ONFI ECC reqirement.\n");
 
 	cap = host->pmecc_corr_cap;
 	sector_size = host->pmecc_sector_size;
-- 
1.7.9.5
