Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D572D2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y2RQMUjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D572D2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yO35ooEg8qdI5KHflqs7uRaSUcBOa4B1/X1XO2f4VC0=; b=Y2RQMUjmeYJWnL
	uDcQRILlr/SGEHAh7p0p2Pn2HE/MTS5D+4kJe1YV1GS9PCKBZnadckVhtYQIK0V6ETT2ggQH+4LTp
	xfeM2IV1dnXNKOxV5mKeJdY1W0lg3ml54UnyFSJrULLSyze1PS8s8Cyq3s8NaNNbb80mPCrzLUZO9
	QI0bUiGNhOqow8Nw03JuGsqP/Tfuun+MruQdPtLd2RPj3ejtC0jp3eKj3xEcacH4Eohu/1oXN/Bu6
	1aUShUQQNjy5ndYUJBsDBKBMxc51BjTu2C9so/2+1gQr2lqih34yQYYbT/2/DsXOVanJe+iXOKidu
	bJBeDvd90z6MiOuKUCKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlFf-0005JA-7L; Thu, 21 Feb 2019 10:06:47 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlBr-0007bi-E3; Thu, 21 Feb 2019 10:03:11 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1ED3D100004;
 Thu, 21 Feb 2019 10:02:46 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 09/27] mtd: nand: ecc: Turn the software BCH
 implementation generic
Date: Thu, 21 Feb 2019 11:01:58 +0100
Message-Id: <20190221100216.25255-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221100216.25255-1-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_020252_287492_E8AD1AA0 
X-CRM114-Status: GOOD (  28.08  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add helpers in the raw NAND core to call the generic functions that
will be re-used by the SPI-NAND layer.

While at it, do some cleanup in the file and its header.

The only reason why rawnand_bch helpers are exported is that the OMAP2
driver uses them. This is something that should be fixed and these
helpers turned static.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc/sw-bch-engine.c   | 192 +++++++++++--------------
 drivers/mtd/nand/raw/nand_base.c       |  87 +++++++++--
 drivers/mtd/nand/raw/nandsim.c         |   3 +-
 drivers/mtd/nand/raw/omap2.c           |  32 ++---
 include/linux/mtd/nand-sw-bch-engine.h |  77 +++++-----
 include/linux/mtd/rawnand.h            |   5 +
 6 files changed, 223 insertions(+), 173 deletions(-)

diff --git a/drivers/mtd/nand/ecc/sw-bch-engine.c b/drivers/mtd/nand/ecc/sw-bch-engine.c
index 871c4dd9f71d..fd982e520989 100644
--- a/drivers/mtd/nand/ecc/sw-bch-engine.c
+++ b/drivers/mtd/nand/ecc/sw-bch-engine.c
@@ -11,133 +11,132 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/nand-sw-bch-engine.h>
-#include <linux/bch.h>
 
 /**
- * struct nand_bch_control - private NAND BCH control structure
- * @bch:       BCH control structure
- * @errloc:    error location array
- * @eccmask:   XOR ecc mask, allows erased pages to be decoded as valid
+ * ecc_sw_bch_calculate - Calculate the ECC corresponding to a data block
+ *
+ * @nand: NAND device
+ * @buf: Input buffer with raw data
+ * @code: Output buffer with ECC
  */
-struct nand_bch_control {
-	struct bch_control   *bch;
-	unsigned int         *errloc;
-	unsigned char        *eccmask;
-};
-
-/**
- * nand_bch_calculate_ecc - [NAND Interface] Calculate ECC for data block
- * @chip:	NAND chip object
- * @buf:	input buffer with raw data
- * @code:	output buffer with ECC
- */
-int nand_bch_calculate_ecc(struct nand_chip *chip, const unsigned char *buf,
-			   unsigned char *code)
+int ecc_sw_bch_calculate(struct nand_device *nand, const unsigned char *buf,
+			 unsigned char *code)
 {
-	struct nand_bch_control *nbc = chip->ecc.priv;
+	struct ecc_sw_bch_conf *engine_conf = nand->ecc.ctx.priv;
 	unsigned int i;
 
-	memset(code, 0, chip->ecc.bytes);
-	encode_bch(nbc->bch, buf, chip->ecc.size, code);
+	memset(code, 0, engine_conf->code_size);
+	encode_bch(engine_conf->bch, buf, nand->ecc.ctx.conf.step_size, code);
 
 	/* apply mask so that an erased page is a valid codeword */
-	for (i = 0; i < chip->ecc.bytes; i++)
-		code[i] ^= nbc->eccmask[i];
+	for (i = 0; i < engine_conf->code_size; i++)
+		code[i] ^= engine_conf->eccmask[i];
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_bch_calculate_ecc);
+EXPORT_SYMBOL(ecc_sw_bch_calculate);
 
 /**
- * nand_bch_correct_data - [NAND Interface] Detect and correct bit error(s)
- * @chip:	NAND chip object
- * @buf:	raw data read from the chip
- * @read_ecc:	ECC from the chip
- * @calc_ecc:	the ECC calculated from raw data
+ * ecc_sw_bch_correct - Detect, correct and report bit error(s)
  *
- * Detect and correct bit errors for a data byte block
+ * @nand: NAND device
+ * @buf: Raw data read from the chip
+ * @read_ecc: ECC bytes from the chip
+ * @calc_ecc: ECC calculated from the raw data
+ *
+ * Detect and correct bit errors for a data block.
  */
-int nand_bch_correct_data(struct nand_chip *chip, unsigned char *buf,
-			  unsigned char *read_ecc, unsigned char *calc_ecc)
+int ecc_sw_bch_correct(struct nand_device *nand, unsigned char *buf,
+		       unsigned char *read_ecc, unsigned char *calc_ecc)
 {
-	struct nand_bch_control *nbc = chip->ecc.priv;
-	unsigned int *errloc = nbc->errloc;
+	struct ecc_sw_bch_conf *engine_conf = nand->ecc.ctx.priv;
+	unsigned int step_size = nand->ecc.ctx.conf.step_size;
+	unsigned int *errloc = engine_conf->errloc;
 	int i, count;
 
-	count = decode_bch(nbc->bch, NULL, chip->ecc.size, read_ecc, calc_ecc,
-			   NULL, errloc);
+	count = decode_bch(engine_conf->bch, NULL, step_size, read_ecc,
+			   calc_ecc, NULL, errloc);
 	if (count > 0) {
 		for (i = 0; i < count; i++) {
-			if (errloc[i] < (chip->ecc.size*8))
-				/* error is located in data, correct it */
+			if (errloc[i] < (step_size * 8))
+				/* The error is in the data: correct it */
 				buf[errloc[i] >> 3] ^= (1 << (errloc[i] & 7));
-			/* else error in ecc, no action needed */
 
+			/* Otherwise the error is in the ECC: nothing to do */
 			pr_debug("%s: corrected bitflip %u\n", __func__,
-					errloc[i]);
+				 errloc[i]);
 		}
 	} else if (count < 0) {
-		pr_err("ecc unrecoverable error\n");
+		pr_err("ECC unrecoverable error\n");
 		count = -EBADMSG;
 	}
+
 	return count;
 }
-EXPORT_SYMBOL(nand_bch_correct_data);
+EXPORT_SYMBOL(ecc_sw_bch_correct);
 
 /**
- * nand_bch_init - [NAND Interface] Initialize NAND BCH error correction
- * @mtd:	MTD block structure
+ * ecc_sw_bch_cleanup - Cleanup software BCH ECC resources
+ * @nand: NAND device
+ */
+void ecc_sw_bch_cleanup(struct nand_device *nand)
+{
+	struct ecc_sw_bch_conf *engine_conf = nand->ecc.ctx.priv;
+
+	free_bch(engine_conf->bch);
+	kfree(engine_conf->errloc);
+	kfree(engine_conf->eccmask);
+}
+EXPORT_SYMBOL(ecc_sw_bch_cleanup);
+
+/**
+ * ecc_sw_bch_init - Initialize software BCH ECC engine
+ * @nand: NAND device
  *
- * Returns:
- *  a pointer to a new NAND BCH control structure, or NULL upon failure
+ * Returns: a pointer to a new NAND BCH control structure, or NULL upon failure
  *
- * Initialize NAND BCH error correction. Parameters @eccsize and @eccbytes
- * are used to compute BCH parameters m (Galois field order) and t (error
- * correction capability). @eccbytes should be equal to the number of bytes
- * required to store m*t bits, where m is such that 2^m-1 > @eccsize*8.
+ * Initialize NAND BCH error correction. @nand.ecc parameters 'step_size' and
+ * 'bytes' are used to compute BCH parameters m (Galois field order) and t
+ * (error correction capability). 'bytes' should be equal to the number of bytes
+ * required to store m*t bits, where m is such that 2^m-1 > step_size*8.
  *
  * Example: to configure 4 bit correction per 512 bytes, you should pass
- * @eccsize = 512  (thus, m=13 is the smallest integer such that 2^m-1 > 512*8)
- * @eccbytes = 7   (7 bytes are required to store m*t = 13*4 = 52 bits)
+ * step_size = 512 (thus, m=13 is the smallest integer such that 2^m-1 > 512*8)
+ * bytes = 7 (7 bytes are required to store m*t = 13*4 = 52 bits)
  */
-struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
+int ecc_sw_bch_init(struct nand_device *nand)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
 	unsigned int m, t, eccsteps, i;
-	struct nand_bch_control *nbc = NULL;
+	struct ecc_sw_bch_conf *engine_conf = nand->ecc.ctx.priv;
 	unsigned char *erased_page;
-	unsigned int eccsize = nand->ecc.size;
-	unsigned int eccbytes = nand->ecc.bytes;
-	unsigned int eccstrength = nand->ecc.strength;
+	unsigned int eccsize = nand->ecc.ctx.conf.step_size;
+	unsigned int eccbytes = engine_conf->code_size;
+	unsigned int eccstrength = nand->ecc.ctx.conf.strength;
 
 	if (!eccbytes && eccstrength) {
 		eccbytes = DIV_ROUND_UP(eccstrength * fls(8 * eccsize), 8);
-		nand->ecc.bytes = eccbytes;
+		engine_conf->code_size = eccbytes;
 	}
 
 	if (!eccsize || !eccbytes) {
 		pr_warn("ecc parameters not supplied\n");
-		goto fail;
+		return -EINVAL;
 	}
 
 	m = fls(1+8*eccsize);
 	t = (eccbytes*8)/m;
 
-	nbc = kzalloc(sizeof(*nbc), GFP_KERNEL);
-	if (!nbc)
-		goto fail;
-
-	nbc->bch = init_bch(m, t, 0);
-	if (!nbc->bch)
-		goto fail;
+	engine_conf->bch = init_bch(m, t, 0);
+	if (!engine_conf->bch)
+		return -EINVAL;
 
 	/* verify that eccbytes has the expected value */
-	if (nbc->bch->ecc_bytes != eccbytes) {
+	if (engine_conf->bch->ecc_bytes != eccbytes) {
 		pr_warn("invalid eccbytes %u, should be %u\n",
-			eccbytes, nbc->bch->ecc_bytes);
+			eccbytes, engine_conf->bch->ecc_bytes);
 		goto fail;
 	}
 
@@ -155,24 +154,15 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 	}
 
-	/*
-	 * ecc->steps and ecc->total might be used by mtd->ooblayout->ecc(),
-	 * which is called by mtd_ooblayout_count_eccbytes().
-	 * Make sure they are properly initialized before calling
-	 * mtd_ooblayout_count_eccbytes().
-	 * FIXME: we should probably rework the sequencing in nand_scan_tail()
-	 * to avoid setting those fields twice.
-	 */
-	nand->ecc.steps = eccsteps;
-	nand->ecc.total = eccsteps * eccbytes;
 	if (mtd_ooblayout_count_eccbytes(mtd) != (eccsteps*eccbytes)) {
 		pr_warn("invalid ecc layout\n");
 		goto fail;
 	}
 
-	nbc->eccmask = kmalloc(eccbytes, GFP_KERNEL);
-	nbc->errloc = kmalloc_array(t, sizeof(*nbc->errloc), GFP_KERNEL);
-	if (!nbc->eccmask || !nbc->errloc)
+	engine_conf->eccmask = kmalloc(eccbytes, GFP_KERNEL);
+	engine_conf->errloc = kmalloc_array(t, sizeof(*engine_conf->errloc),
+					    GFP_KERNEL);
+	if (!engine_conf->eccmask || !engine_conf->errloc)
 		goto fail;
 	/*
 	 * compute and store the inverted ecc of an erased ecc block
@@ -182,37 +172,25 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 
 	memset(erased_page, 0xff, eccsize);
-	memset(nbc->eccmask, 0, eccbytes);
-	encode_bch(nbc->bch, erased_page, eccsize, nbc->eccmask);
+	memset(engine_conf->eccmask, 0, eccbytes);
+	encode_bch(engine_conf->bch, erased_page, eccsize,
+		   engine_conf->eccmask);
 	kfree(erased_page);
 
 	for (i = 0; i < eccbytes; i++)
-		nbc->eccmask[i] ^= 0xff;
+		engine_conf->eccmask[i] ^= 0xff;
 
 	if (!eccstrength)
-		nand->ecc.strength = (eccbytes * 8) / fls(8 * eccsize);
+		nand->ecc.ctx.conf.strength = (eccbytes * 8) / fls(8 * eccsize);
+
+	return 0;
 
-	return nbc;
 fail:
-	nand_bch_free(nbc);
-	return NULL;
-}
-EXPORT_SYMBOL(nand_bch_init);
+	ecc_sw_bch_cleanup(nand);
 
-/**
- * nand_bch_free - [NAND Interface] Release NAND BCH ECC resources
- * @nbc:	NAND BCH control structure
- */
-void nand_bch_free(struct nand_bch_control *nbc)
-{
-	if (nbc) {
-		free_bch(nbc->bch);
-		kfree(nbc->errloc);
-		kfree(nbc->eccmask);
-		kfree(nbc);
-	}
+	return -EINVAL;
 }
-EXPORT_SYMBOL(nand_bch_free);
+EXPORT_SYMBOL(ecc_sw_bch_init);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Ivan Djelic <ivan.djelic@parrot.com>");
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 8a9cbe3aa7c1..64a6e9b840a4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4843,11 +4843,73 @@ static void nand_scan_ident_cleanup(struct nand_chip *chip)
 	kfree(chip->parameters.onfi);
 }
 
+int rawnand_sw_bch_init(struct nand_chip *chip)
+{
+	struct nand_device *base = &chip->base;
+	struct ecc_sw_bch_conf *engine_conf;
+	int ret;
+
+	base->ecc.user_conf.mode = NAND_ECC_SOFT;
+	base->ecc.user_conf.algo = NAND_ECC_BCH;
+	base->ecc.user_conf.step_size = chip->ecc.size;
+	base->ecc.user_conf.strength = chip->ecc.strength;
+
+	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
+	if (!engine_conf)
+		return -ENOMEM;
+
+	engine_conf->code_size = chip->ecc.bytes;
+
+	base->ecc.ctx.priv = engine_conf;
+
+	ret = ecc_sw_bch_init(base);
+	if (ret)
+		kfree(base->ecc.ctx.priv);
+
+	chip->ecc.size = base->ecc.ctx.conf.step_size;
+	chip->ecc.strength = base->ecc.ctx.conf.strength;
+	chip->ecc.total = base->ecc.ctx.conf.total;
+	chip->ecc.steps = engine_conf->nsteps;
+	chip->ecc.bytes = engine_conf->code_size;
+
+	return ret;
+}
+EXPORT_SYMBOL(rawnand_sw_bch_init);
+
+static int rawnand_sw_bch_calculate(struct nand_chip *chip,
+				    const unsigned char *buf,
+				    unsigned char *code)
+{
+	struct nand_device *base = &chip->base;
+
+	return ecc_sw_bch_calculate(base, buf, code);
+}
+
+int rawnand_sw_bch_correct(struct nand_chip *chip, unsigned char *buf,
+			   unsigned char *read_ecc, unsigned char *calc_ecc)
+{
+	struct nand_device *base = &chip->base;
+
+	return ecc_sw_bch_correct(base, buf, read_ecc, calc_ecc);
+}
+EXPORT_SYMBOL(rawnand_sw_bch_correct);
+
+void rawnand_sw_bch_cleanup(struct nand_chip *chip)
+{
+	struct nand_device *base = &chip->base;
+
+	ecc_sw_bch_cleanup(base);
+
+	kfree(base->ecc.ctx.priv);
+}
+EXPORT_SYMBOL(rawnand_sw_bch_cleanup);
+
 static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_device *nanddev = mtd_to_nanddev(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int ret;
 
 	if (WARN_ON(ecc->mode != NAND_ECC_SOFT))
 		return -EINVAL;
@@ -4873,12 +4935,12 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 
 		return 0;
 	case NAND_ECC_BCH:
-		if (!mtd_nand_has_bch()) {
+		if (!IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)) {
 			WARN(1, "CONFIG_MTD_NAND_ECC_SW_BCH not enabled\n");
 			return -EINVAL;
 		}
-		ecc->calculate = nand_bch_calculate_ecc;
-		ecc->correct = nand_bch_correct_data;
+		ecc->calculate = rawnand_sw_bch_calculate;
+		ecc->correct = rawnand_sw_bch_correct;
 		ecc->read_page = nand_read_page_swecc;
 		ecc->read_subpage = nand_read_subpage;
 		ecc->write_page = nand_write_page_swecc;
@@ -4930,13 +4992,14 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 			ecc->strength = bytes * 8 / fls(8 * ecc->size);
 		}
 
-		/* See nand_bch_init() for details. */
+		/* See ecc_sw_bch_init() for details. */
 		ecc->bytes = 0;
-		ecc->priv = nand_bch_init(mtd);
-		if (!ecc->priv) {
+		ret = rawnand_sw_bch_init(chip);
+		if (ret) {
 			WARN(1, "BCH ECC initialization failed!\n");
-			return -EINVAL;
+			return ret;
 		}
+
 		return 0;
 	default:
 		WARN(1, "Unsupported ECC algorithm!\n");
@@ -5443,13 +5506,17 @@ static int nand_scan_tail(struct nand_chip *chip)
 	 * Set the number of read / write steps for one page depending on ECC
 	 * mode.
 	 */
-	ecc->steps = mtd->writesize / ecc->size;
+	if (!ecc->steps)
+		ecc->steps = mtd->writesize / ecc->size;
 	if (ecc->steps * ecc->size != mtd->writesize) {
 		WARN(1, "Invalid ECC parameters\n");
 		ret = -EINVAL;
 		goto err_nand_manuf_cleanup;
 	}
-	ecc->total = ecc->steps * ecc->bytes;
+
+	if (!ecc->total)
+		ecc->total = ecc->steps * ecc->bytes;
+
 	if (ecc->total > mtd->oobsize) {
 		WARN(1, "Total number of ECC bytes exceeded oobsize\n");
 		ret = -EINVAL;
@@ -5638,7 +5705,7 @@ void nand_cleanup(struct nand_chip *chip)
 {
 	if (chip->ecc.mode == NAND_ECC_SOFT &&
 	    chip->ecc.algo == NAND_ECC_BCH)
-		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
+		rawnand_sw_bch_cleanup(chip);
 
 	/* Free bad block table memory */
 	kfree(chip->bbt);
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 797a6e4999cc..a60b972dd211 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -36,7 +36,6 @@
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/list.h>
@@ -2175,7 +2174,7 @@ static int ns_attach_chip(struct nand_chip *chip)
 	if (!bch)
 		return 0;
 
-	if (!mtd_nand_has_bch()) {
+	if (!IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)) {
 		NS_ERR("BCH ECC support is disabled\n");
 		return -EINVAL;
 	}
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 38550148a53b..5e526499824e 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -26,7 +26,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/platform_data/elm.h>
 
 #include <linux/omap-gpmc.h>
@@ -2051,16 +2050,16 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		chip->ecc.bytes		= 7;
 		chip->ecc.strength	= 4;
 		chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.correct	= rawnand_sw_bch_correct;
 		chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
 		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
 		/* Reserve one byte for the OMAP marker */
 		oobbytes_per_step	= chip->ecc.bytes + 1;
 		/* Software BCH library is used for locating errors */
-		chip->ecc.priv		= nand_bch_init(mtd);
-		if (!chip->ecc.priv) {
+		err = rawnand_sw_bch_init(chip);
+		if (err) {
 			dev_err(dev, "Unable to use BCH library\n");
-			return -EINVAL;
+			return err;
 		}
 		break;
 
@@ -2093,16 +2092,16 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		chip->ecc.bytes		= 13;
 		chip->ecc.strength	= 8;
 		chip->ecc.hwctl		= omap_enable_hwecc_bch;
-		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.correct	= rawnand_sw_bch_correct;
 		chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
 		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
 		/* Reserve one byte for the OMAP marker */
 		oobbytes_per_step	= chip->ecc.bytes + 1;
 		/* Software BCH library is used for locating errors */
-		chip->ecc.priv		= nand_bch_init(mtd);
-		if (!chip->ecc.priv) {
+		err = rawnand_sw_bch_init(chip);
+		if (err) {
 			dev_err(dev, "unable to use BCH library\n");
-			return -EINVAL;
+			return err;
 		}
 		break;
 
@@ -2208,7 +2207,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip		= &info->nand;
 	mtd			= nand_to_mtd(nand_chip);
 	mtd->dev.parent		= &pdev->dev;
-	nand_chip->ecc.priv	= NULL;
 	nand_set_flash_node(nand_chip, dev->of_node);
 
 	if (!mtd->name) {
@@ -2278,10 +2276,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 return_error:
 	if (!IS_ERR_OR_NULL(info->dma))
 		dma_release_channel(info->dma);
-	if (nand_chip->ecc.priv) {
-		nand_bch_free(nand_chip->ecc.priv);
-		nand_chip->ecc.priv = NULL;
-	}
+
+	rawnand_sw_bch_cleanup(nand_chip);
+
 	return err;
 }
 
@@ -2290,10 +2287,9 @@ static int omap_nand_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct omap_nand_info *info = mtd_to_omap(mtd);
-	if (nand_chip->ecc.priv) {
-		nand_bch_free(nand_chip->ecc.priv);
-		nand_chip->ecc.priv = NULL;
-	}
+
+	rawnand_sw_bch_cleanup(nand_chip);
+
 	if (info->dma)
 		dma_release_channel(info->dma);
 	nand_release(nand_chip);
diff --git a/include/linux/mtd/nand-sw-bch-engine.h b/include/linux/mtd/nand-sw-bch-engine.h
index 12107aa7c371..d8abfc9fc288 100644
--- a/include/linux/mtd/nand-sw-bch-engine.h
+++ b/include/linux/mtd/nand-sw-bch-engine.h
@@ -8,58 +8,63 @@
 #ifndef __MTD_NAND_ECC_SW_BCH_H__
 #define __MTD_NAND_ECC_SW_BCH_H__
 
-struct mtd_info;
-struct nand_chip;
-struct nand_bch_control;
+#include <linux/mtd/nand.h>
+#include <linux/bch.h>
+
+/**
+ * struct ecc_sw_bch_conf - private software BCH ECC engine structure
+ * @reqooblen: Save the actual user OOB length requested before overwriting it
+ * @code_size: Number of bytes needed to store a code (one code per step)
+ * @nsteps: Number of steps
+ * @calc_buf: Buffer to use when calculating ECC bytes
+ * @code_buf: Buffer to use when reading (raw) ECC bytes from the chip
+ * @bch: BCH control structure
+ * @errloc: error location array
+ * @eccmask: XOR ecc mask, allows erased pages to be decoded as valid
+ */
+struct ecc_sw_bch_conf {
+	unsigned int reqooblen;
+	unsigned int code_size;
+	unsigned int nsteps;
+	u8 *calc_buf;
+	u8 *code_buf;
+	struct bch_control *bch;
+	unsigned int *errloc;
+	unsigned char *eccmask;
+};
 
 #if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
 
-static inline int mtd_nand_has_bch(void) { return 1; }
-
-/*
- * Calculate BCH ecc code
- */
-int nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
-			   u_char *ecc_code);
-
-/*
- * Detect and correct bit errors
- */
-int nand_bch_correct_data(struct nand_chip *chip, u_char *dat,
-			  u_char *read_ecc, u_char *calc_ecc);
-/*
- * Initialize BCH encoder/decoder
- */
-struct nand_bch_control *nand_bch_init(struct mtd_info *mtd);
-/*
- * Release BCH encoder/decoder resources
- */
-void nand_bch_free(struct nand_bch_control *nbc);
+int ecc_sw_bch_calculate(struct nand_device *nand, const unsigned char *buf,
+			 unsigned char *code);
+int ecc_sw_bch_correct(struct nand_device *nand, unsigned char *buf,
+		       unsigned char *read_ecc, unsigned char *calc_ecc);
+int ecc_sw_bch_init(struct nand_device *nand);
+void ecc_sw_bch_cleanup(struct nand_device *nand);
 
 #else /* !CONFIG_MTD_NAND_ECC_SW_BCH */
 
-static inline int mtd_nand_has_bch(void) { return 0; }
-
-static inline int
-nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
-		       u_char *ecc_code)
+static inline int ecc_sw_bch_calculate(struct nand_device *nand,
+				       const unsigned char *buf,
+				       unsigned char *code)
 {
-	return -1;
+	return -ENOTSUPP;
 }
 
-static inline int
-nand_bch_correct_data(struct nand_chip *chip, unsigned char *buf,
-		      unsigned char *read_ecc, unsigned char *calc_ecc)
+static inline int ecc_sw_bch_correct(struct nand_device *nand,
+				     unsigned char *buf,
+				     unsigned char *read_ecc,
+				     unsigned char *calc_ecc)
 {
 	return -ENOTSUPP;
 }
 
-static inline struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
+static inline int ecc_sw_bch_init(struct nand_device *nand)
 {
-	return NULL;
+	return -EINVAL;
 }
 
-static inline void nand_bch_free(struct nand_bch_control *nbc) {}
+static inline void ecc_sw_bch_cleanup(struct nand_device *nand) {}
 
 #endif /* CONFIG_MTD_NAND_ECC_SW_BCH */
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 41d26dc010f2..d4718dcef753 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1232,6 +1232,11 @@ static inline int nand_opcode_8bits(unsigned int command)
 	return 0;
 }
 
+int rawnand_sw_bch_init(struct nand_chip *chip);
+int rawnand_sw_bch_correct(struct nand_chip *chip, unsigned char *buf,
+			   unsigned char *read_ecc, unsigned char *calc_ecc);
+void rawnand_sw_bch_cleanup(struct nand_chip *chip);
+
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
 				void *extraoob, int extraooblen,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
