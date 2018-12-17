Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:07:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE302145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJPQ8ayb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE302145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lm3JpgdsfJZ/5KiJHxnUtPZMmWYBA2xy+UhYeFK9VoQ=; b=IJPQ8aybhwoMLq
	i4+6CN9+JN8IdFT9ewNYfbUa+ePFBnpXLkxoKboDBBxAGlQHm5RbKCfkhtKc4KGzANDJ7sBZFVdpL
	CUuNSYEBMJgAuzLto9HpA3Cl2MaEQtlS5R+vHf4ohuw7oDX8nw+FxxaqAE0jskAofrKWBFQnvJ1vw
	laASPNCmScCa7tTponS0ZTTK20BM3uyY35v2Jski0xw86kl7zG/wyeLpBLe41Nb7B8/jnLAm/k1rw
	xTTXu06iCk/vbPtAx6o0OHxV/8kav8yDCwGHse4kR182mi6uUJCjjy5HLEx/v29n4zMgIhvsOxlWx
	t4e7M0mOWaayXhpjXTIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrgK-0005FS-H8; Mon, 17 Dec 2018 12:07:32 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrgG-0005Em-44
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 12:07:29 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A332691D192D6;
 Mon, 17 Dec 2018 20:07:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Mon, 17 Dec 2018 20:06:55 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Eddie James <eajames@linux.ibm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@aj.id.au>
Subject: [PATCH -next] media: platform: Fix missing spin_lock_init()
Date: Mon, 17 Dec 2018 12:14:35 +0000
Message-ID: <1545048875-157403-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_040728_329759_331BA50E 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/media/platform/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index dfec813..692e08e 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1661,6 +1661,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 
 	video->frame_rate = 30;
 	video->dev = &pdev->dev;
+	spin_lock_init(&video->lock);
 	mutex_init(&video->video_lock);
 	init_waitqueue_head(&video->wait);
 	INIT_DELAYED_WORK(&video->res_work, aspeed_video_resolution_work);




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
