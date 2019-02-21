Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:58:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FE92086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukt9fakq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FE92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NHEhce3r4+sXveLoqt2z88PKp0uvE/k6HIugOduds14=; b=ukt9fakqIcreU7
	CBNuBhY2jsOTRaCAxzP7u+g7AFTCxKXFkUjyy5hI14/oTPYywjP5vgf7g+BJr/iKkp5pMu5uQU+Tu
	qhr9TroNPigfnuxx1Ykb49yYbEx0RdEYSndEs1NEN+mGwEI5UJYBaup+uYVxxFY1LpfoG5yn8rKSK
	CjQUSAsjTtAUi1Sd0expw7e8RvlwcIng3ZfLwVPfxWBkitpKGJ8nQe46yBusWx9BBVFxb3KEczCT5
	O8XhalL25p9jws0Z95XuMvZWTGxl2ETcWBE6Hv4QsGXJYTIu2TPAsRSkeruAftpQ8oTvQTmNYW2w5
	MN4mLmjv7DDlyv7LSabA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnvr-0002sl-MS; Thu, 21 Feb 2019 12:58:31 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnvo-0002ry-BD; Thu, 21 Feb 2019 12:58:29 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 48D63C000C;
 Thu, 21 Feb 2019 12:58:24 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 16/27] mtd: nand: ecc: Let the software BCH ECC engine be
 a module
Date: Thu, 21 Feb 2019 13:57:55 +0100
Message-Id: <20190221125806.28875-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045828_533509_A5120F0C 
X-CRM114-Status: GOOD (  11.91  )
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

There is no reason to prevent the software BCH ECC engine
implementation to be compiled as a module, so change the 'bool' into a
'tristate'.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc/Kconfig           | 2 +-
 include/linux/mtd/nand-sw-bch-engine.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ecc/Kconfig b/drivers/mtd/nand/ecc/Kconfig
index 6ce9007e1d9b..e0106b3a7ec1 100644
--- a/drivers/mtd/nand/ecc/Kconfig
+++ b/drivers/mtd/nand/ecc/Kconfig
@@ -12,7 +12,7 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
 	  The original Linux implementation had byte 0 and 1 swapped.
 
 config MTD_NAND_ECC_SW_BCH
-	bool "Software BCH ECC engine"
+	tristate "Software BCH ECC engine"
 	select BCH
 	default n
 	help
diff --git a/include/linux/mtd/nand-sw-bch-engine.h b/include/linux/mtd/nand-sw-bch-engine.h
index d8abfc9fc288..5d0b98e34a3a 100644
--- a/include/linux/mtd/nand-sw-bch-engine.h
+++ b/include/linux/mtd/nand-sw-bch-engine.h
@@ -33,7 +33,7 @@ struct ecc_sw_bch_conf {
 	unsigned char *eccmask;
 };
 
-#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
+#if IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)
 
 int ecc_sw_bch_calculate(struct nand_device *nand, const unsigned char *buf,
 			 unsigned char *code);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
