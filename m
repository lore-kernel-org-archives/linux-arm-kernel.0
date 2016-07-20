From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Jul 2016 12:16:00 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <578F4608.4030901@arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578F4608.4030901@arm.com>
Message-ID: <20160720111600.GB25890@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 10:36:08AM +0100, Marc Zyngier wrote:
> On 08/07/16 17:35, David Long wrote:
> > +void __kprobes jprobe_return(void)
> > +{
> > +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > +
> > +	/*
> > +	 * Jprobe handler return by entering break exception,
> > +	 * encoded same as kprobe, but with following conditions
> > +	 * -a magic number in x0 to identify from rest of other kprobes.
> > +	 * -restore stack addr to original saved pt_regs
> > +	 */
> > +	asm volatile ("ldr x0, [%0]\n\t"
> > +		      "mov sp, x0\n\t"
> > +		      ".globl jprobe_return_break\n\t"
> > +		      "jprobe_return_break:\n\t"
> > +		      "brk %1\n\t"
> > +		      :
> > +		      : "r"(&kcb->jprobe_saved_regs.sp),
> > +		      "I"(BRK64_ESR_KPROBES)
> > +		      : "memory");
> 
> A couple of remarks here:
> - the comment seems wrong, as you load the stack pointer in X0, nothing
> else, and seem to identify the jprobe by looking at the PC, not X0.
> - using explicit registers is really ugly. How about something like this
> instead:
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c89811d..823cf92 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -513,13 +513,12 @@ void __kprobes jprobe_return(void)
>  	 * -a magic number in x0 to identify from rest of other kprobes.
>  	 * -restore stack addr to original saved pt_regs
>  	 */
> -	asm volatile ("ldr x0, [%0]\n\t"
> -		      "mov sp, x0\n\t"
> +	asm volatile ("mov sp, %0\n\t"
>  		      ".globl jprobe_return_break\n\t"
>  		      "jprobe_return_break:\n\t"
>  		      "brk %1\n\t"
>  		      :
> -		      : "r"(&kcb->jprobe_saved_regs.sp),
> +		      : "r" (kcb->jprobe_saved_regs.sp),
>  		      "I"(BRK64_ESR_KPROBES)
>  		      : "memory");
>  }

The comment indeed doesn't make any sense. Is x0 useful at all?
Otherwise, Marc's fixup looks better.

> though hijacking SP in the middle of a C function still feels pretty fragile.

It may not be that bad if this function is never supposed to return.
However, I no longer hit jprobe_return() in my tests, it fails earlier
when it hits the function entry breakpoint. One difference from the
default Kprobes tests is that tcp_rcv_established() runs in interrupt
context on the IRQ stack. Maybe setjmp_pre_handler() doesn't set things
up properly.

Also, is setjmp_pre_handler() guaranteed to run in a non-preemptible
context? It uses MIN_STACK_SIZE macro which does a
raw_smp_processor_id().

-- 
Catalin
