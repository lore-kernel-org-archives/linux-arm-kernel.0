From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 06:55:30 -0400
Subject: [RFC 03/23] ARM: LPAE: use phys_addr_t on virt <--> phys
 conversion
In-Reply-To: <20120724103717.GF20132@arm.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-4-git-send-email-cyril@ti.com>
 <20120724103717.GF20132@arm.com>
Message-ID: <500E7F22.9090803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2012 6:37 AM, Catalin Marinas wrote:
> On Tue, Jul 24, 2012 at 02:09:05AM +0100, Cyril Chemparathy wrote:
>> This patch fixes up the types used when converting back and forth between
>> physical and virtual addresses.
>>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
>>   arch/arm/include/asm/memory.h |   17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index fcb5757..7629dfe 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -169,22 +169,27 @@ extern unsigned long __pv_phys_offset;
>>   	: "=r" (to)					\
>>   	: "r" (from), "I" (type))
>>
>> -static inline unsigned long __virt_to_phys(unsigned long x)
>> +static inline phys_addr_t __virt_to_phys(unsigned long x)
>>   {
>>   	unsigned long t;
>>   	__pv_stub(x, t, "add", __PV_BITS_31_24);
>>   	return t;
>>   }
>>
>> -static inline unsigned long __phys_to_virt(unsigned long x)
>> +static inline unsigned long __phys_to_virt(phys_addr_t x)
>>   {
>>   	unsigned long t;
>>   	__pv_stub(x, t, "sub", __PV_BITS_31_24);
>>   	return t;
>>   }
>
> BTW, I would prefer if the phys-to-virt patching was fixed as well. It
> shouldn't be difficult.
>

On that topic - yes, we have this on our radar, but in our case we;re 
talking about patching (in head.S) and then repatching (at switch over).

One of the ideas we've been bouncing around has been to convert the 
phys-virt patch code into arithmetic on PFNs.  This way we don't have to 
get too messy with 64-bit in the patch code, and we can use the same 
patch code for both phys_to_virt and virt_to_phys.  Thoughts on this 
approach?

-- 
Thanks
- Cyril
