From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:54 +0000
Subject: [RFC 37/47] mtd: nand: stm_nand_bch: fetch the bit-flips threshold
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-38-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If none is provided by the platform, the default ECC mode will be used.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index a0f0ae2..3853e7a 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -44,6 +44,12 @@ static int bch_ecc_sizes[] = {
 	[BCH_NO_ECC] = 0,
 };
 
+static int bch_ecc_strength[] = {
+	[BCH_18BIT_ECC] = 18,
+	[BCH_30BIT_ECC] = 30,
+	[BCH_NO_ECC] = 0,
+};
+
 /*
  * Inband Bad Block Table (IBBT)
  */
@@ -1843,6 +1849,21 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 	info->ecclayout.eccbytes =
 		nandi->sectors_per_page * bch_ecc_sizes[nandi->bch_ecc_mode];
 
+	/*
+	 * Get bit-flips threshold. A value of '0' is interpreted as
+	 * <ecc_strength>.
+	 */
+	if (pdata->bch_bitflip_threshold) {
+		nandi->bitflip_threshold = pdata->bch_bitflip_threshold;
+	} else {
+		dev_warn(nandi->dev,
+			 "WARNING: bit-flips threshold not specified.\n"
+			 "         Defaulting to ECC strength [%d]\n",
+			 bch_ecc_strength[nandi->bch_ecc_mode]);
+		nandi->bitflip_threshold =
+			bch_ecc_strength[nandi->bch_ecc_mode];
+	}
+
 	compatible = bch_check_compatibility(nandi, mtd, chip);
 	if (!compatible) {
 		dev_err(nandi->dev,
-- 
1.8.3.2
