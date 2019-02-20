Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C199C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:28:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D3B2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C7am53Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D3B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZPQy5lSuiWOqI7UEm3vRyb+len3RSOyP/nvJhZlm9JQ=; b=C7am53WfmK/bTc
	ayOlfu5sJcnCVwbWpzPyicgbmOJbKeAFHCCLo4E4SopHIpndcYrYYvBFp8nZ4PCaNoxyp+Q9i1mTm
	oP/ALINhbq0Cjo9Th8eC6lEh75xo8iqoFie6MBbFQBSdQZXKfKwfD+U6yv7eG1EKf/usV6xb8Mp7Y
	E91Nbxd4e8SrHvUTCMk2GqWW04WY7QuzaIxVx92ChSyqAZatccI8ztozJXvPjLKCoU6327my4XlnG
	EZh1bp84CsoxzyOoI8dPY3adrhLs0KpXDx6gTP/8i6yhFMSPj1MLlm4EaeNikqUi1X6mT4kdP9sIE
	prYvwRKRGuePQ4XdV/LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwP6k-0003ef-Rk; Wed, 20 Feb 2019 10:28:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwP6h-0003eJ-KO
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 10:28:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD738A78;
 Wed, 20 Feb 2019 02:28:02 -0800 (PST)
Received: from [10.162.40.115] (p8cg001049571a15.blr.arm.com [10.162.40.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 CE5DD3F575; Wed, 20 Feb 2019 02:27:56 -0800 (PST)
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
To: Yu Zhao <yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190219222828.GA68281@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
Date: Wed, 20 Feb 2019 15:57:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190219222828.GA68281@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_022803_683963_68C6E3E0 
X-CRM114-Status: GOOD (  30.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/20/2019 03:58 AM, Yu Zhao wrote:
> On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
>> + Matthew Wilcox
>>
>> On 02/19/2019 11:02 AM, Yu Zhao wrote:
>>> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
>>>>> For pte page, use pgtable_page_ctor(); for pmd page, use
>>>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
>>>>> p4d and pgd), don't use any.
>>>> pgtable_page_ctor()/dtor() is not optional for any level page table page
>>>> as it determines the struct page state and zone statistics.
>>>
>>> This is not true. pgtable_page_ctor() is only meant for user pte
>>> page. The name isn't perfect (we named it this way before we had
>>> split pmd page table lock, and never bothered to change it).
>>>
>>> The commit cccd843f54be ("mm: mark pages in use for page tables")
>>> clearly states so:
>>>   Note that only pages currently accounted as NR_PAGETABLES are
>>>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
>>
>> I think the commit is the following one and it does say so. But what is
>> the rationale of tagging only PTE page as PageTable and updating the zone
>> stat but not doing so for higher level page table pages ? Are not they
>> used as page table pages ? Should not they count towards NR_PAGETABLE ?
>>
>> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> 
> Well, I was just trying to clarify how the ctor is meant to be used.
> The rational behind it is probably another topic.
> 
> For starters, the number of pmd/pud/p4d/pgd is at least two orders
> of magnitude less than the number of pte, which makes them almost
> negligible. And some archs use kmem for them, so it's infeasible to
> SetPageTable on or account them in the way the ctor does on those
> archs.
> 

I understand the kmem cases which are definitely problematic and should
be fixed. IIRC there is a mechanism to custom init pages allocated for
slab cache with a ctor function which in turn can call pgtable_page_ctor().
But destructor helper support for slab has been dropped I guess.


> But, as I said, it's not something can't be changed. It's just not
> the concern of this patch.

Using pgtable_pmd_page_ctor() during PMD level pgtable page allocation
as suggested in the patch breaks pmd_alloc_one() changes as per the
previous proposal. Hence we all would need some agreement here.

https://www.spinics.net/lists/arm-kernel/msg701960.html

We can still accommodate the split PMD ptlock feature in pmd_alloc_one().
A possible solution can be like this above and over the previous series.

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..c02abb2a69f7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
        select ACPI_SPCR_TABLE if ACPI
        select ACPI_PPTT if ACPI
        select ARCH_CLOCKSOURCE_DATA
+       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if HAVE_ARCH_TRANSPARENT_HUGEPAGE
        select ARCH_HAS_DEBUG_VIRTUAL
        select ARCH_HAS_DEVMEM_IS_ALLOWED
        select ARCH_HAS_DMA_COHERENT_TO_PFN
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index a02a4d1d967d..258e09fb3ce2 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -37,13 +37,29 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pte);
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-       return (pmd_t *)pte_alloc_one_virt(mm);
+       pgtable_t ptr;
+
+       ptr = pte_alloc_one(mm);
+       if (!ptr)
+               return 0;
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && USE_SPLIT_PMD_PTLOCKS
+       ptr->pmd_huge_pte = NULL;
+#endif
+       return (pmd_t *)page_to_virt(ptr);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
+       struct page *page;
+
        BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
-       pte_free(mm, virt_to_page(pmdp));
+       page = virt_to_page(pmdp);
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && USE_SPLIT_PMD_PTLOCKS
+       VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+#endif
+       pte_free(mm, page);
 }


> 
>>>
>>> I'm sure if we go back further, we can find similar stories: we
>>> don't set PageTable on page tables other than pte; and we don't
>>> account page tables other than pte. I don't have any objection if
>>> you want change these two. But please make sure they are consistent
>>> across all archs.
>>
>> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
>> for generalization which has been already acknowledged earlier. But for now we
>> can atleast fix this on arm64.
>>
>> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/
> 
> This is again not true. Please stop making claims not backed up by
> facts. And the link is completely irrelevant to the ctor.
> 
> I just checked *all* arches. Only four arches call the ctor outside
> pte_alloc_one(). They are arm, arm64, ppc and s390. The last two do
> so not because they want to SetPageTable on or account pmd/pud/p4d/
> pgd, but because they have to work around something, as arm/arm64
> do.

That reaffirms the fact that pgtable_page_ctor()/dtor() are getting used
not in a consistent manner.

> 
>>
>>>
>>>> We should not skip it for any page table page.
>>>
>>> In fact, calling it on pmd/pud/p4d is peculiar, and may even be
>>> considered wrong. AFAIK, no other arch does so.
>>
>> Why would it be considered wrong ? IIUC archs have their own understanding
>> of this and there are different implementations. But doing something for
>> PTE page and skipping for others is plain inconsistent.
> 
> Allocating memory that will never be used is wrong. Please look into
> the ctor and find out what exactly it does under different configs.

Are you referring to ptlock_init() --> ptlock_alloc() triggered spinlock_t
allocations with USE_SPLIT_PTE_PTLOCKS and ALLOC_SPLIT_PTLOCKS.

> 
> And why I said "may"? Because we know there is only negligible number
> of pmd/pud/p4d, so the memory allocated may be considered negligible
> as well.

Okay.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
