Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABC42147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kyLRP+V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABC42147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VDjC5rcCgDO1lW/7B7UFLGVJDdE1PUAo3Hv16NpR1ig=; b=kyLRP+V6ilEjTA
	kgt/D31drajSxSCRib9tVgutDY/hjA8cxMPyoAL6+yubHm+VGh7pLK/YryZLkDmf0SeLHIOyEWBoa
	czYBnMPGbqJTT7Gg7PQlb9x9KsrDW/utqG70+C+V3rQJ0HrQ1djxM41LC1TchGpGZRZxKL3DSK/SN
	VxcpfvTrRgyK8UcCBAn/kJNvtP7kU/e4+KJCVV1efVCydx5j6xeaf7y5HkwzepTHRAKKLTUMLOhHF
	FFBgVhIPl3XkBwY0y/Ff4TgYjWRkJtOu6kqrKlQ2jrqiQqvUIKL50pE3OLf9PxAJjwuJPGuGWLa4M
	9SrGaax4eRQK72OrYPcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlDY-0001To-3g; Thu, 21 Feb 2019 10:04:36 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlBm-0007Tx-1y; Thu, 21 Feb 2019 10:02:54 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id E64DC100019;
 Thu, 21 Feb 2019 10:02:41 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 07/27] mtd: nand: ecc: Move BCH code into the ecc/
 directory
Date: Thu, 21 Feb 2019 11:01:56 +0100
Message-Id: <20190221100216.25255-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221100216.25255-1-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_020246_853667_43E81FDD 
X-CRM114-Status: GOOD (  12.60  )
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

Move generic ECC code in the ecc/ sub-directory for later re-use by
the SPI NAND layer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc/Kconfig                           | 10 ++++++++++
 drivers/mtd/nand/ecc/Makefile                          |  1 +
 .../mtd/nand/{raw/nand_bch.c => ecc/sw-bch-engine.c}   |  2 +-
 drivers/mtd/nand/raw/Kconfig                           | 10 ----------
 drivers/mtd/nand/raw/Makefile                          |  1 -
 drivers/mtd/nand/raw/nand_base.c                       |  2 +-
 drivers/mtd/nand/raw/nandsim.c                         |  2 +-
 drivers/mtd/nand/raw/omap2.c                           |  2 +-
 include/linux/mtd/{nand_bch.h => nand-sw-bch-engine.h} |  6 +++---
 9 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/mtd/nand/{raw/nand_bch.c => ecc/sw-bch-engine.c} (99%)
 rename include/linux/mtd/{nand_bch.h => nand-sw-bch-engine.h} (93%)

diff --git a/drivers/mtd/nand/ecc/Kconfig b/drivers/mtd/nand/ecc/Kconfig
index 66c396dcbfbd..a05f1d474446 100644
--- a/drivers/mtd/nand/ecc/Kconfig
+++ b/drivers/mtd/nand/ecc/Kconfig
@@ -1,3 +1,13 @@
 menu "ECC engine support"
 
+config MTD_NAND_ECC_SW_BCH
+	bool "Software BCH ECC engine"
+	select BCH
+	default n
+	help
+	  This enables support for software BCH error correction. Binary BCH
+	  codes are more powerful and cpu intensive than traditional Hamming
+	  ECC codes. They are used with NAND devices requiring more than 1 bit
+	  of error correction.
+
 endmenu
diff --git a/drivers/mtd/nand/ecc/Makefile b/drivers/mtd/nand/ecc/Makefile
index 6a42577ba424..fdbfc2bc38d7 100644
--- a/drivers/mtd/nand/ecc/Makefile
+++ b/drivers/mtd/nand/ecc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MTD_NAND_CORE) += engine.o
+obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= sw-bch-engine.o
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/ecc/sw-bch-engine.c
similarity index 99%
rename from drivers/mtd/nand/raw/nand_bch.c
rename to drivers/mtd/nand/ecc/sw-bch-engine.c
index 574c0ca16160..37dc0f0061d3 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/ecc/sw-bch-engine.c
@@ -26,7 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand_bch.h>
+#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/bch.h>
 
 /**
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index ebb8a3da9fa5..478bc3f3c042 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -19,16 +19,6 @@ menuconfig MTD_RAW_NAND
 
 if MTD_RAW_NAND
 
-config MTD_NAND_ECC_SW_BCH
-	bool "Support software BCH ECC"
-	select BCH
-	default n
-	help
-	  This enables support for software BCH error correction. Binary BCH
-	  codes are more powerful and cpu intensive than traditional Hamming
-	  ECC codes. They are used with NAND devices requiring more than 1 bit
-	  of error correction.
-
 comment "Raw/parallel NAND flash controllers"
 
 config MTD_NAND_DENALI
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index ffe95b157131..18ae42077b05 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -2,7 +2,6 @@
 
 obj-$(CONFIG_MTD_RAW_NAND)		+= nand.o
 obj-$(CONFIG_MTD_NAND_ECC_SW_HAMMING)	+= nand_ecc.o
-obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
 obj-$(CONFIG_MTD_SM_COMMON) 		+= sm_common.o
 
 obj-$(CONFIG_MTD_NAND_CAFE)		+= cafe_nand.o
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 39cd2b163dc9..8a9cbe3aa7c1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -40,7 +40,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/nand_bch.h>
+#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 670abe8d59ca..797a6e4999cc 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -36,7 +36,7 @@
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand_bch.h>
+#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/list.h>
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index eaf14813a3ab..38550148a53b 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -26,7 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/mtd/nand_bch.h>
+#include <linux/mtd/nand-sw-bch-engine.h>
 #include <linux/platform_data/elm.h>
 
 #include <linux/omap-gpmc.h>
diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand-sw-bch-engine.h
similarity index 93%
rename from include/linux/mtd/nand_bch.h
rename to include/linux/mtd/nand-sw-bch-engine.h
index 06ce2b655c13..a682a15fa165 100644
--- a/include/linux/mtd/nand_bch.h
+++ b/include/linux/mtd/nand-sw-bch-engine.h
@@ -8,8 +8,8 @@
  * This file is the header for the NAND BCH ECC implementation.
  */
 
-#ifndef __MTD_NAND_BCH_H__
-#define __MTD_NAND_BCH_H__
+#ifndef __MTD_NAND_ECC_SW_BCH_H__
+#define __MTD_NAND_ECC_SW_BCH_H__
 
 struct mtd_info;
 struct nand_chip;
@@ -66,4 +66,4 @@ static inline void nand_bch_free(struct nand_bch_control *nbc) {}
 
 #endif /* CONFIG_MTD_NAND_ECC_SW_BCH */
 
-#endif /* __MTD_NAND_BCH_H__ */
+#endif /* __MTD_NAND_ECC_SW_BCH_H__ */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
