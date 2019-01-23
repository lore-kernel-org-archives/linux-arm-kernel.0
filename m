Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2476EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C0A2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gwqw75tw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NFOSey2f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NFOSey2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C0A2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9V48aMkl/gaCgwV93uaqwHjDmgNyoVYtdidtWG4WkQI=; b=Gwqw75twS1KTqfzVDTA3DgpjfJ
	JK451sBqlJD9/uuJO/3/kg2D1llahy/+SsNu4ZsMYxlK98aoCcY6bVg/vam+RglEkH4/0hD/WTaNW
	O66E7XaLzYrGqp/b+V7KDxyva5HJnw58R1TE8qsRJ0DuWGf5C+2KyijqvTL+9XzLQxsL5nTVg8ayD
	NGLj7r9DyVACekZ6xSfaDhP7pTvYZbcQX6Dw0sczYfn97OAoLsTNb8XWer+4rG5ID0Lu1pI3+w0DX
	FkxmompVHE82dpWyKDi88Q99lMjoitT5k2f2qgAnwEyDbJl8oY79k7qVwzJ1vmNgWuJMC0HRk0Bjd
	XZFyWb9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKOc-0001AN-6P; Wed, 23 Jan 2019 15:24:54 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKNW-00006K-Qy
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:23:49 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id B41F34E2062;
 Wed, 23 Jan 2019 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548257026; bh=1lElNF08mp9a3DZ/4zcDEhQNOkQuIGLji0OR564dzrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NFOSey2fO3EXGvDMhqZQRXLx2sZZ3LBGMHmeNE9CUukyJY8J0zsWlxRqwCwPOyVLS
 5kpc1GmooWOwIRURuB5L5hBMboRl8wZaaPgzTgn7zSQih++sK2+CstufmH4ILXAsMm
 CP2LYkUCYSwWVkC6Qt639gbXY54cCvlBGd9xAK54=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mTilSCM7ID1V; Wed, 23 Jan 2019 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id B448F4E204E;
 Wed, 23 Jan 2019 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548257026; bh=1lElNF08mp9a3DZ/4zcDEhQNOkQuIGLji0OR564dzrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NFOSey2fO3EXGvDMhqZQRXLx2sZZ3LBGMHmeNE9CUukyJY8J0zsWlxRqwCwPOyVLS
 5kpc1GmooWOwIRURuB5L5hBMboRl8wZaaPgzTgn7zSQih++sK2+CstufmH4ILXAsMm
 CP2LYkUCYSwWVkC6Qt639gbXY54cCvlBGd9xAK54=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi sdma
 devices
Date: Wed, 23 Jan 2019 08:23:09 -0700
Message-Id: <20190123152310.11680-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123152310.11680-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_072346_895269_057FBB6A 
X-CRM114-Status: GOOD (  13.47  )
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
the correct sdma device, use an index to match.

Based on MLK-16104-2 by Robin Gong <yibin.gong@nxp.com>

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c                | 12 ++++++++++++
 include/linux/platform_data/dma-imx.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 2e691b1cd0eb..bf3752a6a64f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -442,6 +442,7 @@ struct sdma_engine {
 	struct sdma_buffer_descriptor	*bd0;
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
+	int				idx;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -606,6 +607,8 @@ static const struct of_device_id sdma_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
 
+static int sdma_dev_idx;
+
 #define SDMA_H_CONFIG_DSPDMA	BIT(12) /* indicates if the DSPDMA is used */
 #define SDMA_H_CONFIG_RTD_PINS	BIT(11) /* indicates if Real-Time Debug pins are enabled */
 #define SDMA_H_CONFIG_ACR	BIT(4)  /* indicates if AHB freq /core freq = 2 or 1 */
@@ -1934,6 +1937,11 @@ static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
+	/* return false if it's not the right device */
+	if ((sdmac->sdma->drvdata == &sdma_imx8mq)
+		&& (sdmac->sdma->idx != data->idx))
+		return false;
+
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1961,6 +1969,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
+	data.idx = sdma->idx;
 
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
@@ -2149,6 +2158,9 @@ static int sdma_probe(struct platform_device *pdev)
 		of_node_put(spba_bus);
 	}
 
+	/* There maybe multi sdma devices such as i.mx8mq */
+	sdma->idx = sdma_dev_idx++;
+
 	return 0;
 
 err_register:
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7d964e787299..843faf081282 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,6 +55,7 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
+	int idx;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
