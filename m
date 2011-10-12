From: gdavis@mvista.com (George G. Davis)
Date: Tue, 11 Oct 2011 22:34:17 -0400
Subject: [RFC/PATCH 3/7] ARM: ARM11 MPCore: {clean,
	flush}_pmd_entry are not preempt safe
In-Reply-To: <20111011095314.GA23848@arm.com>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-4-git-send-email-gdavis@mvista.com>
	<20111011095314.GA23848@arm.com>
Message-ID: <6EB957F5-6E89-43F3-BAF3-A9E007BD896F@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 11, 2011, at 5:53 AM, Catalin Marinas wrote:

> On Fri, Oct 07, 2011 at 03:38:37AM +0100, gdavis at mvista.com wrote:
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 594d677..3c8253f 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -567,12 +567,24 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
>> 		if (addr & SECTION_SIZE)
>> 			pmd++;
>> 
>> +		if (cache_ops_need_broadcast())
>> +			preempt_disable();
>> 		do {
>> 			*pmd = __pmd(phys | type->prot_sect);
>> 			phys += SECTION_SIZE;
>> 		} while (pmd++, addr += SECTION_SIZE, addr != end);
>> 
>> +		/* FIXME: Multiple PMD entries may be written above
>> +		 * but only one cache line, up to 8 PMDs depending
>> +		 * on the alignment of this mapping, is flushed below.
>> +		 * IFF this mapping spans >8MiB, then only the first
>> +		 * 8MiB worth of entries will be flushed.  Entries
>> +		 * above the 8MiB limit will not be flushed if I
>> +		 * read this correctly.
>> +		 */
>> 		flush_pmd_entry(p);
>> +		if (cache_ops_need_broadcast())
>> +			preempt_enable();
> 
> My reading of the create_mapping() code is that alloc_init_pud() and
> alloc_init_section() are called with a 2MB range only (that's 2
> entries) given by pgd_addr_end().

You're correct of course.  I initially stuck that FIXME note in there more as
a reminder to review it more carefully.  Alas, in my haste, I submitted as-is
w/o checking parameter bounds passed from callers which do as you
say, so it's never more than 2MiB in size.  Thanks for the feedback.
I'll remove that note.

--
Regards,
George

> 
> -- 
> Catalin
