Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0926120660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWAIUyWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8g5IkcCH6ltC8ni3Qccg6O/8qENGzqWrsh7O3QE4Gg=; b=pWAIUyWMjTsACY
	IBu4f45kPD/BM2NGUbF56XR41d1jdJ2Yze2UUlWaH8/TgBkRRHdbktcLGwJaTdv/ZQjLIiVnQawrf
	dbWXrcLCs3v8qjzozr4yUAzQF+H6szz4Z5aqw8yNLZywB+H4emsQ3elfKKI8mdP11XEVuXCeB9ndD
	uiPCe+Dg1kcfHJJonv3pymyQWIAzXy0enzmizlNqoFeMQRx7jd64pDLYzuwJScpV0iEHalvUctB7P
	eouNzNtnDUZK4lV32Yx7vWOnyPVYRTCovWV8IoPBko40Q2V8/PG2BbBGk5+3PX7JhkiDKPutBmUS9
	0tJ0A83p854kVVKdaZxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz23-0003il-Nr; Mon, 14 Jan 2019 09:59:47 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz0g-00021E-SG; Mon, 14 Jan 2019 09:58:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Date: Mon, 14 Jan 2019 10:57:58 +0100
Message-Id: <20190114095804.27978-6-hch@lst.de>
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
 drivers/mmc/host/s3cmci.c | 107 +++++++++++++++++++-------------------
 drivers/mmc/host/s3cmci.h |   3 +-
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 10f5219b3b40..1be84426c817 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -15,6 +15,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
+#include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
@@ -317,26 +318,17 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 	}
 }
 
-static inline int get_data_buffer(struct s3cmci_host *host,
-				  u32 *bytes, u32 **pointer)
+static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	struct scatterlist *sg;
-
-	if (host->pio_active == XFER_NONE)
-		return -EINVAL;
-
-	if ((!host->mrq) || (!host->mrq->data))
-		return -EINVAL;
-
 	if (host->pio_sgptr >= host->mrq->data->sg_len) {
 		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
 		      host->pio_sgptr, host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 
-	*bytes = sg->length;
-	*pointer = sg_virt(sg);
+	host->pio_bytes = host->cur_sg->length;
+	host->pio_offset = host->cur_sg->offset;
 
 	host->pio_sgptr++;
 
@@ -422,11 +414,16 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
 
 static void do_pio_read(struct s3cmci_host *host)
 {
-	int res;
 	u32 fifo;
 	u32 *ptr;
 	u32 fifo_words;
 	void __iomem *from_ptr;
+	void *buf;
+
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
 
 	/* write real prescaler to host, it might be set slow to fix */
 	writel(host->prescaler, host->base + S3C2410_SDIPRE);
@@ -435,20 +432,12 @@ static void do_pio_read(struct s3cmci_host *host)
 
 	while ((fifo = fifo_count(host))) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-					      &host->pio_ptr);
-			if (res) {
-				host->pio_active = XFER_NONE;
-				host->complete_what = COMPLETION_FINALIZE;
-
-				dbg(host, dbg_pio, "pio_read(): "
-				    "complete (no more data).\n");
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_read(): new target: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_read(): new target: [%i]@[%zu]\n",
+			    host->pio_bytes, host->pio_offset);
 		}
 
 		dbg(host, dbg_pio,
@@ -470,63 +459,65 @@ static void do_pio_read(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo_words = fifo >> 2;
-		ptr = host->pio_ptr;
-		while (fifo_words--)
+	
+		buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
+		ptr = buf;
+		while (fifo_words--) {
 			*ptr++ = readl(from_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
 
 		if (fifo & 3) {
 			u32 n = fifo & 3;
 			u32 data = readl(from_ptr);
-			u8 *p = (u8 *)host->pio_ptr;
+			u8 *p = (u8 *)ptr;
 
 			while (n--) {
 				*p++ = data;
 				data >>= 8;
+				host->pio_offset++;
 			}
 		}
+		kunmap_atomic(buf);
 	}
 
 	if (!host->pio_bytes) {
-		res = get_data_buffer(host, &host->pio_bytes, &host->pio_ptr);
-		if (res) {
-			dbg(host, dbg_pio,
-			    "pio_read(): complete (no more buffers).\n");
-			host->pio_active = XFER_NONE;
-			host->complete_what = COMPLETION_FINALIZE;
-
-			return;
-		}
+		if (get_data_buffer(host) < 0)
+			goto done;
 	}
 
 	enable_imask(host,
 		     S3C2410_SDIIMSK_RXFIFOHALF | S3C2410_SDIIMSK_RXFIFOLAST);
+	return;
+
+done:
+	host->pio_active = XFER_NONE;
+	host->complete_what = COMPLETION_FINALIZE;
+	dbg(host, dbg_pio, "pio_read(): complete (no more data).\n");
 }
 
 static void do_pio_write(struct s3cmci_host *host)
 {
 	void __iomem *to_ptr;
-	int res;
+	void *buf;
 	u32 fifo;
 	u32 *ptr;
 
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
+
 	to_ptr = host->base + host->sdidata;
 
 	while ((fifo = fifo_free(host)) > 3) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-							&host->pio_ptr);
-			if (res) {
-				dbg(host, dbg_pio,
-				    "pio_write(): complete (no more data).\n");
-				host->pio_active = XFER_NONE;
-
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_write(): new source: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_write(): new source: [%i]@[%zd]\n",
+			    host->pio_bytes, host->pio_offset);
 
 		}
 
@@ -543,13 +534,20 @@ static void do_pio_write(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo = (fifo + 3) >> 2;
-		ptr = host->pio_ptr;
-		while (fifo--)
+		buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
+		ptr = buf;
+		while (fifo--) {
 			writel(*ptr++, to_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
+		kunmap_atomic(buf);
 	}
 
 	enable_imask(host, S3C2410_SDIIMSK_TXFIFOHALF);
+	return;
+done:
+	dbg(host, dbg_pio, "pio_write(): complete (no more data).\n");
+	host->pio_active = XFER_NONE;
 }
 
 static void pio_tasklet(unsigned long data)
@@ -1055,6 +1053,7 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
 	host->pio_sgptr = 0;
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..4320f7d832dc 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -50,10 +50,11 @@ struct s3cmci_host {
 
 	int			dma_complete;
 
+	struct scatterlist	*cur_sg;
 	u32			pio_sgptr;
 	u32			pio_bytes;
 	u32			pio_count;
-	u32			*pio_ptr;
+	u32			pio_offset;
 #define XFER_NONE 0
 #define XFER_READ 1
 #define XFER_WRITE 2
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
