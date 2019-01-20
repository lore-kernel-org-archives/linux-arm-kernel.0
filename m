Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CBFC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEFB2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t6fHmOjE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eTcdP01v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eTcdP01v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEFB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YeG/rZRtIf7lS1eWEwVKdkI/H2Xqp0LfmWlpRaorC5g=; b=t6fHmOjEpu+UbbGh/QRVz+H47V
	oYYP+/f1lSTn2AZoltKtp8kSQwNCdEWCQAHwMFRT+wL6YsurUmD87wFvjmnzEgHspYAT4Zn4Qugh5
	EEtsiYiKXSGpeFdzk2ki6QrHmezwKwqQUPApG8/AgWn9K8/vwG7K7H54b4k+3mH1Vnk35MNGCi767
	AKcfTMaZScGdkFrMapOmEf44SDvWRcqJYuGUD+bIU320UEWlCtzDDHG4nnoKdUFeW9Zxv1TAjPuxx
	RJVBJmNBKKmHL6azjMiOZoq4/RdG8APbQOj1HJ4OpY6GFSU7GL4cOoXtBAVHroH8peeQPW/52nbGy
	/bMsxb/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2uF-0001dN-PX; Sun, 20 Jan 2019 02:32:15 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2u3-0001TA-6V
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 02:32:04 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id BDFFD4E2056;
 Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951522; bh=wJTH5J5ZdC/httLfL/yGxcEH/k8brU43a6mHXekHaCw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eTcdP01vj7Q/aTKxgz3QAI+HvniW9wnqkiinqLeV4Q57h+v+GnyVURJqyoEFJ25RJ
 VBRVQ3JVtWYGttL7cFLcqUjoFC9QysEoXl0CREHXLflKh0mp4crr051LPrfjEqTBU2
 E0CQM/S6whPEs10W1FFaBDF7KpHIo/RWEf+dVe2k=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TueyfDttQM3c; Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id DB3BD4E204B;
 Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951522; bh=wJTH5J5ZdC/httLfL/yGxcEH/k8brU43a6mHXekHaCw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eTcdP01vj7Q/aTKxgz3QAI+HvniW9wnqkiinqLeV4Q57h+v+GnyVURJqyoEFJ25RJ
 VBRVQ3JVtWYGttL7cFLcqUjoFC9QysEoXl0CREHXLflKh0mp4crr051LPrfjEqTBU2
 E0CQM/S6whPEs10W1FFaBDF7KpHIo/RWEf+dVe2k=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: 
Subject: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
Date: Sat, 19 Jan 2019 19:31:49 -0700
Message-Id: <20190120023150.17138-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_183203_286742_064E0F98 
X-CRM114-Status: GOOD (  11.97  )
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

On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

based on NXP commit MLK-16841-1

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..17544c1820b7 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -67,6 +67,7 @@ Optional properties:
     reg is the GPR register offset.
     shift is the bit position inside the GPR register.
     val is the value of the bit (0 or 1).
+- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.
 
 Examples:
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0b3a67ff8e82..65dada21d3c1 100644
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
