Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCEC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:59:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E6A20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kBYvvJ8K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="RyZHWaNs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="YE86T+MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E6A20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=j0ai64kif9eXO5U3Mc+p1xUpbVmOGgV6CnPWG4khCgk=; b=kBYvvJ8KYg+zzJPHsua/PA6G72
	v/+Ttn6/A3Jt8Zot6sn06jh32+j+BLT7UDbEJwzMhoMPyvVy27nZwLeUKkyvN2ZQAG6ibDmg5cMod
	aL6rrN2xvUYahAyVDYlHNYym23Roba80HEHLgkjBlabL/6DcmeQPard53hmwy7BZ+EIS6NYJ/wxhg
	VV/OKcSxmtZPoT4LEEiSCdgCfECMv1lLv3lzF7/4SX4klV7vKNoeBJRBPCGbpRF73vb+nr6FqI8wb
	O2VcMOZqN2YckrJZG9VysNcwrGhKfyP69ijeaYUdBk4afpDKAA9wFm77LbdOvsiTFw5os5fVjqnBH
	qyZ8HRKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2OO-0007gu-9o; Sun, 20 Jan 2019 01:59:20 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2OA-0007Wu-UX
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 01:59:08 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 0029B4E2056;
 Sun, 20 Jan 2019 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949543; bh=T9HlXba0+O7OmEWuOjckmfDYbcBpmtTFupSoqCaa3Rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RyZHWaNszzGdqNPjOIs6gz2Oxr/tdrw9knFCnkXUTEXAR+yrVXxO6dpwxhmJuDyAG
 y3tWxBTSIatLctgziF0g09GAkNNkzMk8V0PD3B5X7sEVsxLxw7l1WCqMgQowGr+w/s
 nPvicW5Ab8v/04jmClIG2x+K/6lHbenspkK6eCSs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EWjpHtaOxpq; Sun, 20 Jan 2019 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 2D80A4E204B;
 Sun, 20 Jan 2019 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949542; bh=T9HlXba0+O7OmEWuOjckmfDYbcBpmtTFupSoqCaa3Rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YE86T+MGlUJNLKd3TGJpPmdq/5W7cdQ7z4B9Nixc09qTSOxwcNqYU86ZOy0+vI3Cw
 GfNcNpBCR8FeD60qX4kMtyD7TqF0sFbBxaV8Fsh6B8p4S8qnasiRhk7SCHw7HC8ZZX
 AXmBut6mpRqXUp6+M0ZcyDYq8nlSeUfprUUHaxsA=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH 2/3] dma: imx-sdma: add clock ratio 1:1 check
Date: Sat, 19 Jan 2019 18:58:50 -0700
Message-Id: <20190120015851.11797-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120015851.11797-1-angus@akkea.ca>
References: <20190120015851.11797-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_175907_026732_E733FB04 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

based on NXP commit MLK-16841-1

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  2 +-
 drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..b3fbac401bd0 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -67,7 +67,7 @@ Optional properties:
     reg is the GPR register offset.
     shift is the bit position inside the GPR register.
     val is the value of the bit (0 or 1).
-
+- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.
 Examples:
 
 sdma@83fb0000 {
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 064bc50d1e99..616ffd6b301e 100644
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
@@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
 	/* Set bits of CONFIG register with dynamic context switching */
-	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
-		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
+	if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {
+		if (sdma->clk_ratio)
+			reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
+		else
+			reg = SDMA_H_CONFIG_CSM;
+
+		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
+	}
 
 	return ret;
 }
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
 
@@ -1975,6 +1985,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (!sdma)
 		return -ENOMEM;
 
+	sdma->clk_ratio = of_property_read_bool(np, "fsl,ratio-1-1");
+
 	spin_lock_init(&sdma->channel_0_lock);
 
 	sdma->dev = &pdev->dev;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
