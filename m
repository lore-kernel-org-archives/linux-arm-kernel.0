Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4910D2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dvzp4DbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4910D2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=46h17l3MuyYGD+SO/v9Te+uPPHFqxBzhXM9Kz28bYhI=; b=Dvzp4DbXVsdZd6
	dxbUThlLhasd6eOtLkQ4MghzL3p+w3lCwK3z3kCPXN/L0GObMi4d1wAozza7AA5tE4PHKSUexfx3H
	iM8aPSFDfAP4PA1G18TUrZp4O912W9qDRBCwNfI/JXLQlG1DrsdDi7vJFikt11wx1DwEMqgRpqhmz
	eIWbCWNIHerRScEZs55I0S45XXo2vLwAsYuHkUOW5uf37RpLsRggd2aSXAB6b9313o9WW/5GvH8lm
	7byUaVtNYPuViLm5i+F3aoN24kFpKKH78RIicQ5oPvPUAizwBo8gneZdMcE2cdiceDyu1vV1nsp3T
	XPceLLRwJuGOJzY/IjCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSRk-0002OV-H4; Tue, 12 Feb 2019 07:25:36 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSRh-0002OC-IA; Tue, 12 Feb 2019 07:25:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/14] scatterlist: add sg_kmap_atomic / sg_kunmap_atomic
 helpers
Date: Tue, 12 Feb 2019 08:25:15 +0100
Message-Id: <20190212072528.13167-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>,
 linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This avoids bug prone open coding of the sg offset handling and
also helps to document the limitations of mapping scatterlist
entries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/scatterlist.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b96f0d0b5b8f..524cd8448a48 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCATTERLIST_H
 #define _LINUX_SCATTERLIST_H
 
+#include <linux/highmem.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
@@ -239,6 +240,31 @@ static inline void *sg_virt(struct scatterlist *sg)
 	return page_address(sg_page(sg)) + sg->offset;
 }
 
+/**
+ * sg_kmap_atomic - map a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ *
+ * Return a kernel address for scatterlist entry by kmapping it.  Note that
+ * this function must only be called on scatterlist entries that do not span
+ * multiple pages.
+ */
+static inline void *sg_kmap_atomic(struct scatterlist *sg)
+{
+	if (WARN_ON_ONCE(sg->offset + sg->length > PAGE_SIZE))
+		return NULL;
+	return kmap_atomic(sg_page(sg)) + sg->offset;
+}
+
+/**
+ * sg_kunmap_atomic - unmap a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ * @ptr:	address returned from sg_kmap_atomic
+ */
+static inline void sg_kunmap_atomic(struct scatterlist *sg, void *ptr)
+{
+	kunmap_atomic(ptr - sg->offset);
+}
+
 /**
  * sg_init_marker - Initialize markers in sg table
  * @sgl:	   The SG table
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
