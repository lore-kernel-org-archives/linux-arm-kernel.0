Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F77C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:57:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC83B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lx79RTNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC83B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NNQV8nyto2sfnCxP84VyoYEp9jKMcEUHAKjqxtCOVsM=; b=Lx79RTNzNL8rUj
	FnM9OSFcA3h5QW7rVUQ6lPk9GYijqStJTYlCUOgDhDBYQuZ6nRhAHV3H+kk4uH8vnJ5AZl7zcyNXI
	vitNMrb3D+e6mMgRNtbTujv8bdx0v0irKHcqrahA4G9C7bHuS+3dJKe5lmcZyNjsVfcx7Du+GC6W8
	KoCKRYsTGlkvOjWAkwcXyglQoLDrmO+s0pe5hm2QUJBSfXuww5jg4Rxlsndro9T78LE6tm6Zh7H8L
	UvT1HHZJj4Bmx6N2XVVGQrxTexBVCJDIR0/1WgZGOJI6oJu/z4l9mFgXy2caKgNqB09BezCX32O5n
	3rAspUXKChOHkGkfSUyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm2B0-0008Er-GQ; Tue, 22 Jan 2019 19:57:38 +0000
Received: from gateway30.websitewelcome.com ([192.185.179.30])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm2Aw-0007WE-03
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:57:35 +0000
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 204F24E68
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:57:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id m2AjgtkYm90onm2AjgLFeh; Tue, 22 Jan 2019 13:57:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=33118 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gm2Ai-001V4E-A0; Tue, 22 Jan 2019 13:57:20 -0600
Date: Tue, 22 Jan 2019 13:57:19 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] tty: serial: 8250_mtk: Fix potential NULL pointer dereference
Message-ID: <20190122195719.GA21846@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gm2Ai-001V4E-A0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:33118
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_115734_086905_E05EBC34 
X-CRM114-Status: UNSURE (   7.87  )
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on data->dma

This bug was detected with the help of Coccinelle.

Fixes: 85b5c1dd0456 ("serial: 8250-mtk: add uart DMA support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index e2c407656fa6..c1fdbc0b6840 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -357,6 +357,9 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	if (dmacnt == 2) {
 		data->dma = devm_kzalloc(&pdev->dev, sizeof(*data->dma),
 					 GFP_KERNEL);
+		if (!data->dma)
+			return -ENOMEM;
+
 		data->dma->fn = mtk8250_dma_filter;
 		data->dma->rx_size = MTK_UART_RX_SIZE;
 		data->dma->rxconf.src_maxburst = MTK_UART_RX_TRIGGER;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
