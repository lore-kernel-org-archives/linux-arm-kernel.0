Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE5B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MP/ZOPEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE5B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ru2CUfmd99go48ypVXvrMOlovRrTjMvrSqzyVpjKsyI=; b=MP/ZOPEb02D6yyEHHRRM5S2P9
	OqOQnl5WxsWXEiX5tJjY8IkVdkqLDewq1+UI83B1L5HMSMZNBfUhfvjlXGThJuMDIO96hKV8ZmFjj
	vJunTIjdO9hh7Qfyxj2sTbswFxW9rbpaU/0e1TwNF94wWuOpzDFNEraF3OrFU4/vZLD3TRXJ68rqi
	mO2A2s2oREZOkNfYMcDEeyVs0VdrNnT3tm637mENJlpuVHztgoxYw7UKhugnqr2n+wIGBPNzPR3K0
	hPpV/z4s7116V/8CkiskzXO0mYwyCSkfH16l86uAIdcsegz/SUSQDXZnwVsubg6dVG7VyOyvqNKJI
	pyjx7D60Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDlh-0006VF-Q8; Tue, 04 Dec 2018 16:41:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDle-0006I0-2j
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:41:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C8B15BE;
 Tue,  4 Dec 2018 08:41:37 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1DA23F614;
 Tue,  4 Dec 2018 08:41:35 -0800 (PST)
Subject: Re: [PATCH 01/23] dma-mapping: provide a generic DMA_MAPPING_ERROR
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181130132231.16512-1-hch@lst.de>
 <20181130132231.16512-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
Date: Tue, 4 Dec 2018 16:41:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130132231.16512-2-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_084150_130897_F6460A06 
X-CRM114-Status: GOOD (  25.52  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 xen-devel@lists.xenproject.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/11/2018 13:22, Christoph Hellwig wrote:
> Error handling of the dma_map_single and dma_map_page APIs is a little
> problematic at the moment, in that we use different encodings in the
> returned dma_addr_t to indicate an error.  That means we require an
> additional indirect call to figure out if a dma mapping call returned
> an error, and a lot of boilerplate code to implement these semantics.
> 
> Instead return the maximum addressable value as the error.  As long
> as we don't allow mapping single-byte ranges with single-byte alignment
> this value can never be a valid return.  Additionaly if drivers do
> not check the return value from the dma_map* routines this values means
> they will generally not be pointed to actual memory.
> 
> Once the default value is added here we can start removing the
> various mapping_error methods and just rely on this generic check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0f81c713f6e9..46bd612d929e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -133,6 +133,8 @@ struct dma_map_ops {
>   	u64 (*get_required_mask)(struct device *dev);
>   };
>   
> +#define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
> +
>   extern const struct dma_map_ops dma_direct_ops;
>   extern const struct dma_map_ops dma_virt_ops;
>   
> @@ -576,6 +578,10 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
>   	debug_dma_mapping_error(dev, dma_addr);
> +
> +	if (dma_addr == DMA_MAPPING_ERROR)
> +		return 1;
> +
>   	if (ops->mapping_error)
>   		return ops->mapping_error(dev, dma_addr);
>   	return 0;

I'd have been inclined to put the default check here, i.e.

-	return 0
+	return dma_addr == DMA_MAPPING_ERROR

such that the callback retains full precedence and we don't have to deal 
with the non-trivial removals immediately if it comes to it. Not that it 
makes a vast difference though, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
