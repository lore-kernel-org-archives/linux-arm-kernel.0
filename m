Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55428C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E2E2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mhptleQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E2E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5IN+hHO1nHwA7ZvGx7ql4iWuAjRGhiTI1cDg4bCyQ9w=; b=mhptleQhYbsT2e
	Jbg7k+uJt1tZbOCAHTg8Vru0zx6BlLhAZdujWP1rRKMeeRnHqr9vOVR6vMRGALwGQ0d8eSrqZUyvl
	9+ptIdyzg/Wn1byvOiJp+Of/GJ/Ys6s6K5E083SuJv2NXwL/3DZgMnA2ncbYigoKAh6r1AyAoa3SL
	XEpZqtKbcDtXpkvlxBoV3p8QSlgZR/RCx1fqKRGbKqEWLfT8AQAGIleZX0z01oS/PEDJX2dSNhTg8
	wxPXfOuEdHgszddIeYhiUDw+vBW9TpFKFhz9YGBi1sNAgHnYhD+zvWcDIghlvwI8DPtPrWBtbkePP
	scC0gMaC0cI2GozRw5Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSimO-0005RO-SH; Fri, 30 Nov 2018 13:24:24 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilG-0004Rb-EG; Fri, 30 Nov 2018 13:23:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 05/23] mips/jazz: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:13 +0100
Message-Id: <20181130132231.16512-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Jazz iommu code already returns (~(dma_addr_t)0x0) on mapping
failures, so we can switch over to returning DMA_MAPPING_ERROR and
let the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/jazzdma.h |  6 ------
 arch/mips/jazz/jazzdma.c        | 16 +++++-----------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/jazzdma.h b/arch/mips/include/asm/jazzdma.h
index d913439c738c..d13f940022d5 100644
--- a/arch/mips/include/asm/jazzdma.h
+++ b/arch/mips/include/asm/jazzdma.h
@@ -39,12 +39,6 @@ extern int vdma_get_enable(int channel);
 #define VDMA_PAGE(a)		((unsigned int)(a) >> 12)
 #define VDMA_OFFSET(a)		((unsigned int)(a) & (VDMA_PAGESIZE-1))
 
-/*
- * error code returned by vdma_alloc()
- * (See also arch/mips/kernel/jazzdma.c)
- */
-#define VDMA_ERROR		0xffffffff
-
 /*
  * VDMA pagetable entry description
  */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 4c41ed0a637e..6256d35dbf4d 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -104,12 +104,12 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid physical address: %08lx\n",
 			       paddr);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 	if (size > 0x400000 || size == 0) {
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid size: %08lx\n", size);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 
 	spin_lock_irqsave(&vdma_lock, flags);
@@ -123,7 +123,7 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		       first < VDMA_PGTBL_ENTRIES) first++;
 		if (first + pages > VDMA_PGTBL_ENTRIES) {	/* nothing free */
 			spin_unlock_irqrestore(&vdma_lock, flags);
-			return VDMA_ERROR;
+			return DMA_MAPPING_ERROR;
 		}
 
 		last = first + 1;
@@ -569,7 +569,7 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 
 	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == VDMA_ERROR) {
+	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
 		return NULL;
 	}
@@ -620,7 +620,7 @@ static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
 				dir);
 		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
-		if (sg->dma_address == VDMA_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR)
 			return 0;
 		sg_dma_len(sg) = sg->length;
 	}
@@ -674,11 +674,6 @@ static void jazz_dma_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
 }
 
-static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == VDMA_ERROR;
-}
-
 const struct dma_map_ops jazz_dma_ops = {
 	.alloc			= jazz_dma_alloc,
 	.free			= jazz_dma_free,
@@ -692,6 +687,5 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
 	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
-	.mapping_error		= jazz_dma_mapping_error,
 };
 EXPORT_SYMBOL(jazz_dma_ops);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
