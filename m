Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B53C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:31:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1691A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iu2E7jeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1691A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7X1kJ5kHDjVMOQgpxvYWoFkChtOxhi8ZrDm+1jv7JNI=; b=iu2E7jeLHI0pQH
	rXL/CDsvk8zXv5WIduNmOpYtj/voXWnm8nFSuhycEYYyBZx0yuIBlsZeRviawGZQgyqCVGGwnGXAu
	+IMDO0qZnWXko34PzmnFcRdniTfYg8mf2b5rVLE/XgteCTXHGNZ+E9U6TEE0M1yy4lmm+VcIzCHwu
	ZRsffpoRD5udvZ2NVaSJlXpXEoa8U8S59u0FdLGNI31RBmTzAYPZ9w5R1ut/S8uwcHSugs7A/MuhR
	detf1fOojeeACx46g5uzwC416rUW4BVawLUgknFxkTJmtl3fYkGucEUuRomB10NwScEMbgfE4h1Iw
	CADkmX8PPX8zbPkLTfjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiss-0005DL-Cb; Fri, 30 Nov 2018 13:31:06 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilz-00052l-B0; Fri, 30 Nov 2018 13:23:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 20/23] iommu/dma-iommu: remove the mapping_error dma_map_ops
 method
Date: Fri, 30 Nov 2018 14:22:28 +0100
Message-Id: <20181130132231.16512-21-hch@lst.de>
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

Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c |  7 +++----
 drivers/iommu/dma-iommu.c   | 23 ++++++++---------------
 include/linux/dma-iommu.h   |  1 -
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index fdc26ea5036c..4cc70029cf8d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -397,7 +397,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			return NULL;
 
 		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (iommu_dma_mapping_error(dev, *handle)) {
+		if (*handle == DMA_MAPPING_ERROR) {
 			if (coherent)
 				__free_pages(page, get_order(size));
 			else
@@ -414,7 +414,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			return NULL;
 
 		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (iommu_dma_mapping_error(dev, *handle)) {
+		if (*handle == DMA_MAPPING_ERROR) {
 			dma_release_from_contiguous(dev, page,
 						    size >> PAGE_SHIFT);
 			return NULL;
@@ -574,7 +574,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    !iommu_dma_mapping_error(dev, dev_addr))
+	    dev_addr != DMA_MAPPING_ERROR)
 		__dma_map_area(page_address(page) + offset, size, dir);
 
 	return dev_addr;
@@ -657,7 +657,6 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.sync_sg_for_device = __iommu_sync_sg_for_device,
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
-	.mapping_error = iommu_dma_mapping_error,
 };
 
 static int __init __iommu_dma_init(void)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..60c7e9e9901e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -32,8 +32,6 @@
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 
-#define IOMMU_MAPPING_ERROR	0
-
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -523,7 +521,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 {
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = IOMMU_MAPPING_ERROR;
+	*handle = DMA_MAPPING_ERROR;
 }
 
 /**
@@ -556,7 +554,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	dma_addr_t iova;
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 
-	*handle = IOMMU_MAPPING_ERROR;
+	*handle = DMA_MAPPING_ERROR;
 
 	min_size = alloc_sizes & -alloc_sizes;
 	if (min_size < PAGE_SIZE) {
@@ -649,11 +647,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
-		return IOMMU_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
 		iommu_dma_free_iova(cookie, iova, size);
-		return IOMMU_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
 }
@@ -694,7 +692,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
+		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
 		/*
@@ -737,11 +735,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != IOMMU_MAPPING_ERROR)
+		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
 			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
 			s->length = sg_dma_len(s);
-		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
+		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
 }
@@ -858,11 +856,6 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
-int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == IOMMU_MAPPING_ERROR;
-}
-
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
@@ -882,7 +875,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		return NULL;
 
 	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
-	if (iommu_dma_mapping_error(dev, iova))
+	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
 	INIT_LIST_HEAD(&msi_page->list);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e8ca5e654277..e760dc5d1fa8 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -69,7 +69,6 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
-int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
