From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 15:32:45 +0100
Subject: [PATCHv3 09/19] arm64: convert syscall trace logic to C
In-Reply-To: <20180618120310.39527-10-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-10-mark.rutland@arm.com>
Message-ID: <20180619143245.pjkcutm5hupfunla@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:00PM +0100, Mark Rutland wrote:
> +asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> +			       syscall_fn_t syscall_table[])
> +{
> +	unsigned long flags = current_thread_info()->flags;
> +
> +	regs->orig_x0 = regs->regs[0];
> +	regs->syscallno = scno;
> +
> +	local_daif_restore(DAIF_PROCCTX);
> +	user_exit();
> +
> +	if (has_syscall_work(flags)) {
> +		/* set default errno for user-issued syscall(-1) */
> +		if (scno == NO_SYSCALL)
> +			regs->regs[0] = -ENOSYS;
> +		scno = syscall_trace_enter(regs);
> +		if (scno == NO_SYSCALL)
> +			goto trace_exit;
> +	}
> +
> +	invoke_syscall(regs, scno, sc_nr, syscall_table);
> +
> +	/*
> +	 * The tracing status may have changed under our feet, so we have to
> +	 * check again. However, if we were tracing entry, then we always trace
> +	 * exit regardless, as the old entry assembly did.
> +	 */
> +	if (!has_syscall_work(flags)) {
> +		local_daif_mask();
> +		flags = current_thread_info()->flags;
> +		if (!has_syscall_work(flags))
> +			return;
> +		local_daif_restore(DAIF_PROCCTX);
> +	}

IIUC the above 'if' block replaces ret_fast_syscall in entry.S with the
work_pending handled via ret_to_user (we used to check _TIF_WORK_MASK in
two places). 

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
