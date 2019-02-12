Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5E8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19342070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPF4ib10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19342070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XKCtz8uUERmhmFRekXR4PXm1Hc3GLCI9za5x4sRTNSA=; b=fPF4ib10U17oP2
	6HnDutS5iWb2Pk/DKJis88X8mam6AlIbqD+xbmyB6P2CqBUww96lS8eihnjj0DWRRIO+l6MwXtTI6
	ofEQwX4l0vJ5WQGf69vIFjkT4Wfk3VBoFUVKyPNRUfH/0dtxEBNln/f5ipCNSHZ6tl+PGtAr5TKCb
	PkI66m3lRPLSJMcUK7zJ0Zbmp9X2PDgCJC2JNe2ftMhPcL19qxcMqyXv8i2yuKDbYXQAiIJCwlPt+
	c2ArEGDLCCIlLrvTbgcmm7UDlVsHQAwo+4AxHdUNSSzsvV90MBuGow+Hax4rxB4DVO7E4glblwEq8
	n/0o7NXCmrWGGdQ8xnCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSVC-00065O-2P; Tue, 12 Feb 2019 07:29:10 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSSE-0002ty-4k; Tue, 12 Feb 2019 07:26:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/14] mmc: core: don't use block layer bounce buffers
Date: Tue, 12 Feb 2019 08:25:27 +0100
Message-Id: <20190212072528.13167-14-hch@lst.de>
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

All MMC and SD host drivers are highmem safe now, and bounce buffering
for addressing limitations is handled in the DMA layer now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/queue.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 71cd2411329e..1c92a2a4d641 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -354,17 +354,12 @@ static const struct blk_mq_ops mmc_mq_ops = {
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	u64 limit = BLK_BOUNCE_HIGH;
-
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
-		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	blk_queue_bounce_limit(mq->queue, limit);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	blk_queue_max_segments(mq->queue, host->max_segs);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
