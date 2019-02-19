Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98438C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:33:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4EC20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XyOz3oo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4EC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qqeNBuZQ8yL9xgMXxSTrtA9xL7Y/kppVF6iO8Xl44jc=; b=XyOz3oo5/Y3sy0
	nD4XaimbIOHV2UBQ4ZrCEMosq2hU9wtIIyFtcSliMvp/NFCDswv4PHbh+xY92sIlaHsl2cHD7yZe1
	Nnce78u9w7Z7NAYTVHaefDrr9c3cgM4ZG2zjtoC7t0XDGcJz3sWU8PnIG27Ptj4tZBdeXVp5/ShCh
	p26M6UKZxzjBOosEQ7ZDtkElYeMDJdJhZUHexCjP6i7vYJrtakFoheKxSOjLl7msf4ALkC/GhYqJg
	CzlajILGVxVvPTpWE9y1Eyh9sNYYQdfg6nAiGraFAg4EXAvcVemfLfzmFVslhK7Ma0YVrIbZL5pbX
	duzCjpBB+b/rtZQwOqFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvx6M-0004YW-RG; Tue, 19 Feb 2019 04:33:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvx6G-0004Xr-S7
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 04:33:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AAD80D;
 Mon, 18 Feb 2019 20:33:28 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 CE1F73F675; Mon, 18 Feb 2019 20:33:25 -0800 (PST)
Subject: Re: [PATCH 3/6] arm64/mm: Make pgd_pgtable_alloc() call
 pte_alloc_one() always
To: Will Deacon <will.deacon@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-4-git-send-email-anshuman.khandual@arm.com>
 <20190214171101.GD2475@fuggles.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <442e5831-0347-647f-c66e-b42dc1f485b5@arm.com>
Date: Tue, 19 Feb 2019 10:03:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214171101.GD2475@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_203347_597377_EA07B0DE 
X-CRM114-Status: GOOD (  20.82  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/14/2019 10:41 PM, Will Deacon wrote:
> On Thu, Jan 24, 2019 at 10:50:17AM +0530, Anshuman Khandual wrote:
>> pgd_pgtable_alloc() provides page allocation function while creating all
>> levels of page table (e.g PGD, PUD, CONT PMD) for various kernel mappings.
>> It calls __get_free_page() and initializes page with pagetable_page_ctor().
>> pte_alloc_one() already provides a standard interface for allocating a page
>> table page and initializes it with pagetable_page_ctor(). This removes the
>> redundancy and instead make it call pte_alloc_one() directly.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b6f5aa5..2dbd723 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -372,13 +372,22 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>>  
>>  static phys_addr_t pgd_pgtable_alloc(void)
>>  {
>> -	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
>> -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>> -		BUG();
>> +
>> +	pgtable_t ptr;
>> +
>> +	/*
>> +	 * pgd_pgtable_alloc() is called while creating kernel mappings
>> +	 * through __create_pgd_mapping() might not install it through
>> +	 * swapper_pg_dir (&init_mm). Even then init_mm is passed here
>> +	 * just to indicate that the allocation is kernel specific not
>> +	 * for the user space page tables.
>> +	 */
>> +	ptr = pte_alloc_one(&init_mm);
>> +	BUG_ON(!ptr);
>>  
>>  	/* Ensure the zeroed page is visible to the page table walker */
>>  	dsb(ishst);
>> -	return __pa(ptr);
>> +	return page_to_phys(ptr);
> 
> Are you sure this is safe? afaict, this code is used to set up the linear
> mapping which happens before the mem_map is initialised. I don't think
> page_to_phys() can be used at this point. What am I missing?

We are calling into buddy allocator to get a page before coming here. So
mem_map is definitely initialized. There is again early_pgtable_alloc()
used for __create_pgd_mapping() which allocates page from memblock when
buddy has not been initialized.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
