Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A06C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:39:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8E521B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3e9jUlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8E521B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a5D7yfbg8TOIDzJLDcq2t0qeh3AnAArT7ZSGUG/RIO8=; b=S3e9jUlf2R2zbY
	3pgVEZqIjn93pvbi6DG1RBxVsz1VJJOmTVZrMd/Y50sSyp+FEc34KU7hPDzWTe1H4Y7Ll4TlnmshN
	/hg7zkIuASL+Ei54eWxTp2lChG3B7X5SMF+/n+cTpujRLYQhEkvPFWXvOKb1qrdnzp7o9Dzs8ed8W
	pkj6ZMvxeygpQ3zpXuhJS75U585dzyTLmLqeU6afleM/PG2Vy+6Imo7QV67JqTqOGCaSYi9tedTjg
	hZEg/9KTmPPtorTOPZmRaR+Tjtuy2W9LvwDor/HqDt7/GY6F58V+HWD/Yd6W5sCsT6lHYC+e6k7Re
	i6JUKF9Elx+ABw+ivqiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBoJ-0003Qj-8i; Mon, 11 Feb 2019 13:39:47 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBlA-0000WC-MV; Mon, 11 Feb 2019 13:36:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 12/12] dma-mapping: remove dma_assign_coherent_memory
Date: Mon, 11 Feb 2019 14:35:54 +0100
Message-Id: <20190211133554.30055-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The only useful bit in this function was the already assigned check.
Once that is moved to dma_init_coherent_memory thee rest can easily
be handled in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 47 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d7a27008f228..1e3ce71cd993 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -41,6 +41,9 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
 
+	if (*mem)
+		return -EBUSY;
+
 	if (!size) {
 		ret = -EINVAL;
 		goto out;
@@ -88,33 +91,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 	kfree(mem);
 }
 
-static int dma_assign_coherent_memory(struct device *dev,
-				      struct dma_coherent_mem *mem)
-{
-	if (!dev)
-		return -ENODEV;
-
-	if (dev->dma_mem)
-		return -EBUSY;
-
-	dev->dma_mem = mem;
-	return 0;
-}
-
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-	struct dma_coherent_mem *mem;
-	int ret;
-
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
-
-	ret = dma_assign_coherent_memory(dev, mem);
-	if (ret)
-		dma_release_coherent_memory(mem);
-	return ret;
+	return dma_init_coherent_memory(phys_addr, device_addr, size,
+					&dev->dma_mem);
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
 
@@ -238,18 +219,18 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 	int ret;
 
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+			&mem);
+	if (ret && ret != -EBUSY) {
+		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
+			&rmem->base, (unsigned long)rmem->size / SZ_1M);
+		return ret;
 	}
+
 	mem->use_dev_dma_pfn_offset = true;
+	if (dev)
+		dev->dma_mem = mem;
 	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
