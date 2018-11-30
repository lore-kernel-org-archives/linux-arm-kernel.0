Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E459C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:40:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311B92145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ivh1CBka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311B92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VBc/EMvsmvgskozBRQGDXT7bUiZvICIOawrVYYh2TuA=; b=ivh1CBkakoylYB
	0G/xooZBUxUZpvKKxges37nde98yk2hc6eR9ffggdvcRrl7NBOe1j/cE4dDRTIEFPj4OGLnluux9/
	DFGWToL8QONiB10PZyP7PN+Iwad0HqQXuIs1/nGEJ+f6sCD8mWX6XK4kNDdvAvTjfLSjgvTzf3BaV
	deSaVFVYGtWdT8gRvmdBmEBWmPfP7l6FxTqTzCRLFGLZxJU2LTeQI9iNsTph/g/ZUJeZLqWh8ePKs
	oVOZrgKgNuwcYo9UteEFkpZC+DgoEezR3wpuFhxRg1Az0KSpxAOkIKpKtOy8z4bayrpaWX7TwHYZx
	oCgxIjOHIeGWfqG3fwrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSj22-0002Is-Fx; Fri, 30 Nov 2018 13:40:34 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSim2-00055n-Bx; Fri, 30 Nov 2018 13:24:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 21/23] xen-swiotlb: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:29 +0100
Message-Id: <20181130132231.16512-22-hch@lst.de>
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
 drivers/xen/swiotlb-xen.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2a7f545bd0b5..6dc969d5ea2f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -53,8 +53,6 @@
  * API.
  */
 
-#define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
-
 static char *xen_io_tlb_start, *xen_io_tlb_end;
 static unsigned long xen_io_tlb_nslabs;
 /*
@@ -406,7 +404,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
 	if (map == SWIOTLB_MAP_ERROR)
-		return XEN_SWIOTLB_ERROR_CODE;
+		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
 	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
@@ -421,7 +419,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
 
-	return XEN_SWIOTLB_ERROR_CODE;
+	return DMA_MAPPING_ERROR;
 }
 
 /*
@@ -700,11 +698,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
 }
 
-static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == XEN_SWIOTLB_ERROR_CODE;
-}
-
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -719,5 +712,4 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = xen_swiotlb_dma_mmap,
 	.get_sgtable = xen_swiotlb_get_sgtable,
-	.mapping_error	= xen_swiotlb_mapping_error,
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
