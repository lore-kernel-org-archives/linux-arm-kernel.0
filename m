From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:52 +0530
Subject: [PATCH 10/11] fsmc/nand: Add sw bch support for ecc
 calculation/correction
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <3968b65e9aa0a81eca16ce0f20e45504da7ad7fe.1349778821.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 .../devicetree/bindings/mtd/fsmc-nand.txt          |   2 +
 drivers/mtd/nand/fsmc_nand.c                       | 156 +++++++++++++--------
 include/linux/mtd/fsmc.h                           |   3 +
 3 files changed, 106 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
index 598bca2..dcf513b 100644
--- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
@@ -30,6 +30,8 @@ Optional properties:
 - st,rb-gpios: When the st,ready-busy is defined as "rb-gpio", a gpio
   pin number is defined in this property
 
+- nand-sw-ecc: boolean indicating whether s/w ecc is supported
+
 Example:
 
 	fsmc: flash at d1800000 {
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 762cf83..ff84468 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -946,6 +946,9 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	} else
 		pdata->rbpin.use_pin = FSMC_RB_WAIT;
 
+	if (of_property_read_bool(np, "nand-sw-ecc"))
+		pdata->sw_ecc = true;
+
 	return 0;
 }
 #else
@@ -972,6 +975,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	int ret = 0;
 	u32 pid, bank;
+	uint oobeccsize, m;
 	int i;
 
 	if (np) {
@@ -1104,9 +1108,24 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	nand->cmd_ctrl = fsmc_cmd_ctrl;
 	nand->chip_delay = 30;
 
-	nand->ecc.mode = NAND_ECC_HW;
-	nand->ecc.hwctl = fsmc_enable_hwecc;
-	nand->ecc.size = 512;
+	if (pdata->sw_ecc) {
+		nand->ecc.mode = NAND_ECC_SOFT_BCH;
+		/*
+		 * The recent devices require n-bit correctibility in x bytes.
+		 * The values of n and x varies as below
+		 * n - 1 to 100
+		 * x - 512 to 1K
+		 * TODO: For now, take x = 1K for all sw bch mathematics. Think
+		 * of a better way to handle other device dependent
+		 * requirements. May be it should come from board dts files
+		 */
+		nand->ecc.size = 1024;
+	} else {
+		nand->ecc.mode = NAND_ECC_HW;
+		nand->ecc.hwctl = fsmc_enable_hwecc;
+		nand->ecc.size = 512;
+	}
+
 	nand->options = pdata->options;
 	nand->select_chip = fsmc_select_chip;
 	nand->badblockbits = 7;
@@ -1165,17 +1184,19 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 				nand->options & NAND_BUSWIDTH_16,
 				host->dev_timings, host->rbpin);
 
-	if (AMBA_REV_BITS(host->pid) >= 8) {
-		nand->ecc.read_page = fsmc_read_page_hwecc;
-		nand->ecc.calculate = fsmc_read_hwecc_ecc4;
-		nand->ecc.correct = fsmc_bch8_correct_data;
-		nand->ecc.bytes = 13;
-		nand->ecc.strength = 8;
-	} else {
-		nand->ecc.calculate = fsmc_read_hwecc_ecc1;
-		nand->ecc.correct = nand_correct_data;
-		nand->ecc.bytes = 3;
-		nand->ecc.strength = 1;
+	if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
+		if (AMBA_REV_BITS(host->pid) >= 8) {
+			nand->ecc.read_page = fsmc_read_page_hwecc;
+			nand->ecc.calculate = fsmc_read_hwecc_ecc4;
+			nand->ecc.correct = fsmc_bch8_correct_data;
+			nand->ecc.bytes = 13;
+			nand->ecc.strength = 8;
+		} else {
+			nand->ecc.calculate = fsmc_read_hwecc_ecc1;
+			nand->ecc.correct = nand_correct_data;
+			nand->ecc.bytes = 3;
+			nand->ecc.strength = 1;
+		}
 	}
 
 	/*
@@ -1187,48 +1208,73 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		goto err_scan_ident;
 	}
 
-	if (AMBA_REV_BITS(host->pid) >= 8) {
-		switch (host->mtd.oobsize) {
-		case 16:
-			nand->ecc.layout = &fsmc_ecc4_16_layout;
-			host->ecc_place = &fsmc_ecc4_sp_place;
-			break;
-		case 64:
-			nand->ecc.layout = &fsmc_ecc4_64_layout;
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
-		case 128:
-			nand->ecc.layout = &fsmc_ecc4_128_layout;
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
-		case 224:
-			nand->ecc.layout = &fsmc_ecc4_224_layout;
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
-		case 256:
-			nand->ecc.layout = &fsmc_ecc4_256_layout;
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
-		default:
-			printk(KERN_WARNING "No oob scheme defined for "
-			       "oobsize %d\n", mtd->oobsize);
-			BUG();
-		}
+	if (nand->ecc.mode == NAND_ECC_SOFT_BCH) {
+		/*
+		 * Initialize the ecc bytes and strength dynamically based on eccsize
+		 * and writesize.
+		 *
+		 * Parameters @eccsize and @eccbytes are used to compute BCH parameters
+		 * m (Galois field order) and t (error correction capability). @eccbytes
+		 * should be equal to the number of bytes required to store m*t bits,
+		 * where m is such that 2^m-1 > @eccsize*8.
+		 *
+		 * Example: to configure 4 bit correction per 512 bytes, you should pass
+		 * @eccsize = 512  (thus, m=13 is the smallest integer such that 2^m-1 >
+		 * 512*8) @eccbytes = 7 (7 bytes are required to store m*t = 13*4 = 52
+		 * bits)
+		 *
+		 * Note: 2 bytes of oob are considered reserved for bad block marking
+		 */
+		m = fls(1 + 8 * nand->ecc.size);
+		oobeccsize = ((host->mtd.oobsize - 2) * \
+				nand->ecc.size) / host->mtd.writesize;
+		nand->ecc.bytes = (oobeccsize / m) * m;
+		nand->ecc.strength = (nand->ecc.bytes * 8) / m;
+		nand->ecc.layout = NULL;
 	} else {
-		switch (host->mtd.oobsize) {
-		case 16:
-			nand->ecc.layout = &fsmc_ecc1_16_layout;
-			break;
-		case 64:
-			nand->ecc.layout = &fsmc_ecc1_64_layout;
-			break;
-		case 128:
-			nand->ecc.layout = &fsmc_ecc1_128_layout;
-			break;
-		default:
-			printk(KERN_WARNING "No oob scheme defined for "
-			       "oobsize %d\n", mtd->oobsize);
-			BUG();
+		if (AMBA_REV_BITS(host->pid) >= 8) {
+			switch (host->mtd.oobsize) {
+			case 16:
+				nand->ecc.layout = &fsmc_ecc4_16_layout;
+				host->ecc_place = &fsmc_ecc4_sp_place;
+				break;
+			case 64:
+				nand->ecc.layout = &fsmc_ecc4_64_layout;
+				host->ecc_place = &fsmc_ecc4_lp_place;
+				break;
+			case 128:
+				nand->ecc.layout = &fsmc_ecc4_128_layout;
+				host->ecc_place = &fsmc_ecc4_lp_place;
+				break;
+			case 224:
+				nand->ecc.layout = &fsmc_ecc4_224_layout;
+				host->ecc_place = &fsmc_ecc4_lp_place;
+				break;
+			case 256:
+				nand->ecc.layout = &fsmc_ecc4_256_layout;
+				host->ecc_place = &fsmc_ecc4_lp_place;
+				break;
+			default:
+				printk(KERN_WARNING "No oob scheme defined for "
+						"oobsize %d\n", mtd->oobsize);
+				BUG();
+			}
+		} else {
+			switch (host->mtd.oobsize) {
+			case 16:
+				nand->ecc.layout = &fsmc_ecc1_16_layout;
+				break;
+			case 64:
+				nand->ecc.layout = &fsmc_ecc1_64_layout;
+				break;
+			case 128:
+				nand->ecc.layout = &fsmc_ecc1_128_layout;
+				break;
+			default:
+				printk(KERN_WARNING "No oob scheme defined for "
+						"oobsize %d\n", mtd->oobsize);
+				BUG();
+			}
 		}
 	}
 
diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index eed22a1..07eee6e 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -176,6 +176,9 @@ struct fsmc_nand_platform_data {
 	/* priv structures for dma accesses */
 	void			*read_dma_priv;
 	void			*write_dma_priv;
+
+	/* whether s/w ecc is supported */
+	bool			sw_ecc;
 };
 
 extern int __init fsmc_nor_init(struct platform_device *pdev,
-- 
1.7.11.4
