Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648ED2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tXx4J8e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648ED2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=foe+hIK9hLhgkBAnRK+a3TB71wvuRmiLhB71uWgTya0=; b=tXx4J8e2JVhVHC
	Zyj9hRgfjQRkiex3GT3xXnh/4Q/uR6jPSMSJOSsRZYNqRjo9n/VPqT0dNKintY8PP6dwqxaoccdrZ
	hwLZdIzlsHhpz4mIQh2muyhIb+AfIlUWjzQuOqAWJVmzTN9RIn2fbo6zRWbiujwnaFbzzBydcQMcl
	N184HUnLnc6jxTCCBzHWCAY75/UE8xQXtx0KrkZhBRMZrFHnGd+v4a24LKHwQ7T+Otd7/rujwbPdv
	WqJwdUM3qT0JnZWUbVgSIenNoT13PJ6DOEuK5anWi5Yzl2V4GTQ8ZSlDjRbGjXfNNWy1a3WsBUA8N
	yEoJuzkyAq0XRN5onQYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSinv-00082R-3i; Fri, 30 Nov 2018 13:25:59 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilb-0004jv-Kg; Fri, 30 Nov 2018 13:23:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 12/23] ia64/sba_iommu: improve internal map_page users
Date: Fri, 30 Nov 2018 14:22:20 +0100
Message-Id: <20181130132231.16512-13-hch@lst.de>
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

Remove the odd sba_{un,}map_single_attrs wrappers, check errors
everywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c | 73 +++++++++++++--------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index e8a93b07283e..c56f28c98102 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -907,11 +907,12 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 }
 
 /**
- * sba_map_single_attrs - map one buffer and return IOVA for DMA
+ * sba_map_page - map one buffer and return IOVA for DMA
  * @dev: instance of PCI owned by the driver that's asking.
- * @addr:  driver buffer to map.
- * @size:  number of bytes to map in driver buffer.
- * @dir:  R/W or both.
+ * @page: page to map
+ * @poff: offset into page
+ * @size: number of bytes to map
+ * @dir: dma direction
  * @attrs: optional dma attributes
  *
  * See Documentation/DMA-API-HOWTO.txt
@@ -944,7 +945,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
  		** Device is bit capable of DMA'ing to the buffer...
 		** just return the PCI address of ptr
  		*/
-		DBG_BYPASS("sba_map_single_attrs() bypass mask/addr: "
+		DBG_BYPASS("sba_map_page() bypass mask/addr: "
 			   "0x%lx/0x%lx\n",
 		           to_pci_dev(dev)->dma_mask, pci_addr);
 		return pci_addr;
@@ -966,7 +967,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 
 #ifdef ASSERT_PDIR_SANITY
 	spin_lock_irqsave(&ioc->res_lock, flags);
-	if (sba_check_pdir(ioc,"Check before sba_map_single_attrs()"))
+	if (sba_check_pdir(ioc,"Check before sba_map_page()"))
 		panic("Sanity check failed");
 	spin_unlock_irqrestore(&ioc->res_lock, flags);
 #endif
@@ -997,20 +998,12 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 	/* form complete address */
 #ifdef ASSERT_PDIR_SANITY
 	spin_lock_irqsave(&ioc->res_lock, flags);
-	sba_check_pdir(ioc,"Check after sba_map_single_attrs()");
+	sba_check_pdir(ioc,"Check after sba_map_page()");
 	spin_unlock_irqrestore(&ioc->res_lock, flags);
 #endif
 	return SBA_IOVA(ioc, iovp, offset);
 }
 
-static dma_addr_t sba_map_single_attrs(struct device *dev, void *addr,
-				       size_t size, enum dma_data_direction dir,
-				       unsigned long attrs)
-{
-	return sba_map_page(dev, virt_to_page(addr),
-			    (unsigned long)addr & ~PAGE_MASK, size, dir, attrs);
-}
-
 #ifdef ENABLE_MARK_CLEAN
 static SBA_INLINE void
 sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
@@ -1036,7 +1029,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
 #endif
 
 /**
- * sba_unmap_single_attrs - unmap one IOVA and free resources
+ * sba_unmap_page - unmap one IOVA and free resources
  * @dev: instance of PCI owned by the driver that's asking.
  * @iova:  IOVA of driver buffer previously mapped.
  * @size:  number of bytes mapped in driver buffer.
@@ -1063,7 +1056,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 		/*
 		** Address does not fall w/in IOVA, must be bypassing
 		*/
-		DBG_BYPASS("sba_unmap_single_attrs() bypass addr: 0x%lx\n",
+		DBG_BYPASS("sba_unmap_page() bypass addr: 0x%lx\n",
 			   iova);
 
 #ifdef ENABLE_MARK_CLEAN
@@ -1114,12 +1107,6 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 #endif /* DELAYED_RESOURCE_CNT == 0 */
 }
 
-void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
-			    enum dma_data_direction dir, unsigned long attrs)
-{
-	sba_unmap_page(dev, iova, size, dir, attrs);
-}
-
 /**
  * sba_alloc_coherent - allocate/map shared mem for DMA
  * @dev: instance of PCI owned by the driver that's asking.
@@ -1132,30 +1119,24 @@ static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		   gfp_t flags, unsigned long attrs)
 {
+	struct page *page;
 	struct ioc *ioc;
+	int node = -1;
 	void *addr;
 
 	ioc = GET_IOC(dev);
 	ASSERT(ioc);
-
 #ifdef CONFIG_NUMA
-	{
-		struct page *page;
-
-		page = alloc_pages_node(ioc->node, flags, get_order(size));
-		if (unlikely(!page))
-			return NULL;
-
-		addr = page_address(page);
-	}
-#else
-	addr = (void *) __get_free_pages(flags, get_order(size));
+	node = ioc->node;
 #endif
-	if (unlikely(!addr))
+
+	page = alloc_pages_node(node, flags, get_order(size));
+	if (unlikely(!page))
 		return NULL;
 
+	addr = page_address(page);
 	memset(addr, 0, size);
-	*dma_handle = virt_to_phys(addr);
+	*dma_handle = page_to_phys(page);
 
 #ifdef ALLOW_IOV_BYPASS
 	ASSERT(dev->coherent_dma_mask);
@@ -1174,9 +1155,10 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * If device can't bypass or bypass is disabled, pass the 32bit fake
 	 * device to map single to get an iova mapping.
 	 */
-	*dma_handle = sba_map_single_attrs(&ioc->sac_only_dev->dev, addr,
-					   size, 0, 0);
-
+	*dma_handle = sba_map_page(&ioc->sac_only_dev->dev, page, 0, size,
+			DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, *dma_handle))
+		return NULL;
 	return addr;
 }
 
@@ -1193,7 +1175,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
 			      dma_addr_t dma_handle, unsigned long attrs)
 {
-	sba_unmap_single_attrs(dev, dma_handle, size, 0, 0);
+	sba_unmap_page(dev, dma_handle, size, 0, 0);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -1483,7 +1465,10 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 	/* Fast path single entry scatterlists. */
 	if (nents == 1) {
 		sglist->dma_length = sglist->length;
-		sglist->dma_address = sba_map_single_attrs(dev, sba_sg_address(sglist), sglist->length, dir, attrs);
+		sglist->dma_address = sba_map_page(dev, sg_page(sglist),
+				sglist->offset, sglist->length, dir, attrs);
+		if (dma_mapping_error(dev, sglist->dma_address))
+			return 0;
 		return 1;
 	}
 
@@ -1572,8 +1557,8 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 
 	while (nents && sglist->dma_length) {
 
-		sba_unmap_single_attrs(dev, sglist->dma_address,
-				       sglist->dma_length, dir, attrs);
+		sba_unmap_page(dev, sglist->dma_address, sglist->dma_length,
+			       dir, attrs);
 		sglist = sg_next(sglist);
 		nents--;
 	}
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
