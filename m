Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68066C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:25:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38787218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XNDHHo+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38787218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hG0t+DfnAdyqu5nxcPQ5heLqBVHcf6CFLl8tJ/7fG98=; b=XNDHHo+CZ6KS8CcbbWmG+NDa/
	jFzpFhI+m5t3Jdm4+u2V9yKydqLlbRnhaE+d+jph675mlnbBJm76jlUjDu69drTsC6pJ+5fLWw5gU
	dFPWVM/KRb3NoVV124C+umEkBV+d/FHXWr+nsMEeceqyTIL21DptV4pkiTPF4P1O5wAtKhxadXZJA
	g+Oo3r27rQByLoct/jxhg9Zgjt4bh7bUBQS1V2ApVg35V2e8QCCJ2iG9BXhr0lEETVK9bN7eD4W0K
	hTcWcAJoi5YVoqR3dqBsfA5o81j+zOgR/GP7Do7NH21aBkiTVyFR72K0+2Fi2H/LaqULpa72/e5Eo
	rMqT+2+Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpagX-0000Qg-Ab; Fri, 01 Feb 2019 15:24:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpagT-0000PQ-RC
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:24:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133CE80D;
 Fri,  1 Feb 2019 07:24:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFAC53F71E;
 Fri,  1 Feb 2019 07:24:46 -0800 (PST)
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
Date: Fri, 1 Feb 2019 15:24:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_072449_892814_629358A5 
X-CRM114-Status: GOOD (  24.91  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Directly iterating over the pages makes the code a bit simpler and
> prepares for the following changes.

It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm 
not really buying the simplification angle - you've *seen* that code, 
right? ;)

If you want simple, get rid of the pages array entirely. However, as 
I've touched on previously, it's all there for a reason, because making 
the individual iommu_map() calls as large as possible gives significant 
performance/power benefits in many cases which I'm not too keen to 
regress. In fact I still have the spark of an idea to sort the filled 
pages array for optimal physical layout, I've just never had the free 
time to play with it. FWIW, since iommu_map_sg() was new and promising 
at the time, using sg_alloc_table_from_pages() actually *was* the 
simplification over copying arch/arm's __iommu_create_mapping() logic.

Robin.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6b43c1..4f5546a103d8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -30,6 +30,7 @@
>   #include <linux/mm.h>
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
> +#include <linux/highmem.h>
>   #include <linux/vmalloc.h>
>   
>   struct iommu_dma_msi_page {
> @@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct page **pages;
> -	struct sg_table sgt;
>   	dma_addr_t iova;
> -	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
> +	size_t mapped = 0;
>   
>   	*handle = DMA_MAPPING_ERROR;
>   
> @@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	if (!iova)
>   		goto out_free_pages;
>   
> -	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> -		goto out_free_iova;
> +	for (i = 0; i < count; i++) {
> +		phys_addr_t phys = page_to_phys(pages[i]);
>   
> -	if (!(prot & IOMMU_CACHE)) {
> -		struct sg_mapping_iter miter;
> -		/*
> -		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
> -		 * sufficient here, so skip it by using the "wrong" direction.
> -		 */
> -		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> -		while (sg_miter_next(&miter))
> -			flush_page(dev, miter.addr, page_to_phys(miter.page));
> -		sg_miter_stop(&miter);
> -	}
> +		if (!(prot & IOMMU_CACHE)) {
> +			void *vaddr = kmap_atomic(pages[i]);
>   
> -	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> -			< size)
> -		goto out_free_sg;
> +			flush_page(dev, vaddr, phys);
> +			kunmap_atomic(vaddr);
> +		}
> +
> +		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
> +			goto out_unmap;
> +		mapped += PAGE_SIZE;
> +	}
>   
>   	*handle = iova;
> -	sg_free_table(&sgt);
>   	return pages;
> -
> -out_free_sg:
> -	sg_free_table(&sgt);
> -out_free_iova:
> +out_unmap:
> +	iommu_unmap(domain, iova, mapped);
>   	iommu_dma_free_iova(cookie, iova, size);
>   out_free_pages:
>   	__iommu_dma_free_pages(pages, count);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
