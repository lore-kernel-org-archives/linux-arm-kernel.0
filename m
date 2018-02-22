From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 15:39:44 +0000
Subject: [PATCH 3/9] arm64: Introduce arm64_force_sig_info and hook up in
 arm64_notify_die
In-Reply-To: <1519308057-4953-4-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
 <1519308057-4953-4-git-send-email-will.deacon@arm.com>
Message-ID: <20180222153944.v4ensqk2w3omr4u3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 02:00:51PM +0000, Will Deacon wrote:
> +void arm64_force_sig_info(struct siginfo *info, const char *str,
> +			  struct task_struct *tsk)
> +{
> +	unsigned int esr = tsk->thread.fault_code;
> +	struct pt_regs *regs = task_pt_regs(tsk);
> +
> +	if (!unhandled_signal(tsk, info->si_signo))
> +		goto send_sig;
> +
> +	if (!show_unhandled_signals_ratelimited())
> +		goto send_sig;
> +
> +	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
> +	if (esr)
> +		pr_cont("%s, ESR 0x%03x, ", esr_get_class_string(esr), esr);

Can we make that 0x%08x please? ESR_ELx.EC occupies bits 31-26...

I guess this was copied from __do_user_fault, and it's odd there, as
wherever that's called the EC is non-zero.

Thanks,
Mark.
