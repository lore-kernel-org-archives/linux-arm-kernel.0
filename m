From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 15 Jan 2011 15:38:16 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <20110114184759.GN15996@n2100.arm.linux.org.uk>
References: <1294990949-2729-1-git-send-email-ccross@android.com>
	<AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
	<20110114120229.GA15996@n2100.arm.linux.org.uk>
	<1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
	<1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
	<20110114163520.GH15996@n2100.arm.linux.org.uk>
	<1295024327.7901.70.camel@e102109-lin.cambridge.arm.com>
	<20110114173050.GJ15996@n2100.arm.linux.org.uk>
	<20110114184759.GN15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=p+f7TO+_g677VXNJkt-mu+8d8c6T9qgt5MVtn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2011 18:47, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 05:30:50PM +0000, Russell King - ARM Linux wrote:
>> On Fri, Jan 14, 2011 at 04:58:47PM +0000, Catalin Marinas wrote:
>> > I agree, this code needs some clean-up. Maybe for Undef we could unify
>> > the ARM and Thumb-2 offsets so that they are both 4 (it may confuse the
>> > breakpoint code, I haven't checked).
>> >
>> > Otherwise just let the code handling the undef deal with the ARM/Thumb
>> > difference. For SVC, it makes sense to have different offsets as we
>> > always return to the next instruction.
>>
>> I think it just needs better documentation.
>>
>> Having been through all this, there _are_ bugs lurking in the code exactly
>> because of this randomness with what PC value is means what.
>>
>> When the VFP support code tests the state of the VFP hardware during boot,
>> it sets the VFP handler to point at vfp_testing_entry, bypassing the normal
>> VFP handling code, and executes a VFP instruction.
>>
>> If this VFP instruction faults (eg, because there is no VFP hardware
>> present or we're not permitted to use it), it could end up resuming
>> execution in the middle of the 16-bit paired instruction because
>> regs->ARM_pc points in the middle of it.
>>
>> So vfp_testing_entry should at least store r2 into regs->ARM_pc to
>> guarantee resuming at the following instruction.
>>
>> So maybe the right answer is to store r2 into regs->ARM_pc in
>> process_exception in the VFP assembly code too?
>>
>> Or maybe we should just make it unconditional that whenever we have an
>> undefined instruction exception, the regs->ARM_pc value will always be
>> set for resuming execution after the faulted instruction. ?That makes
>> it consistent with r2 throughout the code in every case.
>
> So... this incrementally on top of the previous patch (which I've
> reproduced below as there's a subtle comment change in there wrt IRQ
> state.)
>
> This means we have consistent state - both r2 and regs->ARM_pc always
> point to the next instruction to be executed in every case, which means
> its easy to understand and remember while reading through the code.
>
> diff -u b/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> --- b/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -499,10 +499,11 @@
> ? ? ? ?blo ? ? __und_usr_unknown
> ?3: ? ? ldrht ? r0, [r4]
> ? ? ? ?add ? ? r2, r2, #2 ? ? ? ? ? ? ? ? ? ? ?@ r2 is PC + 2, make it PC + 4
> - ? ? ? orr ? ? r0, r0, r5, lsl #16
> + ? ? ? str ? ? r2, [sp, #S_PC] ? ? ? ? ? ? ? ? @ it's a 2x16bit instr, update
> + ? ? ? orr ? ? r0, r0, r5, lsl #16 ? ? ? ? ? ? @ ?regs->ARM_pc
> ? ? ? ?@
> ? ? ? ?@ r0 = the two 16-bit Thumb instructions which caused the exception
> - ? ? ? @ r2 = PC value for the following Thumb instruction (:= regs->ARM_pc+2)
> + ? ? ? @ r2 = PC value for the following Thumb instruction (:= regs->ARM_pc)
> ? ? ? ?@ r4 = PC value for the first 16-bit Thumb instruction
> ? ? ? ?@
> ?#else

Do we need to modify the VFP entry code to avoit the store to ARM_pc?

-- 
Catalin
