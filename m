Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F2FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9240220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xn/bFz6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9240220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wBsjDQmVwxJNBzEVvvBCzX3z+3ihcrran4P1YDSSHbM=; b=Xn/bFz6XQVz6Vi
	IoO53F85eekmSgzyfoPucGXovjlUBahZJQ4d0N/96ZKD1eAFZinFEFZiGHSmUoO6mNH+0LuBsecU3
	af9hNQnXcJ7hbdyCu4+B9aDfWMuLTP3L/4b1I3NiJtJSJToh9wGtPSGR727CHz18+fZMDgzeT2vrG
	6R7Jzh2GdENX5XFRRlJDOZ/5zDNZJyxcsNqGUchQwpZFXvt+gOqpCz+TuXDH5BxsqEmkfbltiC9lU
	pLbyH7ONIF7F06EJr5xUTtIhZQ6cb92wrQun6YF2MA+z7htX/1LEAxCNezfYDkSyHYTOXILdn3Iay
	IFGPeJViZpaay0Vw4rrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giylq-0006wl-UW; Mon, 14 Jan 2019 09:43:02 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyl2-0006AY-4M; Mon, 14 Jan 2019 09:42:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 03/19] dma-iommu: don't use a scatterlist in iommu_dma_alloc
Date: Mon, 14 Jan 2019 10:41:43 +0100
Message-Id: <20190114094159.27326-4-hch@lst.de>
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

Directly iterating over the pages makes the code a bit simpler and
prepares for the following changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..4f5546a103d8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
+#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 
 struct iommu_dma_msi_page {
@@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct page **pages;
-	struct sg_table sgt;
 	dma_addr_t iova;
-	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
+	size_t mapped = 0;
 
 	*handle = DMA_MAPPING_ERROR;
 
@@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!iova)
 		goto out_free_pages;
 
-	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
-		goto out_free_iova;
+	for (i = 0; i < count; i++) {
+		phys_addr_t phys = page_to_phys(pages[i]);
 
-	if (!(prot & IOMMU_CACHE)) {
-		struct sg_mapping_iter miter;
-		/*
-		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
-		 * sufficient here, so skip it by using the "wrong" direction.
-		 */
-		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
-			flush_page(dev, miter.addr, page_to_phys(miter.page));
-		sg_miter_stop(&miter);
-	}
+		if (!(prot & IOMMU_CACHE)) {
+			void *vaddr = kmap_atomic(pages[i]);
 
-	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
-			< size)
-		goto out_free_sg;
+			flush_page(dev, vaddr, phys);
+			kunmap_atomic(vaddr);
+		}
+
+		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
+			goto out_unmap;
+		mapped += PAGE_SIZE;
+	}
 
 	*handle = iova;
-	sg_free_table(&sgt);
 	return pages;
-
-out_free_sg:
-	sg_free_table(&sgt);
-out_free_iova:
+out_unmap:
+	iommu_unmap(domain, iova, mapped);
 	iommu_dma_free_iova(cookie, iova, size);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
