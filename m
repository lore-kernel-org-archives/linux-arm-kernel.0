From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 15 Oct 2015 19:17:23 +0200
Subject: [PATCH 3/3] mtd: nand: sunxi: add randomizer support
In-Reply-To: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1444929443-25537-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the randomizer engine available in Allwinner's NFC IP.

Randomization is useful to support modern NAND chips which are sensible to
repeated patterns. On such NANDs you might experience an unexpectedly high
number of bitflips when you repeat the same pattern all over a given NAND
block.
Randomizing input data mitigate this problem by avoiding such repeated
patterns.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 274 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 250 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ef46ac6..5508ce8 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -60,6 +60,7 @@
 #define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
 #define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
+#define NFC_REG_PAT_ID		0x00A4
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
 
@@ -225,6 +226,7 @@ struct sunxi_nand_hw_ecc {
  * @node:		used to store NAND chips into a list
  * @nand:		base NAND chip structure
  * @mtd:		base MTD structure
+ * @randomize:		randomize data
  * @clk_rate:		clk_rate required for this NAND chip
  * @timing_cfg		TIMING_CFG register value for this NAND chip
  * @selected:		current active CS
@@ -235,6 +237,7 @@ struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
 	struct mtd_info mtd;
+	bool randomize;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -539,6 +542,161 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 }
 
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
+static const u16 sunxi_nfc_randomizer_ecc512_seeds[] = {
+	0x227b, 0x5baa, 0x15ef, 0x5b13, 0x75b8, 0x04f7, 0x4b5e, 0x4db8,
+	0x4f31, 0x669a, 0x20af, 0x5b91, 0x1d6d, 0x286a, 0x5e98, 0x07f1,
+	0x44b2, 0x0288, 0x3996, 0x7a98, 0x76cc, 0x705a, 0x21c9, 0x5be5,
+	0x23b8, 0x7133, 0x5514, 0x6f0b, 0x7528, 0x5e5b, 0x2ae1, 0x37b6,
+	0x0d19, 0x1525, 0x2f87, 0x0025, 0x0107, 0x7012, 0x0b4f, 0x12e1,
+	0x4e29, 0x6a5e, 0x744a, 0x0032, 0x61c3, 0x1463, 0x3cd4, 0x5636,
+	0x5928, 0x57bf, 0x3ce1, 0x6c35, 0x4167, 0x58cc, 0x7e7f, 0x4ecd,
+	0x05c9, 0x3063, 0x01ab, 0x194f, 0x6b7c, 0x6575, 0x29f5, 0x04d0,
+	0x1e53, 0x4d18, 0x2f12, 0x21c4, 0x3379, 0x12ba, 0x660a, 0x6150,
+	0x2f0e, 0x7339, 0x3bd6, 0x5ab0, 0x72fa, 0x568d, 0x5bf6, 0x410d,
+	0x1e35, 0x2971, 0x3389, 0x420c, 0x5985, 0x169c, 0x6cb3, 0x3139,
+	0x52ac, 0x1475, 0x6611, 0x47df, 0x2c0b, 0x14dd, 0x1839, 0x0853,
+	0x667f, 0x245f, 0x3d7e, 0x5eb1, 0x13d1, 0x4945, 0x11ae, 0x4f1e,
+	0x19bc, 0x7e72, 0x1206, 0x3a64, 0x6c27, 0x1d33, 0x3726, 0x37db,
+	0x6ba3, 0x1dfb, 0x7041, 0x66b5, 0x14b0, 0x13da, 0x5378, 0x0696,
+	0x7887, 0x5c44, 0x4a7e, 0x2888, 0x0794, 0x567f, 0x57bb, 0x0ac0,
+};
+
+static const u16 sunxi_nfc_randomizer_ecc1024_seeds[] = {
+	0x48a6, 0x595e, 0x42c7, 0x63a7, 0x329c, 0x250d, 0x2306, 0x2324,
+	0x4c68, 0x5f64, 0x2656, 0x3a4e, 0x1da6, 0x6b01, 0x775d, 0x2efc,
+	0x3afa, 0x07cc, 0x378e, 0x6e39, 0x64cf, 0x00ce, 0x042b, 0x2d6e,
+	0x092a, 0x66b7, 0x45cb, 0x5dd8, 0x1ef9, 0x7600, 0x3dcc, 0x2bfa,
+	0x0796, 0x4d1c, 0x1cf5, 0x0399, 0x62d3, 0x56fc, 0x33cb, 0x2c74,
+	0x26b2, 0x79f7, 0x4f87, 0x6d96, 0x6fec, 0x777b, 0x7dae, 0x2523,
+	0x0115, 0x0b1c, 0x323a, 0x6438, 0x7ebd, 0x7a81, 0x0739, 0x1df7,
+	0x1d4f, 0x6e1f, 0x0fa4, 0x3f79, 0x18bd, 0x1255, 0x43b1, 0x1f15,
+	0x2446, 0x5b56, 0x2b13, 0x79ae, 0x3ce6, 0x674a, 0x7301, 0x1288,
+	0x721b, 0x3892, 0x0618, 0x0a05, 0x791e, 0x265b, 0x3062, 0x0914,
+	0x46ea, 0x50da, 0x38ad, 0x20e7, 0x04e2, 0x3696, 0x4ed2, 0x0d70,
+	0x5585, 0x71f4, 0x080b, 0x2e22, 0x28eb, 0x6f80, 0x5109, 0x2bb0,
+	0x0ca1, 0x2159, 0x1a8a, 0x61c1, 0x38b2, 0x59ae, 0x1937, 0x1076,
+	0x6a33, 0x7abc, 0x4630, 0x4b37, 0x11b4, 0x4d1b, 0x079f, 0x7e51,
+	0x40e8, 0x7b41, 0x7bc4, 0x037a, 0x3a2b, 0x0fb5, 0x7a06, 0x6401,
+	0x6792, 0x7fab, 0x7bcd, 0x1ac6, 0x1d51, 0x1b91, 0x781f, 0x5776,
+};
+
+static u16 sunxi_nfc_randomizer_step(u16 state, int count)
+{
+	state &= 0x7fff;
+	while (count--)
+		state = ((state >> 1) |
+			 ((((state >> 0) ^ (state >> 1)) & 1) << 14)) & 0x7fff;
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
+	state = sunxi_nfc_randomizer_step(state, 15);
+	bbm[0] ^= state;
+	state = sunxi_nfc_randomizer_step(state, 8);
+	bbm[1] ^= state;
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
@@ -575,18 +733,20 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
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
 
-	sunxi_nfc_read_buf(mtd, data, ecc->size);
+	sunxi_nfc_randomizer_read_buf(mtd, data, ecc->size, false, page);
 
 	if (data_off + ecc->bytes != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
@@ -595,25 +755,54 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
+	sunxi_nfc_randomizer_disable(mtd);
 
 	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
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
@@ -621,6 +810,10 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		 */
 		sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(0)),
 					   oob);
+
+		/* De-randomize the Bad Block Marker. */
+		if (bbm && nand->options & NAND_NEED_SCRAMBLING)
+			sunxi_nfc_randomize_bbm(mtd, page, oob);
 	}
 
 	if (ret < 0) {
@@ -632,11 +825,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	*cur_off = oob_off + ecc->bytes + 4;
 
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
@@ -650,7 +844,11 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
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
@@ -663,7 +861,8 @@ static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
-					int *cur_off)
+					int *cur_off, bool bbm,
+					int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
@@ -673,11 +872,20 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (data_off != *cur_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
 
-	sunxi_nfc_write_buf(mtd, data, ecc->size);
+	sunxi_nfc_randomizer_write_buf(mtd, data, ecc->size, false, page);
 
 	/* Fill OOB data in */
-	writel(sunxi_nfc_buf_to_user_data(oob),
-	       nfc->regs + NFC_REG_USER_DATA(0));
+	if (nand->options & NAND_NEED_SCRAMBLING && bbm) {
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
 
 	if (data_off + ecc->bytes != oob_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
@@ -686,9 +894,11 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
+	sunxi_nfc_randomizer_disable(mtd);
 
 	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 	if (ret)
@@ -700,7 +910,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 }
 
 static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
-					     u8 *oob, int *cur_off)
+					     u8 *oob, int *cur_off,
+					     int page)
 {
 	struct nand_chip *nand = mtd->priv;
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -714,7 +925,7 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN,
 			      offset + mtd->writesize, -1);
 
-	sunxi_nfc_write_buf(mtd, oob + offset, len);
+	sunxi_nfc_randomizer_write_buf(mtd, oob + offset, len, false, page);
 
 	*cur_off = mtd->oobsize + mtd->writesize;
 }
@@ -726,6 +937,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
+	bool raw_mode = false;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -737,13 +949,17 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 
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
 
@@ -768,13 +984,14 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off);
+						   &cur_off, !i, page);
 		if (ret)
 			return ret;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
+	if (oob_required || chip->options & NAND_NEED_SCRAMBLING)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
+						 &cur_off, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -789,6 +1006,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
+	bool raw_mode = false;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
@@ -800,13 +1018,16 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 
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
 
@@ -830,13 +1051,15 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
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
+	if (oob_required || chip->options & NAND_NEED_SCRAMBLING)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
+						 &cur_off, page);
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
@@ -1348,6 +1571,9 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
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
