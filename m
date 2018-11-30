Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D90C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9880B2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ah9lUPLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9880B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jyQPnmyrGXC8Zd1nPdBBVDcNK0dHVcmHAIh1gj9DrXQ=; b=Ah9lUPLzBUUAST
	IqGdOYnpKzufwMNm4vyCyrF5/np6VXIv49V7tVXyLj8vvUH1yYJFoyyIy5tsYFPX7/TyIs3ZpSIKF
	U3GKmTKBK4sKz31r5wIEfzCksq3DQA1B1W4O6ytYuom1QoRy1qLCFbm/jek+EbnHqDCvFOdd4DMqC
	JpXhPFtCevYZ/yjLIVs7xAkynd9wwEdBRfwfS7d+R1TYumAvNegsEOxgFt+jC2fK7lqkHM/Cp0qrI
	BC6mUJDJm5tIhrDKBbRZ8scm+CaOT8y5Id7vYd6eb2mVMw7ibmJ4vzVlz8ODOI97EVwSC1qXqmz1U
	g0Ivlemwkl+TiEOEM9/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSimf-0005hN-Ed; Fri, 30 Nov 2018 13:24:41 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilJ-0004V1-Aj; Fri, 30 Nov 2018 13:23:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/23] s390: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:14 +0100
Message-Id: <20181130132231.16512-7-hch@lst.de>
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

S390 already returns (~(dma_addr_t)0x0) on mapping failures, so we can
switch over to returning DMA_MAPPING_ERROR and let the core dma-mapping
code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/pci/pci_dma.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index d387a0fbdd7e..346ba382193a 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -15,8 +15,6 @@
 #include <linux/pci.h>
 #include <asm/pci_dma.h>
 
-#define S390_MAPPING_ERROR		(~(dma_addr_t) 0x0)
-
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
 static int s390_iommu_strict;
@@ -301,7 +299,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 
 out_error:
 	spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, flags);
-	return S390_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
@@ -349,7 +347,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 	/* This rounds up number of pages based on size and offset */
 	nr_pages = iommu_num_pages(pa, size, PAGE_SIZE);
 	dma_addr = dma_alloc_address(dev, nr_pages);
-	if (dma_addr == S390_MAPPING_ERROR) {
+	if (dma_addr == DMA_MAPPING_ERROR) {
 		ret = -ENOSPC;
 		goto out_err;
 	}
@@ -372,7 +370,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 out_err:
 	zpci_err("map error:\n");
 	zpci_err_dma(ret, pa);
-	return S390_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
@@ -449,7 +447,7 @@ static int __s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int ret;
 
 	dma_addr_base = dma_alloc_address(dev, nr_pages);
-	if (dma_addr_base == S390_MAPPING_ERROR)
+	if (dma_addr_base == DMA_MAPPING_ERROR)
 		return -ENOMEM;
 
 	dma_addr = dma_addr_base;
@@ -496,7 +494,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for (i = 1; i < nr_elements; i++) {
 		s = sg_next(s);
 
-		s->dma_address = S390_MAPPING_ERROR;
+		s->dma_address = DMA_MAPPING_ERROR;
 		s->dma_length = 0;
 
 		if (s->offset || (size & ~PAGE_MASK) ||
@@ -546,11 +544,6 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 	
-static int s390_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == S390_MAPPING_ERROR;
-}
-
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
 	int rc;
@@ -675,7 +668,6 @@ const struct dma_map_ops s390_pci_dma_ops = {
 	.unmap_sg	= s390_dma_unmap_sg,
 	.map_page	= s390_dma_map_pages,
 	.unmap_page	= s390_dma_unmap_pages,
-	.mapping_error	= s390_mapping_error,
 	/* dma_supported is unconditionally true without a callback */
 };
 EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
