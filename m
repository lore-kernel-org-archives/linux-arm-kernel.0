Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD6C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840AE21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gMo9KH6v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="lTJ+XIUV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Q38CLUPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840AE21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+IIxpB3IHApXnZvW2ZozbICqtaLMWw0VVhRzSEfemMA=; b=gMo9KH6vtaUHZXyoBwf8y60QMC
	wFkWEf2fO0P9US72wGimNkxhMTkhFQ2kJvtARwXDPOVNbsliX7k0BxKp2GDddlH4hL187UnyjRY43
	phOAxmwUiDFMg9BdpnGKonsei/l2Mw8sR9rEcWn7UW2sAmYH71ZMtxApwO9otMH+3Q+XyKsVrbSWj
	wUz0jdzZCrDcUX1drO9euXvKgJjiATf+PVgIeq1nAx5QRTnZhr8wE74PIDdxjR9Pz/iJOCBCw4nxL
	7i32vXfrfTvAVMGBHpg4c+gT/hDvhY+69TcV61Yb1+NzsP+f2h1peypnIrBdeqv9N1HVaW5cbqB0J
	avrsCqKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9P1-0003o4-LF; Mon, 28 Jan 2019 16:04:51 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9Om-0003aM-9A
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:04:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 2881E4E2051;
 Mon, 28 Jan 2019 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548691476; bh=ecV0FVs8pf7wdJfAacDQzQaog4WDhg7OxsMhlavdhgo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lTJ+XIUVtTk4URuf4yUWWjGUu6oJYao6apmwhCZlqZCO9bmK/kU3ZVYhfTKzqNlDo
 EmZtICPbHgeRA8bpS043UjNJzK9FSrEylyNSxoOW/bl2u29wQiPR7EP3spWpE5ggfE
 xlOZY13ZkqcFdYtx8XBvmoaX3BHbn7cCL3gS4eIc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBjyiNuthFzc; Mon, 28 Jan 2019 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 1EB5C4E2050;
 Mon, 28 Jan 2019 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548691475; bh=ecV0FVs8pf7wdJfAacDQzQaog4WDhg7OxsMhlavdhgo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q38CLUPcP7VsYjz2Y7Ew1otNBIBpfmXBeDb3RfFgOObN9oiwpnXbCCztMVGIvFOYD
 AEUoDE1bupPv9s9hmD5sHhGnYd4dJhWdJTn6clxHuTB7xwO3X3g6HTINxxNvwA/L21
 XeYENDHeXyIqWjVUrMlQKBc/PXsm9PM8UjVcE9lg=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v6 1/3] dmaengine: imx-sdma: add clock ratio 1:1 check
Date: Mon, 28 Jan 2019 09:03:21 -0700
Message-Id: <20190128160323.28170-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128160323.28170-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128160323.28170-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_080436_326646_AD89AC27 
X-CRM114-Status: GOOD (  10.72  )
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

On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

Based on NXP commit MLK-16841-1 by Robin Gong <yibin.gong@nxp.com>

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0b3a67ff8e82..757fad2fbfae 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -440,6 +440,8 @@ struct sdma_engine {
 	unsigned int			irq;
 	dma_addr_t			bd0_phys;
 	struct sdma_buffer_descriptor	*bd0;
+	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
+	bool				clk_ratio;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -662,8 +664,11 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
 	/* Set bits of CONFIG register with dynamic context switching */
-	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
-		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
+	reg = readl(sdma->regs + SDMA_H_CONFIG);
+	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
+		reg |= SDMA_H_CONFIG_CSM;
+		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
+	}
 
 	return ret;
 }
@@ -1840,6 +1845,9 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto disable_clk_ipg;
 
+	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
+		sdma->clk_ratio = 1;
+
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
@@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
 
 	/* Set bits of CONFIG register but with static context switching */
-	/* FIXME: Check whether to set ACR bit depending on clock ratios */
-	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
+	if (sdma->clk_ratio)
+		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
+	else
+		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
 
 	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
