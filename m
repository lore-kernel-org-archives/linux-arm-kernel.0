From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  2 Dec 2015 12:01:07 +0100
Subject: [PATCH v2 3/3] mtd: nand: sunxi: add randomizer support
In-Reply-To: <1449054067-16751-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449054067-16751-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449054067-16751-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the randomizer engine available in Allwinner's NFC IP.

Randomization is useful to support modern NAND chips which are sensitive to
repeated patterns. On such NANDs you might experience an unexpectedly high
number of bitflips when you repeat the same pattern all over a given NAND
block.
Randomizing input data mitigate this problem by avoiding such repeated
patterns.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 287 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 261 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1bbcc0c..43f25327f 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -60,6 +60,7 @@
 #define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
 #define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
+#define NFC_REG_PAT_ID		0x00A4
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
 
@@ -539,6 +540,174 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 }
 
+/* These seed values have been extracted from Allwinner's BSP */
+static const u16 sunxi_nfc_randomizer_page_seeds[] = {
+	0x2b75, 0x0bd0, 0x5ca3, 0x62d1, 0x1c93, 0x07e9, 0x2162, 0x3a72,
+	0x0d67, 0x67f9, 0x1be7, 0x077d, 0x032f, 0x0dac, 0x2716, 0x2436,
+	0x7922, 0x1510, 0x3860, 0x5287, 0x480f, 0x4252, 0x1789, 0x5a2d,
+	0x2a49, 0x5e10, 0x437f, 0x4b4e, 0x2f45, 0x216e, 0x5cb7, 0x7130,
+	0x2a3f, 0x60e4, 0x4dc9, 0x0ef0, 0x0f52, 0x1bb9, 0x6211, 0x7a56,
+	0x226d, 0x4ea7, 0x6f36, 0x3692, 0x38bf, 0x0c62, 0x05eb, 0x4c55,
+	0x60f4, 0x728c, 0x3b6f, 0x2037, 0x7f69, 0x0936, 0x651a, 0x4ceb,
+	0x6218, 0x79f3, 0x383f, 0x18d9, 0x4f05, 0x5c82, 0x2912, 0x6f17,
+	0x6856, 0x5938, 0x1007, 0x61ab, 0x3e7f, 0x57c2, 0x542f, 0x4f62,
+	0x7454, 0x2eac, 0x7739, 0x42d4, 0x2f90, 0x435a, 0x2e52, 0x2064,
+	0x637c, 0x66ad, 0x2c90, 0x0bad, 0x759c, 0x0029, 0x0986, 0x7126,
+	0x1ca7, 0x1605, 0x386a, 0x27f5, 0x1380, 0x6d75, 0x24c3, 0x0f8e,
+	0x2b7a, 0x1418, 0x1fd1, 0x7dc1, 0x2d8e, 0x43af, 0x2267, 0x7da3,
+	0x4e3d, 0x1338, 0x50db, 0x454d, 0x764d, 0x40a3, 0x42e6, 0x262b,
+	0x2d2e, 0x1aea, 0x2e17, 0x173d, 0x3a6e, 0x71bf, 0x25f9, 0x0a5d,
+	0x7c57, 0x0fbe, 0x46ce, 0x4939, 0x6b17, 0x37bb, 0x3e91, 0x76db,
+};
+
+/*
+ * sunxi_nfc_randomizer_ecc512_seeds and sunxi_nfc_randomizer_ecc1024_seeds
+ * have been generated using
+ * sunxi_nfc_randomizer_step(seed, (step_size * 8) + 15), which is what
+ * the randomizer engine does internally before de/scrambling OOB data.
+ *
+ * Those tables are statically defined to avoid calculating randomizer state
+ * at runtime.
+ */
+static const u16 sunxi_nfc_randomizer_ecc512_seeds[] = {
+	0x3346, 0x367f, 0x1f18, 0x769a, 0x4f64, 0x068c, 0x2ef1, 0x6b64,
+	0x28a9, 0x15d7, 0x30f8, 0x3659, 0x53db, 0x7c5f, 0x71d4, 0x4409,
+	0x26eb, 0x03cc, 0x655d, 0x47d4, 0x4daa, 0x0877, 0x712d, 0x3617,
+	0x3264, 0x49aa, 0x7f9e, 0x588e, 0x4fbc, 0x7176, 0x7f91, 0x6c6d,
+	0x4b95, 0x5fb7, 0x3844, 0x4037, 0x0184, 0x081b, 0x0ee8, 0x5b91,
+	0x293d, 0x1f71, 0x0e6f, 0x402b, 0x5122, 0x1e52, 0x22be, 0x3d2d,
+	0x75bc, 0x7c60, 0x6291, 0x1a2f, 0x61d4, 0x74aa, 0x4140, 0x29ab,
+	0x472d, 0x2852, 0x017e, 0x15e8, 0x5ec2, 0x17cf, 0x7d0f, 0x06b8,
+	0x117a, 0x6b94, 0x789b, 0x3126, 0x6ac5, 0x5be7, 0x150f, 0x51f8,
+	0x7889, 0x0aa5, 0x663d, 0x77e8, 0x0b87, 0x3dcb, 0x360d, 0x218b,
+	0x512f, 0x7dc9, 0x6a4d, 0x630a, 0x3547, 0x1dd2, 0x5aea, 0x69a5,
+	0x7bfa, 0x5e4f, 0x1519, 0x6430, 0x3a0e, 0x5eb3, 0x5425, 0x0c7a,
+	0x5540, 0x3670, 0x63c1, 0x31e9, 0x5a39, 0x2de7, 0x5979, 0x2891,
+	0x1562, 0x014b, 0x5b05, 0x2756, 0x5a34, 0x13aa, 0x6cb5, 0x2c36,
+	0x5e72, 0x1306, 0x0861, 0x15ef, 0x1ee8, 0x5a37, 0x7ac4, 0x45dd,
+	0x44c4, 0x7266, 0x2f41, 0x3ccc, 0x045e, 0x7d40, 0x7c66, 0x0fa0,
+};
+
+static const u16 sunxi_nfc_randomizer_ecc1024_seeds[] = {
+	0x2cf5, 0x35f1, 0x63a4, 0x5274, 0x2bd2, 0x778b, 0x7285, 0x32b6,
+	0x6a5c, 0x70d6, 0x757d, 0x6769, 0x5375, 0x1e81, 0x0cf3, 0x3982,
+	0x6787, 0x042a, 0x6c49, 0x1925, 0x56a8, 0x40a9, 0x063e, 0x7bd9,
+	0x4dbf, 0x55ec, 0x672e, 0x7334, 0x5185, 0x4d00, 0x232a, 0x7e07,
+	0x445d, 0x6b92, 0x528f, 0x4255, 0x53ba, 0x7d82, 0x2a2e, 0x3a4e,
+	0x75eb, 0x450c, 0x6844, 0x1b5d, 0x581a, 0x4cc6, 0x0379, 0x37b2,
+	0x419f, 0x0e92, 0x6b27, 0x5624, 0x01e3, 0x07c1, 0x44a5, 0x130c,
+	0x13e8, 0x5910, 0x0876, 0x60c5, 0x54e3, 0x5b7f, 0x2269, 0x509f,
+	0x7665, 0x36fd, 0x3e9a, 0x0579, 0x6295, 0x14ef, 0x0a81, 0x1bcc,
+	0x4b16, 0x64db, 0x0514, 0x4f07, 0x0591, 0x3576, 0x6853, 0x0d9e,
+	0x259f, 0x38b7, 0x64fb, 0x3094, 0x4693, 0x6ddd, 0x29bb, 0x0bc8,
+	0x3f47, 0x490e, 0x0c0e, 0x7933, 0x3c9e, 0x5840, 0x398d, 0x3e68,
+	0x4af1, 0x71f5, 0x57cf, 0x1121, 0x64eb, 0x3579, 0x15ac, 0x584d,
+	0x5f2a, 0x47e2, 0x6528, 0x6eac, 0x196e, 0x6b96, 0x0450, 0x0179,
+	0x609c, 0x06e1, 0x4626, 0x42c7, 0x273e, 0x486f, 0x0705, 0x1601,
+	0x145b, 0x407e, 0x062b, 0x57a5, 0x53f9, 0x5659, 0x4410, 0x3ccd,
+};
+
+static u16 sunxi_nfc_randomizer_step(u16 state, int count)
+{
+	state &= 0x7fff;
+
+	/*
+	 * This loop is just a simple implementation of a Fibonacci LFSR using
+	 * the x16 + x15 + 1 polynomial.
+	 */
+	while (count--)
+		state = ((state >> 1) |
+			 (((state ^ (state >> 1)) & 1) << 14)) & 0x7fff;
+
+	return state;
+}
+
+static u16 sunxi_nfc_randomizer_state(struct mtd_info *mtd, int page, bool ecc)
+{
+	const u16 *seeds = sunxi_nfc_randomizer_page_seeds;
+	int mod = mtd->erasesize / mtd->writesize;
+
+	if (mod > ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds))
+		mod = ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds);
+
+	if (ecc) {
+		if (mtd->ecc_step_size == 512)
+			seeds = sunxi_nfc_randomizer_ecc512_seeds;
+		else
+			seeds = sunxi_nfc_randomizer_ecc1024_seeds;
+	}
+
+	return seeds[page % mod];
+}
+
+static void sunxi_nfc_randomizer_config(struct mtd_info *mtd,
+					int page, bool ecc)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	u32 ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
+	u16 state;
+
+	if (!(nand->options & NAND_NEED_SCRAMBLING))
+		return;
+
+	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
+	state = sunxi_nfc_randomizer_state(mtd, page, ecc);
+	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_SEED_MSK;
+	writel(ecc_ctl | NFC_RANDOM_SEED(state), nfc->regs + NFC_REG_ECC_CTL);
+}
+
+static void sunxi_nfc_randomizer_enable(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	if (!(nand->options & NAND_NEED_SCRAMBLING))
+		return;
+
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN,
+	       nfc->regs + NFC_REG_ECC_CTL);
+}
+
+static void sunxi_nfc_randomizer_disable(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	if (!(nand->options & NAND_NEED_SCRAMBLING))
+		return;
+
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN,
+	       nfc->regs + NFC_REG_ECC_CTL);
+}
+
+static void sunxi_nfc_randomize_bbm(struct mtd_info *mtd, int page, u8 *bbm)
+{
+	u16 state = sunxi_nfc_randomizer_state(mtd, page, true);
+
+	bbm[0] ^= state;
+	bbm[1] ^= sunxi_nfc_randomizer_step(state, 8);
+}
+
+static void sunxi_nfc_randomizer_write_buf(struct mtd_info *mtd,
+					   const uint8_t *buf, int len,
+					   bool ecc, int page)
+{
+	sunxi_nfc_randomizer_config(mtd, page, ecc);
+	sunxi_nfc_randomizer_enable(mtd);
+	sunxi_nfc_write_buf(mtd, buf, len);
+	sunxi_nfc_randomizer_disable(mtd);
+}
+
+static void sunxi_nfc_randomizer_read_buf(struct mtd_info *mtd, uint8_t *buf,
+					  int len, bool ecc, int page)
+{
+	sunxi_nfc_randomizer_config(mtd, page, ecc);
+	sunxi_nfc_randomizer_enable(mtd);
+	sunxi_nfc_read_buf(mtd, buf, len);
+	sunxi_nfc_randomizer_disable(mtd);
+}
+
 static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd->priv;
@@ -575,18 +744,20 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
 				       int *cur_off,
-				       unsigned int *max_bitflips)
+				       unsigned int *max_bitflips,
+				       bool bbm, int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int raw_mode = 0;
 	u32 status;
 	int ret;
 
 	if (*cur_off != data_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
 
-	sunxi_nfc_read_buf(mtd, NULL, ecc->size);
+	sunxi_nfc_randomizer_read_buf(mtd, NULL, ecc->size, false, page);
 
 	if (data_off + ecc->size != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
@@ -595,25 +766,54 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
 	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
 
+	*cur_off = oob_off + ecc->bytes + 4;
+
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
+	if (status & NFC_ECC_PAT_FOUND(0)) {
+		u8 pattern = 0xff;
+
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1)))
+			pattern = 0x0;
+
+		memset(data, pattern, ecc->size);
+		memset(oob, pattern, ecc->bytes + 4);
+
+		return 1;
+	}
+
 	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0)));
 
 	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
 	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-	sunxi_nfc_read_buf(mtd, oob, ecc->bytes + 4);
+	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4, true, page);
 
 	if (status & NFC_ECC_ERR(0)) {
+		/*
+		 * Re-read the data with the randomizer disabled to identify
+		 * bitflips in erased pages.
+		 */
+		if (nand->options & NAND_NEED_SCRAMBLING) {
+			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
+			nand->read_buf(mtd, data, ecc->size);
+			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+			nand->read_buf(mtd, oob, ecc->bytes + 4);
+		}
+
 		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
 						  oob, ecc->bytes + 4,
 						  NULL, 0, ecc->strength);
+		if (ret >= 0)
+			raw_mode = 1;
 	} else {
 		/*
 		 * The engine protects 4 bytes of OOB data per chunk.
@@ -621,6 +821,10 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		 */
 		sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(0)),
 					   oob);
+
+		/* De-randomize the Bad Block Marker. */
+		if (bbm && nand->options & NAND_NEED_SCRAMBLING)
+			sunxi_nfc_randomize_bbm(mtd, page, oob);
 	}
 
 	if (ret < 0) {
@@ -630,13 +834,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 	}
 
-	*cur_off = oob_off + ecc->bytes + 4;
-
-	return 0;
+	return raw_mode;
 }
 
 static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
-					    u8 *oob, int *cur_off)
+					    u8 *oob, int *cur_off,
+					    bool randomize, int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -650,7 +853,11 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
 			      offset + mtd->writesize, -1);
 
-	sunxi_nfc_read_buf(mtd, oob + offset, len);
+	if (!randomize)
+		sunxi_nfc_read_buf(mtd, oob + offset, len);
+	else
+		sunxi_nfc_randomizer_read_buf(mtd, oob + offset, len,
+					      false, page);
 
 	*cur_off = mtd->oobsize + mtd->writesize;
 }
@@ -663,7 +870,8 @@ static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
-					int *cur_off)
+					int *cur_off, bool bbm,
+					int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
@@ -673,11 +881,20 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (data_off != *cur_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
 
-	sunxi_nfc_write_buf(mtd, data, ecc->size);
+	sunxi_nfc_randomizer_write_buf(mtd, data, ecc->size, false, page);
 
 	/* Fill OOB data in */
-	writel(sunxi_nfc_buf_to_user_data(oob),
-	       nfc->regs + NFC_REG_USER_DATA(0));
+	if ((nand->options & NAND_NEED_SCRAMBLING) && bbm) {
+		u8 user_data[4];
+
+		memcpy(user_data, oob, 4);
+		sunxi_nfc_randomize_bbm(mtd, page, user_data);
+		writel(sunxi_nfc_buf_to_user_data(user_data),
+		       nfc->regs + NFC_REG_USER_DATA(0));
+	} else {
+		writel(sunxi_nfc_buf_to_user_data(oob),
+		       nfc->regs + NFC_REG_USER_DATA(0));
+	}
 
 	if (data_off + ecc->size != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
@@ -686,11 +903,13 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
 
 	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	sunxi_nfc_randomizer_disable(mtd);
 	if (ret)
 		return ret;
 
@@ -700,7 +919,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 }
 
 static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
-					     u8 *oob, int *cur_off)
+					     u8 *oob, int *cur_off,
+					     int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -714,7 +934,7 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN,
 			      offset + mtd->writesize, -1);
 
-	sunxi_nfc_write_buf(mtd, oob + offset, len);
+	sunxi_nfc_randomizer_write_buf(mtd, oob + offset, len, false, page);
 
 	*cur_off = mtd->oobsize + mtd->writesize;
 }
@@ -726,6 +946,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
+	bool raw_mode = false;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -737,13 +958,17 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips);
-		if (ret)
+						  &cur_off, &max_bitflips,
+						  !i, page);
+		if (ret < 0)
 			return ret;
+		else if (ret)
+			raw_mode = true;
 	}
 
 	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off);
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off,
+						!raw_mode, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -768,13 +993,14 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off);
+						   &cur_off, !i, page);
 		if (ret)
 			return ret;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
+	if (oob_required || (chip->options & NAND_NEED_SCRAMBLING))
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
+						 &cur_off, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -789,6 +1015,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
+	bool raw_mode = false;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -800,13 +1027,16 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off, &cur_off,
-						  &max_bitflips);
-		if (ret)
+						  &max_bitflips, !i, page);
+		if (ret < 0)
 			return ret;
+		else if (ret)
+			raw_mode = true;
 	}
 
 	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off);
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off,
+						!raw_mode, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -830,13 +1060,15 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
-						   oob, oob_off, &cur_off);
+						   oob, oob_off, &cur_off,
+						   false, page);
 		if (ret)
 			return ret;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
+	if (oob_required || (chip->options & NAND_NEED_SCRAMBLING))
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
+						 &cur_off, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -1347,6 +1579,9 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	if (nand->bbt_options & NAND_BBT_USE_FLASH)
 		nand->bbt_options |= NAND_BBT_NO_OOB;
 
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		nand->options |= NAND_NO_SUBPAGE_WRITE;
+
 	ret = sunxi_nand_chip_init_timings(chip, np);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
-- 
2.1.4
