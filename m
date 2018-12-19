Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D73C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C62214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="In75Cpxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C62214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lkfDMM1+vnrr1BHstRRqe9mn5z12+e0h/VxtC881oQ0=; b=In75CpxzQYk1C4Zk5oQYec7lj
	Imb2VNps9TmRO/v4RrbEEdy3f5KWAVd27cIbIFaXzEyayvXy8x45ZsmJHLan7/m1fle1uDkKRH54f
	uWdH+cirQOsc7Jm48w+J+/R8Q1G9V+T5ghD0efM+VSxhkXx0NKIHKOMH8WuMjTu3oHc1ddiAy++z5
	3a7gh/HbfVYhYQuhfRX8gopJrbPnrx+l57t9q6sZpn/nsFOxjmyDdr+GpAm2lYOMN2MYmzEzleado
	h+otM44mDzFZ0FdrzlG0Wvz0NtBcHqmT1bTjMBnwc2YkSm6WraHzLO2onJtCpSZaJXwtOxGUpg9Ju
	RFfDEqVag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZfBt-0008Cs-Nl; Wed, 19 Dec 2018 16:59:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZfBp-0008CP-Ts
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:59:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F46A78;
 Wed, 19 Dec 2018 08:59:09 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6170F3F675;
 Wed, 19 Dec 2018 08:59:08 -0800 (PST)
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping in
 get_arch_dma_ops
To: Christoph Hellwig <hch@lst.de>, catalin.marinas@arm.com,
 will.deacon@arm.com
References: <20181214150240.26427-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a6c8eff-a5dd-6a17-71ed-f480df3801d8@arm.com>
Date: Wed, 19 Dec 2018 16:59:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214150240.26427-1-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_085921_968889_D04EEE46 
X-CRM114-Status: GOOD (  22.45  )
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
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/12/2018 15:02, Christoph Hellwig wrote:
> Otherwise the direct mapping won't work at all given that a NULL
> dev->dma_ops causes a fallback.  Note that we already explicitly set
> dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
> fallback should not be needed anyway.

Sorry, I'd somehow completely missed that you'd sent a proper patch for 
this - indeed it looks like the right change to make.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm64/include/asm/dma-mapping.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 273e778f7de2..95dbf3ef735a 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -26,11 +26,7 @@
>   
>   static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>   {
> -	/*
> -	 * We expect no ISA devices, and all other DMA masters are expected to
> -	 * have someone call arch_setup_dma_ops at device creation time.
> -	 */
> -	return &dma_dummy_ops;
> +	return NULL;
>   }
>   
>   void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
