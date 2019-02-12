Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F343C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32F82186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7KEwFLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F82186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hi3vs9aSZbbYVpTVI1sCgZU5wVUh/fE9Gyi7CT3BisY=; b=g7KEwFLkjXlzkM
	QTQ2Mc3XYva7HizgLL58zWlI5JcuI4j+OFNk9jZdg+EcUwINZ1VemlrekiRln+8kq6ky+dZHdly31
	+KzAd+P7nBVM5gHRgrsx+0DSWQCFzKM4xC70BD8JaJUEjgvEpGiGq+REHFMDd6WorD25czcawY1IV
	Qn5bkEySuk4TuzK+GxGcVRRnARwo/bT3ZjkAIQBteF+C7QUKSb6fCFWVFmo9NZLDoeCsgdyIE6vNQ
	hutE3G749dfnXkIAx6DF7aqwDdqf5SW+o4cqwSv94KRfNSzqQpccMyFcx57KLF3OfSFWov0FA5klC
	4dF8V9BfHbmyPQxWAfWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSSi-0003Rl-K3; Tue, 12 Feb 2019 07:26:36 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSRr-0002US-VE; Tue, 12 Feb 2019 07:25:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/14] mmc: moxart: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:19 +0100
Message-Id: <20190212072528.13167-6-hch@lst.de>
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
track the offset in the current page, and do a kmap for the page while
doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/moxart-mmc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..116964e6506d 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -311,7 +311,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	sgp = sg_virt(host->cur_sg);
+	sgp = kmap(sg_page(host->cur_sg)) + host->cur_sg->offset;
 	remain = host->data_remain;
 
 	if (data->flags & MMC_DATA_WRITE) {
@@ -319,8 +319,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_URUN, &status)
 			     == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				iowrite32(*sgp, host->base + REG_DATA_WINDOW);
@@ -335,8 +334,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_ORUN, &status)
 			    == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				/* SCR data must be read in big endian. */
@@ -356,10 +354,15 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	data->bytes_xfered += host->data_remain - remain;
 	host->data_remain = remain;
 
-	if (host->data_len != data->bytes_xfered)
+	if (host->data_len != data->bytes_xfered) {
+		kunmap(sg_page(host->cur_sg));
 		moxart_next_sg(host);
-	else
-		complete(&host->pio_complete);
+		return;
+	}
+
+done:
+	kunmap(sg_page(host->cur_sg));
+	complete(&host->pio_complete);
 }
 
 static void moxart_prepare_data(struct moxart_host *host)
@@ -614,6 +617,7 @@ static int moxart_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &moxart_ops;
+	mmc->need_kmap = 1;
 	mmc->f_max = DIV_ROUND_CLOSEST(host->sysclk, 2);
 	mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
 	mmc->ocr_avail = 0xffff00;	/* Support 2.0v - 3.6v power. */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
