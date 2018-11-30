Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942BF20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="un2TUGtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942BF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x3U2HxHBMFXz1CMUHVwveusPjCfWamwonN5+1L/wLZE=; b=un2TUGtYRy3CPlC/6kjIWEA1D
	T4zs1QOfx72em9jtpqCctzYVFqfATRxYUarwB4HS60x1N8BFJziapsNxfv/Tz5b84lDsEOa9LSNBc
	fWNNCl/Fs25lx7uHlEhVO0Xst9b3ShfMrlSw+B/jqJokzxrsZ/87H5BGpQao+gYugj+xBVbdcripk
	VKZ7zoNFvjb/kmtFKxaOiED/jSI+7FJSvUxuDCBpJaXCdXlpN5faX2ZOQA+7S1378t8gIgd2ELhWE
	fdAEJci5FTDd6whSE0vGhdCRlJV1L7FSoJPLFBgwODLf6arf8S0dcIPYSYTZF940SNqY1XkvwT7Wn
	tNiaQ1wow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo7Y-0003Uv-8V; Fri, 30 Nov 2018 19:06:36 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo6k-00035m-Bu
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:05:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EE1C165C;
 Fri, 30 Nov 2018 11:05:36 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4F63F575;
 Fri, 30 Nov 2018 11:05:34 -0800 (PST)
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-6-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Date: Fri, 30 Nov 2018 19:05:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-6-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_110546_482260_E8D2AB99 
X-CRM114-Status: GOOD (  21.36  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> By using __dma_direct_alloc_pages we can deal entirely with struct page
> instead of having to derive a kernel virtual address.

Simple enough :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/remap.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index bc42766f52df..8f1fca34b894 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t flags, unsigned long attrs)
>   {
>   	struct page *page = NULL;
> -	void *ret, *kaddr;
> +	void *ret;
>   
>   	size = PAGE_ALIGN(size);
>   
> @@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		return ret;
>   	}
>   
> -	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> -	if (!kaddr)
> +	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!page)
>   		return NULL;
> -	page = virt_to_page(kaddr);
>   
>   	/* remove any dirty cache lines on the kernel alias */
>   	arch_dma_prep_coherent(page, size);
> @@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
>   			__builtin_return_address(0));
>   	if (!ret)
> -		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	return ret;
>   }
>   
> @@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
>   	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> -		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +		phys_addr_t phys = dma_to_phys(dev, dma_handle);
> +		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>   
>   		vunmap(vaddr);
> -		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	}
>   }
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
