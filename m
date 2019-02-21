Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D8521734
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Th0BcDtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D8521734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mm+miIlhztOQWlSuKuq7yeFKspMz5i8m5QoJcI7YRf4=; b=Th0BcDtGqDLCGp
	hV8cfBLYO9Yrn6psBRjYJhqS4Oshr1Row3OkCbbosni3tCeJmIOQlChHJmqh2YUqPcLbiBWdRO9kL
	zT7Ba3wKUEhst+G6xEgJ/Af6SDg6rGd+yqZGxmX0D6IodDO2ofetIbyYJ+EjRW0uNgvYSHVKunc8I
	fTLHQmZP4TkXeZqd62xPfmbedx1hYe5ybKv+2GgzUfi2Wr3RPexIrMWIQoRWnOHRUY+LtP1vNrCX7
	sH1d0jLda04AVBYlD3SHn14d++m2cKLEF4NESMdwR4IAM9OsGFTL4nwYTY8GEbTO0e+dWGdRAwkrx
	NUB4iGD1eNgf0XE0ZfMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkSt-0002Cw-08; Thu, 21 Feb 2019 09:16:23 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkSF-0001TC-EH; Thu, 21 Feb 2019 09:15:46 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9526F1BF216;
 Thu, 21 Feb 2019 09:15:38 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 03/15] mtd: nand: Add an helper to retrieve the number of
 pages per target
Date: Thu, 21 Feb 2019 10:15:15 +0100
Message-Id: <20190221091527.20497-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221091527.20497-1-miquel.raynal@bootlin.com>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_011543_628992_BE40CAC0 
X-CRM114-Status: GOOD (  10.12  )
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

Will be used by the raw NAND framework.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/nand.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 12d75402472a..cebc38b6d6f5 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -271,6 +271,20 @@ nanddev_pages_per_eraseblock(const struct nand_device *nand)
 	return nand->memorg.pages_per_eraseblock;
 }
 
+/**
+ * nanddev_pages_per_target() - Get the number of pages per target
+ * @nand: NAND device
+ *
+ * Return: the number of pages per target.
+ */
+static inline unsigned int
+nanddev_pages_per_target(const struct nand_device *nand)
+{
+	return nand->memorg.pages_per_eraseblock *
+	       nand->memorg.eraseblocks_per_lun *
+	       nand->memorg.luns_per_target;
+}
+
 /**
  * nanddev_per_page_oobsize() - Get NAND erase block size
  * @nand: NAND device
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
