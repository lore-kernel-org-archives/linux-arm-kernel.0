Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C9A2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PWgzX1rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C9A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MHTGiUBwsOyaDNVKkGlUFZsklo3GOg9G7DTLNdZUlpY=; b=PWgzX1rcG5g5/w
	hMZOWBw0EnvuA1wpKvquAuzjwonJQkRRqKYwi4BusvJqahBOvYKvGtFf9GhOUsjR99XmMBkdmCnj9
	0ppjoXCjOFjDNyGcyBRg1pV9rm7UF4Eck7OwnCbuuNshWms+GV29uiGfR5wqgb0WDNphEYj2J2laW
	12Fjx0Qly3qIMJ8opRuV0u6LWv+2i2s0Hq1Wo0MQbalnlRTSovsSJfOPBHwfMPFshVfQcx9Ua6tIT
	zE36LFsEC6+06OZFARJ0Xk/CNUUUgNkq1A7rm428VXBuliQV6btefLKgpZasyGjTLHV4kKCG61Otl
	ZiKgX+OzP2b8awmiVQ3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoBg-0006DY-Vk; Thu, 21 Feb 2019 13:14:52 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnwH-0003Rs-BU; Thu, 21 Feb 2019 12:59:27 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 46795C0015;
 Thu, 21 Feb 2019 12:58:53 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines and
 configurations
Date: Thu, 21 Feb 2019 13:58:04 +0100
Message-Id: <20190221125806.28875-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045858_230655_12B98312 
X-CRM114-Status: GOOD (  15.17  )
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

Add the logic in the NAND core to find the right ECC engine depending
on the NAND chip requirements and the user desires. Right now, the
choice may be made between (more will come):
* software Hamming
* software BCH
* on-die (SPI-NAND devices only)

Once the ECC engine has been found, the ECC engine must be
configured.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/core.c  | 107 +++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 872d46b5fc0f..9feb118c9f68 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -207,6 +207,113 @@ int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len)
 }
 EXPORT_SYMBOL_GPL(nanddev_mtd_max_bad_blocks);
 
+/**
+ * nanddev_find_ecc_engine() - Find a suitable ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_find_ecc_engine(struct nand_device *nand)
+{
+	bool is_spinand = mtd_type_is_spinand(&nand->mtd);
+
+	/* Read the user desires in terms of ECC engine/configuration */
+	nand_ecc_read_user_conf(nand);
+
+	/* No ECC engine requestedn, let's return without error */
+	if (nand->ecc.user_conf.mode == NAND_ECC_NONE)
+		return 0;
+
+	/* Raw NAND default mode is hardware */
+	if (!is_spinand && nand->ecc.user_conf.mode < 0)
+		nand->ecc.user_conf.mode = NAND_ECC_HW;
+
+	/* SPI-NAND default mode is on-die */
+	if (is_spinand && nand->ecc.user_conf.mode < 0)
+		nand->ecc.user_conf.mode = NAND_ECC_ON_DIE;
+
+	switch (nand->ecc.user_conf.mode) {
+	case NAND_ECC_SOFT:
+		nand->ecc.engine = nand_ecc_sw_get_engine(nand);
+		break;
+	case NAND_ECC_ON_DIE:
+		if (is_spinand)
+			nand->ecc.engine = spinand_ondie_ecc_get_engine();
+		else
+			pr_err("On-die ECC engines for non SPI devices not supported yet\n");
+		break;
+	case NAND_ECC_HW:
+		pr_err("Hardware ECC engines not supported yet\n");
+		break;
+	default:
+		pr_err("Missing ECC engine property\n");
+	}
+
+	if (!nand->ecc.engine)
+		return  -EINVAL;
+
+	return 0;
+}
+
+/**
+ * nanddev_find_ecc_configuration() - Find a suitable ECC configuration
+ * @nand: NAND device
+ */
+static int nanddev_find_ecc_configuration(struct nand_device *nand)
+{
+	int ret;
+
+	if (!nand->ecc.engine)
+		return -ENOTSUPP;
+
+	ret = nand_ecc_init_ctx(nand);
+	if (ret)
+		return ret;
+
+	if (!nand_ecc_correction_is_enough(nand))
+		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
+			nand->mtd.name);
+
+	return 0;
+}
+
+/**
+ * nanddev_ecc_engine_init() - Initialize an ECC engine for the chip
+ * @nand: NAND device
+ */
+int nanddev_ecc_engine_init(struct nand_device *nand)
+{
+	int ret;
+
+	/* Look for the ECC engine to use */
+	ret = nanddev_find_ecc_engine(nand);
+	if (ret) {
+		pr_err("No ECC engine found\n");
+		return ret;
+	}
+
+	/* No ECC engine requested */
+	if (!nand->ecc.engine)
+		return 0;
+
+	/* Configure the engine: balance user input and chip requirements */
+	ret = nanddev_find_ecc_configuration(nand);
+	if (ret) {
+		pr_err("No suitable ECC configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * nanddev_ecc_engine_cleanup() - Cleanup ECC engine initializations
+ * @nand: NAND device
+ */
+void nanddev_ecc_engine_cleanup(struct nand_device *nand)
+{
+	if (nand->ecc.engine)
+		nand_ecc_cleanup_ctx(nand);
+}
+
 /**
  * nanddev_init() - Initialize a NAND device
  * @nand: NAND device
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 534c07fab9de..bf949f55c139 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -844,6 +844,10 @@ bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 
+/* ECC related functions */
+int nanddev_ecc_engine_init(struct nand_device *nand);
+void nanddev_ecc_engine_cleanup(struct nand_device *nand);
+
 /* BBT related functions */
 enum nand_bbt_block_status {
 	NAND_BBT_BLOCK_STATUS_UNKNOWN,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
