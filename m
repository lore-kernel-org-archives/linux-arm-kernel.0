From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Aug 2015 17:35:05 +0100
Subject: [PATCH] arm64: entry: always restore x0 from the stack on
 syscall return
In-Reply-To: <20150819162359.GA10297@arm.com>
References: <1439996989-5772-1-git-send-email-will.deacon@arm.com>
 <20150819160320.GI24062@e104818-lin.cambridge.arm.com>
 <20150819162359.GA10297@arm.com>
Message-ID: <20150819163504.GL24062@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 05:23:59PM +0100, Will Deacon wrote:
> On Wed, Aug 19, 2015 at 05:03:20PM +0100, Catalin Marinas wrote:
> > On Wed, Aug 19, 2015 at 04:09:49PM +0100, Will Deacon wrote:
> > > @@ -613,13 +609,14 @@ ENDPROC(cpu_switch_to)
> > >   */
> > >  ret_fast_syscall:
> > >  	disable_irq				// disable interrupts
> > > +	str	x0, [sp, #S_X0]			// returned x0
> > >  	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
> > >  	and	x2, x1, #_TIF_SYSCALL_WORK
> > >  	cbnz	x2, ret_fast_syscall_trace
> > >  	and	x2, x1, #_TIF_WORK_MASK
> > > -	cbnz	x2, fast_work_pending
> > > +	cbnz	x2, work_pending
> > >  	enable_step_tsk x1, x2
> > > -	kernel_exit 0, ret = 1
> > > +	kernel_exit 0
> > >  ret_fast_syscall_trace:
> > >  	enable_irq				// enable interrupts
> > >  	b	__sys_trace_return
> > 
> > There is another str x0 in __sys_trace_return which I think we could
> > remove.
> 
> Hmm, I don't think we can remove that. It's needed on the slowpath to
> update the pt_regs with either -ENOSYS (for __ni_sys_trace) or the
> syscall return value from the blr in __sys_trace.
> 
> What we can do instead is change the branch above to branch to
> __sys_trace_return_skipped. Patch below.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 2a5e64ccc991..088322ff1ba0 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -619,7 +619,7 @@ ret_fast_syscall:
>         kernel_exit 0
>  ret_fast_syscall_trace:
>         enable_irq                              // enable interrupts
> -       b       __sys_trace_return
> +       b       __sys_trace_return_skipped      // we already saved x0

That would do. With this added:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(or I can take it for 4.2 but I'd like more testing like LTP)
