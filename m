From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 24 Sep 2012 10:32:48 -0400
Subject: [PATCH v3 RESEND 10/17] ARM: LPAE: use phys_addr_t in switch_mm()
In-Reply-To: <20120924140515.GF23298@arm.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-11-git-send-email-cyril@ti.com>
 <20120924140515.GF23298@arm.com>
Message-ID: <50606F10.60204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/12 10:05, Catalin Marinas wrote:
> On Fri, Sep 21, 2012 at 04:56:08PM +0100, Cyril Chemparathy wrote:
>> This patch modifies the switch_mm() processor functions to use phys_addr_t.
>> On LPAE systems, we now honor the upper 32-bits of the physical address that
>> is being passed in, and program these into TTBR as expected.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> ---
[...]
>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>> index 8de0f1d..c4f4251 100644
>> --- a/arch/arm/mm/proc-v7-3level.S
>> +++ b/arch/arm/mm/proc-v7-3level.S
[...]
>>   ENTRY(cpu_v7_switch_mm)
>>   #ifdef CONFIG_MMU
>> -	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
>> -	and	r3, r1, #0xff
>> -	mov	r3, r3, lsl #(48 - 32)		@ ASID
>> -	mcrr	p15, 0, r0, r3, c2		@ set TTB 0
>> +	ldr	r2, [r2, #MM_CONTEXT_ID]	@ get mm->context.id
>> +	and	r2, r2, #0xff
>> +	mov	r2, r2, lsl #(48 - 32)		@ ASID
>> +	orr	rpgdh, rpgdh, r2		@ upper 32-bits of pgd phys
>
> Can you do:
>
> 	orr	rpgdh, rpgdh, r2, lsl #(48 - 32)
>

Sure.  Thanks.

-- Cyril.
