Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA92C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C53B2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wy+BbBxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C53B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5rsZum6dGVVJujQZjTu324e3SuzJ9EQcNbsjM9IVx98=; b=Wy+BbBxFBj1ZEB
	onUia/zb6YbceOAT7pCQL2ML/hEV47MaBy6pNWPdi2CY+7tKH47zi9TxyDyDcJnwDXT0gO2REZrJU
	SsJcGd3b813kRbVcubHVOpwQTPQquUBsNL5zo7ZCqTiGcQRcPHh9v58XEzna2v/FMWt2IcrE+BIOM
	h9R0mz2QPEiPS0yPX8vELKw4JM4B4dbOX1PyOIXCaIzeT29xlL0xlPmot+ZNLrnQ5aH4Nn+JTtWMK
	/Zw7pRUzpl82YOrSUfS+dYJ8o9gAGmAlt9Cb8wZYDN6bChlNIF9t4bm50PHOmd46qUZhS4cIA1OJs
	+6SvjuSeIkpr3aqUlPWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSefX-0003Go-1f; Fri, 30 Nov 2018 09:01:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSefU-0003FO-69
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:01:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C899415AB;
 Fri, 30 Nov 2018 01:00:49 -0800 (PST)
Received: from [10.1.29.146] (e121487-lin.cambridge.arm.com [10.1.29.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A3E3F5A0;
 Fri, 30 Nov 2018 01:00:48 -0800 (PST)
Subject: Re: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
To: Nathan Jones <nathanj439@gmail.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
 <CACTmSTzQeJiR8S57zYcu+YWbnMdo9Eb9Bei4gfmHyFOrzoWiZw@mail.gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <984681e6-738b-a93b-5f4e-87970a2fe50d@arm.com>
Date: Fri, 30 Nov 2018 09:00:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACTmSTzQeJiR8S57zYcu+YWbnMdo9Eb9Bei4gfmHyFOrzoWiZw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_010100_228192_516EC6AE 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/29/18 2:58 PM, Nathan Jones wrote:
> On Thu, Nov 29, 2018 at 4:51 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> On 11/28/18 6:59 PM, Nathan Jones wrote:
>>> If neither of the if() statements fire then the return value is
>>> uninitialized. In the worst case it returns 0 which means the caller
>>> will think the function succeeded.
>>
>> "ret" is updated indirectly via:
>>
>>         if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>>                 return ret;
>>
>> I assume that it was found with static analyzer or like this, in such case
>> please, provide output produced by the tool.
> 
> No, I had some bad code which was passing a wrong length and receiving the
> strange error code.

Sorry for dragging you into that. If you put statement above into commit log,
feel free to add

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir

> 
>>
>>>
>>> Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
>>
>> I'll leave it up to Russell.
>>
>> Cheers
>> Vladimir
>>
>>> Signed-off-by: Nathan Jones <nathanj439@gmail.com>
>>> ---
>>>  arch/arm/mm/dma-mapping.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>> index 661fe48ab78d..78de138aa66d 100644
>>> --- a/arch/arm/mm/dma-mapping.c
>>> +++ b/arch/arm/mm/dma-mapping.c
>>> @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>>                void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>>                unsigned long attrs)
>>>  {
>>> -     int ret;
>>> +     int ret = -ENXIO;
>>>       unsigned long nr_vma_pages = vma_pages(vma);
>>>       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>       unsigned long pfn = dma_to_pfn(dev, dma_addr);
>>>
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
