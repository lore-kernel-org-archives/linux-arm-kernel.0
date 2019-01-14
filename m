Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:46:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C0920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iJN6M4WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C0920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WoYRQugtB3lyz0GgWFUN5j1mZHnUiYaXuBh/tOtkJl8=; b=iJN6M4WO7hjVQo
	WSC88ZeN7rIio+DF4UN0ho0KVRVnPrwpY+g8e+NDtVRdOZ8CSQkPJEcnWUSiiJdUP0qrtXZ0O+GXP
	g/yFpxQMU4eAUA/NG663uBpKQPtt34PtUF6UaWwZfMK1HNgBziIdwRdRnFz7avruIn79UZGZWDk5r
	YPDVOm3wI9Ay9nQd4Rq7FYIJjHzoqHOKKvREmqRpnd0xnzOVogdrprlNtFRGiOfDdmWzjfv3Si7t3
	REARcZAUVptXnXeho1rrQSOe1bAn4R75jiD/v0esUsX/ErrMUKoHhq50BgEy1JnP/RJ008LrkkM0A
	XHBCSLEL02uanqKaLVGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyp6-0002t8-Ga; Mon, 14 Jan 2019 09:46:24 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giylc-0006kB-Eh; Mon, 14 Jan 2019 09:42:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 14/19] dma-iommu: factor contiguous remapped allocations into
 helpers
Date: Mon, 14 Jan 2019 10:41:54 +0100
Message-Id: <20190114094159.27326-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This moves the last remaning non-dispatch code out of iommu_dma_alloc,
preparing to refactor the allocation method selection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 710814a370b9..956cb218c6ba 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -667,6 +667,29 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+static void *iommu_dma_alloc_contiguous_remap(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	struct page *page;
+	void *addr;
+
+	addr = iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
+	if (!addr)
+		return NULL;
+
+	page = virt_to_page(addr);
+	addr = dma_common_contiguous_remap(page, PAGE_ALIGN(size), VM_USERMAP,
+			prot, __builtin_return_address(0));
+	if (!addr)
+		goto out_free;
+	arch_dma_prep_coherent(page, size);
+	return addr;
+out_free:
+	iommu_dma_free_contiguous(dev, size, page, *dma_handle);
+	return NULL;
+}
+
 /**
  * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
  * @cpu_addr: virtual address of the memory to be remapped
@@ -1016,8 +1039,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	size_t iosize = size;
 	void *addr;
 
-	size = PAGE_ALIGN(size);
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
@@ -1036,23 +1057,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
-				attrs);
-		if (coherent || !addr)
-			return addr;
-
-		page = virt_to_page(addr);
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-				__builtin_return_address(0));
-		if (!addr) {
-			iommu_dma_free_contiguous(dev, iosize, page, *handle);
-			return NULL;
-		}
-
-		arch_dma_prep_coherent(page, iosize);
+		if (coherent)
+			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
+					gfp, attrs);
+		else
+			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
+					handle, gfp, attrs);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
