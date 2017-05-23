From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 23 May 2017 16:43:50 +0100
Subject: [PATCH v3 2/6] mm,
 gup: Ensure real head page is ref-counted when using hugepages
In-Reply-To: <20170523131312.aim6obne2t5sxtdr@node.shutemov.name> (Kirill
 A. Shutemov's message of "Tue, 23 May 2017 16:13:12 +0300")
References: <20170522133604.11392-1-punit.agrawal@arm.com>
 <20170522133604.11392-3-punit.agrawal@arm.com>
 <20170523131312.aim6obne2t5sxtdr@node.shutemov.name>
Message-ID: <874lwbh93d.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, May 22, 2017 at 02:36:00PM +0100, Punit Agrawal wrote:
>> When speculatively taking references to a hugepage using
>> page_cache_add_speculative() in gup_huge_pmd(), it is assumed that the
>> page returned by pmd_page() is the head page. Although normally true,
>> this assumption doesn't hold when the hugepage comprises of successive
>> page table entries such as when using contiguous bit on arm64 at PTE or
>> PMD levels.
>> 
>> This can be addressed by ensuring that the page passed to
>> page_cache_add_speculative() is the real head or by de-referencing the
>> head page within the function.
>> 
>> We take the first approach to keep the usage pattern aligned with
>> page_cache_get_speculative() where users already pass the appropriate
>> page, i.e., the de-referenced head.
>> 
>> Apply the same logic to fix gup_huge_[pud|pgd]() as well.
>
> Hm. Okay. But I'm kinda surprise that this is the only place that need to
> be adjusted.
>
> Have you validated all other pmd_page() use-cases?

I came across the gup issues were found while investigating a failing
test from mce-tests.

I think the problem here is not due to the use of pmd_page() but because
page_cache_[add|get]_speculative() don't ensure they ref-count the head
page as is done in get_page().

Having said that, I had a quick look at the other uses of pmd_page() -

Quite a few of them are followed by an explicit BUG_ON() to check that
the page returned is a head page. All other instances seem to be dealing
with transparent hugepages where contiguous hugepages are not supported.

I don't see any call sites that ring alarm bells.

Did you have any particular part of the code in mind where pmd_page()
usage might be a problem?

Thanks,
Punit
