From: james.morse@arm.com (James Morse)
Date: Mon, 20 Feb 2017 11:10:10 +0000
Subject: [PATCH v2] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <148734678579.30076.8827985106565313944@sboyd-linaro>
References: <20170217011959.26754-1-stephen.boyd@linaro.org>
 <58A6D7D7.1030704@arm.com>
 <148734678579.30076.8827985106565313944@sboyd-linaro>
Message-ID: <58AACE92.4040608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 17/02/17 15:53, Stephen Boyd wrote:
> Quoting James Morse (2017-02-17 03:00:39)
>> On 17/02/17 01:19, Stephen Boyd wrote:
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 156169c6981b..8bd4e7f11c70 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -177,9 +193,19 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>>>        * No handler, we'll have to terminate things with extreme prejudice.
>>>        */
>>>       bust_spinlocks(1);
>>> -     pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
>>> -              (addr < PAGE_SIZE) ? "NULL pointer dereference" :
>>> -              "paging request", addr);
>>> +
>>> +     if (is_permission_fault(esr, regs)) {
>>
>> is_permission_fault() was previously guarded with a 'addr<USER_DS' check, this
>> is because it assumes software-PAN is relevant.
>>
>> The corner case is when the kernel accesses TTBR1-mapped memory while
>> software-PAN happens to have swivelled TTBR0. Translation faults will be matched
>> by is_permission_fault(), but permission faults won't.
> 
> If I understand correctly, and I most definitely don't because there are
> quite a few combinations, you're saying that __do_kernel_fault() could
> be called if the kernel attempts to access some userspace address with
> software PAN? That won't be caught in do_page_fault() with the previous
> is_permission_fault() check?

You're right the user-address side of things will get caught in do_page_fault().
I was trying to badly-explain 'is_permission_fault(esr)' isn't as general
purpose as its name and prototype suggest, it only gives the results that the
PAN checks expect when called with a user address.


>> Juggling is_permission_fault() to look something like:
>> ---%<---
>>         if (fsc_type == ESR_ELx_FSC_PERM)
>>                 return true;
>>
>>         if (addr < USER_DS && system_uses_ttbr0_pan())
>>                 return fsc_type == ESR_ELx_FSC_FAULT &&
>>                         (regs->pstate & PSR_PAN_BIT);
>>
>>         return false;
>> ---%<---
>> ... should fix this.
> 
> But we don't need to check ec anymore?

Sorry, I was being sloppy, something like the above could replace the if/else
block at the end of is_permission_fault(). You're right we still need the ec check!


Thanks,

James
