From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 20 May 2011 13:39:37 +0100 (BST)
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <20110520113758.GA3141@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
Message-ID: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Dave Martin wrote:

[ ... ]
>> +/*
>> + * Save the current CPU state before suspend / poweroff.
>> + */
>> +ENTRY(swsusp_arch_suspend)
>> +	ldr	r0, =__swsusp_arch_ctx
>> +	mrs	r1, cpsr
>> +	str	r1, [r0], #4		/* CPSR */
>> +ARM(	msr	cpsr_c, #SYSTEM_MODE					)
>> +THUMB(	mov	r2, #SYSTEM_MODE					)
>> +THUMB(	msr	cpsr_c, r2						)
>
> For Thumb-2 kernels, you can use the cps instruction to change the CPU
> mode:
> 	cps	#SYSTEM_MODE
>
> For ARM though, this instruction is only supported for ARMv6 and above,
> so it's best to keep the msr form for compatibility for that case.

Ah, ok, no problem will make that change, looks good.

Do all ARMs have cpsr / spsr as used here ? Or is that code restricted to 
ARMv5+ ? I don't have the CPU evolution history there, only got involved 
with ARM when armv6 already was out.

I've simply done there what the "setmode" macro from <asm/assembler.h> 
is doing, have chosen not to include that file because it overrides "push" 
on a global scale for no good reason and that sort of thing makes me 
cringe.


>
>> +	stm	r0!, {r4-r12,lr}	/* nonvolatile regs */
>
> Since r12 is allowed to be corrupted across a function call, we
> probably don't need to save it.

ah ok thx for clarification. Earlier iterations of the patch just saved 
r0-r14 there, "just to have it all", doing it right is best as always.

>
[ ... ]
>> +	bl	__save_processor_state
>
> <aside>
>
> Structurally, we seem to have:
>
> swsusp_arch_suspend {
> 	/* save some processor state */
> 	__save_processor_state();
>
> 	swsusp_save();
> }
>
> Is __save_processor_state() intended to encapsulate all the CPU-model-
> specific state saving?  Excuse my ignorance of previous conversations...
>
> </aside>

You're right.

I've attached the codechanges which implement __save/__restore... for 
TI OMAP3 and Samsung S5P64xx, to illustrate, again (that's the stuff 
referred to in the earlier mail I mentioned in first post; beware of code 
churn in there, those diffs don't readily apply to 'just any' kernel).

These hooks are essentially the same as the machine-specific cpu_suspend() 
except that we substitute "r0" (the save context after the generic part) 
as target for where-to-save-the-state, and we make the funcs return 
instead of switching to OFF mode.

That's what I meant with "backdoorish". A better way would be to change 
the cpu_suspend interface so that it returns instead of directly switching 
to off mode / powering down.

Russell has lately been making changes in this area; the current kernels 
are a bit different here since the caller already supplies the 
state-save-buffer, while the older ones used to choose in some 
mach-specific way where to store that state.

(one of the reasons why these mach-dependent enablers aren't part of this 
patch suggestion ...)


>
>> +	pop	{lr}
>> +	b	swsusp_save
>> +ENDPROC(swsusp_arch_suspend)
>
> I'm not too familiar with the suspend/resume stuff, so I may be asking
> a dumb question here, but:
>
> Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> (I'm assuming there's no reason to save/restore r14 or SPSR for any
> exception mode, since we presumably aren't going to suspend/resume
> from inside an exception handler (?))
>
> The exception stack pointers might conceivably be reinitialised to
> sane values on resume, without necessarily needing to save/restore
> them, providing my assumption in the previous paragraph is correct.
>
> r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> this state itself, rather than doing it globally?  This may be
> reasonable.

We don't need to save/restore those, because at the time the snapshot is 
taken interrupts are off and we cannot be in any trap handler either. On 
resume, the kernel that has been loaded has initialized them properly 
already.

If there's really any driver out there which uses FIQ in such an exclusive 
manner that it expects FIQ register bank contents to remain the same 
across multiple FIQ events then it's rather that driver's responsibility 
to perform the save/restore via suspend/resume callbacks.

See also Russell's mails about that, for previous attempts a year and half 
a year ago to get "something for ARM hibernation" in:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-July/027571.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029665.html

The kernel doesn't do IRQ/FIQ/ABT/UND save / restore for suspend-to-ram 
either. CPU hotplug support (re)initializes those. I believe we're fine.


>
> Cheers
> ---Dave
>
>

Thanks,
FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: s5p-hibernate-hook.patch
Type: text/x-diff
Size: 2451 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110520/2da942b0/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap3-hibernate-hook.patch
Type: text/x-diff
Size: 2034 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110520/2da942b0/attachment-0001.bin>
