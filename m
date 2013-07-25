From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Jul 2013 14:53:53 -0400
Subject: [PATCH 6/8] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <51F0A051.20203@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
 <1371858502-10083-7-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1307231850350.15022@syhkavp.arg> <51EF356D.2050902@ti.com>
 <alpine.LFD.2.03.1307232222200.15022@syhkavp.arg> <51EFBF8F.4010201@ti.com>
 <51EFC37B.80906@ti.com> <alpine.LFD.2.03.1307241456260.15022@syhkavp.arg>
 <51F0A051.20203@ti.com>
Message-ID: <51F17441.3000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 July 2013 11:49 PM, Sricharan R wrote:
> Hi Nicolas,
> 
> On Thursday 25 July 2013 01:51 AM, Nicolas Pitre wrote:

[..]

>> I don't think I follow you here.
>>
>> Let's assume:
>>
>> phys_addr_t __pv_offset = PHYS_START - VIRT_START;
>>
>> If PA = 0x0-8000-0000 and VA = 0xc000-0000 then
>> __pv_offset = 0xffff-ffff-c000-0000.
>>
>> If PA = 0x2-8000-0000 and VA = 0xc000-0000 then
>> __pv_offset = 0x1-c000-0000.
>>
>> So the __virt_to_phys() assembly stub could look like:
>>
>> static inline phys_addr_t __virt_to_phys(unsigned long x)
>> {
>> 	phys_addr_t t;
>>
>> 	if if (sizeof(phys_addr_t) == 4) {
>> 		__pv_stub(x, t, "add", __PV_BITS_31_24);
>> 	} else {
>> 		__pv_movhi_stub(t);
>> 		__pv_add_carry_stub(x, t);
>> 	}
>>
>> 	return t;
>> }
>>
>> And...
>>
>> #define __pv_movhi_stub(y) \
>> 	__asm__("@ __pv_movhi_stub\n" \
>> 	"1:	mov	%R0, %1\n" \
>> 	"	.pushsection .pv_table,\"a\"\n" \
>> 	"	.long	1b\n" \
>> 	"	.popsection\n" \
>> 	: "=r" (y) \
>> 	: "I" (__PV_BITS_8_0))
>>
>> #define __pv_add_carry_stub(x, y) \
>> 	__asm__("@ __pv_add_carry_stub\n" \
>> 	"1:	adds	%Q0, %1, %2\n" \
>> 	"	adc	%R0, %R0, #0\n" \
>> 	"	.pushsection .pv_table,\"a\"\n" \
>> 	"	.long	1b\n" \
>> 	"	.popsection\n" \
>> 	: "+r" (y) \
>> 	: "r" (x), "I" (__PV_BITS_31_24) \
>> 	: "cc")
>>
>> The stub bits such as __PV_BITS_8_0 can be augmented with more bits in 
>> the middle to determine the type of fixup needed.  The fixup code would 
>> determine the shift needed on the value, and whether or not the low or 
>> high word of __pv_offset should be used according to those bits.
>>
>> Then, in the case where a mov is patched, you need to check if the high 
>> word of __pv_offset is 0xffffffff and if so the mov should be turned 
>> into a "mvn rn, #0".
>>
>> And there you are with all possible cases handled.
>>
Brilliant !!
We knew you will have some tricks and better way. We were
not convinced with the extra stub for 'mov' but also didn't
have idea to avoid it.

>   Thanks and you have given the full details here.
> 
>   Sorry if i was not clear on my previous response.
> 
>  1)  When i said special case can be avoided, i meant that
>       we need not differentiate the 0xfffffff case inside the
>       __virt_to_phy macro, but can handle it at the time of patching.
>       Your above code makes that clear.
>  
>  2) I would have ended creating separate tables for 'mov' and 'add'
>       case. But again thanks to your above idea of augumenting the
>       __PV_BITS, with which we can find out run time. And 'mvn' would
>       be needed for moving '0xffffffff' . Now I can get rid
>      of the separate section that i created for 'mov' in my previous
>      version.
> 
We also get rid of calling separate patching for modules as well
as late patching. Overall the patch-set becomes smaller and
simpler. Thanks for help.

Regards,
Santosh
