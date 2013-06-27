From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Jun 2013 15:54:20 -0500
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <51C48B5A.2040404@ti.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
Message-ID: <51CCA67C.2010803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:20 PM, Santosh Shilimkar wrote:
> On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
>> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
>>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
>>> index 0a2c68f..62e2e8f 100644
>>> --- a/arch/microblaze/kernel/prom.c
>>> +++ b/arch/microblaze/kernel/prom.c
>>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>>>  }
>>>  
>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>> -		unsigned long end)
>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>  {
>>>  	initrd_start = (unsigned long)__va(start);
>>>  	initrd_end = (unsigned long)__va(end);
>>
>> I think it would better to go here for phys_addr_t instead of u64. This
>> would force you in of_flat_dt_match() to check if the value passed from
>> DT specifies a memory address outside of 32bit address space and the
>> kernel can't deal with this because its phys_addr_t is 32bit only due
>> to a Kconfig switch.
>>
>> For x86, the initrd has to remain in the 32bit address space so passing
>> the initrd in the upper range would violate the ABI. Not sure if this
>> is true for other archs as well (ARM obviously not).
>>
> That pretty much means phys_addr_t. It will work for me as well but
> in last thread from consistency with memory and reserved node, Rob
> insisted to keep it as u64. So before I re-spin another version,
> would like to here what Rob has to say considering the x86 requirement.
> 
> Rob,
> Are you ok with phys_addr_t since your concern was about rest
> of the memory specific bits of the device-tree code use u64 ?

No. I still think it should be u64 for same reasons I said originally.

Rob
