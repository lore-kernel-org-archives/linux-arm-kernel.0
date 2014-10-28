From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 28 Oct 2014 11:13:11 -0700
Subject: [PATCH v7 1/2] mtd: nand: add sunxi NAND flash controller support
In-Reply-To: <1413896922-11680-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1413896922-11680-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413896922-11680-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141028181310.GA23619@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Oct 21, 2014 at 03:08:41PM +0200, Boris Brezillon wrote:
> +static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
> +				       struct nand_ecc_ctrl *ecc,
> +				       struct device_node *np)
> +{
> +	struct nand_ecclayout *layout;
> +	int i, j;
> +	int ret;
> +
> +	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
> +	if (ret)
> +		return ret;
> +
> +	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
> +	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
> +	layout = ecc->layout;
> +
> +	for (i = 0; i < ecc->steps; i++) {

Hmm, did you retest this since changing this to ecc->steps? I think this
won't work, since ecc->steps is only initialized in nand_scan_tail(),
which comes after this. I only recommended the change for the
{read,write}_page() type of functions, not the initialization functions.

[snip the rest]

So I'd suggest the following additional patch, and otherwise, the series
is fine with me. If you give your ack, I can just squash this in and
apply it to my tree:

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ea615dc442a4..ccaa8e283388 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -931,6 +931,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
 	struct nand_ecclayout *layout;
+	int nsectors;
 	int ret;
 	int i;
 
@@ -959,13 +960,14 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
 	layout = &data->layout;
+	nsectors = mtd->writesize / ecc->size;
 
-	if (mtd->oobsize < ((ecc->bytes + 4) * ecc->steps)) {
+	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
 		ret = -EINVAL;
 		goto err;
 	}
 
-	layout->eccbytes = (ecc->bytes * ecc->steps);
+	layout->eccbytes = (ecc->bytes * nsectors);
 
 	ecc->layout = layout;
 	ecc->priv = data;
@@ -988,6 +990,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				       struct device_node *np)
 {
 	struct nand_ecclayout *layout;
+	int nsectors;
 	int i, j;
 	int ret;
 
@@ -998,8 +1001,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
 	layout = ecc->layout;
+	nsectors = mtd->writesize / ecc->size;
 
-	for (i = 0; i < ecc->steps; i++) {
+	for (i = 0; i < nsectors; i++) {
 		if (i) {
 			layout->oobfree[i].offset =
 				layout->oobfree[i - 1].offset +
@@ -1022,13 +1026,13 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 					layout->oobfree[i].length + j;
 	}
 
-	if (mtd->oobsize > (ecc->bytes + 4) * ecc->steps) {
-		layout->oobfree[ecc->steps].offset =
-				layout->oobfree[ecc->steps - 1].offset +
-				layout->oobfree[ecc->steps - 1].length +
+	if (mtd->oobsize > (ecc->bytes + 4) * nsectors) {
+		layout->oobfree[nsectors].offset =
+				layout->oobfree[nsectors - 1].offset +
+				layout->oobfree[nsectors - 1].length +
 				ecc->bytes;
-		layout->oobfree[ecc->steps].length = mtd->oobsize -
-				((ecc->bytes + 4) * ecc->steps);
+		layout->oobfree[nsectors].length = mtd->oobsize -
+				((ecc->bytes + 4) * nsectors);
 	}
 
 	return 0;
@@ -1039,6 +1043,7 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 						struct device_node *np)
 {
 	struct nand_ecclayout *layout;
+	int nsectors;
 	int i;
 	int ret;
 
@@ -1051,8 +1056,9 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
 
 	layout = ecc->layout;
+	nsectors = mtd->writesize / ecc->size;
 
-	for (i = 0; i < (ecc->bytes * ecc->steps); i++)
+	for (i = 0; i < (ecc->bytes * nsectors); i++)
 		layout->eccpos[i] = i;
 
 	layout->oobfree[0].length = mtd->oobsize - i;
