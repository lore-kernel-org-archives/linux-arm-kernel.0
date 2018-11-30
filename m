Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C0C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B013B20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VhV+YrJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B013B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q/qbC3cZKFYhesfTlM0Y+YNpBOjx89bH4wMJyZEAb7w=; b=VhV+YrJQDuPIEGCt1nYvaLKAY
	MO7+P7IFW4ovo3oVqrJ043qTl08b6zJGAlBk6lansYLhYPwROSjq6PB9Na6kSRsSmNRJ7zOZo60b8
	vDVy3yCEd6q5ie2LIjPEwk7ytcGLVvChEgbjGdpwv5F43tP0Aiu9lzaHTrtpjvXsk68PCsfJUDH3j
	Sbaozac3MHICDsTUs+/8wa1OE6RiEHUnOHoRFs27xNz+H6mnVDRTM/KJ4glCDfZYoBrPOtfcJ9KPZ
	wbz3Yy9sogJgigC7QOsFT+wA1Gj/xXpi71TYFJQPmcAXrAvo4NmtXHn2jjRdO/1Sk00bnsxW683p4
	wiJRMYYwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo6A-0001nu-5I; Fri, 30 Nov 2018 19:05:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo5w-0001Kl-Cu
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:04:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B611165C;
 Fri, 30 Nov 2018 11:04:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AFA3F575;
 Fri, 30 Nov 2018 11:04:42 -0800 (PST)
Subject: Re: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
Date: Fri, 30 Nov 2018 19:04:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-2-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_110456_449655_D239A7D8 
X-CRM114-Status: GOOD (  23.36  )
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
> Some architectures support remapping highmem into DMA coherent
> allocations.  To use the common code for them we need variants of
> dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.

FWIW it's as much about non-cacheable remapping of lowmem as it is about 
highmem. Regardless, the diff looks OK to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h |  3 +++
>   kernel/dma/direct.c        | 32 ++++++++++++++++++++++----------
>   2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index bd73e7a91410..5a7a3bbb912f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -67,6 +67,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
>   void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs);
> +struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> +void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
>   dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, enum dma_data_direction dir,
>   		unsigned long attrs);
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 22a12ab5a5e9..680287779b0a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -103,14 +103,13 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
>   }
>   
> -void *dma_direct_alloc_pages(struct device *dev, size_t size,
> +struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int page_order = get_order(size);
>   	struct page *page = NULL;
>   	u64 phys_mask;
> -	void *ret;
>   
>   	if (attrs & DMA_ATTR_NO_WARN)
>   		gfp |= __GFP_NOWARN;
> @@ -150,11 +149,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	return page;
> +}
> +
> +void *dma_direct_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +{
> +	struct page *page;
> +	void *ret;
> +
> +	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
>   	if (!page)
>   		return NULL;
> +
>   	ret = page_address(page);
>   	if (force_dma_unencrypted()) {
> -		set_memory_decrypted((unsigned long)ret, 1 << page_order);
> +		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>   		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>   	} else {
>   		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> @@ -163,20 +173,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	return ret;
>   }
>   
> -/*
> - * NOTE: this function must never look at the dma_addr argument, because we want
> - * to be able to use it as a helper for iommu implementations as well.
> - */
> +void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
> +{
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	if (!dma_release_from_contiguous(dev, page, count))
> +		__free_pages(page, get_order(size));
> +}
> +
>   void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs)
>   {
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned int page_order = get_order(size);
>   
>   	if (force_dma_unencrypted())
>   		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
> -	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
> -		free_pages((unsigned long)cpu_addr, page_order);
> +	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
>   }
>   
>   void *dma_direct_alloc(struct device *dev, size_t size,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
