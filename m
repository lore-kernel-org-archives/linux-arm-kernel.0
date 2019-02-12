Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082912186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BwohJYzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082912186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbmgsyhLy8s2QyIHgNvsHOOKrzERyshrvWe5H6msqfw=; b=BwohJYzvFeVFBb
	QaQ4boRqEP8HlyLzLxbJDuaY6y7rhT4K8MmNWzkE8f8k03ddj32IexOAjQ37tqQbg2D2/YolhEEOF
	nM21rhNIDonlcEbrl6vNUg1VoKUjKA/RBctUrUHxt0g7iSWz9nNPn/V4oAwXuzerEeLScJAdJIV9t
	aDNfGcKP5lGCH6lsQWa4pL0eEqdX8oHiCPbTh7tHCbGzAJtigrwtxs0h4wsHMIIUIXdR52fwbitxW
	jwOgphCM0CFSynOv675CcAxxIKFdd5WWn41E8c/MTZkkcmjGfzJ3bTYnz47QcTIKPg6Uf3wJHgy8O
	G67dln3E+TiS27PGMwZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSUO-0005Cp-Jo; Tue, 12 Feb 2019 07:28:20 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSS6-0002lW-2f; Tue, 12 Feb 2019 07:25:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/14] mmc: mvsdio: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:24 +0100
Message-Id: <20190212072528.13167-11-hch@lst.de>
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
 drivers/mmc/host/mvsdio.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff89c8d..d04c78125a4d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -42,7 +42,8 @@ struct mvsd_host {
 	unsigned int intr_en;
 	unsigned int ctrl;
 	unsigned int pio_size;
-	void *pio_ptr;
+	struct scatterlist *pio_sg;
+	unsigned int pio_offset; /* offset in words into the segment */
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -96,9 +97,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
 		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
 
-	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
+	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
 		(data->flags & MMC_DATA_READ) ? "read" : "write",
-		(u32)sg_virt(data->sg), data->blocks, data->blksz,
+		(u64)sg_phys(data->sg), data->blocks, data->blksz,
 		tmout, tmout_index);
 
 	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
@@ -118,10 +119,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		 * boundary.
 		 */
 		host->pio_size = data->blocks * data->blksz;
-		host->pio_ptr = sg_virt(data->sg);
+		host->pio_sg = data->sg;
+		host->pio_offset = data->sg->offset / 2;
 		if (!nodma)
-			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
-				host->pio_ptr, host->pio_size);
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
+				host->pio_offset, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -291,8 +293,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 {
 	void __iomem *iobase = host->base;
 
-	if (host->pio_ptr) {
-		host->pio_ptr = NULL;
+	if (host->pio_sg) {
+		host->pio_sg = NULL;
+		host->pio_offset = 0;
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
@@ -376,8 +379,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
+
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
 			readsw(iobase + MVSD_FIFO, p, 16);
 			p += 16;
@@ -416,13 +421,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
@@ -453,8 +460,9 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	}
 
@@ -737,6 +745,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	clk_prepare_enable(host->clk);
 
 	mmc->ops = &mvsd_ops;
+	mmc->need_kmap = 1;
 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
