From: james.morse@arm.com (James Morse)
Date: Wed, 20 Apr 2016 18:35:57 +0100
Subject: [PATCH v7 13/16] arm64: head.S: el2_setup() to accept sctlr_el1
 as an argument
In-Reply-To: <20160420171204.GG11377@e104818-lin.cambridge.arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-14-git-send-email-james.morse@arm.com>
 <20160420171204.GG11377@e104818-lin.cambridge.arm.com>
Message-ID: <5717BDFD.4000005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 20/04/16 18:12, Catalin Marinas wrote:
> On Fri, Apr 01, 2016 at 05:53:37PM +0100, James Morse wrote:
>> el2_setup() doesn't just configure el2, it configures el1 too. This
>> means we can't use it to re-configure el2 after resume from hibernate,
>> as we will be returned to el1 with the MMU turned off.
>>
>> Split the sctlr_el1 setting code up, so that el2_setup() accepts an
>> initial value as an argument. This value will be ignored if el2_setup()
>> is called at el1: the running value will be preserved with endian
>> correction.
>>
>> Hibernate can now call el2_setup() to re-configure el2, passing the
>> current sctlr_el1 as an argument.
> 
> I don't fully understand the description. The first paragraph says we
> can't use el2_setup to re-configure el2 after resume from hibernate
> while the last paragraph says that we can.

Then I need to rephrase the middle paragraph. Is this any clearer:
This happens because el2_setup() generates a sctlr_el1 value needed for early
boot, (mmu off etc). Change el2_setup() to accept this as an argument, so that
hibernate can pass the current sctlr_el1 (with the mmu on), to el2_setup(), and
have it re-configure el2 without changing el1.

The motivation for this patch was resuming with a different kernel version,
which may have left el2 in an incompatible state. Running the original
el2_setup() was the only guaranteed way to know everything was set correctly.
If we definitely don't want to support this, then this patch can go, and the
minimum el2-reset code can be put into hibernate-asm.S.


>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index a04fd7a9c102..627d66efec68 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -311,6 +311,16 @@ lr	.req	x30		// link register
>>  	.endm
>>  
>>  /*
>> + * Generate the initial sctlr_el1 value for el2_setup to set if we boot at EL2.
>> + */
>> +	.macro init_sctlr_el1 reg
>> +		mov	\reg, #0x0800		// Set/clear RES{1,0} bits
>> +CPU_BE(		movk	\reg, #0x33d0, lsl #16)	// Set EE and E0E on BE systems
>> +CPU_LE(		movk	\reg, #0x30d0, lsl #16)	// Clear EE and E0E on LE systems
>> +	.endm
> 
> I can see, at least in this patch, that all places where this macro is
> invoked are immediately followed by a call to el2_setup. Can we not just
> place this at the beginning of el2_setup?

Hibernate's resume path is added as a later caller, it doesn't expect to be
returned to with the MMU off.


>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 1217262b5210..097986152203 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -208,6 +208,7 @@ section_table:
>>  
>>  ENTRY(stext)
>>  	bl	preserve_boot_args
>> +	init_sctlr_el1	x0
>>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
>>  	mov	x23, xzr			// KASLR offset, defaults to 0
>>  	adrp	x24, __PHYS_OFFSET
>> @@ -514,8 +515,12 @@ ENTRY(kimage_vaddr)
>>   *
>>   * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
>>   * booted in EL1 or EL2 respectively.
>> + *
>> + * If booted in EL2, SCTLR_EL1 will be initialised with the value in x0
>> + * (otherwise the existing value will be preserved, with endian correction).
>>   */
>>  ENTRY(el2_setup)
>> +	mov	x1, x0				// preserve passed-in sctlr_el1
>>  	mrs	x0, CurrentEL
>>  	cmp	x0, #CurrentEL_EL2
>>  	b.ne	1f
>> @@ -524,7 +529,7 @@ CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
>>  CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
>>  	msr	sctlr_el2, x0
>>  	b	2f
>> -1:	mrs	x0, sctlr_el1
>> +1:	mrs	x0, sctlr_el1			// ignore passed-in sctlr_el1
>>  CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
>>  CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
>>  	msr	sctlr_el1, x0
> 
> BTW, I wonder whether we need this read-modify-write sequence at all
> rather than always setting a pre-set sane value (as per the
> init_sctlr_el1 macro). This way we can always do this at the beginning
> of el2_setup independent of whether we run in EL1 or EL2.

In this case el2_setup is preserving the existing sctlr_el1 value because it was
run at el1, it just changes the EE/EOE bits. I guess it's being clever in not
overwriting it with the value it uses later (if run at el2), presumably the boot
loader can leave some bit set that we don't want to lose.


> 
>> @@ -578,6 +583,10 @@ set_hcr:
>>  
>>  3:
>>  #endif
>> +	/* use sctlr_el1 value we were provided with */
>> +CPU_BE(	orr	x1, x1, #(3 << 24)	)	// Set the EE and E0E bits for EL1
>> +CPU_LE(	bic	x1, x1, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
>> +	msr	sctlr_el1, x1
> 
> I don't think we need this here, the value passed already has the EE/E0E
> bits set accordingly by the init_sctlr_el1 macro.

I've removed this one locally...


Thanks!

James
