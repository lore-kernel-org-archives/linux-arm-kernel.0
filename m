From: cpandya@codeaurora.org (Chintan Pandya)
Date: Fri, 27 Apr 2018 17:22:28 +0530
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180427073719.GT15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
Message-ID: <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/27/2018 1:07 PM, joro at 8bytes.org wrote:
> On Thu, Apr 26, 2018 at 10:30:14PM +0000, Kani, Toshi wrote:
>> Thanks for the clarification. After reading through SDM one more time, I
>> agree that we need a TLB purge here. Here is my current understanding.
>>
>>   - INVLPG purges both TLB and paging-structure caches. So, PMD cache was
>> purged once.
>>   - However, processor may cache this PMD entry later in speculation
>> since it has p-bit set. (This is where my misunderstanding was.
>> Speculation is not allowed to access a target address, but it may still
>> cache this PMD entry.)
>>   - A single INVLPG on each processor purges this PMD cache. It does not
>> need a range purge (which was already done).
>>
>> Does it sound right to you?
> 
> The right fix is to first synchronize the changes when the PMD/PUD is
> cleared and then flush the TLB system-wide. After that is done you can
> free the page.
> 

I'm bit confused here. Are you pointing to race within ioremap/vmalloc
framework while updating the page table or race during tlb ops. Since
later is arch dependent, I would not comment. But if the race being 
discussed here while altering page tables, I'm not on the same page.

Current ioremap/vmalloc framework works with reserved virtual area for 
its own purpose. Within this virtual area, we maintain mutual 
exclusiveness by maintaining separate rbtree which is of course 
synchronized. In the __vunmap leg, we perform page table ops first and
then release the virtual area for someone else to re-use. This way, 
without taking any additional locks for page table modifications, we are
good.

If that's not the case and I'm missing something here.

Also, I'm curious to know what race you are observing at your end.


Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
