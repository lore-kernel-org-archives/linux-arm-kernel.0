From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 9 Aug 2016 07:19:19 +0900
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <57A2C8DF.7050401@linaro.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
 <57993211.1040600@linaro.org>
 <20160728144053.GA26510@e104818-lin.cambridge.arm.com>
 <360d582b-5401-7126-ef40-bd78369c0a34@linaro.org>
 <57A2C8DF.7050401@linaro.org>
Message-ID: <20160809071919.26533c155c0b51dad8e64ed9@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Aug 2016 00:47:27 -0400
David Long <dave.long@linaro.org> wrote:

> On 07/29/2016 05:01 AM, Daniel Thompson wrote:
> > On 28/07/16 15:40, Catalin Marinas wrote:
> >> On Wed, Jul 27, 2016 at 06:13:37PM -0400, David Long wrote:
> >>> On 07/27/2016 07:50 AM, Daniel Thompson wrote:
> >>>> On 25/07/16 23:27, David Long wrote:
> >>>>> On 07/25/2016 01:13 PM, Catalin Marinas wrote:
> >>>>>> The problem is that the original design was done on x86 for its 
> >>>>>> PCS and
> >>>>>> it doesn't always fit other architectures. So we could either 
> >>>>>> ignore the
> >>>>>> problem, hoping that no probed function requires argument passing on
> >>>>>> stack or we copy all the valid data on the kernel stack:
> >>>>>>
> >>>>>> diff --git a/arch/arm64/include/asm/kprobes.h
> >>>>>> b/arch/arm64/include/asm/kprobes.h
> >>>>>> index 61b49150dfa3..157fd0d0aa08 100644
> >>>>>> --- a/arch/arm64/include/asm/kprobes.h
> >>>>>> +++ b/arch/arm64/include/asm/kprobes.h
> >>>>>> @@ -22,7 +22,7 @@
> >>>>>>
> >>>>>>  #define __ARCH_WANT_KPROBES_INSN_SLOT
> >>>>>>  #define MAX_INSN_SIZE            1
> >>>>>> -#define MAX_STACK_SIZE            128
> >>>>>> +#define MAX_STACK_SIZE            THREAD_SIZE
> >>>>>>
> >>>>>>  #define flush_insn_slot(p)        do { } while (0)
> >>>>>>  #define kretprobe_blacklist_size    0
> >>>>>
> >>>>> I doubt the ARM PCS is unusual.  At any rate I'm certain there are 
> >>>>> other
> >>>>> architectures that pass aggregate parameters on the stack. I suspect
> >>>>> other RISC(-ish) architectures have similar PCS issues and I think 
> >>>>> this
> >>>>> is at least a big part of where this simple copy with a 64/128 limit
> >>>>> comes from, or at least why it continues to exist.  That said, I'm not
> >>>>> enthusiastic about researching that assertion in detail as it could be
> >>>>> time consuming.
> >>>>
> >>>> Given Mark shared a test program I *was* curious enough to take a look
> >>>> at this.
> >>>>
> >>>> The only architecture I can find that behaves like arm64 with the
> >>>> implicit pass-by-reference described by Catalin/Mark is sparc64.
> >>>>
> >>>> In contrast alpha, arm (32-bit), hppa64, mips64 and powerpc64 all use a
> >>>> hybrid approach where the first fragments of the structure are 
> >>>> passed in
> >>>> registers and the remainder on the stack.
> >>>
> >>> That's interesting.  It also looks like sparc64 does not copy any 
> >>> stack for
> >>> jprobes. I guess that approach at least makes it clear what will and 
> >>> won't
> >>> work.
> >>
> >> I suggest we do the same for arm64 - avoid the copying entirely as it's
> >> not safe anyway. We don't know how much to copy, nor can we be sure it
> >> is safe (see Dave's DMA to the stack example). This would need to be
> >> documented in the kprobes.txt file and MAX_STACK_SIZE removed from the
> >> arm64 kprobes support.
> >>
> >> There is also the case that Daniel was talking about - passing more than
> >> 8 arguments. I don't think it's worth handling this
> > 
> > Its actually quite hard to document the (architecture specific) "no big 
> > structures" *and* the "8 argument" limits. It ends up as something like:
> > 
> >    Structures/unions >16 bytes must not be passed by value and the
> >    size of all arguments, after padding each to an 8 byte boundary, must
> >    be less than 64 bytes.
> > 
> > We cannot avoid tackling big structures through documentation but when 
> > we impose additional limits like "only 8 arguments" we are swapping an 
> > architecture neutral "gotcha" that affects almost all jprobes uses (and 
> > can be inferred from the documentation) with an architecture specific one!
> > 
> 
> See new patch below.  The documentation change in it could use some scrutiny.
> I've tested with one-off jprobes functions in a test module and I've
> verified NET_TCPPROBE doesn't cause misbehavior.
> 
> > 
> >  > but we should at
> >> least add a warning and skip the probe:
> >>
> >> diff --git a/arch/arm64/kernel/probes/kprobes.c 
> >> b/arch/arm64/kernel/probes/kprobes.c
> >> index bf9768588288..84e02606ec3d 100644
> >> --- a/arch/arm64/kernel/probes/kprobes.c
> >> +++ b/arch/arm64/kernel/probes/kprobes.c
> >> @@ -491,6 +491,10 @@ int __kprobes setjmp_pre_handler(struct kprobe 
> >> *p, struct pt_regs *regs)
> >>      struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >>      long stack_ptr = kernel_stack_pointer(regs);
> >>
> >> +    /* do not allow arguments passed on the stack */
> >> +    if (WARN_ON_ONCE(regs->sp != regs->regs[29]))
> >> +        return 0;
> >> +
> > 
> > I don't really understand this test.
> > 
> > If we could reliably assume that the frame record was at the lowest 
> > address within a stack frame then we could exploit that to store the 
> > stacked arguments without risking overwriting volatile variables on the 
> > stack.
> > 
> > 
> > Daniel.
> > 
> 
> I'm assuming the consensus is to not use the above snippet of code.
> 
> Thanks,
> -dl
> 
> ----------cut here--------
> 
> 
> From b451caa1adaf1d03e08a44b5dad3fca31cebd97a Mon Sep 17 00:00:00 2001
> From: "David A. Long" <dave.long@linaro.org>
> Date: Thu, 4 Aug 2016 00:35:33 -0400
> Subject: [PATCH] arm64: Remove stack duplicating code from jprobes
> 
> Because the arm64 calling standard allows stacked function arguments to be
> anywhere in the stack frame, do not attempt to duplicate the stack frame for
> jprobes handler functions.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> ---
>  Documentation/kprobes.txt          |  7 +++++++
>  arch/arm64/include/asm/kprobes.h   |  2 --
>  arch/arm64/kernel/probes/kprobes.c | 31 +++++--------------------------
>  3 files changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 1f9b3e2..bd01839 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -103,6 +103,13 @@ Note that the probed function's args may be passed on the stack
>  or in registers.  The jprobe will work in either case, so long as the
>  handler's prototype matches that of the probed function.
>  
> +Note that in some architectures (e.g.: arm64) the stack copy is not
> +done, as the actual location of stacked parameters may be outside of
> +a reasonable MAX_STACK_SIZE value and because that location cannot be
> +determined by the jprobes code. In this case the jprobes user must be
> +careful to make certain the calling signature of the function does
> +not cause parameters to be passed on the stack.
> +
>  1.3 Return Probes
>  
>  1.3.1 How Does a Return Probe Work?
> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> index 61b4915..1737aec 100644
> --- a/arch/arm64/include/asm/kprobes.h
> +++ b/arch/arm64/include/asm/kprobes.h
> @@ -22,7 +22,6 @@
>  
>  #define __ARCH_WANT_KPROBES_INSN_SLOT
>  #define MAX_INSN_SIZE			1
> -#define MAX_STACK_SIZE			128
>  
>  #define flush_insn_slot(p)		do { } while (0)
>  #define kretprobe_blacklist_size	0
> @@ -47,7 +46,6 @@ struct kprobe_ctlblk {
>  	struct prev_kprobe prev_kprobe;
>  	struct kprobe_step_ctx ss_ctx;
>  	struct pt_regs jprobe_saved_regs;
> -	char jprobes_stack[MAX_STACK_SIZE];
>  };
>  
>  void arch_remove_kprobe(struct kprobe *);
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index bf97685..c6b0f40 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -41,18 +41,6 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  static void __kprobes
>  post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>  
> -static inline unsigned long min_stack_size(unsigned long addr)
> -{
> -	unsigned long size;
> -
> -	if (on_irq_stack(addr, raw_smp_processor_id()))
> -		size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
> -	else
> -		size = (unsigned long)current_thread_info() + THREAD_START_SP - addr;
> -
> -	return min(size, FIELD_SIZEOF(struct kprobe_ctlblk, jprobes_stack));
> -}
> -
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	/* prepare insn slot */
> @@ -489,20 +477,15 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct jprobe *jp = container_of(p, struct jprobe, kp);
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> -	long stack_ptr = kernel_stack_pointer(regs);
>  
>  	kcb->jprobe_saved_regs = *regs;
>  	/*
> -	 * As Linus pointed out, gcc assumes that the callee
> -	 * owns the argument space and could overwrite it, e.g.
> -	 * tailcall optimization. So, to be absolutely safe
> -	 * we also save and restore enough stack bytes to cover
> -	 * the argument area.
> +	 * Since we can't be sure where in the stack frame "stacked"
> +	 * pass-by-value arguments are stored we just don't try to
> +	 * duplicate any of the stack. Do not use jprobes on functions that
> +	 * use more than 64 bytes (after padding each to an 8 byte boundary)
> +	 * of arguments, or pass individual arguments larger than 16 bytes.
>  	 */
> -	kasan_disable_current();
> -	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
> -	       min_stack_size(stack_ptr));
> -	kasan_enable_current();
>  
>  	instruction_pointer_set(regs, (unsigned long) jp->entry);
>  	preempt_disable();
> @@ -554,10 +537,6 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  	}
>  	unpause_graph_tracing();
>  	*regs = kcb->jprobe_saved_regs;
> -	kasan_disable_current();
> -	memcpy((void *)stack_addr, kcb->jprobes_stack,
> -	       min_stack_size(stack_addr));
> -	kasan_enable_current();
>  	preempt_enable_no_resched();
>  	return 1;
>  }
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
