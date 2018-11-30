Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38ABC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB220673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cRw5ITtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YK5CyZpru//506dkEDzNUYVS1F4MIKzUquukRc9UNoc=; b=cRw5ITttPgNNhne/Zq5fyixN/
	kFHbZHEfGDPeLboUbUdwJ0XnaHpxUQJsSSKgCm6q+d7pseF2qqEKwn6XsCkMIyJfjHPKnpb+AvaWG
	Qfld7UQwkHmsQgDdmLlrtrG2uGuPdPl+Nyujfyv0xW79i1ADcCJDtoeeeL2Tzel+yd3zGRv+DZhjq
	LQq6W3obiAaU1ZK19E8MJdZk8XYvRm6C+EzW9Y/uTG8pkSjHQYT6GVPW1xDuUlazkRY7GWEq5tdgW
	0P3nRV7D7RYqMUrJTQ2MKB2wozvUSBxW9CUlC6vKaWWstDCP7TxtZvsiG2W+Ob+mLovTv9NT02k27
	SPt6gNGKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo5z-0001MQ-Hb; Fri, 30 Nov 2018 19:04:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo5w-0001L9-Kt
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:04:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925231682;
 Fri, 30 Nov 2018 11:04:54 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D683F575;
 Fri, 30 Nov 2018 11:04:52 -0800 (PST)
Subject: Re: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
Date: Fri, 30 Nov 2018 19:04:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-3-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_110456_745727_CD97986A 
X-CRM114-Status: GOOD (  21.29  )
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
> dma_alloc_from_contiguous can return highmem pages depending on the
> setup, which a plain non-remapping DMA allocator can't handle.  Detect
> this case and try the normal page allocator instead.

...except the actual implementation is "Detect this case and fail the 
entire allocation if so".

Again, the diff itself makes sense, so given an accurate commit message,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 680287779b0a..c49849bcced6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> +	if (PageHighMem(page)) {
> +		/*
> +		 * Depending on the cma= arguments and per-arch setup
> +		 * dma_alloc_from_contiguous could return highmem pages.
> +		 * Without remapping there is no way to return them here,
> +		 * so log an error and fail.
> +		 */
> +		dev_info(dev, "Rejecting highmem page from CMA.\n");
> +		__dma_direct_free_pages(dev, size, page);
> +		return NULL;
> +	}
> +
>   	ret = page_address(page);
>   	if (force_dma_unencrypted()) {
>   		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
