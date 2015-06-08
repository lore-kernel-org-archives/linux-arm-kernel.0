From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jun 2015 11:21:05 +0100
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <1433539683-29539-1-git-send-email-jistone@redhat.com>
References: <20150605153816.GG7420@arm.com>
 <1433539683-29539-1-git-send-email-jistone@redhat.com>
Message-ID: <20150608102104.GB1654@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

Thanks for the patch.

On Fri, Jun 05, 2015 at 10:28:03PM +0100, Josh Stone wrote:
> If a syscall is entered without TIF_SYSCALL_TRACE set, then it goes on
> the fast path.  It's then possible to have TIF_SYSCALL_TRACE added in
> the middle of the syscall, but ret_fast_syscall doesn't check this flag
> again.  This causes a ptrace syscall-exit-stop to be missed.
> 
> For instance, from a PTRACE_EVENT_FORK reported during do_fork, the
> tracer might resume with PTRACE_SYSCALL, setting TIF_SYSCALL_TRACE.
> Now the completion of the fork should have a syscall-exit-stop.
> 
> Russell King fixed this on arm by re-checking _TIF_SYSCALL_WORK in the
> fast exit path.  Do the same on arm64.
> 
> v2: Re-enable interrupts before branching to __sys_trace_return.

Please don't include the changelog in the commit message.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Josh Stone <jistone@redhat.com>
> ---
>  arch/arm64/kernel/entry.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 959fe8733560..988bea43dc74 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -608,11 +608,16 @@ ENDPROC(cpu_switch_to)
>   */
>  ret_fast_syscall:
>  	disable_irq				// disable interrupts
> -	ldr	x1, [tsk, #TI_FLAGS]
> +	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
> +	and	x2, x1, #_TIF_SYSCALL_WORK
> +	cbnz	x2, ret_fast_syscall_trace
>  	and	x2, x1, #_TIF_WORK_MASK
>  	cbnz	x2, fast_work_pending
>  	enable_step_tsk x1, x2
>  	kernel_exit 0, ret = 1
> +ret_fast_syscall_trace:
> +	enable_irq				// enable interrupts
> +	b	__sys_trace_return

Looks good to me:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

I assume this can wait until 4.2?

Will
