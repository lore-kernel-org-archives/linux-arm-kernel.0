From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jun 2018 14:21:51 +0100
Subject: [PATCH] arm64: entry: add END/ENDPROC markers to *.S files
In-Reply-To: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
References: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
Message-ID: <20180627132150.GA30631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eugene,

On Tue, Jun 26, 2018 at 10:47:41AM -0700, eugene.loh at oracle.com wrote:
> From: Eugene Loh <eugene.loh@oracle.com>
> 
> Add END/ENDPROC markers to *.S files so that assembly instructions
> can be mapped to symbols.

Could you expand on the commid message please? Who's mapping what and how?

> Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
> Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
> 
> Orabug: 28143715

Please remove this line.

> ---
>  arch/arm64/kernel/entry.S      | 6 +++++-

Please be aware that work is underway to rewrite much of entry.S in C, so
it's not clear how relevant this patch will be. Take a look at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582238.html

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

We should have a matching ENTRY for all END macros, I think.

>  #endif /* CONFIG_VMAP_STACK */
>  
>  /*
> @@ -622,6 +623,7 @@ el1_preempt:
>  	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
>  	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
>  	ret	x24
> +END(el1_preempt)
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

Hmm, I tend to thing of this exit code as a state machine with a bunch of
labels, rather than as a set of functions. What exactly are you doing
with the END annotations?

Will
