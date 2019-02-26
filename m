Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A19C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1C42147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m2FhL0qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1C42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fywd0/9zJYw3YkHLVc/+JcgCVQSwxY/rqcMLhe/+C9Q=; b=m2FhL0qf+d5Leb
	H6DzG5r1bwKRrDd3WfhPY/lhQPbcgGCfgFT69Yutgf5bYXekuMZhWmIC8JE964uSvpXIMzS0/Xwg8
	j3847wa6idaeXmvIawxi7lcu8rD3khWdkdg9vxTK+mJPCRmIcAJ08wv5ApWHQwg3QD16BxM/yByyt
	r6NwJk/X9cPyQy4lQZEh2B6NPCcXbh3caWLf6g61OAqkjo7nTLPzifqHocGAZpQ+AApA0ixDkXuD3
	PPrl21ONEtIRxrYsuHZRab+BHKx7XgefEKlcFLEL7+8zk9nXKZzjA1ZEBg3JJDZlcXz3HNSbSwSzm
	phGCfl6FNIFrtGr0WFlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyUwU-0002S5-KA; Tue, 26 Feb 2019 05:06:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyUwO-0002RT-Mh
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 05:06:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8321DA78;
 Mon, 25 Feb 2019 21:05:58 -0800 (PST)
Received: from [10.162.40.137] (p8cg001049571a15.blr.arm.com [10.162.40.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EB06A3F71D; Mon, 25 Feb 2019 21:05:55 -0800 (PST)
Subject: Re: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for
 user space
To: Mark Rutland <mark.rutland@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
 <20190225111108.GD26236@lakrids.cambridge.arm.com>
 <d6c62e0d-f890-a60d-517c-c0ba1e56e48c@arm.com>
 <20190225153553.GI26236@lakrids.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <27de9775-1ff9-01a1-6bf4-b6a912fc2440@arm.com>
Date: Tue, 26 Feb 2019 10:36:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225153553.GI26236@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_210604_748628_0639BF50 
X-CRM114-Status: GOOD (  18.00  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/25/2019 09:05 PM, Mark Rutland wrote:
> On Mon, Feb 25, 2019 at 08:19:53PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 02/25/2019 04:41 PM, Mark Rutland wrote:
>>> On Mon, Feb 25, 2019 at 10:33:58AM +0530, Anshuman Khandual wrote:
>>>> Page table pages created for user space processes must be accounted against
>>>> their memory control groups if initialized. This just introduces a helper
>>>> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
>>>> table page allocations but adds __GFP_ACCOUNT for user page table pages.
>>>
>>> Can't we have pte_alloc_one_kernel() and pte_alloc_one() explicitly pass
>>> the GFP flags down to a __pte_alloc_one() helper, and consistently use
>>> pte_alloc_one_kernel() for kernel mappings?
>>>
>>> That would seem less surprising than hiding that detail in another
>>> function.
>>
>> Yes that will work as well. But its better to have this mm_struct based GFP switch
>> which is used in other archs as well to create generic MM helper functions going
>> forward.
> 
> I don't follow -- if we can make pte_alloc_one() generic, then we can
> *also* make pte_alloc_one_kernel() generic.

Right but when we do mm_struct can be used to decide applicable GFP for
the allocation. The way your proposal defers is that it wants to have
the GFP flag unique for both pte_alloc_one and pte_alloc_one_kernel
without looking into mm_struct which will work as well.

> 
> Looking at x86, I see:
> 
> pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> {
>         return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
> }
> 
> ... which arhitectures do you see which look at the mm struct to decide
> the flags?
> 

On powerpc its an explicit helper function

arch/powerpc/include/asm/pgalloc.h (pgtable_gfp_flags)

On X86 its not an explicit helper function but we can see

arch/x86/include/asm/pgalloc.h

static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
{
        struct page *page;
        gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;

        if (mm == &init_mm)
                gfp &= ~__GFP_ACCOUNT;
        page = alloc_pages(gfp, 0);
        if (!page)
                return NULL;
        if (!pgtable_pmd_page_ctor(page)) {
                __free_pages(page, 0);
                return NULL;
        }
        return (pmd_t *)page_address(page);
}

static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
{
        gfp_t gfp = GFP_KERNEL_ACCOUNT;

        if (mm == &init_mm)
                gfp &= ~__GFP_ACCOUNT;
        return (pud_t *)get_zeroed_page(gfp);
}

static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
{
        gfp_t gfp = GFP_KERNEL_ACCOUNT;

        if (mm == &init_mm)
                gfp &= ~__GFP_ACCOUNT;
        return (p4d_t *)get_zeroed_page(gfp);
}

There are some more places on powerpc and x86 where it does the switch. But you
are right, pte_alloc_one_kernel() does not go through ctor functions on other
archs. But it should and this series changes it. Do you see any concerns in
doing so ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
