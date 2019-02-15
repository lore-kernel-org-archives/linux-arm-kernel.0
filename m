Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7220B21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ldt4/g9M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M06tQnzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7220B21B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eIb0vsXYcWYzbj64xo4fXZMyAXcLKDx1vjn8EFi3ZWc=; b=ldt
	4/g9M+VkOOL9JWginQx1wuDxf8rGyndWZ4QvBTUNm1pWb3xq56KH2J3ifi5cqCzPoCIArp9H1pXQ0
	0Sr50xJ9I4jUA8Xo+9KHHpSOduWQoS+DANqvIJ/uPwZshVzdYwB+OgGq7eIejdY9jREqcl17dUmI/
	+B3OBFzVBm2mbiXW/bNbqHvtq9yjOaLyqbNx8xNW4pgc9XFBXBbtymyHtGCYbeze/59qDAQSNMeWX
	tnHUmIp+z49gsHjDGuP5nFXWiJxwORWAhdFOtvZWgEeYOpsMWBkYKR1PwjiodTJZQVzmLeS+Vloag
	4aY0n2rLO0+MKJk06VgGw4plWYFzjtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZNw-0002ZQ-Ac; Fri, 15 Feb 2019 09:02:16 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZNs-0002Rj-15
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:02:14 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so4498662pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 01:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=TKEr6BQfPYwpZOOmXDLLiGCXvoI2GmC6CPcG6Delj7k=;
 b=M06tQnzmpEvPURrsn18wmE1G0bf8j/j3E4/gaRn5UHdWAIszU5S/8BRF4bn0GNtXSe
 r7t1bSEpPbePPUAaBWw95Kui9EIi7UJTA81Di6i6f5bxLCXBdflLoBmKbdqrWgc+DwRL
 gE2EemCnKz5LtwY05osXbp7gG2eB8OesL0+Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TKEr6BQfPYwpZOOmXDLLiGCXvoI2GmC6CPcG6Delj7k=;
 b=AQweAmfF6Z3t7ayqBjJ9dpnRJJlFQUCc39KgHntdnYGLXNQ2GykIiHEA8tFsX6Y9Jx
 G5gIqglg3eLXajbOy+3u39MC+4Kf7FAAe33kDObwd/gIAOSpkZa+5Uuh0h+/VUp3usj5
 HKbyqyZgM+7aRAW1qZ3peDv73RgBQMrKKriU4tXee5i4nZ+tNlOoKjjrDtbNNazcuw0q
 Js7tcJI2eUist2w/i20LNE/HBkJpSwAeI7N+iYx4ToGb2sMQdJlupCYNX0IPmqO0o36T
 TGGOYTt5dAipYHSY9E0Ci9UxOlTnk1qZkcu9Ei8NvG+rprjzw0f7NLadNiGGrTsBM8b+
 TMxg==
X-Gm-Message-State: AHQUAuYDNeswiCpQ+QD3DnEu3wynRc/68SdGzLLF38CQxAqFBSVrecMg
 epeKghtkGQ0xHzD8VXBXf4pqVbBmCZUFZA==
X-Google-Smtp-Source: AHgI3IZ+IPALVVKhe1XQ2ry7m3Jzss69II/WcqBU5mzDNdUy2gIbEPcfg4GYGt2NpDsJktpgvm9zaw==
X-Received: by 2002:a65:6219:: with SMTP id d25mr4392407pgv.18.1550221330954; 
 Fri, 15 Feb 2019 01:02:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:b852:bd51:9305:4261])
 by smtp.gmail.com with ESMTPSA id z67sm9012653pfd.188.2019.02.15.01.02.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 15 Feb 2019 01:02:10 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Date: Fri, 15 Feb 2019 17:02:02 +0800
Message-Id: <20190215090202.157100-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_010212_075795_9CEE268B 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa@the-dreams.de>,
 Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
0 and msg->len is also 0, function makes zero-length allocation, which returns
a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
code to fail. Modify the threshold to > 0 so the function returns NULL pointer.

Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index a74ef76705e0..2bb4d20ead32 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -503,7 +503,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_rd_buf)
 			return -ENOMEM;
 
@@ -526,7 +526,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -549,7 +549,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -561,7 +561,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			return -ENOMEM;
 		}
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 1);
 		if (!dma_rd_buf) {
 			dma_unmap_single(i2c->dev, wpaddr,
 					 msgs->len, DMA_TO_DEVICE);
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
