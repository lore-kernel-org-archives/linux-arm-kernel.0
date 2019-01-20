Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABDC61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705212084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QDXEKMZ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Yvw6jjEV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="cEBqiWlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705212084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GkCjL7G4gRSYVNk+61237IHxpSwGM/yigdFdMXBq7aU=; b=QDXEKMZ7f1LWUwLWKVD3bzDucc
	ALFSan8jX0aFz03EDVFHysxKoKwHl9NJe+vM9vpNiTDb3U3dhaV6KgB6j9ONYeawPpUraYJJKMGFy
	VEvqC2fmEmyl/1gj6GB24Sh/CEnruEAnzOVLN0jN9sSDje5gelQzPdI/MQSOsy1vuFpqeyRxpJ1gA
	BRwSJpWhY5XJEumVVIEz0B5UWPOpz1Xx32K62ZlhoX0oUxIZ1u92QmwCuTSI4kW948KARkNR6gKNV
	+q4PrYnen6Y4ujhIsYGctKPjPGHvlNao26k/cl8ZiJSjwmocOK+0gPah6x7ehPl9UpozBGSOI6TC9
	fNX8WskQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2u6-0001UF-C3; Sun, 20 Jan 2019 02:32:06 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2u3-0001T8-6W
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 02:32:04 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 30F4E4E2051;
 Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951522; bh=WUXWccT5PmV9S0juFUFU4MxzFbKyfQ6fspVdbDlV0c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yvw6jjEVw9CKGorYpikfdV+i+9mxGmaZySVufNzzx7KlW/2dW7EImaEkGGGayaWHh
 LT6ZYPumGZl8iwZ+F8XrPiZaAgZX//rhvtYzOQe4g3f/h/5Sj7Ihy/oFQ/RDm+Cf1N
 gY7mi+1EzFxNNOsjzMzXYwJ9sbgj8rSJXFaAo9SA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OD7boVEN262S; Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 4A3134E204D;
 Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951521; bh=WUXWccT5PmV9S0juFUFU4MxzFbKyfQ6fspVdbDlV0c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cEBqiWlmJ6ijJB8m6s6k62zxrQ12X6viLCx94RtTPlPWTw8J/7jCjlPrH7FFK/vpM
 sL3AcBVrQLZAN2oH+ZA7pkNRrBiD580CLjSxa6gpQfdsC1A2g0wOC9VJPYs06Ck02i
 cXrw4qXAgTscnxS2DeZK0o8LAtki2QpZOFcfkpOI=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: 
Subject: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
Date: Sat, 19 Jan 2019 19:31:48 -0700
Message-Id: <20190120023150.17138-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_183203_290611_32BE65FD 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: "Angus Ainslie \(Purism\)" <angus@akkea.ca>, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On the imx8mq I get NULL pointer de-deference errors if the device
isn't passed in during allocation.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 86708fb9bda1..0b3a67ff8e82 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -677,7 +677,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	int ret;
 	unsigned long flags;
 
-	buf_virt = dma_alloc_coherent(NULL, size, &buf_phys, GFP_KERNEL);
+	buf_virt = dma_alloc_coherent(sdma->dev, size, &buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
 		return -ENOMEM;
 	}
@@ -696,7 +696,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	dma_free_coherent(sdma->dev, size, buf_virt, buf_phys);
 
 	return ret;
 }
@@ -1182,8 +1182,8 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 {
 	int ret = -EBUSY;
 
-	sdma->bd0 = dma_alloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
-				       GFP_NOWAIT);
+	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
+					GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1205,8 +1205,8 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret = 0;
 
-	desc->bd = dma_alloc_coherent(NULL, bd_size, &desc->bd_phys,
-				      GFP_NOWAIT);
+	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
+			&desc->bd_phys,	GFP_NOWAIT);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1219,7 +1219,8 @@ static void sdma_free_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
+			desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1842,7 +1843,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
-	sdma->channel_control = dma_alloc_coherent(NULL,
+	sdma->channel_control = dma_alloc_coherent(sdma->dev,
 			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) +
 			sizeof(struct sdma_context_data),
 			&ccb_phys, GFP_KERNEL);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
