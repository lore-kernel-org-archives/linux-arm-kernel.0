Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877ABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B7220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZ1WsTzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B7220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0/OiMEvZILwGo0TDaF77wGeuTAcbYq9/7tGFNhY8YUs=; b=EZ1WsTzATK00EE
	Gm4GHfs792NY5kEvj2Jf1hRWHOY8i/fceIy5TSeOZ+f6jIQx/nMHlCcl7h69a0cTc/amH7lrdRO9u
	SqvsVdIhEMCDWc7301TZnVeWEVPnPT3jAS5iMHPUBVrwywNoCSnqBnLAIDkp6ltLyodGcnQUbtYk7
	I0yGgz15rQwYDZzO1fsNGVqZ4zM0VSl4IDkefcBm+egSuvOgObJ4MV5fJaW/mx6Ll+8B6cEiyPeMg
	ZMc4lZW+LthG47pdG3JXBQcUYo5BmWR0fmyGk+7ZHuGceCxI+pPG7CJN9up/pIHKbYmkUHX26t4Gd
	Wzst6+H/Cf9UhN7eP7pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giypg-0003Po-QF; Mon, 14 Jan 2019 09:47:00 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyli-0006q2-NE; Mon, 14 Jan 2019 09:42:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 16/19] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Date: Mon, 14 Jan 2019 10:41:56 +0100
Message-Id: <20190114094159.27326-17-hch@lst.de>
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

For entirely dma coherent architectures there is no good reason to ever
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
index fd25c995bde4..e27909771d55 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -502,6 +502,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 	return page_address(page);
 }
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -775,6 +776,7 @@ static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
 				gfp, attrs);
 	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
 }
+#endif /* CONFIG_DMA_DIRECT_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1057,6 +1059,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (!dev_is_dma_coherent(dev))
 		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
@@ -1064,6 +1067,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+#endif
 
 	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
@@ -1083,6 +1087,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 *
 	 * Hence how dodgy the below logic looks...
 	 */
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
 		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
 		return;
@@ -1096,6 +1101,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	iommu_dma_free_contiguous(dev, size, page, dma_handle);
@@ -1119,11 +1125,13 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= count || user_count > count - off)
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
@@ -1137,11 +1145,13 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
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
