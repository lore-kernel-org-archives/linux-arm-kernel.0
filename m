Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799DC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CE3217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z15AuiG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CE3217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rVtiAtUwV66Tte8ApUpRyFQChjFn+tx7Z20QPdb06hI=; b=Z15AuiG90Vz1pt0+woS60fiUy
	6N/6nm14QaMNwmcvHP1a818UAQOqEXlXCVbmFcs0welCSXiqyU6Vdj/LmDu2pEsZHie2MLSRp+50W
	JzYz7u1EODuCXK+dPcqLIIIZLWBkgCPUCC0FxFEc/wRCQdOR/ekidUCmSzUjHpIdEAgcekGkxnrj1
	uBUMmsSJI79Xfg1qfPady5Imnnf/qcMRI9g0yJ1Cj/BXJ2ug67pUgIV/hrXuHjQhmnYtQlrwAiDwJ
	TZjQ+P1iszCuDXw5YRXNnV9M+PsBkvV2uMtTa+u2wV/6x5U8rDsQoEt/EuCmqMcO07r5/+7c+lKCl
	xvphFREYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2F7-0003z7-FE; Tue, 05 Feb 2019 15:02:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2F1-0003yU-7w
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:02:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2984280D;
 Tue,  5 Feb 2019 07:02:26 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855823F557;
 Tue,  5 Feb 2019 07:02:24 -0800 (PST)
Subject: Re: [PATCH 06/19] dma-iommu: fix and refactor iommu_dma_mmap
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-7-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
Date: Tue, 5 Feb 2019 15:02:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-7-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_070227_292542_1E9E7248 
X-CRM114-Status: GOOD (  30.03  )
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
> The current iommu_dma_mmap code does not properly handle memory from the
> page allocator that hasn't been remapped, which can happen in the rare
> case of allocations for a coherent device that aren't allowed to block.
> 
> Fix this by replacing iommu_dma_mmap with a slightly tweaked copy of
> dma_common_mmap with special handling for the remapped array of
> pages allocated from __iommu_dma_alloc.

If there's an actual bugfix here, can we make that before all of the 
other code movement? If it's at all related to other reports of weird 
mmap behaviour it might warrant backporting, and either way I'm finding 
it needlessly tough to follow what's going on in this patch :(

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 59 +++++++++++++++------------------------
>   1 file changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e0ffe22775ac..26f479d49103 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -592,23 +592,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   }
>   
>   /**
> - * __iommu_dma_mmap - Map a buffer into provided user VMA
> - * @pages: Array representing buffer from __iommu_dma_alloc()
> + * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
> + * @cpu_addr: virtual address of the memory to be remapped
>    * @size: Size of buffer in bytes
>    * @vma: VMA describing requested userspace mapping
>    *
> - * Maps the pages of the buffer in @pages into @vma. The caller is responsible
> + * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
>    * for verifying the correct size and protection of @vma beforehand.
>    */
> -static int __iommu_dma_mmap(struct page **pages, size_t size,
> +static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>   		struct vm_area_struct *vma)
>   {
> +	struct vm_struct *area = find_vm_area(cpu_addr);
>   	unsigned long uaddr = vma->vm_start;
>   	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int ret = -ENXIO;
>   
> +	if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +
>   	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		ret = vm_insert_page(vma, uaddr, area->pages[i]);
>   		if (ret)
>   			break;
>   		uaddr += PAGE_SIZE;
> @@ -1047,29 +1051,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	}
>   }
>   
> -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = vma_pages(vma);
> -	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -
> -	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> -				      vma->vm_end - vma->vm_start,
> -				      vma->vm_page_prot);
> -	}
> -
> -	return ret;
> -}
> -
>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
> -	struct vm_struct *area;
> +	unsigned long user_count = vma_pages(vma);
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
> +	unsigned long pfn;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1077,20 +1066,18 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> -
> -	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> +	if (off >= count || user_count > count - off)
>   		return -ENXIO;
>   
> -	return __iommu_dma_mmap(area->pages, size, vma);
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +			return iommu_dma_mmap_remap(cpu_addr, size, vma);
> +		pfn = vmalloc_to_pfn(cpu_addr);
> +	} else
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
> +
> +	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> +			user_count << PAGE_SHIFT, vma->vm_page_prot);
>   }
>   
>   static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
