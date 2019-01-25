Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0DFC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0C8217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAhB6mKB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DpyD3Z5+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DpyD3Z5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0C8217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/7fVTDECBzJNoj1u4XeuJhbztp+mIbp5W2Ql2WhI9gc=; b=OAhB6mKBCl1u6eKSmfMRwRKi8e
	CqieMUxE//hKL/ZOa2aDgULnO+y8x0k0K2TJs1xUQKxVhw7cYvSS3OoC/0a6TyZr7ghMWBySid5n+
	PLRQy39m35S2+h0Gl1dvF+n+zBdROaiQgMUaGToIm8g/2MOGdjBcZhAZ7SyH2PwJ4zosJ00jUsXmH
	Ak36ElcnFAY94xrakQps/uCi4D2yYhx8PYUM7RdfsXrwEBV252gAYeODavxWjp9OZ7HQaM2jaqO75
	AX2m2O+SUtO22YoWVy5cEpAe7mJvOXtWj5vmelDPTDp/76YSj1NcF8xt2Ab5uq6ocf8cKW9R+ZxaR
	jX8iMnxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrfJ-00068e-Qe; Fri, 25 Jan 2019 02:56:21 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmree-0005b2-6Z
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:55:41 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id EAE3C4E2058;
 Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384938; bh=2BskzDdkFSPQ7IWwVr4w3oGtVDWNwTeYX0iWNkTP6cU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DpyD3Z5+oNfU6uJs6Jgqhv8BIVvERCiRKkKcirj20uqqOybvivU8wUtay6LGulBmg
 tU2KybODiExQFDy3DbRjVf3BBeQYbzt8kRpAUvtnlk0NUrwUPu9bsWauZLAqAz2oen
 R6BR6Bi6WpX2bk2hcleGSRe7LbB/oIdErzdbi10Y=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33bNu387GHL5; Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 0EE274E204D;
 Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384938; bh=2BskzDdkFSPQ7IWwVr4w3oGtVDWNwTeYX0iWNkTP6cU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DpyD3Z5+oNfU6uJs6Jgqhv8BIVvERCiRKkKcirj20uqqOybvivU8wUtay6LGulBmg
 tU2KybODiExQFDy3DbRjVf3BBeQYbzt8kRpAUvtnlk0NUrwUPu9bsWauZLAqAz2oen
 R6BR6Bi6WpX2bk2hcleGSRe7LbB/oIdErzdbi10Y=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v4 3/5] dt-bindings: dma: fsl-imx-sdma: add fsl,
 imx8mq to the accepted compatible node
Date: Thu, 24 Jan 2019 19:55:26 -0700
Message-Id: <20190125025528.15645-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185540_311800_DBF0BBFA 
X-CRM114-Status: UNSURE (   7.86  )
X-CRM114-Notice: Please train this message.
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

The imx8mq is a slightly different variant on the imx7d

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..9d8bbac27d8b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx8mq-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without additional
   firmware.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
