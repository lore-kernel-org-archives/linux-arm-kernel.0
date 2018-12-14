Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80417C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C86B20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EXlNsS2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C86B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YsLNJIy46futSvQvJWlHqK9YOnkO+1Jc14bIvjiFX0c=; b=EXlNsS2hKBYOcO
	Ry0tzEeFlI8a4xqaHV8DXlgh4IaV8jasqEylilB0pF7gahbYGT62nRatZZ4IgyX5o1yjuswGaiW6s
	EAiiSbreQF6KqB3XaBBJsW0CFJKrcwBGufJO82DdIlBoRz6uqaJ88eZFlNkpKG17Ndi2fz/E/ONrL
	XW+9usZu0k6EDW50/ONsCwp3P/Vt1eE5QLkEAMAC6uzAT+P5tirjRhPojnYO85D2sUof2AhVP1NI2
	HRBW21qQJ/Wk7XvlhxPbsJMnflZZ6mnqQgiajMuVbP689/5P7bTJYc/payOKunGB+Px0HsuZC3XCR
	rtthb9e4hjc5vi+KA+VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXozG-0003LX-5A; Fri, 14 Dec 2018 15:02:46 +0000
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXozC-0003LP-Ur; Fri, 14 Dec 2018 15:02:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: robin.murphy@arm.com,
	catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH dma-mapping tree] arm64: default to the direct mapping in
 get_arch_dma_ops
Date: Fri, 14 Dec 2018 16:02:40 +0100
Message-Id: <20181214150240.26427-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
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
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Otherwise the direct mapping won't work at all given that a NULL
dev->dma_ops causes a fallback.  Note that we already explicitly set
dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
fallback should not be needed anyway.

Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/include/asm/dma-mapping.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 273e778f7de2..95dbf3ef735a 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -26,11 +26,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/*
-	 * We expect no ISA devices, and all other DMA masters are expected to
-	 * have someone call arch_setup_dma_ops at device creation time.
-	 */
-	return &dma_dummy_ops;
+	return NULL;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
