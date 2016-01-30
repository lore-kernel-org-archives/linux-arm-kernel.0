From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri, 29 Jan 2016 19:13:14 -0600
Subject: [PATCH v2] irqchip: gicv3-its: Fix memory leak in
 its_free_tables()
In-Reply-To: <alpine.DEB.2.11.1601290930000.3886@nanos>
References: <1454042578-13933-1-git-send-email-shankerd@codeaurora.org>
 <alpine.DEB.2.11.1601290930000.3886@nanos>
Message-ID: <56AC0E2A.1090402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/29/2016 02:30 AM, Thomas Gleixner wrote:
> On Thu, 28 Jan 2016, Shanker Donthineni wrote:
>> @@ -807,9 +810,10 @@ static void its_free_tables(struct its_node *its)
>>   	int i;
>>   
>>   	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
>> -		if (its->tables[i]) {
>> -			free_page((unsigned long)its->tables[i]);
>> -			its->tables[i] = NULL;
>> +		if (its->tables[i].base) {
>> +			free_pages((unsigned long)its->tables[i].base,
>> +				   get_order(its->tables[i].size));
>> +			its->tables[i].base = NULL;
>>   		}
>>   	}
>>   }
>> @@ -880,6 +884,7 @@ retry_alloc_baser:
>>   		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>>   			alloc_pages = GITS_BASER_PAGES_MAX;
>>   			order = get_order(GITS_BASER_PAGES_MAX * psz);
>> +			alloc_size = (1 << order) * PAGE_SIZE;
> Why don't you record the order instead of converting back and forth ?
I can use page order information to fix memory leak and I will post v3 
patch with your suggestion.


We have another coding BUG which is related to not refreshing alloc_size 
whenever order changes.
Because we are not updating alloc_size variable here, later part of the 
code logic uses incorrect
alloc_size value in two places as shown below.

Code snippet-1:

             if (!shr) {
                 cache = GITS_BASER_nC;
                 __flush_dcache_area(base, alloc_size);
             }

Code snippet-2:

         pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
             (int)(alloc_size / entry_size),
             its_base_type_string[type],
             (unsigned long)virt_to_phys(base),
             psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);


How do you suggest I fix the second problem? Should I create another 
patch or include in v3 patch?

> Thanks,
>
> 	tglx
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
