From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 10:04:24 -0400
Subject: [PATCH 6/8] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <51EFC37B.80906@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
 <1371858502-10083-7-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1307231850350.15022@syhkavp.arg> <51EF356D.2050902@ti.com>
 <alpine.LFD.2.03.1307232222200.15022@syhkavp.arg> <51EFBF8F.4010201@ti.com>
 <51EFC37B.80906@ti.com>
Message-ID: <51EFDEE8.5050205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 July 2013 08:07 AM, Sricharan R wrote:
> On Wednesday 24 July 2013 05:20 PM, Sricharan R wrote:
>> On Wednesday 24 July 2013 08:19 AM, Nicolas Pitre wrote:
>>> On Tue, 23 Jul 2013, Santosh Shilimkar wrote:
>>>
>>>> On Tuesday 23 July 2013 09:10 PM, Nicolas Pitre wrote:
>>>>> On Fri, 21 Jun 2013, Santosh Shilimkar wrote:
>>>>>
>>>>>> From: Sricharan R <r.sricharan@ti.com>
>>>>>>
>>>>>> The current phys_to_virt patching mechanism does not work
>>>>>> for 64 bit physical addressesp. Note that constant used in add/sub
>>>>>> instructions is encoded in to the last 8 bits of the opcode. So shift
>>>>>> the _pv_offset constant by 24 to get it in to the correct place.
>>>>>>
>>>>>> The v2p patching mechanism patches the higher 32bits of physical
>>>>>> address with a constant. While this is correct, in those platforms
>>>>>> where the lowmem addressable physical memory spawns across 4GB boundary,
>>>>>> a carry bit can be produced as a result of addition of lower 32bits.
>>>>>> This has to be taken in to account and added in to the upper. The patched
>>>>>> __pv_offset and va are added in lower 32bits, where __pv_offset can be
>>>>>> in two's complement form when PA_START < VA_START and that can result
>>>>>> in a false carry bit.
>>>>>>
>>>>>> e.g PA = 0x80000000 VA = 0xC0000000
>>>>>> __pv_offset = PA - VA = 0xC0000000 (2's complement)
>>>>>>
>>>>>> So adding __pv_offset + VA should never result in a true overflow. So in
>>>>>> order to differentiate between a true carry, a extra flag __pv_sign_flag
>>>>>> is introduced.
>>>> First of all thanks for the review.
>>>>  
>>>>> I'm still wondering if this is worth bothering about.
>>>>>
>>>>> If PA = 0x80000000 and VA = 0xC0000000 there will never be a real carry 
>>>>> to propagate to the high word of the physical address as the VA space 
>>>>> cannot be larger than 0x40000000.
>>>>>
>>>> Agreed.
>>>>
>>>>> So is there really a case where:
>>>>>
>>>>> 1) physical memory is crossing the 4GB mark, and ...
>>>>>
>>>>> 2) physical memory start address is higher than virtual memory start 
>>>>>    address needing a carry due to the 32-bit add overflow?
>>>>>
>>>> Consider below two cases of memory layout apart from one mentioned
>>>> above where the carry is bit irrelevant as you rightly said.
>>>>
>>>> 1) PA = 0x8_0000_0000, VA= 0xC000_0000, absolute pv_offset = 0x7_4000_0000
>>> This can be patched as:
>>>
>>> 	mov	phys_hi, #0x8
>>> 	add	phys_lo, virt, #0x40000000  @ carry ignored
>>>
>>>> 2) PA = 0x2_8000_0000, VA= 0xC000_000, absolute pv_offset = 0x1_C000_0000
>>> 	mov	phys_hi, #0x2
>>> 	add	phys_lo, virt, #0xc0000000  @ carry ignored
>>>
>>>> In both of these cases there a true carry which needs to be
>>>> considered.
>>> Well, not really.  However, if you have:
>>>
>>> 3) PA = 0x2_8000_0000, VA = 0x4000-0000, pv_offset = 0x2-4000-0000
>>>
>>> ... then you need:
>>>
>>> 	mov	phys_hi, #0x2
>>> 	adds	phys_lo, virt, #0x40000000
>>> 	adc	phys_hi, phys_hi, #0
>>>
>>> My question is: how likely is this?
>>>
>>> What is your actual physical memory start address?
>>  Agreed.  In our case we do not have the Physical address crossing across
>>   4GB. So ignoring the carry would have be been OK. But we are
>>  also addressing the other case where it would really crossover.
>>
Yes. We don't need to worry this case. We can get to this with kernel:user
split but nobody uses that case so we can safely ignore this case.

>>> If we really need to cope with the carry, then the __pv_sign_flag should 
>>> instead be represented in pv_offset directly:
>>>
>>> Taking example #2 above, that would be:
>>>
>>> 	mov	phys_hi, #0x1
>>> 	adds	phys_lo, virt, #0xc0000000
>>> 	adc	phys_hi, phys_hi, #0
>>>
>>> If PA = 0x8000-0000 and VA = 0xc000-0000 then pv_offset is 
>>> 0xffff-ffff-c000-0000, meaning:
>>>
>>> 	mvn	phys_hi, #0
>>> 	add	phys_lo, virt, #0xc0000000
>>> 	adc	phys_hi, phys_hi, #0
>>>
>>> So that would require a special case in the patching code where a mvn 
>>> with 0 is used if the high part of pv_offset is 0xffffffff.
>>>
>>>
>>> Nicolas
>> Extending pv_offset to 64bit is really neat way. When PA > VA, then pv_offset
>> is going to be actual value and not 2's complement. Fine here.
>> When running from higher physical address space, we will always fall here.
>>
>> So for the second case where pv_offset is 0xffffffff .., (PA < VA)
>> is a problem only when we run from lower physical address. So we can safely
>> assume that the higher 32bits of PA are '0' and stub it initially. In this way we
>> can avoid the special case.
>    Sorry, I missed one more point here. In the second case,we should patch it with
>    0x0 when (PA > VA) and with 0xffffffff when (PA < VA).
> 
As Sricharan said, we agree with your suggestion for the special case patching. It
will be either 0x0 or 0xffffffff so easy to take care. We will try out the
suggested changes.

Thanks a lot again.

Regards,
Santosh
