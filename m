Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E680DC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8003217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="esDigElw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="coyFDyZ/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="coyFDyZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8003217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tXD+9oS9NPddGsR0mYZezl+OD6YB0CcLqSK0TVT9oQM=; b=esDigElwfdbWjGIwVsGl0CpNyp
	S9cw7ff+LaGKwDVEkKlAhLDOTd7qCf03wTIVjvTZMotm48a3wGuFhY6N2oNzbVlEgYAW5B/hLDb2Y
	eeP3Jho4n4jYMAAHME39mIiDzBj7Om45Rumnd38xlO5+hHFTHMpUg1kjbtP1kQoWo+u3HXxWiC/lo
	AArQHCYcXmbzCFGLOebRZA7dDosIzS2JiCKIoSANYRIKmDj1uySnBhhIw6rAS5iKFQpHXZfQ85Xjc
	Y2apdjhuu+8GwVH1XOe7aq/ugCSbCtnlAjFiK8ZHxurltpoO+UPPfQNpRWgMlKKcxSeT27xwboFBl
	ZE9ImNMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrfu-0006bA-PJ; Fri, 25 Jan 2019 02:56:58 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmred-0005aj-TS
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:55:41 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id C03E64E205C;
 Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384939; bh=NtFtvKu7hgih6/01kJslPvJy0MSpNrvkPmrJHu9XxMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=coyFDyZ/SG5g1Ba9ugw1yk/Cnn0Wi0rML5tbTK26IGvGgF0vJ5l8oMylby4QANIZZ
 eX5yEZHB/OzAJ8wmeY9G4f9zJ/DiOg3jMZXahzqkobbieT0Kx+0AU1gY4vkUts17YG
 xD89XTwdFNasizYL+iyDgM2dGEeYDs6O7GygUUiU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5E9mFXaPlrsN; Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id C3A8C4E204E;
 Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384939; bh=NtFtvKu7hgih6/01kJslPvJy0MSpNrvkPmrJHu9XxMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=coyFDyZ/SG5g1Ba9ugw1yk/Cnn0Wi0rML5tbTK26IGvGgF0vJ5l8oMylby4QANIZZ
 eX5yEZHB/OzAJ8wmeY9G4f9zJ/DiOg3jMZXahzqkobbieT0Kx+0AU1gY4vkUts17YG
 xD89XTwdFNasizYL+iyDgM2dGEeYDs6O7GygUUiU=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v4 4/5] dma: imx-sdma: add a test for imx8mq multi sdma devices
Date: Thu, 24 Jan 2019 19:55:27 -0700
Message-Id: <20190125025528.15645-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185539_967288_B607C329 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On i.mx8mq, there are two sdma instances, and the common dma framework
will get a channel dynamically from any available sdma instance whether
it's the first sdma device or the second sdma device. Some IPs like
SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
the correct sdma device, use the phandle to match.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c                | 8 ++++++++
 include/linux/platform_data/dma-imx.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ec6fb48f387a..88e112a4aabf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1927,11 +1927,17 @@ static int sdma_init(struct sdma_engine *sdma)
 static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = fn_param;
 
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
+	/* return false if it's not the right device */
+	if ((sdmac->sdma->drvdata == &sdma_imx8mq)
+		&& (sdma->dev->of_node->phandle != data->phandle))
+		return false;
+
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1942,6 +1948,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 				   struct of_dma *ofdma)
 {
 	struct sdma_engine *sdma = ofdma->of_dma_data;
+	struct device_node *np = ofdma->of_node;
 	dma_cap_mask_t mask = sdma->dma_device.cap_mask;
 	struct imx_dma_data data;
 
@@ -1959,6 +1966,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
+	data.phandle = np->phandle;
 
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7d964e787299..eeb5b73ae542 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,6 +55,7 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
+	int phandle;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
