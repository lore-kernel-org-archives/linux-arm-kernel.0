Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE032086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t8DBUddQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE032086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bZk45Xc/0nvbTOJ8H2oFvjloawlHiOX3rTObGMX17t0=; b=t8DBUddQm7APS/
	LXCWIcqIrxFM0NnRFi/7qoAdXUrVTeJ3LHnRbpY4VPtgr/B972YJfA65kuO/BvZ3D1vXaE2ZcLf7+
	cMbfTISEfRGY5pOioRlkgnx31vfLbiXarCTiTMibtcP7OzYQOh1wKI8iMSzOFRmG266N2tuEtf/af
	jeaXWN9/tuL0gGBciW9TdtIrn/k3f1tly+P8/NSO0fFBEe1x5q9y1bnibkeK26RCHcyHyRFUzN0Vx
	uvCQv/MxVJN8ZZSDYSwPA43suGSw8gZMWV+YkAWcOWcmeDtniktmUcRFKv/kbsJQj9tRXwzpvrZrQ
	vg4X9P9MlrNWd+FyUGRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkXa-0000Yh-5n; Thu, 21 Feb 2019 09:21:14 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkSX-0001pI-SI; Thu, 21 Feb 2019 09:16:09 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CA1C81BF214;
 Thu, 21 Feb 2019 09:15:57 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 11/15] mtd: rawnand: Use nanddev_mtd_max_bad_blocks()
Date: Thu, 21 Feb 2019 10:15:23 +0100
Message-Id: <20190221091527.20497-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221091527.20497-1-miquel.raynal@bootlin.com>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_011602_584598_E8C94F48 
X-CRM114-Status: GOOD (  14.06  )
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

nanddev_mtd_max_bad_blocks() is implemented by the generic NAND layer
and is already doing what we need. Reuse this function instead of
having our own implementation.

While at it, get rid of the ->max_bb_per_die and ->blocks_per_die
fields which are now unused.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 38 +-------------------------------
 drivers/mtd/nand/raw/nand_onfi.c |  3 ---
 include/linux/mtd/rawnand.h      |  5 -----
 3 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 256d16903d54..4c9c2660df64 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4350,42 +4350,6 @@ static int nand_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	return nand_block_markbad_lowlevel(mtd_to_nand(mtd), ofs);
 }
 
-/**
- * nand_max_bad_blocks - [MTD Interface] Max number of bad blocks for an mtd
- * @mtd: MTD device structure
- * @ofs: offset relative to mtd start
- * @len: length of mtd
- */
-static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	u32 part_start_block;
-	u32 part_end_block;
-	u32 part_start_die;
-	u32 part_end_die;
-
-	/*
-	 * max_bb_per_die and blocks_per_die used to determine
-	 * the maximum bad block count.
-	 */
-	if (!chip->max_bb_per_die || !chip->blocks_per_die)
-		return -ENOTSUPP;
-
-	/* Get the start and end of the partition in erase blocks. */
-	part_start_block = mtd_div_by_eb(ofs, mtd);
-	part_end_block = mtd_div_by_eb(len, mtd) + part_start_block - 1;
-
-	/* Get the start and end LUNs of the partition. */
-	part_start_die = part_start_block / chip->blocks_per_die;
-	part_end_die = part_end_block / chip->blocks_per_die;
-
-	/*
-	 * Look up the bad blocks per unit and multiply by the number of units
-	 * that the partition spans.
-	 */
-	return chip->max_bb_per_die * (part_end_die - part_start_die + 1);
-}
-
 /**
  * nand_suspend - [MTD Interface] Suspend the NAND flash
  * @mtd: MTD device structure
@@ -5854,7 +5818,7 @@ static int nand_scan_tail(struct nand_chip *chip)
 	mtd->_block_isreserved = nand_block_isreserved;
 	mtd->_block_isbad = nand_block_isbad;
 	mtd->_block_markbad = nand_block_markbad;
-	mtd->_max_bad_blocks = nand_max_bad_blocks;
+	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 
 	/*
 	 * Initialize bitflip_threshold to its default prior scan_bbt() call.
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index f3f59cf37d7f..3ca9c8923a30 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -251,9 +251,6 @@ int nand_onfi_detect(struct nand_chip *chip)
 	memorg->bits_per_cell = p->bits_per_cell;
 	chip->bits_per_cell = p->bits_per_cell;
 
-	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
-	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
-
 	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
 		chip->options |= NAND_BUSWIDTH_16;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 00a8795b215d..d748e09de480 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1027,9 +1027,6 @@ struct nand_legacy {
  * @id:			[INTERN] holds NAND ID
  * @parameters:		[INTERN] holds generic parameters under an easily
  *			readable form.
- * @max_bb_per_die:	[INTERN] the max number of bad blocks each die of a
- *			this nand device will encounter their life times.
- * @blocks_per_die:	[INTERN] The number of PEBs in a die
  * @data_interface:	[INTERN] NAND interface timing information
  * @cur_cs:		currently selected target. -1 means no target selected,
  *			otherwise we should always have cur_cs >= 0 &&
@@ -1085,8 +1082,6 @@ struct nand_chip {
 
 	struct nand_id id;
 	struct nand_parameters parameters;
-	u16 max_bb_per_die;
-	u32 blocks_per_die;
 
 	struct nand_data_interface data_interface;
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
