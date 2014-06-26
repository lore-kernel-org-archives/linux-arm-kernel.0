From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 26 Jun 2014 10:54:17 +0100
Subject: [PATCH v6 4/4] ARM: Add KGDB/KDB FIQ debugger generic code
In-Reply-To: <20140624160844.GV32514@n2100.arm.linux.org.uk>
References: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-5-git-send-email-daniel.thompson@linaro.org>
 <20140624160844.GV32514@n2100.arm.linux.org.uk>
Message-ID: <53ABEDC9.6020407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/06/14 17:08, Russell King - ARM Linux wrote:
> On Tue, Jun 24, 2014 at 04:18:17PM +0100, Daniel Thompson wrote:
>> +	.align	5
>> +__fiq_svc:
>> +	svc_entry
> 
> Remember that the registers you have on the stack here are r0-r12, plus
> the SVC banked sp and lr registers.  These may not be the registers
> from the mode you took the FIQ (eg, if it was IRQ, or abort mode.)

We probably ought to save/restore lr_abt and spsr_abt but I think sp_abt
and the state for irq and und can be neglected.

The stack pointers are constant anyway and I think it reasonable to
assume the FIQ handler doesn't unmask interrupts or attempt to execute
undefined instructions.


> Also bear in mind that svc_entry calls trace_hardirqs_off - is this
> appropriate and safe for the FIQ to call?

I personally think it appropriate and it looked safe on the lockdep side
of things. However I will look a bit deeper at this since I don't
remember how far I chased things back.

Naturally it is a problem that we don't currently call trace_hardirq_on.
I'll fix this.


>> +	fiq_handler
>> +	mov	r0, sp
>> +	ldmib	r0, {r1 - r14}
> 
> So this restores r1 to r12, and the SVC mode sp and lr registers.
> Nothing touches the SVC SPSR, so we hope that retains its value
> throughout the FIQ processing. 

Are you worried about something changing it?

I haven't thought of any good reason for it to change. The FIQ handler
can't safely execute a SVC instruction.


> Note that the stack pointer at this
> point will be above state which we have not yet read, so we better
> not take any exceptions from this instruction (not even an imprecise
> abort).

Can a comment cover this? We shouldn't get an abort reading the SVC
stack and imprecise abort is blocked.

Note we could copy these values back onto the FIQ stack before switching
modes if is there's a possibility of an abort we cannot avoid, however
I'm not know if this is worthwhile.


>> +	msr	cpsr_c, #FIQ_MODE | PSR_I_BIT | PSR_F_BIT
> 
> Here we switch to FIQ mode.  What about the PSR_A_BIT which prevents
> imprecise aborts on ARMv6+ ?
> 
> Nevertheless, I think it's safe because the A bit will be set by the
> CPU when taking the FIQ exception, and it should remain set since
> cpsr_c won't modify it.

Agreed.

Note that while double checking this I realized that this code will drop
the value of PSR_ISETSTATE (T bit) that the vector_stub macro set for
us. I'll fix this.


>> +	add	r8, r0, #S_PC
>> +	ldr	r9, [r0, #S_PSR]
>> +	msr	spsr_cxsf, r9
> 
> Here we update the FIQ SPSR with the calling mode's CPSR, ready to
> return...
> 
>> +	ldr	r0, [r0, #S_R0]
> 
> Load the calling mode's R0 value.
> 
>> +	ldmia	r8, {pc}^
> 
> And return (restoring CPSR from SPSR_fiq).
> 
> This looks pretty good except for the niggles...

Thanks.

I've picked out the following actions from the above:

1. Wrap a save and restore lr_abt and spsr_abt around the FIQ handler
2. Add a paired up trace_hardirqs_on() (and review more deeply).
3. Add comments explaining hazards w.r.t. data abort,
4. Correctly manage T bit during transition back to FIQ mode.

Do I miss anything?


Daniel.
