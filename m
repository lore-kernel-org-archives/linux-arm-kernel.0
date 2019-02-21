Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B726B2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EpGLoR6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B726B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YUMz1/0EUP7+wiYPhFGOWmuD3sDn6G7ow84qLNb1pdE=; b=EpGLoR6kZ94fkm
	uNiE0Bjm9MKLVKJRZiPGg1YuR013D6MuRLhFuupNKqTgkO+MX/yCyhSg72Cy/8qzfheKkYKok15nW
	e2hLnJRtmd00pptlik6bQKQ5iU9cgByhfa+4lir/7Sss4I6BLEw6motqkiavlbKxxp+3k+KaBMVbB
	fZ9A9/HH3kybuYGttLWmpGyAlDLoiDI/S+8FEtGC4lf/WakJrCMaSQLtu56TRPb+XriGlOOgbNhTO
	P94VxKesJKXVhgagnf6/SykwCMBBsyCOh2RxZfPdiIKzoTlyET6xf3geQN5GgXMQWBFs845oaitDA
	ijUm5RbbQG/wv+K8ArTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnyc-0007ex-6h; Thu, 21 Feb 2019 13:01:22 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnw8-0003Gv-OJ; Thu, 21 Feb 2019 12:59:11 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8CCD0C0006;
 Thu, 21 Feb 2019 12:58:43 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 22/27] mtd: spinand: Let the SPI-NAND core flag a SPI-NAND
 chip
Date: Thu, 21 Feb 2019 13:58:01 +0100
Message-Id: <20190221125806.28875-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045849_493888_13BD9EA4 
X-CRM114-Status: GOOD (  14.70  )
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

As of today there is no way to make the distinction between a raw NAND
chip and a SPI-NAND chip. The ABI is stable and we cannot add a
"SPI-NAND" tag to the MTD type, but we can add a special SPINAND
capability to the flags instead. A helper is also provided to retrieve
if whether or not the chip is working over SPI or not.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/core.c    | 2 +-
 include/linux/mtd/mtd.h    | 5 +++++
 include/uapi/mtd/mtd-abi.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index a76d206d233a..872d46b5fc0f 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -245,7 +245,7 @@ int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 
 	mtd->type = memorg->bits_per_cell == 1 ?
 		    MTD_NANDFLASH : MTD_MLCNANDFLASH;
-	mtd->flags = MTD_CAP_NANDFLASH;
+	mtd->flags = MTD_SPINAND | MTD_CAP_NANDFLASH;
 	mtd->erasesize = memorg->pagesize * memorg->pages_per_eraseblock;
 	mtd->writesize = memorg->pagesize;
 	mtd->writebufsize = memorg->pagesize;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 677768b21a1d..7c245d109524 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -551,6 +551,11 @@ static inline int mtd_type_is_nand(const struct mtd_info *mtd)
 	return mtd->type == MTD_NANDFLASH || mtd->type == MTD_MLCNANDFLASH;
 }
 
+static inline int mtd_type_is_spinand(const struct mtd_info *mtd)
+{
+	return mtd_type_is_nand(mtd) && (mtd->flags & MTD_SPINAND);
+}
+
 static inline int mtd_can_have_bb(const struct mtd_info *mtd)
 {
 	return !!mtd->_block_isbad;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index aff5b5e59845..7c7124c88fe0 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -104,6 +104,7 @@ struct mtd_write_req {
 #define MTD_BIT_WRITEABLE	0x800	/* Single bits can be flipped */
 #define MTD_NO_ERASE		0x1000	/* No erase necessary */
 #define MTD_POWERUP_LOCK	0x2000	/* Always locked after reset */
+#define MTD_SPINAND		0x4000	/* Device works over SPI */
 
 /* Some common devices / combinations of capabilities */
 #define MTD_CAP_ROM		0
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
