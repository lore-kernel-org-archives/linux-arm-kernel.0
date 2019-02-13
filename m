Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDB3222D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2N6kCFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDB3222D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZV4up6SfT+71jIDDpfpeSFCtBN9UJrIAfFnC2+nOesc=; b=q2N6kCFy2zrFKC
	RSfkT0zjTmpYCofZw4/QPSRfEa7UN/rjNhhYLC1Iqr1GlfTEY55ybBzC6yueTR0X+1m4EyehNwB4R
	n+BNmZr4vajHaKE0ETDUodVjX1ZTYphTM7Q2QPycPle00ZjILpY7TLhcI4EZ/J/Bhq05wmpQCPSyl
	EhwHneeT0ubLPB7AbI8dsfzBuxrnaCp5eQbM2N20ABbj18UDuiNlEWVxlJk4GVoQGmWyjs8ZBnHEs
	EQJbkWT58EiGgK+92o93VOLlJVxHKDURjZ55/0K7TqviNHR/UBgvs9+IDNOxWjg2yTDaBnptMjKH8
	2jcz2NoM8h0zA5wIe0ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzPr-0000ms-48; Wed, 13 Feb 2019 18:37:51 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzIO-0000oX-Tp; Wed, 13 Feb 2019 18:30:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 18/21] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Date: Wed, 13 Feb 2019 19:29:17 +0100
Message-Id: <20190213182920.16764-19-hch@lst.de>
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

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8b13fb7d0263..d9a25715650e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,7 +94,6 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5f3c70c65d50..35a5c219b82e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -501,6 +501,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 	return page_address(page);
 }
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -783,6 +784,7 @@ static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
 				gfp, attrs);
 	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
 }
+#endif /* CONFIG_DMA_DIRECT_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1065,6 +1067,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (!dev_is_dma_coherent(dev))
 		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
@@ -1072,6 +1075,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+#endif
 
 	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
@@ -1091,6 +1095,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 *
 	 * Hence how dodgy the below logic looks...
 	 */
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
 		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
 		return;
@@ -1104,6 +1109,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	iommu_dma_free_contiguous(dev, size, page, dma_handle);
@@ -1126,11 +1132,13 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_mmap_remap(cpu_addr, size, vma);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else
+#endif
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
@@ -1144,11 +1152,13 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
 		page = vmalloc_to_page(cpu_addr);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
