Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FB920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GpyGQzSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FB920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0rU5BpjrdvlDGTso9KHQeymYhqq8EjfWciRn0ERrl5c=; b=GpyGQzSObP4t4sN1SuOtE04yj
	Ya63dymmcdlZdhm/5XwRnjJLKUVNUQt479cSnyBN5ni8KPVko4mAaz7cdDck7L7psjGmqJUixkki6
	z9rKX8qaM9F024L3VunUvH0ubR06dGDGibEnop9m4RcxwEEmb7JemWjVDGhSMW64pByUxslJJuIle
	rYA34XSH8lwOmnYDe2f/l3O+6yEGMh7gSZVQ0KW16FpflUbfpxBK2HoMA25esgu3kdvbUIymjYwLZ
	lY8BNT7tgR4+zNnc1tGrkKgZ1JAheWGBEbYlNJwMeLu0F1h/kFwJ6j5oBsQd5Jr3od047hzPo43DP
	ODpKH2dpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj32t-0003ID-9V; Mon, 14 Jan 2019 14:16:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj32q-0003Ho-HC
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 14:16:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA66A78;
 Mon, 14 Jan 2019 06:16:49 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3DB3F5AF;
 Mon, 14 Jan 2019 06:16:47 -0800 (PST)
Subject: Re: [PATCH 2/3] dma-mapping: don't BUG when calling dma_map_resource
 on RAM
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8f9e4f0-87fc-9f4f-37ea-39297acc8d31@arm.com>
Date: Mon, 14 Jan 2019 14:16:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111181731.11782-3-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_061652_575344_C363E4A5 
X-CRM114-Status: GOOD (  20.86  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/01/2019 18:17, Christoph Hellwig wrote:
> Use WARN_ON_ONCE to print a stack trace and return a proper error
> code instead.

I was racking my brain to remember the reasoning behind BUG_ON() being 
the only viable way to prevent errors getting through unhandled, but of 
course that was before we had a standardised DMA_MAPPING_ERROR that 
would work across all implementations.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d3087829a6df..91add0751aa5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -353,7 +353,8 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
>   	BUG_ON(!valid_dma_direction(dir));
>   
>   	/* Don't allow RAM to be mapped */

Ugh, I'm pretty sure that that "pfn_valid means RAM" misunderstanding 
originally came from me - it might be nice to have a less-misleading 
comment here, but off-hand I can't think of a succinct way to say "only 
for 'DMA' access to MMIO registers/SRAMs/etc. and not for anything the 
kernel knows as actual system/device memory" to better explain the WARN...

Either way, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> -	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
> +	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> +		return DMA_MAPPING_ERROR;
>   
>   	if (dma_is_direct(ops))
>   		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
