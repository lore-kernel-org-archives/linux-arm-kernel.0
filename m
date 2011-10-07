From: gdavis@mvista.com (George G. Davis)
Date: Fri, 7 Oct 2011 11:31:52 -0400
Subject: [RFC/PATCH 2/7] ARM: ARM11 MPCore: pte_alloc_one{,
	_kernel} are not preempt safe
In-Reply-To: <20111007074707.GD21464@n2100.arm.linux.org.uk>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-3-git-send-email-gdavis@mvista.com>
	<20111007074707.GD21464@n2100.arm.linux.org.uk>
Message-ID: <EC59DFB6-B2AB-4A52-9019-CC8CFCFB360F@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 7, 2011, at 3:47 AM, Russell King - ARM Linux wrote:

> On Thu, Oct 06, 2011 at 10:38:36PM -0400, gdavis at mvista.com wrote:
>> -#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
>> +#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT)
>> @@ -81,8 +88,14 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
>> 	pte = alloc_pages(PGALLOC_GFP, 0);
>> #endif
>> 	if (pte) {
>> +		void *p = page_address(pte);
>> +		if (cache_ops_need_broadcast())
>> +			preempt_disable();
>> +		memset(p, 0, PAGE_SIZE);
>> 		if (!PageHighMem(pte))
>> -			clean_pte_table(page_address(pte));
>> +			clean_pte_table(p);
>> +		if (cache_ops_need_broadcast())
>> +			preempt_enable();
> 
> This won't work - page_address(pte) will be NULL for highmem pages, and
> so will cause an oops, and removing the __GFP_ZERO will mean that highmem
> pages will not be zeroed, meaning that such page tables will not have been
> initialized.

Yep, I had a feeling that it was not going to work correctly for the HIGHMEM case.
Alas, I'm not using HIGHMEM so I did not see the issue in my testing.  I'll respin it to fix
HIGHMEM breakage.

Thanks!

--
Regards,
George
