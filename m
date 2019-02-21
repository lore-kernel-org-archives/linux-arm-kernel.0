Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:14:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46AA2148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c72ZOva/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46AA2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+xEXNEsy6O4HiOXD5gc0wsUfhh6VzMFQUgaGn6owIME=; b=c72ZOva/9K9i65
	EZf726/TCaZVoYU/misRwzFjCxqdWcQz6b+IovxZz60tvy1vOdd/TzOrMZvxynCB2krXFpjIgFM4y
	+/hjbeWE86p1op070Xgs2rS33hE4Y1gYjxHAs9A9qxuYM7FEeDcfyCJPEZrkHbiSsD5XI76AT16Aj
	QVxYK90OWOXig3VSlo7VLT4bWTeOzvvQG+VCUuEeO3Hx759BP/aXJ7Kx97mqKli8j4gmHzvh8drVO
	9H/ePjvZDhVxXizfTaif+II3yYFzGvwjWmtyzzYwApl13WPwDTKC65nW+FhgTcoOmtb1ZVY3UCEoM
	vALDFj7MoKgwgyW/MZmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlNT-00010D-7D; Thu, 21 Feb 2019 10:14:51 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlBt-0007fZ-Vj; Thu, 21 Feb 2019 10:03:16 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id D948810000D;
 Thu, 21 Feb 2019 10:02:49 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 10/27] mtd: rawnand: Get rid of chip->ecc.priv
Date: Thu, 21 Feb 2019 11:01:59 +0100
Message-Id: <20190221100216.25255-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221100216.25255-1-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_020254_854530_C1FACF67 
X-CRM114-Status: GOOD (  15.62  )
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

nand_ecc_ctrl embeds a private pointer which had only a meaning in the
sunxi driver. This structure will soon be deprecated, but as this
field is actually not needed, let's just drop it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 29 ++++++++++++++---------------
 include/linux/mtd/rawnand.h       |  2 --
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index b56f89c992f3..d05f71f33b5c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -230,6 +230,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  *			this NAND controller
  * @complete:		a completion object used to wait for NAND
  *			controller events
+ * @ecc:		ECC controller structure
  */
 struct sunxi_nfc {
 	struct nand_controller controller;
@@ -243,6 +244,7 @@ struct sunxi_nfc {
 	struct list_head chips;
 	struct completion complete;
 	struct dma_chan *dmac;
+	struct sunxi_nand_hw_ecc *ecc;
 };
 
 static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_controller *ctrl)
@@ -774,14 +776,13 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_hw_ecc *data = nand->ecc.priv;
 	u32 ecc_ctl;
 
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
 	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
 		     NFC_ECC_BLOCK_SIZE_MSK);
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION |
-		   NFC_ECC_PIPELINE;
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(nfc->ecc->mode) |
+		   NFC_ECC_EXCEPTION | NFC_ECC_PIPELINE;
 
 	if (nand->ecc.size == 512)
 		ecc_ctl |= NFC_ECC_BLOCK_512;
@@ -1671,9 +1672,9 @@ static const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
 	.free = sunxi_nand_ooblayout_free,
 };
 
-static void sunxi_nand_hw_ecc_ctrl_cleanup(struct nand_ecc_ctrl *ecc)
+static void sunxi_nand_hw_ecc_ctrl_cleanup(struct sunxi_nfc *nfc)
 {
-	kfree(ecc->priv);
+	kfree(nfc->ecc);
 }
 
 static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
@@ -1685,7 +1686,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
-	struct sunxi_nand_hw_ecc *data;
 	int nsectors;
 	int ret;
 	int i;
@@ -1722,8 +1722,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	if (ecc->size != 512 && ecc->size != 1024)
 		return -EINVAL;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
+	nfc->ecc = kzalloc(sizeof(*nfc->ecc), GFP_KERNEL);
+	if (!nfc->ecc)
 		return -ENOMEM;
 
 	/* Prefer 1k ECC chunk over 512 ones */
@@ -1750,7 +1750,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 		goto err;
 	}
 
-	data->mode = i;
+	nfc->ecc->mode = i;
 
 	/* HW ECC always request ECC bytes for 1024 bytes blocks */
 	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
@@ -1768,7 +1768,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->read_oob = sunxi_nfc_hw_ecc_read_oob;
 	ecc->write_oob = sunxi_nfc_hw_ecc_write_oob;
 	mtd_set_ooblayout(mtd, &sunxi_nand_ooblayout_ops);
-	ecc->priv = data;
 
 	if (nfc->dmac) {
 		ecc->read_page = sunxi_nfc_hw_ecc_read_page_dma;
@@ -1789,16 +1788,16 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	return 0;
 
 err:
-	kfree(data);
+	kfree(nfc->ecc);
 
 	return ret;
 }
 
-static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
+static void sunxi_nand_ecc_cleanup(struct sunxi_nfc *nfc)
 {
-	switch (ecc->mode) {
+	switch (nfc->ecc->mode) {
 	case NAND_ECC_HW:
-		sunxi_nand_hw_ecc_ctrl_cleanup(ecc);
+		sunxi_nand_hw_ecc_ctrl_cleanup(nfc);
 		break;
 	case NAND_ECC_NONE:
 	default:
@@ -1980,7 +1979,7 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 		chip = list_first_entry(&nfc->chips, struct sunxi_nand_chip,
 					node);
 		nand_release(&chip->nand);
-		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
+		sunxi_nand_ecc_cleanup(nfc);
 		list_del(&chip->node);
 	}
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index d4718dcef753..afe75e707e2c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -279,7 +279,6 @@ static const struct nand_ecc_caps __name = {			\
  * @prepad:	padding information for syndrome based ECC generators
  * @postpad:	padding information for syndrome based ECC generators
  * @options:	ECC specific options (see NAND_ECC_XXX flags defined above)
- * @priv:	pointer to private ECC control data
  * @calc_buf:	buffer for calculated ECC, size is oobsize.
  * @code_buf:	buffer for ECC read from flash, size is oobsize.
  * @hwctl:	function to control hardware ECC generator. Must only
@@ -331,7 +330,6 @@ struct nand_ecc_ctrl {
 	int prepad;
 	int postpad;
 	unsigned int options;
-	void *priv;
 	u8 *calc_buf;
 	u8 *code_buf;
 	void (*hwctl)(struct nand_chip *chip, int mode);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
