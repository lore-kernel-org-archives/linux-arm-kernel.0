From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 29 Jul 2014 21:25:55 +0200
Subject: [PATCH v4 3/5] x86: Split syscall_trace_enter into two phases
In-Reply-To: <714cf438762d342673b3b131d5c90bc69ca921a9.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
 <714cf438762d342673b3b131d5c90bc69ca921a9.1406604806.git.luto@amacapital.net>
Message-ID: <20140729192555.GB6308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Andy Lutomirski wrote:
>
> +long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
> +				unsigned long phase1_result)
> +{
> +	long ret = 0;
> +	u32 work = ACCESS_ONCE(current_thread_info()->flags) &
> +		_TIF_WORK_SYSCALL_ENTRY;
> +
> +	BUG_ON(regs != task_pt_regs(current));
>  
>  	/*
>  	 * If we stepped into a sysenter/syscall insn, it trapped in
> @@ -1463,17 +1569,20 @@ long syscall_trace_enter(struct pt_regs *regs)
>  	 * do_debug() and we need to set it again to restore the user
>  	 * state.  If we entered on the slow path, TF was already set.
>  	 */
> -	if (test_thread_flag(TIF_SINGLESTEP))
> +	if (work & _TIF_SINGLESTEP)
>  		regs->flags |= X86_EFLAGS_TF;

This is minor, I won't argue, but this can be moved into phase1(), afaics.

Oleg.
