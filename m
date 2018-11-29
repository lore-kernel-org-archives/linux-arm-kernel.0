Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F7C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740CA20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NyrPH5pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740CA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6pr4ZbTJ95bkYohO5UuGZKpZGYoaGHBtX+pHNw0zUDw=; b=NyrPH5pgVUd5c2OY8t+oqrGMl
	9FKnnDUQ5496TXXC1d+GMGZKdPXSft3kdXfDYXknP01dryocLIKXZPQ04JQcO1Zvgi+ek4mYD/tSL
	ONzF3u7xqSCnjMfrDCuDUWZQ8pW5Qo1PSdj+oFNXagu6Ue4EuaMGT22cYPEckJ9E1AGNv3BlFLePI
	F9skc6KIzckw2FcUKOSaKswx3nMHiLFTjSGR9lNAKHayHdWIOjpzq8nuP3tlHckYTOM1GdITnDMK/
	bseHZb5dwns8v0SfPYGSoArsxc/ZVdJPgo3x5WZ3LbKmqMqX1sDxDIlCBDLKak+HgE0zBj0iT9f1c
	qnAfo4mMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSO4f-0000Oh-1o; Thu, 29 Nov 2018 15:17:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSO4b-0000Nh-BV
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:17:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C20F80D;
 Thu, 29 Nov 2018 07:17:38 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 927C13F59C;
 Thu, 29 Nov 2018 07:17:37 -0800 (PST)
Subject: Re: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
To: Nathan Jones <nathanj439@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <652b58e8-f003-310a-c3f2-55d54c4041d0@arm.com>
Date: Thu, 29 Nov 2018 15:17:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128185910.5778-1-nathanj439@gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_071749_407831_27F6891B 
X-CRM114-Status: GOOD (  22.92  )
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
Cc: vladimir.murzin@arm.com, linux@armlinux.org.uk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/11/2018 18:59, Nathan Jones wrote:
> If neither of the if() statements fire then the return value is
> uninitialized. In the worst case it returns 0 which means the caller
> will think the function succeeded.

Looking at the referenced commit, the original initialisation of ret 
must have actually belonged to the MMU code anyway, since all the NOMMU 
path did was overwrite it unconditionally. Thus the patch itself and the 
fixes tag both look like the right thing to do.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
> Signed-off-by: Nathan Jones <nathanj439@gmail.com>
> ---
>   arch/arm/mm/dma-mapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48ab78d..78de138aa66d 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		 unsigned long attrs)
>   {
> -	int ret;
> +	int ret = -ENXIO;
>   	unsigned long nr_vma_pages = vma_pages(vma);
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned long pfn = dma_to_pfn(dev, dma_addr);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
