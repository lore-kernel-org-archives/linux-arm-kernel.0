Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A27C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:31:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AD821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eequjw5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AD821872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6bUNnrV/8dsclFBUSBz0JbVvFo22L8mD0ztxFgstKC0=; b=eequjw5MidQIf0
	iotfVZBMj21iPxZuHWYOCHkElhnNiHQhcYXULN0ETwoWzQ7kpJRstySL0hqOLlskBjF4dQyAHrlHf
	0Gf1x5kTmw6YXvTmWcOApJdEOi95wSvMwHT25Dcd9Gexd5BRTcECUp6EEXQgh9VBlFtYPRhO5IROx
	DxR2u5SfoclLt/kRBOaG+/4hDqcIjKBrwvIV8ZNYZPEYpBwajvu34QuI730eJ3uTT3LHSUqEcI4nG
	xsgfDZ6IIPjoa1pxhtJZYki6a9GrHKnUt7T11ync2XOQfq3aZ6nwIJL0vnpGgTslq0wLEp+PmfK5U
	onbZ29+dQIKfxviFhRCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfX3d-0002HE-85; Fri, 04 Jan 2019 21:31:09 +0000
Received: from gateway32.websitewelcome.com ([192.185.145.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfX3Z-0002Fm-K3
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 21:31:07 +0000
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 170D25E304D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 15:30:52 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id fX3LgWL2390onfX3Lg1GAF; Fri, 04 Jan 2019 15:30:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41140 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gfX3K-0033Fu-DA; Fri, 04 Jan 2019 15:30:50 -0600
Date: Fri, 4 Jan 2019 15:30:47 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] staging: mt7621-dma: Use struct_size() in devm_kzalloc()
Message-ID: <20190104213047.GA19391@embeddedor>
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
X-Exim-ID: 1gfX3K-0033Fu-DA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:41140
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_133105_759049_1193D2E4 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/mt7621-dma/ralink-gdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-dma/ralink-gdma.c b/drivers/staging/mt7621-dma/ralink-gdma.c
index 792a63bd55d4..d78042eba6dd 100644
--- a/drivers/staging/mt7621-dma/ralink-gdma.c
+++ b/drivers/staging/mt7621-dma/ralink-gdma.c
@@ -821,9 +821,9 @@ static int gdma_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	data = (struct gdma_data *) match->data;
 
-	dma_dev = devm_kzalloc(&pdev->dev, sizeof(*dma_dev) +
-			(sizeof(struct gdma_dmaengine_chan) * data->chancnt),
-			GFP_KERNEL);
+	dma_dev = devm_kzalloc(&pdev->dev,
+			       struct_size(dma_dev, chan, data->chancnt),
+			       GFP_KERNEL);
 	if (!dma_dev) {
 		dev_err(&pdev->dev, "alloc dma device failed\n");
 		return -EINVAL;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
