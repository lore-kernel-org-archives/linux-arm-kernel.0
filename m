Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021812086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VzWslPfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021812086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xFV3VmxFtRzIJ5KD9rIvsC4hovw5pIckx35Btne4GWY=; b=VzWslPfYtyZrZW
	sUwzzxA3IEpmG4P5G/uozhM7/NtNpPQtgAtDs6SaOfSpcPUJXciJfDCSZOfehb7DjN/aYTYwf6X/v
	pqv+Ss1vOuPTVcNcjbxU6lMABAlgIo3DJaIWHGm4GSXxlBs7rtHy/RrgIsJ1AiGH5xM+nykP9+Nwr
	F65u84/QlNSv8TEmvU2oB+2aLzTEL186RgIv8aOgpJg/cie41xx57EhcHZnJ/KqOBmNMVQxjqNjTG
	qy9QRb5Hqv2qjvJ2LlF7gU3LqnJU3/XTTYMbFioNTK0FiVUQEvmKPVlQb35lpuD99lMyMsLlv8mlq
	JJL0rS+gsg3EvnW9pdwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzKM-0004Ho-NV; Wed, 13 Feb 2019 18:32:10 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzI8-0008Pa-GP; Wed, 13 Feb 2019 18:29:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 12/21] dma-iommu: factor atomic pool allocations into helpers
Date: Wed, 13 Feb 2019 19:29:11 +0100
Message-Id: <20190213182920.16764-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
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

This keeps the code together and will simplify compiling the code
out on architectures that are always dma coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c1ecb0c3436e..ff1ada9f98f5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -674,6 +674,35 @@ static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
 			GFP_KERNEL);
 }
 
+static void iommu_dma_free_pool(struct device *dev, size_t size,
+		void *vaddr, dma_addr_t dma_handle)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
+	dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+}
+
+static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	struct page *page;
+	void *vaddr;
+
+	vaddr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+	if (!vaddr)
+		return NULL;
+
+	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size,
+			dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs),
+			iommu_get_domain_for_dev(dev));
+	if (*dma_handle == DMA_MAPPING_ERROR) {
+		dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+		return NULL;
+	}
+
+	return vaddr;
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -982,21 +1011,18 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		 * get the virtually contiguous buffer we need by way of a
 		 * physically contiguous allocation.
 		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = dma_alloc_from_pool(size, &page, gfp);
-		}
-		if (!addr)
+		if (!coherent)
+			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
+					attrs);
+
+		page = alloc_pages(gfp, get_order(size));
+		if (!page)
 			return NULL;
 
+		addr = page_address(page);
 		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				dma_free_from_pool(addr, size);
+			__free_pages(page, get_order(size));
 			addr = NULL;
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
@@ -1050,8 +1076,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		dma_free_from_pool(cpu_addr, size);
+		iommu_dma_free_pool(dev, size, cpu_addr, handle);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		struct page *page = vmalloc_to_page(cpu_addr);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
