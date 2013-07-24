From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 23 Jul 2013 22:01:17 -0400
Subject: [PATCH 6/8] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <alpine.LFD.2.03.1307231850350.15022@syhkavp.arg>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
 <1371858502-10083-7-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1307231850350.15022@syhkavp.arg>
Message-ID: <51EF356D.2050902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 July 2013 09:10 PM, Nicolas Pitre wrote:
> On Fri, 21 Jun 2013, Santosh Shilimkar wrote:
> 
>> From: Sricharan R <r.sricharan@ti.com>
>>
>> The current phys_to_virt patching mechanism does not work
>> for 64 bit physical addressesp. Note that constant used in add/sub
>> instructions is encoded in to the last 8 bits of the opcode. So shift
>> the _pv_offset constant by 24 to get it in to the correct place.
>>
>> The v2p patching mechanism patches the higher 32bits of physical
>> address with a constant. While this is correct, in those platforms
>> where the lowmem addressable physical memory spawns across 4GB boundary,
>> a carry bit can be produced as a result of addition of lower 32bits.
>> This has to be taken in to account and added in to the upper. The patched
>> __pv_offset and va are added in lower 32bits, where __pv_offset can be
>> in two's complement form when PA_START < VA_START and that can result
>> in a false carry bit.
>>
>> e.g PA = 0x80000000 VA = 0xC0000000
>> __pv_offset = PA - VA = 0xC0000000 (2's complement)
>>
>> So adding __pv_offset + VA should never result in a true overflow. So in
>> order to differentiate between a true carry, a extra flag __pv_sign_flag
>> is introduced.
>
First of all thanks for the review.
 
> I'm still wondering if this is worth bothering about.
> 
> If PA = 0x80000000 and VA = 0xC0000000 there will never be a real carry 
> to propagate to the high word of the physical address as the VA space 
> cannot be larger than 0x40000000.
> 
Agreed.

> So is there really a case where:
> 
> 1) physical memory is crossing the 4GB mark, and ...
> 
> 2) physical memory start address is higher than virtual memory start 
>    address needing a carry due to the 32-bit add overflow?
> 
Consider below two cases of memory layout apart from one mentioned
above where the carry is bit irrelevant as you rightly said.

1) PA = 0x8_0000_0000, VA= 0xC000_0000, absolute pv_offset = 0x7_4000_0000
2) PA = 0x2_8000_0000, VA= 0xC000_000, absolute pv_offset = 0x1_C000_0000

In both of these cases there a true carry which needs to be
considered.

> It is easy to create (2) just by having a different user:kernel address 
> space split.  However I wonder if (1) is likely.  Sure you need a memory 
> alias in physical space to be able to boot, however you shouldn't need 
> to address that memory alias via virtual addresses for any 
> significant amount of time.  In fact, as soon as the MMU is turned on, 
> there shouldn't be any issue simply using the final physical memory 
> addresses right away.
> 
> What am I missing?
> 
I thought about switching to the final address space along with
MMU enable at startup but then based on the discussion earlier
(RMK suggested), to have such a patching support in least disruptive
manner, we could patch once at boot, and then re-patch at switch  
over. This also gives flexibility to be able to patch code post
machine init. Hopefully I haven't missed your point here.

regards,
Santosh
