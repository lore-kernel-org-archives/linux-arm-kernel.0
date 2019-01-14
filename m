Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63356C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3281720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GRYEN0wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3281720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EtCbzW9pJAm/ai9GpBSOm7Q71JH9P/RoZpmc0ZsQI4=; b=GRYEN0wfC4g2Gl
	gKaPQOOWDFqUjG3gz4e1x8dgsbN67p4VoQWUwp9ZL602K3HSz5OpEJiM8Sghw9DUs5KqwTvaonlje
	CJrDpH+kD7isC9l3mHINxBnleS6PgygU9iutPJT8GmM8ECoBblQZHeqVjnMNJHiBVfrqb5nDJ5ujG
	7gZGnaPTXrab0wgVxMQO4xQ3Ar59MD8URTzU3fwo/9kDMx/cj1Yk3/2eN+kUqPMWYkJISULxkB7IW
	Tta0vZfL7qldD+dEzTVOSXzPNxKVmzzh9tH7Bo1bEkInX3Dpu3EBZZMDTwZKysISJXoJmWE4jhWi0
	vXF7mh1OrdDcceU1JKpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giymA-0007GX-3a; Mon, 14 Jan 2019 09:43:22 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyl5-0006Dy-Jr; Mon, 14 Jan 2019 09:42:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 04/19] dma-iommu: remove the flush_page callback
Date: Mon, 14 Jan 2019 10:41:44 +0100
Message-Id: <20190114094159.27326-5-hch@lst.de>
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

We now have a arch_dma_prep_coherent architecture hook that is used
for the generic DMA remap allocator, and we should use the same
interface for the dma-iommu code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c |  8 +-------
 drivers/iommu/dma-iommu.c   | 14 ++++----------
 include/linux/dma-iommu.h   |  3 +--
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index fb0908456a1f..75fe7273a1e4 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -104,12 +104,6 @@ arch_initcall(arm64_dma_init);
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
-/* Thankfully, all cache ops are by VA so we can ignore phys here */
-static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
-{
-	__dma_flush_area(virt, PAGE_SIZE);
-}
-
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
 				 unsigned long attrs)
@@ -186,7 +180,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 
 		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle, flush_page);
+					handle);
 		if (!pages)
 			return NULL;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4f5546a103d8..d6a437385b26 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
@@ -533,8 +534,6 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * @attrs: DMA attributes for this allocation
  * @prot: IOMMU mapping flags
  * @handle: Out argument for allocated DMA handle
- * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
- *		given VA/PA are visible to the given non-coherent device.
  *
  * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
  * but an IOMMU which supports smaller pages might not map the whole thing.
@@ -543,8 +542,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle,
-		void (*flush_page)(struct device *, const void *, phys_addr_t))
+		unsigned long attrs, int prot, dma_addr_t *handle)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -580,12 +578,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	for (i = 0; i < count; i++) {
 		phys_addr_t phys = page_to_phys(pages[i]);
 
-		if (!(prot & IOMMU_CACHE)) {
-			void *vaddr = kmap_atomic(pages[i]);
-
-			flush_page(dev, vaddr, phys);
-			kunmap_atomic(vaddr);
-		}
+		if (!(prot & IOMMU_CACHE))
+			arch_dma_prep_coherent(pages[i], PAGE_SIZE);
 
 		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
 			goto out_unmap;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 65aa888c2768..59e606f78626 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -43,8 +43,7 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle,
-		void (*flush_page)(struct device *, const void *, phys_addr_t));
+		unsigned long attrs, int prot, dma_addr_t *handle);
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
