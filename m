Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FECC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AD92146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JF81sygY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AD92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QaCQs9vQu2+GpTF2ajJn4pwCGoV/Z1BGJE6Te1G9Xy0=; b=JF81sygYT/mvqA
	Us5mGijn8RsabfHYmBzoyOyQSfOD11PPDse6+RxP/D7rKIR0rzx4BoZ/+ysiRX+pXVnlvF4ypYZv+
	5eNoJ8CFc+rA+djjRifxIg9Gvjd6lAd07gRjFvauFdt6sexKeIm4aOo/w5WSHb48vbujnOtS/tQET
	QbFlwOgpG1XuAM/3+bKoZP0XmFv2JyLoEfdvs7s+dXiQk+qGX6qUd6OCZ49Auyj/MFo84ltYGu4KR
	PdGhdNyfaDLb6nAzTPey8WgVChiLSkNXs+45K3ZqGRBKWrrpG9tNdncxfb1VJr/OEPWn3hbgqlAW1
	+yDTqQ6s91f5V4zMLzKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiqV-0001pU-Jl; Fri, 30 Nov 2018 13:28:39 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilw-0004zL-AT; Fri, 30 Nov 2018 13:23:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 19/23] iommu/vt-d: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:27 +0100
Message-Id: <20181130132231.16512-20-hch@lst.de>
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
 drivers/iommu/intel-iommu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 66b4444398ae..0ad67d65bbce 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3617,7 +3617,7 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
-		return 0;
+		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
 	size = aligned_nrpages(paddr, size);
@@ -3655,7 +3655,7 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
-	return 0;
+	return DMA_MAPPING_ERROR;
 }
 
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
@@ -3756,7 +3756,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_handle = __intel_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL,
 				       dev->coherent_dma_mask);
-	if (*dma_handle)
+	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
@@ -3865,11 +3865,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
-static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return !dma_addr;
-}
-
 static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
@@ -3877,7 +3872,6 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
-	.mapping_error = intel_mapping_error,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
