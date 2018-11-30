Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47751C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:29:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12CF20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/8qiIFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12CF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4SOcayXLMofcaqeSu5YhNggmx6WSKjrNKsWg7GrYD9g=; b=H/8qiIFKKRpkuW
	KS4SOBW4DGh+W+V5E1tOeQtEDn560xoIlooKv87l+fnGzxGMEcxD2xb710E4UNt8dLpq4giT5UDti
	W9j3zvEvATGHBC5AHFgBwWHZxJ75S5sVJ6P+bMUrsPO63y73mp4AHAjVCg2IiHgJCdIR6ZQfQqab5
	IFDUYTyQcLk3uc9OQb93nhFIps7+M8N72pezxWcH3/SzFyAx4dh1rh3XwaMGI7ORuROIlJ50JJhLh
	/Zrv/24L43yiIOJwdFsF3nx4INQwt1gWzZz0UPP34DMaE0eiOPCGnzDFa3KdUPEnu2Rw3yH+LJKvC
	YXyb6YStcSmNJf60qsvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSirE-0002Om-1V; Fri, 30 Nov 2018 13:29:24 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiln-0004sU-Dx; Fri, 30 Nov 2018 13:23:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 16/23] x86/calgary: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:24 +0100
Message-Id: <20181130132231.16512-17-hch@lst.de>
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

Return DMA_MAPPING_ERROR instead of the magic bad_dma_addr on a dma
mapping failure and let the core dma-mapping code handle the rest.

Remove the magic EMERGENCY_PAGES that the bad_dma_addr gets redirected to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-calgary_64.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index bbfc8b1e9104..e76ec1b8ed1f 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -51,8 +51,6 @@
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
 
-#define CALGARY_MAPPING_ERROR	0
-
 #ifdef CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT
 int use_calgary __read_mostly = 1;
 #else
@@ -157,8 +155,6 @@ static const unsigned long phb_debug_offsets[] = {
 
 #define PHB_DEBUG_STUFF_OFFSET	0x0020
 
-#define EMERGENCY_PAGES 32 /* = 128KB */
-
 unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
 static int translate_empty_slots __read_mostly = 0;
 static int calgary_detected __read_mostly = 0;
@@ -255,7 +251,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			if (panic_on_overflow)
 				panic("Calgary: fix the allocator.\n");
 			else
-				return CALGARY_MAPPING_ERROR;
+				return DMA_MAPPING_ERROR;
 		}
 	}
 
@@ -274,11 +270,10 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 	dma_addr_t ret;
 
 	entry = iommu_range_alloc(dev, tbl, npages);
-
-	if (unlikely(entry == CALGARY_MAPPING_ERROR)) {
+	if (unlikely(entry == DMA_MAPPING_ERROR)) {
 		pr_warn("failed to allocate %u pages in iommu %p\n",
 			npages, tbl);
-		return CALGARY_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 	}
 
 	/* set the return dma address */
@@ -298,8 +293,7 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	unsigned long flags;
 
 	/* were we called with bad_dma_address? */
-	badend = CALGARY_MAPPING_ERROR + (EMERGENCY_PAGES * PAGE_SIZE);
-	if (unlikely(dma_addr < badend)) {
+	if (unlikely(dma_addr == DMA_MAPPING_ERROR)) {
 		WARN(1, KERN_ERR "Calgary: driver tried unmapping bad DMA "
 		       "address 0x%Lx\n", dma_addr);
 		return;
@@ -383,7 +377,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 		npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
 
 		entry = iommu_range_alloc(dev, tbl, npages);
-		if (entry == CALGARY_MAPPING_ERROR) {
+		if (entry == DMA_MAPPING_ERROR) {
 			/* makes sure unmap knows to stop */
 			s->dma_length = 0;
 			goto error;
@@ -401,7 +395,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 error:
 	calgary_unmap_sg(dev, sg, nelems, dir, 0);
 	for_each_sg(sg, s, nelems, i) {
-		sg->dma_address = CALGARY_MAPPING_ERROR;
+		sg->dma_address = DMA_MAPPING_ERROR;
 		sg->dma_length = 0;
 	}
 	return 0;
@@ -454,7 +448,7 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 
 	/* set up tces to cover the allocated range */
 	mapping = iommu_alloc(dev, tbl, ret, npages, DMA_BIDIRECTIONAL);
-	if (mapping == CALGARY_MAPPING_ERROR)
+	if (mapping == DMA_MAPPING_ERROR)
 		goto free;
 	*dma_handle = mapping;
 	return ret;
@@ -479,11 +473,6 @@ static void calgary_free_coherent(struct device *dev, size_t size,
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
-static int calgary_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == CALGARY_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops calgary_dma_ops = {
 	.alloc = calgary_alloc_coherent,
 	.free = calgary_free_coherent,
@@ -491,7 +480,6 @@ static const struct dma_map_ops calgary_dma_ops = {
 	.unmap_sg = calgary_unmap_sg,
 	.map_page = calgary_map_page,
 	.unmap_page = calgary_unmap_page,
-	.mapping_error = calgary_mapping_error,
 	.dma_supported = dma_direct_supported,
 };
 
@@ -739,9 +727,6 @@ static void __init calgary_reserve_regions(struct pci_dev *dev)
 	u64 start;
 	struct iommu_table *tbl = pci_iommu(dev->bus);
 
-	/* reserve EMERGENCY_PAGES from bad_dma_address and up */
-	iommu_range_reserve(tbl, CALGARY_MAPPING_ERROR, EMERGENCY_PAGES);
-
 	/* avoid the BIOS/VGA first 640KB-1MB region */
 	/* for CalIOC2 - avoid the entire first MB */
 	if (is_calgary(dev->device)) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
