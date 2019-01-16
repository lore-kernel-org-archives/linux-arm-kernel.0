Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82349C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502C2206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3HHkc9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502C2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fIBVISq2z74no7Fchikrt3RM8zCqbU3zHyYNhGVqM5Q=; b=C3H
	Hkc9Yt5jbhLyu1K3q3ZWU9gB5Kq7mVyCU8psaoc9dgOD1Blp7xy3hW1xzhKF0T6OSu41Ww/UeHvDp
	RG1YDS3wPfBzIQnwvs6iWL3P9Hs5JaJBN4ph6ftDoI/U4HSh88SNEuASd4xJ9k0tA8gQ0sfzjS0F7
	Weo92EaVggIstNFwqL1nPd53g56rRdyAjnyGkCI3+ZBOKj1a1n5nRJarUpHU8Xe0Dy9qOfslPFs/m
	lnvgYkcSbwjCwGGwOv6J2RVg3ZXE/XPQsgE3GheUBMG4TMLXCTQUBYSQNGAH/n+gaqQW06jcE6MC2
	G7CCuUDI1StgRUArvlvBCnrbovUJ8TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjNX-0004Kx-1N; Wed, 16 Jan 2019 11:29:03 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjNU-0004KS-3m
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:29:01 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 487B320001D;
 Wed, 16 Jan 2019 12:28:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BCEB200018;
 Wed, 16 Jan 2019 12:28:58 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.82.46])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9555D2060F;
 Wed, 16 Jan 2019 12:28:57 +0100 (CET)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de
Subject: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Date: Wed, 16 Jan 2019 13:28:54 +0200
Message-Id: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_032900_290865_5D9DCC40 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: fabio.estevam@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 leoyang.li@nxp.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the correct error pointer when extracting the error code.

Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 09b124547669..42fed40198a0 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		ret = PTR_ERR(dma->chan_rx);
+		ret = PTR_ERR(dma->chan_tx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
 		goto fail_al;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
