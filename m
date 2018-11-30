Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E56C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0AA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEV3H7Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X9cf2ra9Xf/cD5kIzS97stViW9lcIBAMWQXSO90T44c=; b=qEV3H7YrVKw931
	cApC01lmMGd6qorWXS2wHj+8tmx3xYuxZOGseHw0I5mvO8TPdzUmy9p1JXaRVAqgV14ki3XWxVgj1
	wkPW69q5obbWvSGf1G8A1FTr7bFd/xCg8jNc6A58MfN27hxifUgN0KsxlaVJ83ohUrKS9UFLzKAi8
	OmDWHp+qYaGC0T8riMn5TX2FBv2RWaE1zcpceRrE5XtvJ4fatpPe4/7c+TWYlLpcIpR+MjVSWxIis
	rD34gkJIZwCCmY+zCyQsEYbCdZeJCGiP84TYJT/Vk39NG9r1/Hi4n5zsX8Bbg2W0oQuojDkIBKH4O
	b8xjsDrzUiRPJA+i2R4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSirR-0002Zj-6O; Fri, 30 Nov 2018 13:29:37 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilq-0004u8-CK; Fri, 30 Nov 2018 13:23:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 17/23] iommu: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:25 +0100
Message-Id: <20181130132231.16512-18-hch@lst.de>
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

Note that the existing code used AMD_IOMMU_MAPPING_ERROR to check from
a 0 return from the IOVA allocator, which is replaced with an explicit
0 as in the implementation and other users of that interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd_iommu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..c5d6c7c42b0a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -55,8 +55,6 @@
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
 
-#define AMD_IOMMU_MAPPING_ERROR	0
-
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 #define LOOP_TIMEOUT	100000
@@ -2339,7 +2337,7 @@ static dma_addr_t __map_single(struct device *dev,
 	paddr &= PAGE_MASK;
 
 	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
-	if (address == AMD_IOMMU_MAPPING_ERROR)
+	if (!address)
 		goto out;
 
 	prot = dir2prot(direction);
@@ -2376,7 +2374,7 @@ static dma_addr_t __map_single(struct device *dev,
 
 	dma_ops_free_iova(dma_dom, address, pages);
 
-	return AMD_IOMMU_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 /*
@@ -2427,7 +2425,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	if (PTR_ERR(domain) == -EINVAL)
 		return (dma_addr_t)paddr;
 	else if (IS_ERR(domain))
-		return AMD_IOMMU_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
@@ -2504,7 +2502,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
-	if (address == AMD_IOMMU_MAPPING_ERROR)
+	if (address == DMA_MAPPING_ERROR)
 		goto out_err;
 
 	prot = dir2prot(direction);
@@ -2627,7 +2625,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
 
-	if (*dma_addr == AMD_IOMMU_MAPPING_ERROR)
+	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
 
 	return page_address(page);
@@ -2678,11 +2676,6 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
-static int amd_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == AMD_IOMMU_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops amd_iommu_dma_ops = {
 	.alloc		= alloc_coherent,
 	.free		= free_coherent,
@@ -2691,7 +2684,6 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
 	.map_sg		= map_sg,
 	.unmap_sg	= unmap_sg,
 	.dma_supported	= amd_iommu_dma_supported,
-	.mapping_error	= amd_iommu_mapping_error,
 };
 
 static int init_reserved_iova_ranges(void)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
