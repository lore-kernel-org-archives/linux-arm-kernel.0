Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A8A20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WHSjMHKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pbRFG3QzGvxn+tKQv17VFETj7H4wvg+PcaI0ggYj++0=; b=WHSjMHKwRPV2Xl
	ycYGhoc31TXZ8Qh60V7xliSA2lagatUuPRIUe++zvzeNlJ7OCdimKDDLTrbQ5OqU5uwusdzgCucTn
	C+D40LPBCAUksYY74r6HfDdluUjmDj6azuTUPopphUjOXf+hCP1uYgs4/Ww4UztRH/LPU1Gc7LTvj
	bE0JIX33djzudRUSCsThRTCTbV5Xp6eq/E2+1vu8SwDP2hA9cggLV51VIHcz7XyYQ1e7HRZQwlTEA
	vEHcGtyXkUMshzhqAMYr0luqiJcgYZoh21CesJa40OuOEs8mJ6KKice95BikxdvFsSy53NCb8tmb5
	38WBvccxULLMyvhp9rYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giypP-00038a-8U; Mon, 14 Jan 2019 09:46:43 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giylf-0006n7-LE; Mon, 14 Jan 2019 09:42:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 15/19] dma-iommu: refactor iommu_dma_alloc
Date: Mon, 14 Jan 2019 10:41:55 +0100
Message-Id: <20190114094159.27326-16-hch@lst.de>
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

Split all functionality related to non-coherent devices into a
separate helper, and make the decision flow more obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 956cb218c6ba..fd25c995bde4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -760,6 +760,22 @@ static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
 	return vaddr;
 }
 
+static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	/*
+	 * In atomic context we can't remap anything, so we'll only get the
+	 * virtually contiguous buffer we need by way of a physically
+	 * contiguous allocation.
+	 */
+	if (!gfpflags_allow_blocking(gfp))
+		return iommu_dma_alloc_pool(dev, size, dma_handle, gfp, attrs);
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
+		return iommu_dma_alloc_contiguous_remap(dev, size, dma_handle,
+				gfp, attrs);
+	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1033,40 +1049,23 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool coherent = dev_is_dma_coherent(dev);
-	size_t iosize = size;
-	void *addr;
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (!gfpflags_allow_blocking(gfp)) {
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (!coherent)
-			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
-					attrs);
-		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
+	if (!dev_is_dma_coherent(dev))
+		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		if (coherent)
-			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
-					gfp, attrs);
-		else
-			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
-					handle, gfp, attrs);
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
-	}
-	return addr;
+
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+
+	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
