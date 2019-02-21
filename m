Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6425F2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJHYoJUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3y2mrCXgJj1IsEuiufFOY5t6LjGwIHflCI6VpeB4Gc0=; b=cJHYoJUabZi4nX
	J6OLuXocNoUF2fn1MOrvuJx1gUMnXVZGcI0FZoUz0BI8AJzMUIfCET9HtRHzEgiHux+V/VKivfxxX
	63DY+U6kOegKPnEmfSR5Hlnj6TSMA2Rk07h4VbXw7VV1sDTnk+/I3vJKxHNzGSJILw7cU25QMi+pl
	yprGr0v6P+ehTG+jcRWxrHy2vo0DlFGe56nrUX4bNVu7dTd2tlKVJLxu5fB72subnpDyPAHLO42EV
	HJMIRmJyNJ4SOk5ing9aPd7OE5lPE7dlN4qIOgip1kcxgi6OXuZQiewMnVFKodyqqVRiqYkJP/9wZ
	Gmo2MT9R+Vu8WQxD9gIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwo0l-00021s-ME; Thu, 21 Feb 2019 13:03:35 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnzB-0008Pi-QA; Thu, 21 Feb 2019 13:02:50 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1F1C3FF809;
 Thu, 21 Feb 2019 13:01:49 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 26/27] mtd: spinand: Use the external ECC engine logic
Date: Thu, 21 Feb 2019 14:01:47 +0100
Message-Id: <20190221130148.28980-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_050158_827248_894C22C8 
X-CRM114-Status: GOOD (  21.05  )
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

Now that all the logic is available in the NAND core, let's use it
from the SPI-NAND core. Right now there is no functional change as the
default ECC engine for SPI-NANDs is set to 'on-die', but user can now
use software correction if they want to by just setting the right
properties in the DT.

Also note that the OOB layout handling is removed from the SPI-NAND
core as each ECC engine is supposed to handle it by it's own; users
should not be aware of that.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 126 ++++++++++++++----------------------
 include/linux/mtd/spinand.h |   1 -
 2 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index eb0b4ffdd8ed..510a1201d6a7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,7 +222,6 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 {
 	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
 	struct nand_page_io_req adjreq = *req;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -276,17 +275,6 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		memcpy(req->databuf.in, spinand->databuf + req->dataoffs,
 		       req->datalen);
 
-	if (req->ooblen) {
-		if (req->mode == MTD_OPS_AUTO_OOB)
-			mtd_ooblayout_get_databytes(mtd, req->oobbuf.in,
-						    spinand->oobbuf,
-						    req->ooboffs,
-						    req->ooblen);
-		else
-			memcpy(req->oobbuf.in, spinand->oobbuf + req->ooboffs,
-			       req->ooblen);
-	}
-
 	return 0;
 }
 
@@ -295,16 +283,18 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 {
 	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
 	struct nand_page_io_req adjreq = *req;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
 	int ret;
 
+	/*
+	 * Only reset the data buffer, the OOB buffer is prepared by ECC engines
+	 *->prepare/finish_io_req() callbacks.
+	 */
 	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	       nanddev_page_size(nand));
 
 	if (req->datalen) {
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
@@ -317,15 +307,6 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	}
 
 	if (req->ooblen) {
-		if (req->mode == MTD_OPS_AUTO_OOB)
-			mtd_ooblayout_set_databytes(mtd, req->oobbuf.out,
-						    spinand->oobbuf,
-						    req->ooboffs,
-						    req->ooblen);
-		else
-			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
-			       req->ooblen);
-
 		adjreq.ooblen = nanddev_per_page_oobsize(nand);
 		adjreq.ooboffs = 0;
 		nbytes += nanddev_per_page_oobsize(nand);
@@ -457,12 +438,17 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 }
 
 static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req,
-			     bool ecc_enabled)
+			     const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req,
+				      spinand->oobbuf);
+	if (ret)
+		return ret;
+
 	ret = spinand_load_page_op(spinand, req);
 	if (ret)
 		return ret;
@@ -471,22 +457,28 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret < 0)
 		return ret;
 
+	spinand_ondie_ecc_save_status(nand, status);
+
 	ret = spinand_read_from_cache_op(spinand, req);
 	if (ret)
 		return ret;
 
-	if (!ecc_enabled)
-		return 0;
-
-	return spinand_check_ecc_status(spinand, status);
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req,
+				      spinand->oobbuf);
 }
 
 static int spinand_write_page(struct spinand_device *spinand,
 			      const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req,
+				      spinand->oobbuf);
+	if (ret)
+		return ret;
+
 	ret = spinand_write_enable_op(spinand);
 	if (ret)
 		return ret;
@@ -501,9 +493,10 @@ static int spinand_write_page(struct spinand_device *spinand,
 
 	ret = spinand_wait(spinand, &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
-	return ret;
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req,
+				      spinand->oobbuf);
 }
 
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
@@ -513,25 +506,24 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 	mutex_lock(&spinand->lock);
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
-		if (ret)
-			break;
-
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -562,20 +554,19 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 	mutex_lock(&spinand->lock);
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
-		ret = spinand_select_target(spinand, iter.req.pos.target);
-		if (ret)
-			break;
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
@@ -605,7 +596,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 
 	memset(spinand->oobbuf, 0, 2);
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req, false);
+	spinand_read_page(spinand, &req);
 	if (spinand->oobbuf[0] != 0xff || spinand->oobbuf[1] != 0xff)
 		printk("would be bad, but fuck it\n");
 //		return true;
@@ -901,30 +892,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.free = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -994,6 +961,11 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
+	spinand_ecc_enable(spinand, false);
+	ret = nanddev_ecc_engine_init(nand);
+	if (ret)
+		goto err_cleanup_nanddev;
+
 	/*
 	 * Right now, we don't support ECC, so let the whole oob
 	 * area available for the user.
@@ -1006,19 +978,17 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 
-	if (spinand->eccinfo.ooblayout)
-		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
-	else
-		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
-
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 
 	mtd->oobavail = ret;
 
 	return 0;
 
+err_cleanup_ecc_engine:
+	nanddev_ecc_engine_cleanup(nand);
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 77d9caff4a5c..7fa75a53e1a1 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -420,6 +420,5 @@ int spinand_match_and_init(struct spinand_device *dev,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 int spinand_ecc_enable(struct spinand_device *spinand, bool enable);
-int spinand_check_ecc_status(struct spinand_device *spinand, u8 status);
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
