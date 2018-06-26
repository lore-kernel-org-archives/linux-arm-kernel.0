From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jun 2018 11:31:14 +0100
Subject: [PATCH 1/3] arm64: rseq: Implement backend rseq calls and select
 HAVE_RSEQ
In-Reply-To: <1529949285-11013-2-git-send-email-will.deacon@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-2-git-send-email-will.deacon@arm.com>
Message-ID: <20180626103114.ddu62cccupjdo2ia@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 06:54:43PM +0100, Will Deacon wrote:
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 28ad8799406f..1eda9e1a1f4a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -904,6 +904,7 @@ ENDPROC(el0_error)
>  ret_fast_syscall:
>  	disable_daif
>  	str	x0, [sp, #S_X0]			// returned x0
> +#ifndef CONFIG_DEBUG_RSEQ
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
>  	and	x2, x1, #_TIF_SYSCALL_WORK
>  	cbnz	x2, ret_fast_syscall_trace
> @@ -911,6 +912,7 @@ ret_fast_syscall:
>  	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
>  	kernel_exit 0
> +#endif
>  ret_fast_syscall_trace:
>  	enable_daif
>  	b	__sys_trace_return_skipped	// we already saved x0

I *think* this is ok, since we re-check the TIF bits in
syscall_trace_exit().

This does mean that we'd now always call audit_syscall_exit(),
regardless of TIF_AUDIT, but there are already cases when we call that
with TIF_AUDIT clear, so I think if that's a problem it's a latent bug.
Likewise for audit_syscall_entry().

It seems we're in the same boat as other architectures there,
regardless.

FWIW, for the entry bits:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
