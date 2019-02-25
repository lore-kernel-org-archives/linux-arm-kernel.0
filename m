Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciQJlCmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wnxGCpjd4l8CX5MxE90sqNpaItMlvUvEtR3imvtdT6Y=; b=ciQJlCmDod2wp3
	q8B1nVBAHJR6tU1Buf43PVskcK3Lz0/+XBXTxo0SaM4L3d6lnGC13o+gui5KjyVaxVkMnpX4SMasc
	UyWvTBJ1RcjpJvkg3yeHbOL1MTjY3NGdmhGladfG5bLPgWbZWb6KEL9IwovtMY9hzomveK3vkRDrB
	u2HhCfrOpo3h5HOPQfr/1AiKLW9avF/88RHmQeUE+77acC1WyD9s7w179JJr0Q658tQchjgDRglVy
	ENW/CkHR/AOqEdg47dh8snJZYrYkTKuTIbRnpzdf6PHAyIAjOBlqdHu+idol6SOfqmQE9qgjLNbuh
	FLd81pwM7UEJ8FXQcv9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHRD-0000Ee-SO; Mon, 25 Feb 2019 14:40:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHRB-0000E0-0D
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:40:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DBA80D;
 Mon, 25 Feb 2019 06:40:56 -0800 (PST)
Received: from [10.163.1.20] (unknown [10.163.1.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAFB63F575;
 Mon, 25 Feb 2019 06:40:53 -0800 (PST)
Subject: Re: [PATCH V2 2/6] arm64/mm: Make pgd_pgtable_alloc() call
 pte_alloc_one() always
To: Mark Rutland <mark.rutland@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-3-git-send-email-anshuman.khandual@arm.com>
 <20190225110813.GC26236@lakrids.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <71571bad-ca3a-bff8-2751-46030ad858e2@arm.com>
Date: Mon, 25 Feb 2019 20:11:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225110813.GC26236@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_064057_057867_AB7F352E 
X-CRM114-Status: GOOD (  23.85  )
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

pgtable_page_ctor/pgtable

On 02/25/2019 04:38 PM, Mark Rutland wrote:
> On Mon, Feb 25, 2019 at 10:33:55AM +0530, Anshuman Khandual wrote:
>> pgd_pgtable_alloc() provides page allocation function while creating all
>> levels of page table (PGD, PUD, CONT PMD etc) for various kernel mappings.
>> It calls __get_free_page() and initializes page with pagetable_page_ctor().
>> pte_alloc_one() already provides a standard interface for allocating a page
>> table page and initializes it with pagetable_page_ctor(). This removes the
>> redundancy and instead make it call pte_alloc_one() directly.
> 
> I see we also have pte_alloc_one_kernel(), which does not call
> pgtable_page_ctor().

We are changing it.

> 
> Was it deliberate that we don't call the ctor on kernel mappings?

Right now parts of the kernel mapping call pgtable_page_ctor() like everything
with __create_pgd_mapping(pgd_pgtabble_alloc,....) but pgtable_page_ctor()
never gets called with pte_alloc_one_kernel() based allocations. This series
is trying to move all possible kernel mappings to use pgtable_page_ctor/pgtable
_page_dtor() constructs.

It makes sense to call pgtable_page_ctor/pgtable_page_dtor for kernel mappings
as it helps put the page in right state PageTable and also account towards zone
statistics (NR_PAGETABLE).

>
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b6f5aa52ac67..2dbd72319152 100644
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
> 
> I'm not sure what this is trying to convey. I guess we also use this for
> creating the EFI mappings?

The argument here will be used to select right GFP flags. With this init_mm
would pick the right one whether its used for init_mm or efi_mm mappings.
Though we still check for both the options while picking up the GFP flags
in one of the later patches.

> 
> No other architecture seems to use pte_alloc_one() for kernel tables,
> and it's not clear to me how the mm argument is intended to be used by
> the implementation.

It selects appropriate GFP flags (with or without __GFP_ACCOUNT). To make
things better will probably pass mm_struct in pgtable_alloc() which is used
with __create_pgd_mappings. Parts of arm64 kernel mappings already use it.
This is just making it uniform across the kernel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
