From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 20 Jun 2011 13:32:47 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <20110616213128.GC32629@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
	<20110616213128.GC32629@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106201251340.11405@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 16 Jun 2011, Russell King - ARM Linux wrote:

> On Wed, Jun 15, 2011 at 02:35:26PM +0100, Frank Hofmann wrote:
>> this change is perfect; with this, the hibernation support code turns
>> into the attached.
>
> Should I assume that's an ack for all the patches?

Sorry the late reply, been away.

I've only tested on s3c64xx (for s2ram and s2disk) and omap3 (s2disk only 
due to the omap code not having been "genericized" yet), the changes are 
ok there.
The remainder apply and compile ok.

If that's sufficient, then:
Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>

>
>> That's both better and simpler to perform a full suspend/resume cycle
>> (via resetting in the cpu_suspend "finisher") after the snapshot image
>> has been created, instead of shoehorning a return into this.
>
> It's now not soo difficult to have an error code returned from the
> finisher function - the only thing we have to make sure is that
> the cpu_do_suspend helper just saves state and does not make any
> state changes.
>
> We can then do this, which makes it possible for the finisher to
> return, and we propagate its return value.  We also ensure that a
> path through from cpu_resume will result in a zero return value
> from cpu_suspend.
>
> This isn't an invitation for people to make the S2RAM path return
> after they time out waiting for suspend to happen - that's potentially
> dangerous because in that case the suspend may happen while we're
> resuming devices which wouldn't be nice.

You're right there's some risk that the ability to return an error here is 
misinterpreted as an invitation to use error returns for indicating state 
machine conditions.

What I'm wondering about is the usecase for having an error return 
opportunity in this case (beyond reporting it as such). Isn't it rather so 
that most finishers would succeed and at best do a "BUG_ON()" at failure, 
because system state then isn't such to make it trivially recoverable ?

For hibernation, the ability to force the entire down/up transition before 
writing the snapshot image out is actually very beneficial, for 
reliability - one knows that the device/cpu side of suspend/resume has 
already worked when the snapshot is being written, without having to wait 
for reboot/image load/resume to test that. One would want to go through 
suspend/resume even if the memory snapshot operation, swsusp_save, errors.
A failure of swsusp_save doesn't make suspend/resume itself a failure, 
therefore it's desirable to propagate that return code in other ways (and 
keep the finisher "unconditional").

I'm not opposed to this addition as such, but I'm curious:
* If an error occurs, how can the caller of cpu_suspend recover from it ?
* What's the state the system is in after an error in this codepath ?
* What subsystems / users would do anything else with it than BUG_ON() ?

Also, consider possible errors in the SoC-specific code on the resume 
side; situations like a failure to perform SoC-iROM-calls for e.g. an 
attempted secure state restore would result in errors that can't be 
propagated by this mechanism; i.e. there are still failure modes which 
require platform-specific intervention of sorts, and platform-specific 
error propagation/handling, even were cpu_suspend to return error codes.

FrankH.

>
> diff -u b/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> --- b/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -12,7 +12,6 @@
>  *  r1 = v:p offset
>  *  r2 = suspend function arg0
>  *  r3 = suspend function
> - * Note: does not return until system resumes
>  */
> ENTRY(cpu_suspend)
> 	stmfd	sp!, {r4 - r11, lr}
> @@ -26,7 +25,7 @@
> #endif
> 	mov	r6, sp			@ current virtual SP
> 	sub	sp, sp, r5		@ allocate CPU state on stack
> -	mov	r0, sp			@ save pointer
> +	mov	r0, sp			@ save pointer to CPU save block
> 	add	ip, ip, r1		@ convert resume fn to phys
> 	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
> 	ldr	r5, =sleep_save_sp
> @@ -55,10 +54,17 @@
> #else
> 	bl	__cpuc_flush_kern_all
> #endif
> +	adr	lr, BSYM(cpu_suspend_abort)
> 	ldmfd	sp!, {r0, pc}		@ call suspend fn
> ENDPROC(cpu_suspend)
> 	.ltorg
>
> +cpu_suspend_abort:
> +	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
> +	mov	sp, r2
> +	ldmfd	sp!, {r4 - r11, pc}
> +ENDPROC(cpu_suspend_abort)
> +
> /*
>  * r0 = control register value
>  * r1 = v:p offset (preserved by cpu_do_resume)
> @@ -88,6 +94,7 @@
> cpu_resume_after_mmu:
> 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
> 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
> +	mov	r0, #0			@ return zero on success
> 	ldmfd	sp!, {r4 - r11, pc}
> ENDPROC(cpu_resume_after_mmu)
>
>
>
