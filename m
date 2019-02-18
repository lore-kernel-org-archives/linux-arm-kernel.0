Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7924AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:27:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB51217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riYqHj5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB51217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ANZEecSseOLkeMOLKLpvkPR6CNgWyER7MQ3CzIPwC9Y=; b=riYqHj5+GzPzJM
	HgHbA39KZtNj2PykLlvblgkXW5jLCZceTQ4yHiYwWsnNNm9wqNb67kijp0lGs3wdP9avfVUhMRsAF
	5dHXszi/VJ2hm+ev8/i0c/vYqXfyU+b9uuCzTSN+1SsXiPD5yu0vRUynL+A4V2YEVLqNfZMBsGwt/
	nG/zZ/XanTyXb20fnmX558IYphrA5mNsO2SUPxmQ8kDI0zni6PFeg+zJjH+cE35gHeguBUc3kAyZE
	mUQYRrbYtgyEKfFA+8R1mHKzD3pgMV5nBfCSQLt4XLqyuwyaSn4zWj5QAl79Nr3HRL5AKvz3/dryt
	lKumdbE8s529GM8d1gLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvndj-0005XA-Go; Mon, 18 Feb 2019 18:27:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvndZ-0005I3-DC
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:27:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41CF480D;
 Mon, 18 Feb 2019 10:27:18 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 302373F720;
 Mon, 18 Feb 2019 10:27:12 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: vkoul@kernel.org
Subject: [PATCH] dmaengine: mv_xor: Use correct device for DMA API
Date: Mon, 18 Feb 2019 18:27:06 +0000
Message-Id: <a4ee24cc9dac4f94b27fa521092ceb9cac2d5de2.1550514265.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_102729_744341_E00A58D7 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: dmaengine@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
 hch@lst.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Using dma_dev->dev for mappings before it's assigned with the correct
device is unlikely to work as expected, and with future dma-direct
changes, passing a NULL device may end up crashing entirely. I don't
know enough about this hardware or the mv_xor_prep_dma_interrupt()
operation to implement the appropriate error-handling logic that would
have revealed those dma_map_single() calls failing on arm64 for as long
as the driver has been enabled there, but moving the assignment earlier
will at least make the current code operate as intended.

Fixes: 22843545b200 ("dma: mv_xor: Add support for DMA_INTERRUPT")
Reported-by: John David Anglin <dave.anglin@bell.net>
Tested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7f595355fb79..fe4a7c71fede 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1059,6 +1059,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		mv_chan->op_in_desc = XOR_MODE_IN_DESC;
 
 	dma_dev = &mv_chan->dmadev;
+	dma_dev->dev = &pdev->dev;
 	mv_chan->xordev = xordev;
 
 	/*
@@ -1091,7 +1092,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
-	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
 	if (dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask))
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
