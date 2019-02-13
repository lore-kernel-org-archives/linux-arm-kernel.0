Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:37:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CB5222D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oj6yW2qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CB5222D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OeGWOvHaHtzX3VRXX0sPOCm/R7N1BI5Aza47xWEVxbk=; b=oj6yW2qHh8qWeD
	slInDoF1kALf5nyyCspd3WudVlI9mlsiJHcQ1iQOB4x3qPukyweRUZiHWduCFDgc+pQ1V/xgfZEeH
	wLldXe4qy77APQ7pJgkRbfNZqB140MsiwhOXu6oeMn2vPLHON860L2iyE4Jy+vZQNHRDPuCezxm7t
	BtWiJJ3OPIH6yurQPjBX4gDKWqL2NqpUxan/s9m7a4S0Uu/WYU1FMLPlxnQGUk0VDmT8/9uQ+jl7G
	baSp5J6TmmP+3nHNKUAa7oaKg08Ps1aWNeK5aQwK4oAPcbKWcz1sLgqipUFk3X/Ab8n/f0w6ebRFi
	b1/LrduyX+lQYr5phLgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzPd-0000Ne-0C; Wed, 13 Feb 2019 18:37:37 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzHy-00089H-6X; Wed, 13 Feb 2019 18:29:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
Date: Wed, 13 Feb 2019 19:29:07 +0100
Message-Id: <20190213182920.16764-9-hch@lst.de>
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

Move the vm_area handling into __iommu_dma_mmap, which is renamed
to iommu_dma_mmap_remap.

Inline __iommu_dma_mmap_pfn into the main function to simplify the code
flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 50 ++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c320c52cdac4..ed2ef8409806 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -598,23 +598,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 /**
- * __iommu_dma_mmap - Map a buffer into provided user VMA
- * @pages: Array representing buffer from __iommu_dma_alloc()
+ * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
+ * @cpu_addr: virtual address of the memory to be remapped
  * @size: Size of buffer in bytes
  * @vma: VMA describing requested userspace mapping
  *
- * Maps the pages of the buffer in @pages into @vma. The caller is responsible
+ * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
  * for verifying the correct size and protection of @vma beforehand.
  */
-static int __iommu_dma_mmap(struct page **pages, size_t size,
+static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
 		struct vm_area_struct *vma)
 {
+	struct vm_struct *area = find_vm_area(cpu_addr);
 	unsigned long uaddr = vma->vm_start;
 	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int ret = -ENXIO;
 
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
 	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
+		ret = vm_insert_page(vma, uaddr, area->pages[i]);
 		if (ret)
 			break;
 		uaddr += PAGE_SIZE;
@@ -1053,21 +1057,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	}
 }
 
-static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	struct vm_struct *area;
+	unsigned long pfn;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1078,25 +1074,15 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+			return iommu_dma_mmap_remap(cpu_addr, size, vma);
+		pfn = vmalloc_to_pfn(cpu_addr);
+	} else
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
-
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return __iommu_dma_mmap(area->pages, size, vma);
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
 }
 
 static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
