Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:45:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5E220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXVvvJ6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5E220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCe/tKIv/qrIK9euwXQnwNHzxLTlbUMUUoDQ6Injci4=; b=bXVvvJ6wihvq2W
	eOApL6JmTiQJYSAI7Xk8bUv3meqaRycNWhyw6pKTPTKb1dGrVvJgnz7QbgIghhKJXtljbb1bgENlx
	uqqkOsp57z9cuZUXI9jvjg5GQN2WxyhqxCZyzmw8P8a0jde1WrCNtCR+8qiFXlVC2L+qzrz8hYzN/
	+GVmtNlzgdKqOLyMUYkFhnt689Ki0tOuvhIy6zlX3tRhONxYb5Ryq+X9vVxO/xM+eLx+5vfL2LU3G
	+1vytLCiJw+6Go8meSJVP49/ZGGRUGb/oYCfndeERH6BkNlGDeThF2LREdqVT3ZdR+a4EY20tSA11
	lls/C9gku0BDmDQORmlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyoU-0002MI-NF; Mon, 14 Jan 2019 09:45:46 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giylW-0006e2-0U; Mon, 14 Jan 2019 09:42:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 12/19] dma-iommu: refactor iommu_dma_free
Date: Mon, 14 Jan 2019 10:41:52 +0100
Message-Id: <20190114094159.27326-13-hch@lst.de>
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

Reorder the checks a bit so that a non-remapped allocation is the
fallthrough case, as this will ease making remapping conditional.
Also get rid of the confusing game with the size and iosize variables
and rename the handle argument to the more standard dma_handle.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 73f76226ff5e..c9788e0c1d5d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1061,34 +1061,36 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
-	size_t iosize = size;
+	struct page *page;
 
-	size = PAGE_ALIGN(size);
 	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
+	 * cpu_addr can be one of 4 things depending on how it was allocated:
+	 *
+	 *  (1) A non-cacheable alias from the atomic pool.
+	 *  (2) A remapped array of pages from iommu_dma_alloc_remap().
+	 *  (3) A remapped contiguous lowmem allocation.
+	 *  (4) A normal lowmem address.
+	 *
 	 * Hence how dodgy the below logic looks...
 	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_free_pool(dev, size, cpu_addr, handle);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		iommu_dma_free_contiguous(dev, iosize,
-				vmalloc_to_page(cpu_addr), handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
-	} else {
-		iommu_dma_free_contiguous(dev, iosize, virt_to_page(cpu_addr),
-				handle);
+	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
+		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
+		return;
 	}
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+			iommu_dma_free_remap(dev, size, cpu_addr, dma_handle);
+			return;
+		}
+		page = vmalloc_to_page(cpu_addr);
+		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
+	} else
+		page = virt_to_page(cpu_addr);
+
+	iommu_dma_free_contiguous(dev, size, page, dma_handle);
 }
 
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
