Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F80FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6035220873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DBu2GAML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6035220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COg4RXIOAhCBkWe967/d0j7phyZwkh60czW8GFI8aZg=; b=DBu2GAMLnL92xa
	CL8JFI6EpRbIX7rDPGwUWdVde0CfrcYlJlvXdcTiPR7ubeTWSS6p8Xqqupx7PGcUN1WtFTG9tgDl0
	Ogzl8AwkfXqSUIfb/CA/3Og0sbBzFsV+zQU827P1t+y7e7kukpGHxKdR3uJiuUFxBGqeBfdyZ570H
	PKGpnhwBSgAR5Vz8zo0g0ZGhUMv90DLFY9So0cYCYWNoB0PLSE0QFjyzB6ttxslv7xWQObHNv3JIz
	bkiYNnQVTBonaZtpApJsVNyvmnIRES5y0xQZBnbX6CP8jizA/rruuaf8TcuBiEmK9lbQrf5vnwhhu
	9/VLpn0QWOly7NCiZo6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz3G-0006BA-TN; Mon, 14 Jan 2019 10:01:02 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz0v-0002Is-AA; Mon, 14 Jan 2019 09:58:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/11] mmc: sh_mmcif: handle chained sglists
Date: Mon, 14 Jan 2019 10:58:02 +0100
Message-Id: <20190114095804.27978-10-hch@lst.de>
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

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/sh_mmcif.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0d2bbb8943f5..a4116be5ebc7 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -234,7 +234,6 @@ struct sh_mmcif_host {
 	enum sh_mmcif_wait_for wait_for;
 	struct delayed_work timeout_work;
 	size_t blocksize;
-	int sg_idx;
 	int sg_blkidx;
 	bool power;
 	bool ccs_enable;		/* Command Completion Signal support */
@@ -606,13 +605,13 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len) {
-			data->sg++;
-			host->pio_offset = data->sg->offset / 4;
-		}
+		data->sg = sg_next(data->sg);
+		if (!data->sg)
+			return false;
+		host->pio_offset = data->sg->offset / 4;
 	}
 
-	return host->sg_idx != data->sg_len;
+	return true;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -665,7 +664,6 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
@@ -752,7 +750,6 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
