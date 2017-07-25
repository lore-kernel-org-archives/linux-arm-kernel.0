From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jul 2017 14:13:03 +0100
Subject: [PATCH 3/4] arm64: unwind: reference pt_regs via embedded stack
 frame
In-Reply-To: <20170724175446.GE9726@leverpostej>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
 <20170724112623.26109-4-ard.biesheuvel@linaro.org>
 <20170724175446.GE9726@leverpostej>
Message-ID: <20170725131303.GA28815@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 06:54:46PM +0100, Mark Rutland wrote:
> On Mon, Jul 24, 2017 at 12:26:22PM +0100, Ard Biesheuvel wrote:
> > @@ -203,20 +193,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> >  		ret = unwind_frame(tsk, &frame);
> >  		if (ret < 0)
> >  			break;
> > -		stack = frame.sp;
> >  		if (in_exception_text(where)) {
> > -			/*
> > -			 * If we switched to the irq_stack before calling this
> > -			 * exception handler, then the pt_regs will be on the
> > -			 * task stack. The easiest way to tell is if the large
> > -			 * pt_regs would overlap with the end of the irq_stack.
> > -			 */
> > -			if (stack < irq_stack_ptr &&
> > -			    (stack + sizeof(struct pt_regs)) > irq_stack_ptr)
> > -				stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
> > +			stack = frame.fp - offsetof(struct pt_regs, stackframe);
> >  
> > -			dump_mem("", "Exception stack", stack,
> > -				 stack + sizeof(struct pt_regs));
> > +			if (on_task_stack(tsk, stack) ||
> > +			    (tsk == current && !preemptible() && on_irq_stack(stack)))
> > +				dump_mem("", "Exception stack", stack,
> > +					 stack + sizeof(struct pt_regs));
> 
> So here, we're using information from three records (where the last
> might have been faked from the current FP + LR). We look at the previous
> frame's LR value to determine whether the current frame's fp points to a
> next frame that's associated with some regs:
> 
>          +----+----------------+
>          | fp | interrupted PC | /* embedded in pt_regs */
>          +----+----------------+
>            /\
>            ||
>          +----+----------------+
> where => | fp | < entry PC >   |
>          +----+----------------+
>            /\
>            ||
>          +----+----------------+
>          | fp | where          | /* "where" is in exception text */
>          +----+----------------+
> 
> Which (IIUC) has three problems, inherited from the existing approach.
> 
> 1) Several C functions called from exception entry assembly are missing
>    __exception annotations. e.g. bad_mode.
>    
>    So we can miss exception regs in some cases.
> 
> 2) Several functions may be called either from the exception entry
>    assembly, or from other C code. e.g. do_undefinstr, and any cascaded
>    irqchip handlers.
>    
>    So we can spuriously decide part of the stack is a pt_regs.
> 
> 3) The entry assembly can enable exceptions before calling C code, so if
>    an exception is taken at the right time, these will eb in the
>    backtrace without a surrounding frame in the exception text.
> 
>    So we can miss exception regs in some cases (distinct from (1)).
> 
> ... given that, I don't think we can rely on in_exception_text(). I
> think we have to look at whether the current frame's PC/LR is in
> .entry.text.

Looking around, I think most (all?) users of in_exception_text and the
associated linker script labels suffer from similar problems. AFAICT, these
are:

  kprobes	- Used to blacklist probes, but omits entry code
  ftrace	- For graph tracer backtracing; attempted to hack around the
		  problem in 9a5ad7d0e3e1 but still excludes .entry.text
  kasan		- Duplicates ftrace stuff in core code, but also checks
		  against softirqentry

So it looks like we should either include the entry text in these sections
or avoid using these functions altogether (eventually removing them). It
needn't hold this series up, but worth considering.

What do you think?

Will
