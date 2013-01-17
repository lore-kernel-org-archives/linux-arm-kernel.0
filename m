From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 17 Jan 2013 11:24:30 +0800
Subject: [PATCH v2 1/3] MTD: at91: atmel_nand: for PMECC,
 add code to choose the ecc bits and sector size according to the ONFI
 parameter ECC requirement.
In-Reply-To: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
References: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358393072-14794-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will check NAND flash's ecc minimum requirement in ONFI parameter.

If ecc minimum requirement is equal or smaller than pmecc-cap in dtsi, then 
use ecc_bits in ONFI. otherwise, return an error since pmecc-cap in dtsi 
doesn't meet the ecc minimum reqirement.

This patch also check sector size (codeword) requirement in ONFI. If it is 
equal or bigger than sector_size in dtsi, then use the one of ONFI. 
otherwise return error.

Currently we don't support to read the ECC parameter in ONFI extended 
parameter page. So in that case we just use the value specified in dts.

For non-ONFI support nand flash, we assume the minimum ecc requirement is 
2bits in 512 bytes.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
change log:
  v2: wrap the commit message. 

 drivers/mtd/nand/atmel_nand.c |   89 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index c516a94..b50283a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -908,6 +908,84 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
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
+ * Choose ecc cap and sector size in atmel_nand_host according to ONFI
+ * parameters ecc requirement.
+ * return 0 if success. otherwise return error code.
+ */
+static int pmecc_choose_ecc_bits(struct atmel_nand_host *host,
+		struct nand_chip *chip)
+{
+	int ecc_bits, sector_size;
+
+	if (!get_onfi_ecc_param(chip, &ecc_bits, &sector_size)) {
+		dev_info(host->dev, "ONFI params, minimum required ECC: %dbits in %d bytes\n",
+				ecc_bits, sector_size);
+
+		if (ecc_bits > host->pmecc_corr_cap) {
+			dev_err(host->dev, "Error: Need to set a bigger pmecc-cap in dts. Current is: %d\n",
+				host->pmecc_corr_cap);
+			return -EINVAL;
+		}
+		if (sector_size < host->pmecc_sector_size) {
+			dev_err(host->dev, "Error: Need to set a smaller pmecc-sector-size in dts. Current is: %d\n",
+					host->pmecc_sector_size);
+			return -EINVAL;
+		}
+
+		/* use the most fitable ecc bits (the near bigger one ) */
+		if (ecc_bits <= 2)
+			host->pmecc_corr_cap = 2;
+		else if (ecc_bits <= 4)
+			host->pmecc_corr_cap = 4;
+		else if (ecc_bits < 8)
+			host->pmecc_corr_cap = 8;
+		else if (ecc_bits < 12)
+			host->pmecc_corr_cap = 12;
+		else if (ecc_bits < 24)
+			host->pmecc_corr_cap = 24;
+		else
+			return -EINVAL;
+
+		/* use the most fitable sector size (the near smaller one ) */
+		if (sector_size >= 1024)
+			host->pmecc_sector_size = 1024;
+		else if (sector_size >= 512)
+			host->pmecc_sector_size = 512;
+		else
+			return -EINVAL;
+	} else {
+		dev_info(host->dev,
+		"NAND chip ECC reqirement is in Extended ONFI parameter, we don't support yet. So use default setting in dts\n");
+	}
+
+	return 0;
+}
+
 static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
@@ -916,8 +994,19 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 	struct resource *regs, *regs_pmerr, *regs_rom;
 	int cap, sector_size, err_no;
 
+	if (nand_chip->onfi_version) {
+		/* Choose ecc cap and sector size base on ONFI parameters */
+		err_no = pmecc_choose_ecc_bits(host, nand_chip);
+		if (err_no)
+			return err_no;
+	} else {
+		dev_info(host->dev, "NAND chip is not ONFI compliant, assume ecc_bits is 2");
+		host->pmecc_corr_cap = 2;
+	}
+
 	cap = host->pmecc_corr_cap;
 	sector_size = host->pmecc_sector_size;
+
 	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
 		 cap, sector_size);
 
-- 
1.7.9.5
