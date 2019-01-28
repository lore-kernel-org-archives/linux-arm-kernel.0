Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD62C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B332171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1AFSjuY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="xgDx0vTL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="xgDx0vTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B332171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K97z6/6fMKWf0+MnNXvhhpM7GxWgdTqdc8G9T5lRzM8=; b=e1AFSjuY1SJ5UmZr0ZmvkSnUBQ
	4kWo4lQ2gFccd8aiFM+vzRMyMtSTHFe66fGAkoJi79zeaHAdzk8ytn4bu8YAPGP8Iq9QrvWrxWRmg
	Tny8G7W/igYHamjHQUbNt+mMWTsSI5st83pXeieQJrCnTNi01u1v9NeOjGOoFIDYkMOAHW2WWPGXG
	XBe1qRRdiKWZMvHkfBexhEu1TUlBXOObDjFiEH6OMwjVliolzQuYUT++MYy7+k2MD3PNdVH7svlPR
	5pmOVfKCemvS9kUZtpMgJ5ZgSF7Rlusbi1hqJOlViFgWhlnaYA/vfSCTTSRf3Tv+UiDmbYR8hyfU9
	yyN2czuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9Pu-0005fu-Fs; Mon, 28 Jan 2019 16:05:46 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9Om-0003ae-Tm
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:04:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id C95774E2056;
 Mon, 28 Jan 2019 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548691476; bh=I60JoXZ0Fpb5JUjsLYBGi9hotAmLYskNzq8pFwZSRaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xgDx0vTLB7wYTmcpSyFIzwKN1e+HojjwX1fhgOfCRBZkFainI8Zf7L70+mjqrbiT5
 A+hkyCuEpZ9C6x9LGBa/nbjGklJjX/Ocij8BoKYHyi/aorqiDjjHr+ex1Q2wIhNQXt
 enIwJYLBTR2uSpPOySgOEPggRmw4ZsF+dMVlF3ig=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id syvnqMpJKrZF; Mon, 28 Jan 2019 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id D4C134E204B;
 Mon, 28 Jan 2019 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548691476; bh=I60JoXZ0Fpb5JUjsLYBGi9hotAmLYskNzq8pFwZSRaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xgDx0vTLB7wYTmcpSyFIzwKN1e+HojjwX1fhgOfCRBZkFainI8Zf7L70+mjqrbiT5
 A+hkyCuEpZ9C6x9LGBa/nbjGklJjX/Ocij8BoKYHyi/aorqiDjjHr+ex1Q2wIhNQXt
 enIwJYLBTR2uSpPOySgOEPggRmw4ZsF+dMVlF3ig=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v6 2/3] dmaengine: imx-sdma: add a test for imx8mq multi sdma
 devices
Date: Mon, 28 Jan 2019 09:03:22 -0700
Message-Id: <20190128160323.28170-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128160323.28170-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128160323.28170-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_080436_961929_FA0B5C0D 
X-CRM114-Status: GOOD (  11.76  )
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
the correct sdma device, use the node pointer to match.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c                | 6 ++++++
 include/linux/platform_data/dma-imx.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 757fad2fbfae..d2fae53be689 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1914,11 +1914,16 @@ static int sdma_init(struct sdma_engine *sdma)
 static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = fn_param;
 
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
+	/* return false if it's not the right device */
+	if (sdma->dev->of_node != data->of_node)
+		return false;
+
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1946,6 +1951,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
+	data.of_node = ofdma->of_node;
 
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7d964e787299..9daea8d42a10 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,6 +55,7 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
+	struct device_node *of_node;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
