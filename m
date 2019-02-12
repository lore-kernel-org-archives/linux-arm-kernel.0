Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21775C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2982083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nFIRdZx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2982083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=21uxw8wzoS0IpgwF/L2aD2cCRN2EJ7zj9wcQMZ8yRGA=; b=nFIRdZx9LUQu4D
	P41ES5+irSREvDjO3p2niCYJgNUfCpR7v9rD+TwIRTxEcNtuaHLhm1+O6371zWgCn6r2p/H3pDmLh
	CEp5tb+aJ0kHz5dE9uSWRI08U1FzKoGdQD6QzHAQc5yRJ77HiFy0lhqJnE4I71j4bxJYf3qVPYDda
	q7Q2lwOK95q3gEMz9S+ionZk3oZiHGa4gNwXpt9VJPVFOcKluqog5dmbIKENlX5pMDvpd24fPYPcS
	khm/cqXnqt+xMzyyxjhuuql0pPwqdVKVYxpgX13THhisEJ529qK+585bpdZmUmcFru2Mc4QPvccfr
	cUiaDWcyBk1lhdz9R9Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSU5-0004qa-FP; Tue, 12 Feb 2019 07:28:01 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSS3-0002iH-Gu; Tue, 12 Feb 2019 07:25:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/14] mmc: s3cmci: handle chained sglists
Date: Tue, 12 Feb 2019 08:25:23 +0100
Message-Id: <20190212072528.13167-10-hch@lst.de>
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

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/s3cmci.c | 19 +++++++++----------
 drivers/mmc/host/s3cmci.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 989fefea19f1..df7c27f78abf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -319,20 +319,19 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 
 static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	if (host->pio_sgptr >= host->mrq->data->sg_len) {
-		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
-		      host->pio_sgptr, host->mrq->data->sg_len);
+	if (!host->next_sg) {
+		dbg(host, dbg_debug, "no more buffers (%i)\n",
+		      host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->next_sg;
+	host->next_sg = sg_next(host->next_sg);
 
 	host->pio_bytes = host->cur_sg->length;
 	host->pio_offset = host->cur_sg->offset;
 
-	host->pio_sgptr++;
-
-	dbg(host, dbg_sg, "new buffer (%i/%i)\n",
-	    host->pio_sgptr, host->mrq->data->sg_len);
+	dbg(host, dbg_sg, "new buffer (%i)\n",
+	    host->mrq->data->sg_len);
 
 	return 0;
 }
@@ -1051,8 +1050,8 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	host->pio_sgptr = 0;
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->mrq->data->sg;
+	host->next_sg = sg_next(host->cur_sg);
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 4320f7d832dc..caf1078d07d1 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -51,7 +51,7 @@ struct s3cmci_host {
 	int			dma_complete;
 
 	struct scatterlist	*cur_sg;
-	u32			pio_sgptr;
+	struct scatterlist	*next_sg;
 	u32			pio_bytes;
 	u32			pio_count;
 	u32			pio_offset;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
