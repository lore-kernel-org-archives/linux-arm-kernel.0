Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554D32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVB892+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554D32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BC5/71r5z734LYjixcDSF52Tjero4g8cZUc0NPFkuTU=; b=PVB892+/dEiuX8
	Dw0nA7DWJNysiCIHHoRXZH9l2ZAV4rtAcRUMXIXGkKEqwBWCm2GvnzJAsbq7uTo8aOy4vaikUlIiO
	xTOhR0XMZM0+XlHjIj8PxsFM871dpm7ZUYhkEfD1+1eTfWp9HGbIuqNKA/P75mXBP1nEDmsLVa7UQ
	08AXl1FIdfT56/ONp4KYXnw0E8HD1iq/x3YWH0g4v2fNCJ6yR+JfMFoRb683RAo826oDUb8uAydLw
	i6qFL8bvnZk1+4D6QZ/SijO9Yf7nYVZvemmV0iNQ/7pL6vimLWe1g0JcdvtfKHk9JiyJpT7H+ckHi
	MZu9w99q+IaNi4Ob9RKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz2y-0005vJ-SK; Mon, 14 Jan 2019 10:00:44 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz0r-0002Cb-Nh; Mon, 14 Jan 2019 09:58:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/11] mmc: sh_mmcif: handle highmem pages
Date: Mon, 14 Jan 2019 10:58:01 +0100
Message-Id: <20190114095804.27978-9-hch@lst.de>
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
 drivers/mmc/host/sh_mmcif.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 81bd9afb0980..0d2bbb8943f5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -228,7 +228,7 @@ struct sh_mmcif_host {
 	bool dying;
 	long timeout;
 	void __iomem *addr;
-	u32 *pio_ptr;
+	u32 pio_offset;
 	spinlock_t lock;		/* protect sh_mmcif_host::state */
 	enum sh_mmcif_state state;
 	enum sh_mmcif_wait_for wait_for;
@@ -595,7 +595,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	return ret;
 }
 
-static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
+static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 {
 	struct mmc_data *data = host->mrq->data;
 
@@ -606,10 +606,10 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len)
-			host->pio_ptr = sg_virt(++data->sg);
-	} else {
-		host->pio_ptr = p;
+		if (++host->sg_idx < data->sg_len) {
+			data->sg++;
+			host->pio_offset = data->sg->offset / 4;
+		}
 	}
 
 	return host->sg_idx != data->sg_len;
@@ -631,8 +631,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -640,8 +640,11 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = kmap_atomic(sg_page(data->sg));
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+		p[off++] = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	kunmap_atomic(p);
 
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
@@ -664,7 +667,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
@@ -673,7 +676,7 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -684,10 +687,14 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	p = kmap_atomic(sg_page(data->sg));
+	for (i = 0; i < host->blocksize / 4; i++) {
+		p[host->pio_offset++] =
+			sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	}
+	kunmap_atomic(p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -711,8 +718,8 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -720,8 +727,11 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = kmap_atomic(sg_page(data->sg));
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, p[off++]);
+	kunmap_atomic(p);
 
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
@@ -744,7 +754,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
@@ -753,7 +763,7 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -764,10 +774,14 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+	p = kmap_atomic(sg_page(data->sg));
+	for (i = 0; i < host->blocksize / 4; i++) {
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA,
+				p[host->pio_offset++]);
+	}
+	kunmap_atomic(p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
