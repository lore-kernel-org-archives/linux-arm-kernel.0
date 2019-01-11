Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:18:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20AF205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjJpxu4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20AF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xC/D8SfIDPGf3SWbEqB55SsrWOIC7lMr1nJe65D8tFg=; b=hjJpxu4DyYw4GJ
	1oc2VRhryWOGD+AIzLB8GyAKNtt0UWsKSoOUTDEDLmB6K2GP5eCb8JrhBtEfFhJclRKev6XH7e3HI
	loEawgaeMm6Szc9tbHELlJGmtMahvlsCljQbcFt4eZmOK6+d1GrK8Fx/ZuAqHmeIbm6BzNlbcvkp3
	0fsJ/LbZ7D425rYRpfU3a8T42P3O1RzmRGmXm1dghC5D0BVFS2P3+WuNLk1GJOtRre9RtJOtrkFJE
	hyiiNZ20Ijtk1jXMzwZk7SW41xLMND0+gHTpXE+WGG2GPFFbjGzB42JGYl2XzK1vVgqt/N1kNUobK
	n13jgCSIB3rB++hXL0Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1Nr-0001Z0-LY; Fri, 11 Jan 2019 18:18:19 +0000
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1NK-0000zl-Ke; Fri, 11 Jan 2019 18:17:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Fri, 11 Jan 2019 19:17:31 +0100
Message-Id: <20190111181731.11782-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111181731.11782-1-hch@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
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
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

vb2_dc_get_userptr pokes into arm direct mapping details to get the
resemblance of a dma address for a a physical address that does is
not backed by a page struct.  Not only is this not portable to other
architectures with dma direct mapping offsets, but also not to uses
of IOMMUs of any kind.  Switch to the proper dma_map_resource /
dma_unmap_resource interface instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++---------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index aff0ab7bf83d..82389aead6ed 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -439,42 +439,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
 				set_page_dirty_lock(pages[i]);
 		sg_free_table(sgt);
 		kfree(sgt);
+	} else {
+		dma_unmap_resource(buf->dev, buf->dma_addr, buf->size,
+				   buf->dma_dir, 0);
 	}
 	vb2_destroy_framevec(buf->vec);
 	kfree(buf);
 }
 
-/*
- * For some kind of reserved memory there might be no struct page available,
- * so all that can be done to support such 'pages' is to try to convert
- * pfn to dma address or at the last resort just assume that
- * dma address == physical address (like it has been assumed in earlier version
- * of videobuf2-dma-contig
- */
-
-#ifdef __arch_pfn_to_dma
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__arch_pfn_to_dma(dev, pfn);
-}
-#elif defined(__pfn_to_bus)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-#elif defined(__pfn_to_phys)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_phys(pfn);
-}
-#else
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	/* really, we cannot do anything better at this point */
-	return (dma_addr_t)(pfn) << PAGE_SHIFT;
-}
-#endif
-
 static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	unsigned long size, enum dma_data_direction dma_dir)
 {
@@ -528,7 +500,12 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 		for (i = 1; i < n_pages; i++)
 			if (nums[i-1] + 1 != nums[i])
 				goto fail_pfnvec;
-		buf->dma_addr = vb2_dc_pfn_to_dma(buf->dev, nums[0]);
+		buf->dma_addr = dma_map_resource(buf->dev,
+				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
+		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
+			ret = -ENOMEM;
+			goto fail_pfnvec;
+		}
 		goto out;
 	}
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
