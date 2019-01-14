Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F740C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5020B214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GghPaRZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5020B214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t5KBJNd1orqP4sg4IM9Ax7HRtDVdFjR+Q1wX2nORf1s=; b=GghPaRZjc9Ju1n
	FT8VAkhURCDNCL9Q0c+b7OVRE+EaGA8UHx7/h0KIo7+7TJSXlWxsOJVVRYE2C2NO3P25pCph/Ymy0
	1syFm0eWHXJMIy3SWhPNqp6alwccqZxbnFu4Al5yqCB2D/GU6EJU+gOxeTmpqODuAY0app4bHVn4Z
	3SB8Uy20FVPr1HeNIfmmOWeSX5ivp2zBolLNKP7DSfo5C35vQEc3m/NUjxU8kOWqWsb/PrI+RdA7z
	LHL5WyI22YmnwkcN+1AmohxnL5uqF0H3xtDG/MmKXd1HOED90paCucW/2rPRM0ETzDpmgiRV4c6cc
	f458IAWaegKqTGBF/gnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz15-0002WX-4v; Mon, 14 Jan 2019 09:58:47 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz0W-0001rf-L4; Mon, 14 Jan 2019 09:58:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/11] mmc: moxart: handle highmem pages
Date: Mon, 14 Jan 2019 10:57:55 +0100
Message-Id: <20190114095804.27978-3-hch@lst.de>
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
track the offset in the current page, and do a kmap for the page while
doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/moxart-mmc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..7142bca425c8 100644
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
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
