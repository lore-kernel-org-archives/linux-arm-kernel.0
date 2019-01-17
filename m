Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E038206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0ygbd/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E038206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/df0/OGUqJ0blmddbYFesEE5E+pWBJKit+ON5A0YI8U=; b=M0ygbd/jFoSHDa
	vtGPflf/YSKNbkb4gy6591lQDr245fHgZWyzC8oNlTlHgqII8VqG7YutRVvvkMepFn86Yj9QwFcIx
	Xr1kC1N9kD1lz4Sssi31+r/n6ymVl3E9cGB1vCmlQZZalLlTvhNeBWItvk1BNRYhXPajlDwMe1R2P
	KiJWcZv2e4UZIbtwqxAWdWH6KGLfkdncS6woIC02B8SeHfNv2dNfx/TB78ziEa2KikKwE1zLpOFyx
	OEU9bB0Qnr7LNViV+IEwx2O8eOebf/GcLgPjqj7YBcx/072DsO/wUw2cMyOhExMVMpj0loelFqAXf
	HGLtSG9EP3MSpbQhkLdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjy3J-00082j-6m; Thu, 17 Jan 2019 03:09:09 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjy3E-000824-GI
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 03:09:06 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E6660EDE96360F5DFAFC;
 Thu, 17 Jan 2019 11:08:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Thu, 17 Jan 2019 11:08:50 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, 
 <fabio.estevam@nxp.com>, <linux-imx@nxp.com>, <peda@axentia.se>,
 <wsa+renesas@sang-engineering.com>, <u.kleine-koenig@pengutronix.de>,
 <l.stach@pengutronix.de>, <eha@deif.com>, <linux@rempel-privat.de>
Subject: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Date: Thu, 17 Jan 2019 03:14:54 +0000
Message-ID: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_190904_702860_82DFE74E 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Change the call to PTR_ERR to access the value just tested by IS_ERR.

Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 09b1245..42fed40 100644
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




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
