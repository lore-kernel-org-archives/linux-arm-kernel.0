Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED5BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C51E2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEw9da2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C51E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9NdPcwRAYHIwFekCH5zBROoYR+jgwHG24uVpz3Jh63E=; b=hEw9da2xSfGEVH
	x8FwXxTKloow3Twv8tJanr29P8l70hTHorImE4iWOMZQZpCrmhuEilh9vpMl7+ZfLZUzC8FpI6Kd0
	de5WcmHUgF7fUbzJzA07nMYZTXytz1Rii0MVuEi5nRt/M17CTfCrC+fdisKxAa1cXBEg/ZfVuqi16
	4uZeKHmnHQEOpRxiN872/XoBKCOImov4rQkTWJUHCoj2cvU/+YDKrxgd4WXnRm/2M8bw1AKOi0O1Z
	2x443BsMWXkYPCyClV+VoZnT0u+KQbNSDeRrCriW+mPy6wCk0Nfz1aV8CM6eAT6ReDDOv2eq9h+K2
	X+OVIURD/EAw565HuiQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnz9-0008Mv-5Z; Thu, 21 Feb 2019 13:01:55 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnw1-00033d-72; Thu, 21 Feb 2019 12:58:49 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 28617C000C;
 Thu, 21 Feb 2019 12:58:37 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 20/27] mtd: nand: Let software ECC engines be retrieved
 from the NAND core
Date: Thu, 21 Feb 2019 13:57:59 +0100
Message-Id: <20190221125806.28875-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045842_264735_129A76F2 
X-CRM114-Status: GOOD (  10.67  )
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

Before making use of the ECC engines, we must retrieve them. Add the
boilerplate for the ones already available: software engines (Hamming
and BCH).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc/engine.c              | 14 ++++++++++++++
 include/linux/mtd/nand-sw-bch-engine.h     |  3 +++
 include/linux/mtd/nand-sw-hamming-engine.h |  3 +++
 include/linux/mtd/nand.h                   |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/drivers/mtd/nand/ecc/engine.c b/drivers/mtd/nand/ecc/engine.c
index 7dd3f9772698..318dbb2d56a2 100644
--- a/drivers/mtd/nand/ecc/engine.c
+++ b/drivers/mtd/nand/ecc/engine.c
@@ -286,6 +286,20 @@ bool nand_ecc_correction_is_enough(struct nand_device *nand)
 	return corr >= ds_corr && conf->strength >= reqs->strength;
 }
 
+struct nand_ecc_engine *nand_ecc_sw_get_engine(struct nand_device *nand)
+{
+	switch (nand->ecc.user_conf.algo) {
+	case NAND_ECC_HAMMING:
+		return ecc_sw_hamming_get_engine();
+	case NAND_ECC_BCH:
+		return ecc_sw_bch_get_engine();
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("Generic ECC engine");
diff --git a/include/linux/mtd/nand-sw-bch-engine.h b/include/linux/mtd/nand-sw-bch-engine.h
index e406aa53ec4e..38cdad117fea 100644
--- a/include/linux/mtd/nand-sw-bch-engine.h
+++ b/include/linux/mtd/nand-sw-bch-engine.h
@@ -11,6 +11,9 @@
 #include <linux/mtd/nand.h>
 #include <linux/bch.h>
 
+/* Needed for cross inclusion with nand.h */
+struct nand_device;
+
 /**
  * struct ecc_sw_bch_conf - private software BCH ECC engine structure
  * @reqooblen: Save the actual user OOB length requested before overwriting it
diff --git a/include/linux/mtd/nand-sw-hamming-engine.h b/include/linux/mtd/nand-sw-hamming-engine.h
index 8df36d189482..51c5a2acee42 100644
--- a/include/linux/mtd/nand-sw-hamming-engine.h
+++ b/include/linux/mtd/nand-sw-hamming-engine.h
@@ -12,6 +12,9 @@
 
 #include <linux/mtd/nand.h>
 
+/* Needed for cross inclusion with nand.h */
+struct nand_device;
+
 /**
  * struct ecc_sw_hamming_conf - private software Hamming ECC engine structure
  * @reqooblen: Save the actual user OOB length requested before overwriting it
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 4482eb2bbfd4..3abe113e4f06 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -11,6 +11,8 @@
 #define __LINUX_MTD_NAND_H
 
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand-sw-hamming-engine.h>
+#include <linux/mtd/nand-sw-bch-engine.h>
 
 struct nand_device;
 
@@ -253,6 +255,7 @@ struct nand_ecc_engine {
 };
 
 void nand_ecc_read_user_conf(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_sw_get_engine(struct nand_device *nand);
 int nand_ecc_init_ctx(struct nand_device *nand);
 void nand_ecc_cleanup_ctx(struct nand_device *nand);
 int nand_ecc_prepare_io_req(struct nand_device *nand,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
