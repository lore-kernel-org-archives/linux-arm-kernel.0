Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47902186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RjHv1DVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47902186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YX1Rgr+q6tXNOZr+FyE6I7mhULmcXtz4ms/X+etCru4=; b=RjHv1DVw7eypdF
	u855HWEmvm4N0ok5kDqPD6RRQ478CdfxfhV9Mx9bVP13Rgm1AvV+5xrWLPGLj+BI8bwLH3bhYyRGX
	NQ36HyRhUhXYpQSIqtIFzM6EBODPLfS4Msj49pcFSIfLnQIsCCXFL67PVGPV/37mvAjy9UatqzgtF
	smvmcQCN+Uwc8PHi5AnXNsG1eslUm81Ptl3cRP/CTwWtBNorC8v3CJ1CHCbVL5mD0bmu2WaHzRo3g
	3roBJXgwzyelrRcvazWinXTh9zoe0jdwo0TXkL46NIOIJGQT6G3rTst9C/2HyVYt4dJ6+3raVmfqW
	KUc1eUEatHierQz3BEZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSSV-0003Ak-7P; Tue, 12 Feb 2019 07:26:23 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSRp-0002RZ-8Y; Tue, 12 Feb 2019 07:25:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/14] mmc: davinci: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:18 +0100
Message-Id: <20190212072528.13167-5-hch@lst.de>
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

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/davinci_mmc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..6a16d7a1d5bc 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -194,11 +194,12 @@ struct mmc_davinci_host {
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
 
@@ -229,8 +230,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +239,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	u8 *p, *base;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +247,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	base = sg_kmap_atomic(host->sg);
+	p = base + host->buffer_offset;
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -275,7 +277,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 			p = p + (n & 3);
 		}
 	}
-	host->buffer = p;
+	host->buffer_offset = p - base;
+	sg_kunmap_atomic(host->sg, base);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +575,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
@@ -1291,6 +1294,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	mmc->ops = &mmc_davinci_ops;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->need_kmap = 1;
 
 	/* With no iommu coalescing pages, each phys_seg is a hw_seg.
 	 * Each hw_seg uses one EDMA parameter RAM slot, always one
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
