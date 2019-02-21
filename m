Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19146C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2D7208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9ZRRr8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BHS01pQHxCNtO/Teihm5KI3H9et0iTl6NWgTv657Dkc=; b=T9ZRRr8tQr5UPy
	wnDnhcbiksp+JroQdnrosljtkbbn4sr2Sxfapy6E1D9fchXy6XA+3xiM6MOtP/qDLayguosIKfGrZ
	ueBTiiPRPjZmEk+m0mAErorfp2kLgyBhqQtS0gdtQWusXul2gnRYpUKJ4bzPKLlgcRTEibYQ1ahSB
	+hpuN6h/tcCfaRnl2G8vEwPxNN9uBvPUGYwakgiCAluY4esvXoBXTuVZEG899jE8gmy+ELut3O6PZ
	qpr0MNVWl/YpZtMKzGs1GYixzIUKcNj3gj2xHRQ1RFp48OncLOXGDKAxILjCMAzidcJcUgSzWGVcX
	HyUWpOGh9PAfoi3S+XSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkuQ-0005fh-8F; Thu, 21 Feb 2019 09:44:50 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkSh-000209-QU; Thu, 21 Feb 2019 09:16:29 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A19011BF216;
 Thu, 21 Feb 2019 09:16:07 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 15/15] mtd: rawnand: Get rid of chip->ecc_{strength,step}_ds
Date: Thu, 21 Feb 2019 10:15:27 +0100
Message-Id: <20190221091527.20497-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221091527.20497-1-miquel.raynal@bootlin.com>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_011612_405424_C4B89353 
X-CRM114-Status: GOOD (  21.20  )
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

nand_device embeds a nand_ecc_req object which contains the minimum
strength and step-size required by the NAND device.

Drop the chip->ecc_{strength,step}_ds fields and use
chip->base.eccreq.{strength,step_size} instead.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c |  8 ++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c   | 11 ++++--
 drivers/mtd/nand/raw/marvell_nand.c          |  6 +--
 drivers/mtd/nand/raw/mtk_nand.c              |  4 +-
 drivers/mtd/nand/raw/nand_base.c             | 15 ++++----
 drivers/mtd/nand/raw/nand_esmt.c             | 10 ++---
 drivers/mtd/nand/raw/nand_hynix.c            | 40 ++++++++++----------
 drivers/mtd/nand/raw/nand_jedec.c            |  4 +-
 drivers/mtd/nand/raw/nand_micron.c           | 12 +++---
 drivers/mtd/nand/raw/nand_onfi.c             |  8 ++--
 drivers/mtd/nand/raw/nand_samsung.c          | 18 ++++-----
 drivers/mtd/nand/raw/nand_toshiba.c          | 10 ++---
 drivers/mtd/nand/raw/sunxi_nand.c            |  4 +-
 drivers/mtd/nand/raw/tegra_nand.c            |  8 ++--
 include/linux/mtd/rawnand.h                  |  8 ----
 15 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 5781fcf6b76c..9867e9115399 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1068,15 +1068,15 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
 		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
 	else if (chip->ecc.strength)
 		req.ecc.strength = chip->ecc.strength;
-	else if (chip->ecc_strength_ds)
-		req.ecc.strength = chip->ecc_strength_ds;
+	else if (chip->base.eccreq.strength)
+		req.ecc.strength = chip->base.eccreq.strength;
 	else
 		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
 
 	if (chip->ecc.size)
 		req.ecc.sectorsize = chip->ecc.size;
-	else if (chip->ecc_step_ds)
-		req.ecc.sectorsize = chip->ecc_step_ds;
+	else if (chip->base.eccreq.step_size)
+		req.ecc.sectorsize = chip->base.eccreq.step_size;
 	else
 		req.ecc.sectorsize = ATMEL_PMECC_SECTOR_SIZE_AUTO;
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 6151214eddec..dbefb6bac5c9 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -204,7 +204,8 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this,
 	default:
 		dev_err(this->dev,
 			"unsupported nand chip. ecc bits : %d, ecc size : %d\n",
-			chip->ecc_strength_ds, chip->ecc_step_ds);
+			chip->base.eccreq.strength,
+			chip->base.eccreq.step_size);
 		return -EINVAL;
 	}
 	geo->ecc_chunk_size = ecc_step;
@@ -417,11 +418,13 @@ int common_nfc_set_geometry(struct gpmi_nand_data *this)
 
 	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
 				|| legacy_set_geometry(this)) {
-		if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
+		if (!(chip->base.eccreq.strength > 0 &&
+		      chip->base.eccreq.step_size > 0))
 			return -EINVAL;
 
-		return set_geometry_by_ecc_info(this, chip->ecc_strength_ds,
-						chip->ecc_step_ds);
+		return set_geometry_by_ecc_info(this,
+						chip->base.eccreq.strength,
+						chip->base.eccreq.step_size);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index e8023b32be93..d21e808bb075 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2248,9 +2248,9 @@ static int marvell_nand_ecc_init(struct mtd_info *mtd,
 	int ret;
 
 	if (ecc->mode != NAND_ECC_NONE && (!ecc->size || !ecc->strength)) {
-		if (chip->ecc_step_ds && chip->ecc_strength_ds) {
-			ecc->size = chip->ecc_step_ds;
-			ecc->strength = chip->ecc_strength_ds;
+		if (chip->base.eccreq.step_size && chip->base.eccreq.strength) {
+			ecc->size = chip->base.eccreq.step_size;
+			ecc->strength = chip->base.eccreq.strength;
 		} else {
 			dev_info(nfc->dev,
 				 "No minimum ECC strength, using 1b/512B\n");
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index b6b4602f5132..bfb89aca4155 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1197,8 +1197,8 @@ static int mtk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
 	/* if optional dt settings not present */
 	if (!nand->ecc.size || !nand->ecc.strength) {
 		/* use datasheet requirements */
-		nand->ecc.strength = nand->ecc_strength_ds;
-		nand->ecc.size = nand->ecc_step_ds;
+		nand->ecc.strength = nand->base.eccreq.strength;
+		nand->ecc.size = nand->base.eccreq.step_size;
 
 		/*
 		 * align eccstrength and eccsize
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e4bc851b099a..3bd077ca58bb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4592,8 +4592,8 @@ static bool find_full_id_nand(struct nand_chip *chip,
 					   memorg->pagesize *
 					   memorg->pages_per_eraseblock);
 		chip->options |= type->options;
-		chip->ecc_strength_ds = NAND_ECC_STRENGTH(type);
-		chip->ecc_step_ds = NAND_ECC_STEP(type);
+		chip->base.eccreq.strength = NAND_ECC_STRENGTH(type);
+		chip->base.eccreq.step_size = NAND_ECC_STEP(type);
 		chip->onfi_timing_mode_default =
 					type->onfi_timing_mode_default;
 
@@ -5266,8 +5266,8 @@ nand_match_ecc_req(struct nand_chip *chip,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_ecc_step_info *stepinfo;
-	int req_step = chip->ecc_step_ds;
-	int req_strength = chip->ecc_strength_ds;
+	int req_step = chip->base.eccreq.step_size;
+	int req_strength = chip->base.eccreq.strength;
 	int req_corr, step_size, strength, nsteps, ecc_bytes, ecc_bytes_total;
 	int best_step, best_strength, best_ecc_bytes;
 	int best_ecc_bytes_total = INT_MAX;
@@ -5460,7 +5460,7 @@ static bool nand_ecc_strength_good(struct nand_chip *chip)
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int corr, ds_corr;
 
-	if (ecc->size == 0 || chip->ecc_step_ds == 0)
+	if (ecc->size == 0 || chip->base.eccreq.step_size == 0)
 		/* Not enough information */
 		return true;
 
@@ -5469,9 +5469,10 @@ static bool nand_ecc_strength_good(struct nand_chip *chip)
 	 * the correction density.
 	 */
 	corr = (mtd->writesize * ecc->strength) / ecc->size;
-	ds_corr = (mtd->writesize * chip->ecc_strength_ds) / chip->ecc_step_ds;
+	ds_corr = (mtd->writesize * chip->base.eccreq.strength) /
+		  chip->base.eccreq.step_size;
 
-	return corr >= ds_corr && ecc->strength >= chip->ecc_strength_ds;
+	return corr >= ds_corr && ecc->strength >= chip->base.eccreq.strength;
 }
 
 static int rawnand_erase(struct nand_device *nand, const struct nand_pos *pos)
diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
index 96f039a83bc8..3de5e89482f5 100644
--- a/drivers/mtd/nand/raw/nand_esmt.c
+++ b/drivers/mtd/nand/raw/nand_esmt.c
@@ -14,20 +14,20 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
 
 	/* Extract ECC requirements from 5th id byte. */
 	if (chip->id.len >= 5 && nand_is_slc(chip)) {
-		chip->ecc_step_ds = 512;
+		chip->base.eccreq.step_size = 512;
 		switch (chip->id.data[4] & 0x3) {
 		case 0x0:
-			chip->ecc_strength_ds = 4;
+			chip->base.eccreq.strength = 4;
 			break;
 		case 0x1:
-			chip->ecc_strength_ds = 2;
+			chip->base.eccreq.strength = 2;
 			break;
 		case 0x2:
-			chip->ecc_strength_ds = 1;
+			chip->base.eccreq.strength = 1;
 			break;
 		default:
 			WARN(1, "Could not get ECC info");
-			chip->ecc_step_ds = 0;
+			chip->base.eccreq.step_size = 0;
 			break;
 		}
 	}
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 272b934dffb7..821d221b83eb 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -508,30 +508,30 @@ static void hynix_nand_extract_ecc_requirements(struct nand_chip *chip,
 
 	if (valid_jedecid) {
 		/* Reference: H27UCG8T2E datasheet */
-		chip->ecc_step_ds = 1024;
+		chip->base.eccreq.step_size = 1024;
 
 		switch (ecc_level) {
 		case 0:
-			chip->ecc_step_ds = 0;
-			chip->ecc_strength_ds = 0;
+			chip->base.eccreq.step_size = 0;
+			chip->base.eccreq.strength = 0;
 			break;
 		case 1:
-			chip->ecc_strength_ds = 4;
+			chip->base.eccreq.strength = 4;
 			break;
 		case 2:
-			chip->ecc_strength_ds = 24;
+			chip->base.eccreq.strength = 24;
 			break;
 		case 3:
-			chip->ecc_strength_ds = 32;
+			chip->base.eccreq.strength = 32;
 			break;
 		case 4:
-			chip->ecc_strength_ds = 40;
+			chip->base.eccreq.strength = 40;
 			break;
 		case 5:
-			chip->ecc_strength_ds = 50;
+			chip->base.eccreq.strength = 50;
 			break;
 		case 6:
-			chip->ecc_strength_ds = 60;
+			chip->base.eccreq.strength = 60;
 			break;
 		default:
 			/*
@@ -552,14 +552,14 @@ static void hynix_nand_extract_ecc_requirements(struct nand_chip *chip,
 		if (nand_tech < 3) {
 			/* > 26nm, reference: H27UBG8T2A datasheet */
 			if (ecc_level < 5) {
-				chip->ecc_step_ds = 512;
-				chip->ecc_strength_ds = 1 << ecc_level;
+				chip->base.eccreq.step_size = 512;
+				chip->base.eccreq.strength = 1 << ecc_level;
 			} else if (ecc_level < 7) {
 				if (ecc_level == 5)
-					chip->ecc_step_ds = 2048;
+					chip->base.eccreq.step_size = 2048;
 				else
-					chip->ecc_step_ds = 1024;
-				chip->ecc_strength_ds = 24;
+					chip->base.eccreq.step_size = 1024;
+				chip->base.eccreq.strength = 24;
 			} else {
 				/*
 				 * We should never reach this case, but if that
@@ -572,14 +572,14 @@ static void hynix_nand_extract_ecc_requirements(struct nand_chip *chip,
 		} else {
 			/* <= 26nm, reference: H27UBG8T2B datasheet */
 			if (!ecc_level) {
-				chip->ecc_step_ds = 0;
-				chip->ecc_strength_ds = 0;
+				chip->base.eccreq.step_size = 0;
+				chip->base.eccreq.strength = 0;
 			} else if (ecc_level < 5) {
-				chip->ecc_step_ds = 512;
-				chip->ecc_strength_ds = 1 << (ecc_level - 1);
+				chip->base.eccreq.step_size = 512;
+				chip->base.eccreq.strength = 1 << (ecc_level - 1);
 			} else {
-				chip->ecc_step_ds = 1024;
-				chip->ecc_strength_ds = 24 +
+				chip->base.eccreq.step_size = 1024;
+				chip->base.eccreq.strength = 24 +
 							(8 * (ecc_level - 5));
 			}
 		}
diff --git a/drivers/mtd/nand/raw/nand_jedec.c b/drivers/mtd/nand/raw/nand_jedec.c
index 99e2f017c79b..9b540e76f84f 100644
--- a/drivers/mtd/nand/raw/nand_jedec.c
+++ b/drivers/mtd/nand/raw/nand_jedec.c
@@ -110,8 +110,8 @@ int nand_jedec_detect(struct nand_chip *chip)
 	ecc = &p->ecc_info[0];
 
 	if (ecc->codeword_size >= 9) {
-		chip->ecc_strength_ds = ecc->ecc_bits;
-		chip->ecc_step_ds = 1 << ecc->codeword_size;
+		chip->base.eccreq.strength = ecc->ecc_bits;
+		chip->base.eccreq.step_size = 1 << ecc->codeword_size;
 	} else {
 		pr_warn("Invalid codeword size\n");
 	}
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 98ce6575aa64..7a2cef02eacd 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -391,7 +391,7 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 	/*
 	 * We only support on-die ECC of 4/512 or 8/512
 	 */
-	if  (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
+	if  (chip->base.eccreq.strength != 4 && chip->base.eccreq.strength != 8)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	/* 0x2 means on-die ECC is available. */
@@ -424,7 +424,7 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 	/*
 	 * We only support on-die ECC of 4/512 or 8/512
 	 */
-	if  (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
+	if  (chip->base.eccreq.strength != 4 && chip->base.eccreq.strength != 8)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	return MICRON_ON_DIE_SUPPORTED;
@@ -479,7 +479,7 @@ static int micron_nand_init(struct nand_chip *chip)
 		 * That's not needed for 8-bit ECC, because the status expose
 		 * a better approximation of the number of bitflips in a page.
 		 */
-		if (chip->ecc_strength_ds == 4) {
+		if (chip->base.eccreq.strength == 4) {
 			micron->ecc.rawbuf = kmalloc(mtd->writesize +
 						     mtd->oobsize,
 						     GFP_KERNEL);
@@ -489,16 +489,16 @@ static int micron_nand_init(struct nand_chip *chip)
 			}
 		}
 
-		if (chip->ecc_strength_ds == 4)
+		if (chip->base.eccreq.strength == 4)
 			mtd_set_ooblayout(mtd,
 					  &micron_nand_on_die_4_ooblayout_ops);
 		else
 			mtd_set_ooblayout(mtd,
 					  &micron_nand_on_die_8_ooblayout_ops);
 
-		chip->ecc.bytes = chip->ecc_strength_ds * 2;
+		chip->ecc.bytes = chip->base.eccreq.strength * 2;
 		chip->ecc.size = 512;
-		chip->ecc.strength = chip->ecc_strength_ds;
+		chip->ecc.strength = chip->base.eccreq.strength;
 		chip->ecc.algo = NAND_ECC_BCH;
 		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
 		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index 7b468e7214c7..0b879bd0a68c 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -94,8 +94,8 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 		goto ext_out;
 	}
 
-	chip->ecc_strength_ds = ecc->ecc_bits;
-	chip->ecc_step_ds = 1 << ecc->codeword_size;
+	chip->base.eccreq.strength = ecc->ecc_bits;
+	chip->base.eccreq.step_size = 1 << ecc->codeword_size;
 	ret = 0;
 
 ext_out:
@@ -252,8 +252,8 @@ int nand_onfi_detect(struct nand_chip *chip)
 		chip->options |= NAND_BUSWIDTH_16;
 
 	if (p->ecc_bits != 0xff) {
-		chip->ecc_strength_ds = p->ecc_bits;
-		chip->ecc_step_ds = 512;
+		chip->base.eccreq.strength = p->ecc_bits;
+		chip->base.eccreq.step_size = 512;
 	} else if (onfi_version >= 21 &&
 		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
 
diff --git a/drivers/mtd/nand/raw/nand_samsung.c b/drivers/mtd/nand/raw/nand_samsung.c
index 9a9ad43cc97d..f7d7041b6213 100644
--- a/drivers/mtd/nand/raw/nand_samsung.c
+++ b/drivers/mtd/nand/raw/nand_samsung.c
@@ -80,23 +80,23 @@ static void samsung_nand_decode_id(struct nand_chip *chip)
 		/* Extract ECC requirements from 5th id byte*/
 		extid = (chip->id.data[4] >> 4) & 0x07;
 		if (extid < 5) {
-			chip->ecc_step_ds = 512;
-			chip->ecc_strength_ds = 1 << extid;
+			chip->base.eccreq.step_size = 512;
+			chip->base.eccreq.strength = 1 << extid;
 		} else {
-			chip->ecc_step_ds = 1024;
+			chip->base.eccreq.step_size = 1024;
 			switch (extid) {
 			case 5:
-				chip->ecc_strength_ds = 24;
+				chip->base.eccreq.strength = 24;
 				break;
 			case 6:
-				chip->ecc_strength_ds = 40;
+				chip->base.eccreq.strength = 40;
 				break;
 			case 7:
-				chip->ecc_strength_ds = 60;
+				chip->base.eccreq.strength = 60;
 				break;
 			default:
 				WARN(1, "Could not decode ECC info");
-				chip->ecc_step_ds = 0;
+				chip->base.eccreq.step_size = 0;
 			}
 		}
 	} else {
@@ -106,8 +106,8 @@ static void samsung_nand_decode_id(struct nand_chip *chip)
 			switch (chip->id.data[1]) {
 			/* K9F4G08U0D-S[I|C]B0(T00) */
 			case 0xDC:
-				chip->ecc_step_ds = 512;
-				chip->ecc_strength_ds = 1;
+				chip->base.eccreq.step_size = 512;
+				chip->base.eccreq.strength = 1;
 				break;
 
 			/* K9F1G08U0E 21nm chips do not support subpage write */
diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index d8465049dfd6..13f9632f1cb4 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -130,20 +130,20 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
 	 *  - 24nm: 8 bit ECC for each 512Byte is required.
 	 */
 	if (chip->id.len >= 6 && nand_is_slc(chip)) {
-		chip->ecc_step_ds = 512;
+		chip->base.eccreq.step_size = 512;
 		switch (chip->id.data[5] & 0x7) {
 		case 0x4:
-			chip->ecc_strength_ds = 1;
+			chip->base.eccreq.strength = 1;
 			break;
 		case 0x5:
-			chip->ecc_strength_ds = 4;
+			chip->base.eccreq.strength = 4;
 			break;
 		case 0x6:
-			chip->ecc_strength_ds = 8;
+			chip->base.eccreq.strength = 8;
 			break;
 		default:
 			WARN(1, "Could not get ECC info");
-			chip->ecc_step_ds = 0;
+			chip->base.eccreq.step_size = 0;
 			break;
 		}
 	}
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d5de0a7114bc..69599854fdd6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1821,8 +1821,8 @@ static int sunxi_nand_attach_chip(struct nand_chip *nand)
 	nand->options |= NAND_SUBPAGE_READ;
 
 	if (!ecc->size) {
-		ecc->size = nand->ecc_step_ds;
-		ecc->strength = nand->ecc_strength_ds;
+		ecc->size = nand->base.eccreq.step_size;
+		ecc->strength = nand->base.eccreq.strength;
 	}
 
 	if (!ecc->size || !ecc->strength)
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 13be32c38194..3cc9a4c41443 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -853,7 +853,7 @@ static int tegra_nand_get_strength(struct nand_chip *chip, const int *strength,
 		} else {
 			strength_sel = strength[i];
 
-			if (strength_sel < chip->ecc_strength_ds)
+			if (strength_sel < chip->base.eccreq.strength)
 				continue;
 		}
 
@@ -917,9 +917,9 @@ static int tegra_nand_attach_chip(struct nand_chip *chip)
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = 512;
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
-	if (chip->ecc_step_ds != 512) {
+	if (chip->base.eccreq.step_size != 512) {
 		dev_err(ctrl->dev, "Unsupported step size %d\n",
-			chip->ecc_step_ds);
+			chip->base.eccreq.step_size);
 		return -EINVAL;
 	}
 
@@ -950,7 +950,7 @@ static int tegra_nand_attach_chip(struct nand_chip *chip)
 		if (ret < 0) {
 			dev_err(ctrl->dev,
 				"No valid strength found, minimum %d\n",
-				chip->ecc_strength_ds);
+				chip->base.eccreq.strength);
 			return ret;
 		}
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e5a25ba75211..14748183508b 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1004,12 +1004,6 @@ struct nand_legacy {
  * @badblockbits:	[INTERN] minimum number of set bits in a good block's
  *			bad block marker position; i.e., BBM == 11110111b is
  *			not bad when badblockbits == 7
- * @ecc_strength_ds:	[INTERN] ECC correctability from the datasheet.
- *			Minimum amount of bit errors per @ecc_step_ds guaranteed
- *			to be correctable. If unknown, set to zero.
- * @ecc_step_ds:	[INTERN] ECC step required by the @ecc_strength_ds,
- *			also from the datasheet. It is the recommended ECC step
- *			size, if known; if unknown, set to zero.
  * @onfi_timing_mode_default: [INTERN] default ONFI timing mode. This field is
  *			      set to the actually used ONFI mode if the chip is
  *			      ONFI compliant or deduced from the datasheet if
@@ -1069,8 +1063,6 @@ struct nand_chip {
 	} pagecache;
 
 	int subpagesize;
-	uint16_t ecc_strength_ds;
-	uint16_t ecc_step_ds;
 	int onfi_timing_mode_default;
 	int badblockpos;
 	int badblockbits;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
