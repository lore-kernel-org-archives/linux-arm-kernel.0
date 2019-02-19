Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF250C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4CA20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZkYF9dCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4CA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uwByU8rdRRt+isZj1LZXpvD2ni1pzHslJo0T3NH0kiQ=; b=ZkYF9dCmEf3PuB
	5SmivL3D04A+zU1RaPo6wBwanr4NmRV4NcWDdUEGjMu2D6+IwwaLVfqTZL5nvtdDCFDUjrLe7ElKr
	IgCQWjkMFYQVayyqw407iKrKjxUR8Gz5msIiE+NPjHjcWBUgr8xukaoGYOx/opf0nTIAIzDkmMMk1
	5Ksivcupy6U28pS29C7xErzhBU2Y0GS9OsF8CK2CZAlSECe/N0OvnUF9hLRLbcGmD+/31NnAaOQcK
	NH28L2mT5OmMyHLg17NNOHFcRufJRW9yzZ6lb+d1T0I/inCEfz9FKIQmK2+c4uT6uILN5niV88CVs
	qSGuzd7KNVtiyT8VyODw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvx73-0004pn-Hv; Tue, 19 Feb 2019 04:34:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvx6y-0004p7-Rw
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 04:34:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB5B80D;
 Mon, 18 Feb 2019 20:34:25 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4F0EE3F675; Mon, 18 Feb 2019 20:34:23 -0800 (PST)
Subject: Re: [PATCH 5/6] arm64/mm: Call pgtable_page_dtor() for both PMD and
 PUD page table pages
To: Will Deacon <will.deacon@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-6-git-send-email-anshuman.khandual@arm.com>
 <20190214171108.GE2475@fuggles.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <21438e45-b05d-4dc1-45e5-8e45919e6930@arm.com>
Date: Tue, 19 Feb 2019 10:04:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214171108.GE2475@fuggles.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_203429_734023_DD6CE0F6 
X-CRM114-Status: GOOD (  16.36  )
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
> On Thu, Jan 24, 2019 at 10:50:19AM +0530, Anshuman Khandual wrote:
>> TLB flush during PMD and PUD level page table page tear down currently does
>> not call pgtable_page_dtor() like that for PTE page table pages. Now that
>> all the page table pages which are allocated from the buddy allocator must
>> have been initialized through pgtable_page_ctor() they must be freed back
>> only after being called into pgtable_page_dtor() destructor. Else these
>> pages might run into bad page state errors while getting freed into buddy
>> allocator.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/tlb.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index 106fdc9..de46ba0 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -62,6 +62,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>>  static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>>  				  unsigned long addr)
>>  {
>> +	pgtable_page_dtor(virt_to_page(pmdp));
>>  	tlb_remove_table(tlb, virt_to_page(pmdp));
>>  }
>>  #endif
>> @@ -70,6 +71,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>>  				  unsigned long addr)
>>  {
>> +	pgtable_page_dtor(virt_to_page(pudp));
>>  	tlb_remove_table(tlb, virt_to_page(pudp));
> 
> This would be cleaner if you assigned to a temporary struct page * variable.
> With that:

Sure will do.

> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
