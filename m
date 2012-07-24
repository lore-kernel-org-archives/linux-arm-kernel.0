From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 06:52:14 -0400
Subject: [RFC 02/23] ARM: LPAE: use signed arithmetic for mask definitions
In-Reply-To: <20120724100511.GE20132@arm.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-3-git-send-email-cyril@ti.com>
 <20120724100511.GE20132@arm.com>
Message-ID: <500E7E5E.1030005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2012 6:05 AM, Catalin Marinas wrote:
> On Tue, Jul 24, 2012 at 02:09:04AM +0100, Cyril Chemparathy wrote:
>> This patch applies to PAGE_MASK, PMD_MASK, and PGDIR_MASK, where forcing
>> unsigned long math truncates the mask at the 32-bits.  This clearly does bad
>> things on PAE systems.
>>
>> This patch fixes this problem by defining these masks as signed quantities.
>> We then rely on sign extension to do the right thing.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> ---
>>   arch/arm/include/asm/page.h           |    7 ++++++-
>>   arch/arm/include/asm/pgtable-3level.h |    6 +++---
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
>> index ecf9019..1c810d2 100644
>> --- a/arch/arm/include/asm/page.h
>> +++ b/arch/arm/include/asm/page.h
>> @@ -13,7 +13,12 @@
>>   /* PAGE_SHIFT determines the page size */
>>   #define PAGE_SHIFT		12
>>   #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
>> -#define PAGE_MASK		(~(PAGE_SIZE-1))
>> +
>> +/*
>> + * We do not use PAGE_SIZE in the following because we rely on sign
>> + * extension to appropriately extend upper bits for PAE systems
>> + */
>> +#define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
>
> Would it work if we use a 1ULL here and avoid the sign trick? I'm
> worried about some context where this would lose the sign. We could have
> an #ifdef here while the PGDIR/PMD masks are in a separate file already.
>

Sure, I will modify accordingly in the next version.

-- 
Thanks
- Cyril
