Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EDC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C714A214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/Ou2Yuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C714A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/scnUbQ/Z8wo2He2NbPiU+wODjZ5Nif+DwuebwWrjI=; b=j/Ou2YujYd7ssA
	QK6q1ekqRFxJv86+I6WH4ftOT/x49snMfuou/bt1V65QOeYOyC8MDh9b0uM30FicRATQ5JpCh7Kiq
	ay6iLFoVHdIqcmXcsnt9M10LWis/1qDLYqOOlGuoJNfB+4rS571N8XJorVpR0L7RqI1r/N6pRIAgF
	6Of1IxT7VDzpJ/dOat/Wx7hOMJ5mNf+sjRJ9XbXQ7xbLsKemplqc6RlsEylQtY7GsYau2RTfa/omx
	pGldp6KV0JkSXjdmdt4TVqBSXRUG9hudiihgerqGjWNBmrF9bwpcafzatdfEoLUeMWqqPCal9YPTx
	/0c98EOMIqX95pP9DdHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkXE-0008WL-9q; Thu, 21 Feb 2019 09:20:52 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkST-0001hh-34; Thu, 21 Feb 2019 09:16:07 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2DA731BF210;
 Thu, 21 Feb 2019 09:15:52 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 09/15] mtd: rawnand: Provide an helper to get chip->data_buf
Date: Thu, 21 Feb 2019 10:15:21 +0100
Message-Id: <20190221091527.20497-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221091527.20497-1-miquel.raynal@bootlin.com>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_011558_285716_7319E0DF 
X-CRM114-Status: GOOD (  17.83  )
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
 Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Boris Brezillon <bbrezillon@kernel.org>

We plan to move cache related fields to a pagecache struct in nand_chip
but some drivers access ->pagebuf directly to invalidate the cache
before they start using ->data_buf.

Let's provide an helper that returns a pointer to ->data_buf after
invalidating the cache.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c   |  7 +---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  4 +-
 drivers/mtd/nand/raw/marvell_nand.c        | 43 +++++++++-------------
 drivers/mtd/nand/raw/nand_base.c           |  7 ++--
 drivers/mtd/nand/raw/nand_bbt.c            |  4 +-
 drivers/mtd/nand/raw/qcom_nandc.c          |  8 ++--
 drivers/mtd/nand/raw/sunxi_nand.c          | 11 +++---
 include/linux/mtd/rawnand.h                | 21 +++++++++++
 8 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f093f99..ce0b8ffc7812 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1676,11 +1676,8 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int page = addr >> chip->page_shift;
 	int ret;
 
-	if (!buf) {
-		buf = chip->data_buf;
-		/* Invalidate page cache */
-		chip->pagebuf = -1;
-	}
+	if (!buf)
+		buf = nand_get_data_buf(chip);
 
 	sas = mtd->oobsize / chip->ecc.steps;
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index ed405c9434fe..05f6f68e4e0d 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1602,7 +1602,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
 	unsigned int page;
-	uint8_t *buffer = chip->data_buf;
+	u8 *buffer = nand_get_data_buf(chip);
 	int saved_chip_number;
 	int found_an_ncb_fingerprint = false;
 
@@ -1664,7 +1664,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int block;
 	unsigned int stride;
 	unsigned int page;
-	uint8_t      *buffer = chip->data_buf;
+	u8 *buffer = nand_get_data_buf(chip);
 	int saved_chip_number;
 	int status;
 
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 84283c6bb0ff..e8023b32be93 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1083,12 +1083,11 @@ static int marvell_nfc_hw_ecc_hmg_read_page(struct nand_chip *chip, u8 *buf,
  */
 static int marvell_nfc_hw_ecc_hmg_read_oob_raw(struct nand_chip *chip, int page)
 {
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
+	u8 *buf = nand_get_data_buf(chip);
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
-	return marvell_nfc_hw_ecc_hmg_do_read_page(chip, chip->data_buf,
-						   chip->oob_poi, true, page);
+	return marvell_nfc_hw_ecc_hmg_do_read_page(chip, buf, chip->oob_poi,
+						   true, page);
 }
 
 /* Hamming write helpers */
@@ -1179,15 +1178,13 @@ static int marvell_nfc_hw_ecc_hmg_write_oob_raw(struct nand_chip *chip,
 						int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *buf = nand_get_data_buf(chip);
 
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
-
-	memset(chip->data_buf, 0xFF, mtd->writesize);
+	memset(buf, 0xFF, mtd->writesize);
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
-	return marvell_nfc_hw_ecc_hmg_do_write_page(chip, chip->data_buf,
-						    chip->oob_poi, true, page);
+	return marvell_nfc_hw_ecc_hmg_do_write_page(chip, buf, chip->oob_poi,
+						    true, page);
 }
 
 /* BCH read helpers */
@@ -1434,18 +1431,16 @@ static int marvell_nfc_hw_ecc_bch_read_page(struct nand_chip *chip,
 
 static int marvell_nfc_hw_ecc_bch_read_oob_raw(struct nand_chip *chip, int page)
 {
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
+	u8 *buf = nand_get_data_buf(chip);
 
-	return chip->ecc.read_page_raw(chip, chip->data_buf, true, page);
+	return chip->ecc.read_page_raw(chip, buf, true, page);
 }
 
 static int marvell_nfc_hw_ecc_bch_read_oob(struct nand_chip *chip, int page)
 {
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
+	u8 *buf = nand_get_data_buf(chip);
 
-	return chip->ecc.read_page(chip, chip->data_buf, true, page);
+	return chip->ecc.read_page(chip, buf, true, page);
 }
 
 /* BCH write helpers */
@@ -1619,25 +1614,21 @@ static int marvell_nfc_hw_ecc_bch_write_oob_raw(struct nand_chip *chip,
 						int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *buf = nand_get_data_buf(chip);
 
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
+	memset(buf, 0xFF, mtd->writesize);
 
-	memset(chip->data_buf, 0xFF, mtd->writesize);
-
-	return chip->ecc.write_page_raw(chip, chip->data_buf, true, page);
+	return chip->ecc.write_page_raw(chip, buf, true, page);
 }
 
 static int marvell_nfc_hw_ecc_bch_write_oob(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *buf = nand_get_data_buf(chip);
 
-	/* Invalidate page cache */
-	chip->pagebuf = -1;
+	memset(buf, 0xFF, mtd->writesize);
 
-	memset(chip->data_buf, 0xFF, mtd->writesize);
-
-	return chip->ecc.write_page(chip, chip->data_buf, true, page);
+	return chip->ecc.write_page(chip, buf, true, page);
 }
 
 /* NAND framework ->exec_op() hooks and related helpers */
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e8c1ad17f3c6..07985d2b91ac 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4033,10 +4033,9 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
 					 __func__, buf);
 			if (part_pagewr)
 				bytes = min_t(int, bytes - column, writelen);
-			chip->pagebuf = -1;
-			memset(chip->data_buf, 0xff, mtd->writesize);
-			memcpy(&chip->data_buf[column], buf, bytes);
-			wbuf = chip->data_buf;
+			wbuf = nand_get_data_buf(chip);
+			memset(wbuf, 0xff, mtd->writesize);
+			memcpy(&wbuf[column], buf, bytes);
 		}
 
 		if (unlikely(oob)) {
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 1b722fe9213c..0b96c4cab967 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -901,7 +901,9 @@ static int write_bbt(struct nand_chip *this, uint8_t *buf,
 static inline int nand_memory_bbt(struct nand_chip *this,
 				  struct nand_bbt_descr *bd)
 {
-	return create_bbt(this, this->data_buf, bd, -1);
+	u8 *pagebuf = nand_get_data_buf(this);
+
+	return create_bbt(this, pagebuf, bd, -1);
 }
 
 /**
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 46c62a31fa46..3f8005113fe2 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1680,14 +1680,12 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *cw_data_buf, *cw_oob_buf;
 	int cw, data_size, oob_size, ret = 0;
 
-	if (!data_buf) {
-		data_buf = chip->data_buf;
-		chip->pagebuf = -1;
-	}
+	if (!data_buf)
+		data_buf = nand_get_data_buf(chip);
 
 	if (!oob_buf) {
+		nand_get_data_buf(chip);
 		oob_buf = chip->oob_poi;
-		chip->pagebuf = -1;
 	}
 
 	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e828ee50a201..d5de0a7114bc 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1426,20 +1426,19 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *chip,
 
 static int sunxi_nfc_hw_ecc_read_oob(struct nand_chip *chip, int page)
 {
-	chip->pagebuf = -1;
+	u8 *buf = nand_get_data_buf(chip);
 
-	return chip->ecc.read_page(chip, chip->data_buf, 1, page);
+	return chip->ecc.read_page(chip, buf, 1, page);
 }
 
 static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *buf = nand_get_data_buf(chip);
 	int ret;
 
-	chip->pagebuf = -1;
-
-	memset(chip->data_buf, 0xff, mtd->writesize);
-	ret = chip->ecc.write_page(chip, chip->data_buf, 1, page);
+	memset(buf, 0xff, mtd->writesize);
+	ret = chip->ecc.write_page(chip, buf, 1, page);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index dfeedfe2f3e0..e62c3ab4e0f7 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1358,4 +1358,25 @@ int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
 void nand_select_target(struct nand_chip *chip, unsigned int cs);
 void nand_deselect_target(struct nand_chip *chip);
 
+/**
+ * nand_get_data_buf() - Get the internal page buffer
+ * @chip: NAND chip object
+ *
+ * Returns the pre-allocated page buffer after invalidating the cache. This
+ * function should be used by drivers that do not want to allocate their own
+ * bounce buffer and still need such a buffer for specific operations (most
+ * commonly when reading OOB data only).
+ *
+ * Be careful to never call this function in the write/write_oob path, because
+ * the core may have placed the data to be written out in this buffer.
+ *
+ * Return: pointer to the page cache buffer
+ */
+static inline void *nand_get_data_buf(struct nand_chip *chip)
+{
+	chip->pagebuf = -1;
+
+	return chip->data_buf;
+}
+
 #endif /* __LINUX_MTD_RAWNAND_H */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
