Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B8E20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xi88lPtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B8E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TrDh/lGMjHxs+XOov597e9CYE4QKqisQMOY2ivg6b14=; b=Xi88lPtFg+kzh7+CP1AfyceL7
	9eJOuf+1e7vzU+Cnpktf5oyCBIQXOwLVHkY+WTahjnuXaBCJD++DIFqErESN6dYeCsC7Ilq6oSbfh
	F89eCFgKwy3oHo5E2NSS87EUC7rKA7REsPJPRH60sMI2+ZwbPdmr1HZDeUJHnyEebhHpdCyBsRxZH
	CDcghHqEiyIlv21L2HV7XSN9kpH/sWT3pk1C5GLOv9uuWvCYbu6chmeRV37MuJg1CCpl2Ql0MmREQ
	tc8d1Hx5H1x5BBDy9o/ifAdvBmHsx8DhyDPtkL3AZN9KeB4hfXaKtt55kBMiHoVQ/c4QvNG2EYEzj
	cI8wi6G5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo7k-0003j2-Me; Fri, 30 Nov 2018 19:06:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo6k-000376-Bc
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:05:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860A61684;
 Fri, 30 Nov 2018 11:05:43 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27EFC3F575;
 Fri, 30 Nov 2018 11:05:42 -0800 (PST)
Subject: Re: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-7-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e993440c-53bf-8071-b1b6-06d022d39e4e@arm.com>
Date: Fri, 30 Nov 2018 19:05:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-7-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_110546_479135_4AB55001 
X-CRM114-Status: GOOD (  23.17  )
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
> Do not waste vmalloc space on allocations that do not require a mapping
> into the kernel address space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/remap.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 8f1fca34b894..10a545126b0b 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   
>   	size = PAGE_ALIGN(size);
>   
> -	if (!gfpflags_allow_blocking(flags)) {
> +	if (!gfpflags_allow_blocking(flags) &&
> +	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
>   		ret = dma_alloc_from_pool(size, &page, flags);
>   		if (!ret)
>   			return NULL;
> @@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   	/* remove any dirty cache lines on the kernel alias */
>   	arch_dma_prep_coherent(page, size);
>   
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +		return page; /* opaqueue cookie */

Best to preempt the inevitable patch fixing that typo in 3 months' time. 
Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
>   	/* create a coherent mapping */
>   	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
>   			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> @@ -227,7 +231,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
> -	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
> +		/* vaddr is a struct page cookie, not a kernel address */
> +		__dma_direct_free_pages(dev, size, vaddr);
> +	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
>   		phys_addr_t phys = dma_to_phys(dev, dma_handle);
>   		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
