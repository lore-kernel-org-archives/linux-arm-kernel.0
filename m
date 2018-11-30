Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF92C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:31:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9516D20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kd+OiXlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9516D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N4XBl+B4vaq7aRbRp+F2AjKYIUWTrYtWm3yK0ZmlYqo=; b=kd+OiXlgGOTNYQ
	1/ksiPCHIe3Ezt8yVGxmSPN1KuGYQgCZKrR7Y1B4FC9eIQLMbI0BvkFcOigjCSNe7nrVdBZRdazfi
	NTLBcyTTB8J504hH017Gkh7EMRQg6hfMBHpZX7EjuOiOo7LX9bAqLgoleAnMi0E+QhH7PwFq8Or2l
	Pe6wERSp1dseKZPaYsbGltDm4ibMtBhVrLOZMRf8wwWJl5WPxg7AI7tm+jhrqfu+gMqA9KQOuMNey
	p1RLH2/Y2I69wYR0WIg+wp1I27OXyDsqQG+6eX4gyvMONdjaR4BRfASFKn+ZoUZ3jf4wrsJ4HAj4p
	bnnz0E7EuqXUnF7acETg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSit9-0005Wg-V8; Fri, 30 Nov 2018 13:31:23 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSim5-00058s-DF; Fri, 30 Nov 2018 13:24:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 22/23] dma-mapping: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:30 +0100
Message-Id: <20181130132231.16512-23-hch@lst.de>
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

No users left except for vmd which just forwards it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/vmd.c | 6 ------
 include/linux/dma-mapping.h  | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e50b0b5815ff..98ce79eac128 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -394,11 +394,6 @@ static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	vmd_dma_ops(dev)->sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
 }
 
-static int vmd_mapping_error(struct device *dev, dma_addr_t addr)
-{
-	return vmd_dma_ops(dev)->mapping_error(to_vmd_dev(dev), addr);
-}
-
 static int vmd_dma_supported(struct device *dev, u64 mask)
 {
 	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
@@ -446,7 +441,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
 	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
 	add_dma_domain(domain);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 46bd612d929e..2adef56c6069 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -128,7 +128,6 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
 			enum dma_data_direction direction);
-	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 };
@@ -575,15 +574,9 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 	debug_dma_mapping_error(dev, dma_addr);
-
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return 1;
-
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
 	return 0;
 }
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
