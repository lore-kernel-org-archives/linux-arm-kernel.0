Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2461EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7872080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OcZTIWQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7872080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Htkxqdw5bjvPpndz72bwpv2mmkZCwmQD0obirnsnRRw=; b=OcZTIWQeZ6SdqV
	lyMLeaZjOBsN70R0VrRy8B6XUtBMda6UPWNYVP9V0xKX62DuQ0w8edci6JI/KDzCT/m1LXm/b5hBR
	Epoj0oEbXCI4Mb8Y7zZAJUsoGz8oPSIg1fRwqPqWsMS3xXERDnUN8ZXdtOmjwzP3uvYmsEzfv9tHJ
	+5HFTZ9yLfg3RCq2nBvYmN88IUuWb3v4iErxbKCruMbl8oTPmVbgAzipv6LfVRa2d6MKbifrCrZgv
	Eudtx3WbmoML2vbXK0mjXhLQu1cA4eXnfmUQ4iGNuASf8WvlC/Yyi9RP2zRFFHfBCAOdYnkukaKkR
	30GxeYDGhthlqsEMSfAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSior-0000gT-Oc; Fri, 30 Nov 2018 13:26:57 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSil7-0004HW-47; Fri, 30 Nov 2018 13:23:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 02/23] dma-direct: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:10 +0100
Message-Id: <20181130132231.16512-3-hch@lst.de>
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

The dma-direct code already returns (~(dma_addr_t)0x0) on mapping
failures, so we can switch over to returning DMA_MAPPING_ERROR and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma-swiotlb.c |  1 -
 include/linux/dma-direct.h        |  3 ---
 kernel/dma/direct.c               |  8 +-------
 kernel/dma/swiotlb.c              | 11 +++++------
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 5fc335f4d9cd..3d8df2cf8be9 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -59,7 +59,6 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.sync_single_for_device = swiotlb_sync_single_for_device,
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = dma_direct_mapping_error,
 	.get_required_mask = swiotlb_powerpc_get_required,
 };
 
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 9e66bfe369aa..e7600f92d876 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -5,8 +5,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/mem_encrypt.h>
 
-#define DIRECT_MAPPING_ERROR		(~(dma_addr_t)0)
-
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #else
@@ -73,5 +71,4 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
-int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab5a5e9..d4335a03193a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -265,7 +265,7 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
 	if (!check_addr(dev, dma_addr, size, __func__))
-		return DIRECT_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_device(dev, dma_addr, size, dir);
@@ -312,11 +312,6 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return mask >= phys_to_dma(dev, min_mask);
 }
 
-int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == DIRECT_MAPPING_ERROR;
-}
-
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
@@ -335,7 +330,6 @@ const struct dma_map_ops dma_direct_ops = {
 #endif
 	.get_required_mask	= dma_direct_get_required_mask,
 	.dma_supported		= dma_direct_supported,
-	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
 };
 EXPORT_SYMBOL(dma_direct_ops);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e32c0e..ff1ce81bb623 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -631,21 +631,21 @@ static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
 	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
 		dev_warn_ratelimited(dev,
 			"Cannot do DMA to address %pa\n", phys);
-		return DIRECT_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 	}
 
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
 	if (*phys == SWIOTLB_MAP_ERROR)
-		return DIRECT_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	/* Ensure that the address returned is DMA'ble */
 	dma_addr = __phys_to_dma(dev, *phys);
 	if (unlikely(!dma_capable(dev, dma_addr, size))) {
 		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
-		return DIRECT_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 	}
 
 	return dma_addr;
@@ -680,7 +680,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 
 	if (!dev_is_dma_coherent(dev) &&
 	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0 &&
-	    dev_addr != DIRECT_MAPPING_ERROR)
+	    dev_addr != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
 
 	return dev_addr;
@@ -789,7 +789,7 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 	for_each_sg(sgl, sg, nelems, i) {
 		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
 				sg->length, dir, attrs);
-		if (sg->dma_address == DIRECT_MAPPING_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR)
 			goto out_error;
 		sg_dma_len(sg) = sg->length;
 	}
@@ -869,7 +869,6 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 }
 
 const struct dma_map_ops swiotlb_dma_ops = {
-	.mapping_error		= dma_direct_mapping_error,
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
 	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
