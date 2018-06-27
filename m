From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Jun 2018 14:09:17 +0100
Subject: [PATCH] arm64: entry: add END/ENDPROC markers to *.S files
In-Reply-To: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
References: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
Message-ID: <20180627130917.g45eigeevavqsi3u@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 26, 2018 at 10:47:41AM -0700, eugene.loh at oracle.com wrote:
> From: Eugene Loh <eugene.loh@oracle.com>
> 
> Add END/ENDPROC markers to *.S files so that assembly instructions
> can be mapped to symbols.

Is this just for external debug, or does anything in-kernel rely on
this?

> Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
> Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
> 
> Orabug: 28143715
> ---
>  arch/arm64/kernel/entry.S      | 6 +++++-
>  arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 5f4e54a..3ad0e1a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -456,6 +456,7 @@ __bad_stack:
>  	/* Time to die */
>  	bl	handle_bad_stack
>  	ASM_BUG()
> +END(__bad_stack)
>  #endif /* CONFIG_VMAP_STACK */
>  
>  /*
> @@ -622,6 +623,7 @@ el1_preempt:
>  	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
>  	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
>  	ret	x24
> +END(el1_preempt)

We treat el1_preempt like a subroutine (it gets called and returns), so
END_PROC() would seem more sensible.

>  #endif
>  
>  /*
> @@ -886,6 +888,7 @@ ret_fast_syscall:
>  ret_fast_syscall_trace:
>  	enable_irq				// enable interrupts
>  	b	__sys_trace_return_skipped	// we already saved x0
> +END(ret_fast_syscall)
>  
>  /*
>   * Ok, we need to do extra processing, enter the slow path.
> @@ -898,6 +901,7 @@ work_pending:
>  #endif
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
>  	b	finish_ret_to_user
> +END(work_pending)
>  /*
>   * "slow" syscall return path.
>   */
> @@ -958,7 +962,6 @@ ni_sys:
>  	mov	x0, sp
>  	bl	do_ni_syscall
>  	b	ret_fast_syscall
> -ENDPROC(el0_svc)
>  
>  	/*
>  	 * This is the really slow path.  We're going to be doing context
> @@ -995,6 +998,7 @@ __ni_sys_trace:
>  	mov	x0, sp
>  	bl	do_ni_syscall
>  	b	__sys_trace_return
> +ENDPROC(el0_svc)

I'm converting the syscall paths to C [1], which should address all of
the above, except for work_pending.

I do hope to convert that in future along with the rest of the entry
triage logic [2].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582238.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm
