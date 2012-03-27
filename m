From: gdavis@mvista.com (George G. Davis)
Date: Tue, 27 Mar 2012 13:41:52 -0400
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <20120327133226.GE18738@mudshark.cambridge.arm.com>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <274124B9C6907D4B8CE985903EAA19E91B2D5798D9@SI-MBX06.de.bosch.com>
 <20120327133226.GE18738@mudshark.cambridge.arm.com>
Message-ID: <20120327174152.GA905@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 27, 2012 at 02:32:26PM +0100, Will Deacon wrote:
> Peter,
> 
> On Mon, Mar 26, 2012 at 05:10:45PM +0100, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> > Probably just an "expected deadlock" as mentioned in the comment
> > of the v6_early_abort macro:
> > 
> >  * Purpose : obtain information about current aborted instruction.
> >  * Note: we read user space.  This means we might cause a data
> >  * abort here if the I-TLB and D-TLB aren't seeing the same
> >  * picture.  Unfortunately, this does happen.  We live with it.
> 
> I don't see this referring to an expected deadlock.
> 
> > For now the errata workarounds are removed for the 11MPcore
> > like proposed in this thread to avoid faulting with IRQs turned off:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041869.html
> > 
> > But there it looked like an optimization, but it wasn't.
> 
> I have a theory about what goes on:
> 
> Say we have a valid (i.e. non-faulting) page which contains a load instruction
> that will fault. A CPU executes this load and takes a data abort but at the
> same time another CPU marks the page being executed as old. So when the
> original CPU tries to load the faulting instruction in do_thumb_abort, we take
> a second data abort (assumedly because we don't have a D-side TLB entry for the
> text page, so we immediately see that it is old) and, because interrupts were
> not yet re-enabled in the first fault, they are not enabled in the nested fault
> either.

This is precisely what happened here.  The only difference is that the traces
I've reviewed faulted at "not_thumb:" while attempting to read the userspace
ARM instruction which lead to the (second) data abort with interrupts disabled.


> At this point, the faulting CPU will be unable to get the lock on the page,
> since the other guy has it and is waiting for the TLB broadcast to complete.
> Given that interrupts are disabled on the faulting CPU, everything locks up.

Right again.


> Possible solutions:
> 
> (1) Enable interrupts if they are enabled in the faulting context before
>     loading instructions on the dabt path.
> 
> (2) Use the FSR to determine whather a fault is due to a read or a write on
>     ARMv6 - only load and disassemble the instruction on 1136 CPUs affected
>     by erratum #325103 (which aren't SMP, so cannot hit the problem above).

We submitted a change similar to (2) above to the ARM Linux kernel mailing
list for RFC [1] over a year ago.  That change [1] is similar to your change
below.


> The latter is probably best. Please can you try the patch below? I've
> checked that it does the right thing on an r0p1 1136 core using a simple
> fork/swp program to trigger a CoW.

I tested your patch but only on a CPU_V6K based SMP machine.  In this
case, ARM_ERRATA_326103 depends on CPU_V6, so is left disabled, renderring
this patch functionally equivaltent to [1] below.


> Will
> 
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dfb0312..dedb885 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1163,6 +1163,15 @@ if !MMU
>  source "arch/arm/Kconfig-nommu"
>  endif
>  
> +config ARM_ERRATA_326103
> +       bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
> +       depends on CPU_V6
> +       help
> +         Executing a SWP instruction to read-only memory does not set bit 11
> +         of the FSR on the ARM 1136 prior to r1p0. This causes the kernel to
> +         treat the access as a read, preventing a COW from occurring and
> +         causing the faulting task to livelock.
> +
>  config ARM_ERRATA_411920
>         bool "ARM errata: Invalidation of the Instruction Cache operation can fail"
>         depends on CPU_V6 || CPU_V6K
> diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
> index ff1f7cc..8074199 100644
> --- a/arch/arm/mm/abort-ev6.S
> +++ b/arch/arm/mm/abort-ev6.S
> @@ -26,18 +26,23 @@ ENTRY(v6_early_abort)
>         mrc     p15, 0, r1, c5, c0, 0           @ get FSR
>         mrc     p15, 0, r0, c6, c0, 0           @ get FAR
>  /*
> - * Faulty SWP instruction on 1136 doesn't set bit 11 in DFSR (erratum 326103).
> - * The test below covers all the write situations, including Java bytecodes
> + * Faulty SWP instruction on 1136 doesn't set bit 11 in DFSR.
>   */
> -       bic     r1, r1, #1 << 11                @ clear bit 11 of FSR
> +#ifdef CONFIG_ARM_ERRATA_326103
> +       ldr     ip, =0x4107b36
> +       mrc     p15, 0, r3, c0, c0, 0           @ get processor id
> +       teq     ip, r3, lsr #4                  @ r0 ARM1136?
> +       bne     do_DataAbort
>         tst     r5, #PSR_J_BIT                  @ Java?
> +       tsteq   r5, #PSR_T_BIT                  @ Thumb?
>         bne     do_DataAbort
> -       do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
> -       ldreq   r3, [r4]                        @ read aborted ARM instruction
> +       bic     r1, r1, #1 << 11                @ clear bit 11 of FSR
> +       ldr     r3, [r4]                        @ read aborted ARM instruction
>  #ifdef CONFIG_CPU_ENDIAN_BE8
> -       reveq   r3, r3
> +       rev     r3, r3
>  #endif
>         do_ldrd_abort tmp=ip, insn=r3
>         tst     r3, #1 << 20                    @ L = 0 -> write
>         orreq   r1, r1, #1 << 11                @ yes.
> +#endif
>         b       do_DataAbort

FYI/FWIW, your patch above suffered whitespace damage.

Thanks!

--
Regards,
George

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041733.html
