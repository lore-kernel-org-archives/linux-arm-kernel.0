Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B950C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C454A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUgaIBqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C454A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rzL6fOIcDxp19GZCDZEhOUaxv2OFhCdnnqZNwMpY32Q=; b=nUgaIBqwcLeD/Q
	IFdhzxEOPh5+MwS/MyAOjbFrkUozL7ATvnqzalsgTN9AFqxvJkGOJ55NoFjNvqRY4fYMEqOTrmtfd
	Bc43PDC4K6TJoH2wiFKRmraMd63AyIjLLPWDBd/4431q7giMpSOae+MT+l3im7GZVxjPBQezWPgxe
	VEYA2VJyKh+7Y24WczG81E6kVxqwv7NdUwiPCu7/vuax/8c9dT9FtH0I2Sb6zIAerrPhM2QW4pK/i
	U2I7K9hu+g0zDmztiZG3fYltxmD/+oD6o3FNOIPaJUSji8JFw5pvAASWs3ozyiLjUVC9Ya3IyPZ21
	/PZyd/ifPjRLc04cuzVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSjGC-00083t-34; Fri, 30 Nov 2018 13:55:12 +0000
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSilY-0004gK-H6; Fri, 30 Nov 2018 13:23:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 11/23] alpha: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:19 +0100
Message-Id: <20181130132231.16512-12-hch@lst.de>
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

Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/pci_iommu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 46e08e0d9181..e1716e0d92fd 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -291,7 +291,7 @@ pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	   use direct_map above, it now must be considered an error. */
 	if (! alpha_mv.mv_pci_tbi) {
 		printk_once(KERN_WARNING "pci_map_single: no HW sg\n");
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 
 	arena = hose->sg_pci;
@@ -307,7 +307,7 @@ pci_map_single_1(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	if (dma_ofs < 0) {
 		printk(KERN_WARNING "pci_map_single failed: "
 		       "could not allocate dma page tables\n");
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 
 	paddr &= PAGE_MASK;
@@ -455,7 +455,7 @@ static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
 	memset(cpu_addr, 0, size);
 
 	*dma_addrp = pci_map_single_1(pdev, cpu_addr, size, 0);
-	if (*dma_addrp == 0) {
+	if (*dma_addrp == DMA_MAPPING_ERROR) {
 		free_pages((unsigned long)cpu_addr, order);
 		if (alpha_mv.mv_pci_tbi || (gfp & GFP_DMA))
 			return NULL;
@@ -671,7 +671,7 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 		sg->dma_address
 		  = pci_map_single_1(pdev, SG_ENT_VIRT_ADDRESS(sg),
 				     sg->length, dac_allowed);
-		return sg->dma_address != 0;
+		return sg->dma_address != DMA_MAPPING_ERROR;
 	}
 
 	start = sg;
@@ -935,11 +935,6 @@ iommu_unbind(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 	return 0;
 }
 
-static int alpha_pci_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == 0;
-}
-
 const struct dma_map_ops alpha_pci_ops = {
 	.alloc			= alpha_pci_alloc_coherent,
 	.free			= alpha_pci_free_coherent,
@@ -947,7 +942,6 @@ const struct dma_map_ops alpha_pci_ops = {
 	.unmap_page		= alpha_pci_unmap_page,
 	.map_sg			= alpha_pci_map_sg,
 	.unmap_sg		= alpha_pci_unmap_sg,
-	.mapping_error		= alpha_pci_mapping_error,
 	.dma_supported		= alpha_pci_supported,
 };
 EXPORT_SYMBOL(alpha_pci_ops);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
