Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91022C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E6720660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJ/LQL+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E6720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sui9+vdLT/Wz7eXmtP1kTZJ4qHBQDQIrsqW8fyyT5qI=; b=AJ/LQL+uvt4IZD
	aA/8u/8uWulef2hThhUGWrIM3h+WsFn+oLqFUL4NWEZ/RMdjGeWXNaonEaU/VGLh1gELK/G++9L3t
	kgOLz6AlIwtzvFDx/08+lxciQWCsLVZS+yq2FefdLXJrxg76bzBTPRzD8K7IWldnwxPCt3UpRm7Pw
	QPGf8tKY4OWJKf0zeVbgEz11AQN6xKywEYT98GUheuKm7k+4TyAvedL9vprsTxEaV1C4aG8ouhPsP
	8nTthjiFP85+E2wSSfIObudA5Ik2eEeqtVtTWktbhDb8VTnRbk1vzApXqlOXoBPwOjoIsrdy6v6HL
	SgCkdjz92mSq17ge8/sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz0j-00023l-1N; Mon, 14 Jan 2019 09:58:25 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz0T-0001qz-HZ; Mon, 14 Jan 2019 09:58:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/11] mmc: davinci: handle highmem pages
Date: Mon, 14 Jan 2019 10:57:54 +0100
Message-Id: <20190114095804.27978-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
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

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/davinci_mmc.c | 43 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..9c500c52b63d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -194,11 +195,12 @@ struct mmc_davinci_host {
 #define DAVINCI_MMC_DATADIR_WRITE	2
 	unsigned char data_dir;
 
-	/* buffer is used during PIO of one scatterlist segment, and
-	 * is updated along with buffer_bytes_left.  bytes_left applies
-	 * to all N blocks of the PIO transfer.
+	/*
+	 * buffer_offset is used during PIO of one scatterlist segment, and is
+	 * updated along with buffer_bytes_left.  bytes_left applies to all N
+	 * blocks of the PIO transfer.
 	 */
-	u8 *buffer;
+	u32 buffer_offset;
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
@@ -229,8 +231,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +240,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	void *p;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +248,7 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	p = kmap_atomic(sg_page(host->sg));
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -258,24 +260,31 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 	 */
 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
 		for (i = 0; i < (n >> 2); i++) {
-			writel(*((u32 *)p), host->base + DAVINCI_MMCDXR);
-			p = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			writel(*val, host->base + DAVINCI_MMCDXR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			iowrite8_rep(host->base + DAVINCI_MMCDXR, p, (n & 3));
-			p = p + (n & 3);
+			iowrite8_rep(host->base + DAVINCI_MMCDXR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	} else {
 		for (i = 0; i < (n >> 2); i++) {
-			*((u32 *)p) = readl(host->base + DAVINCI_MMCDRR);
-			p  = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			*val = readl(host->base + DAVINCI_MMCDRR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			ioread8_rep(host->base + DAVINCI_MMCDRR, p, (n & 3));
-			p = p + (n & 3);
+			ioread8_rep(host->base + DAVINCI_MMCDRR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	}
-	host->buffer = p;
+
+	kunmap_atomic(p);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +581,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
