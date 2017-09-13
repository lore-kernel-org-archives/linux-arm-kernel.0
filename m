From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Sep 2017 10:26:05 -0700
Subject: [PATCH v2 11/28] arm64/sve: Core task context handling
In-Reply-To: <1504198860-12951-12-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-12-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170913172605.hjrwjf34kyy7coh4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:00:43PM +0100, Dave P Martin wrote:
> +el0_sve_acc:
> +	/*
> +	 * Scalable Vector Extension access
> +	 */
> +	enable_dbg
> +	ct_user_exit
> +	mov	x0, x25
> +	mov	x1, sp
> +	bl	do_sve_acc
> +	b	ret_to_user

I think do_sve_acc() runs with interrupts disabled. We may have some
high latency for large SVE states.

> +/*
> + * Trapped SVE access
> + */
> +void do_sve_acc(unsigned int esr, struct pt_regs *regs)
> +{
> +	/* Even if we chose not to use SVE, the hardware could still trap: */
> +	if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
> +		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
> +		return;
> +	}
> +
> +	task_fpsimd_save();
> +
> +	sve_alloc(current);
> +	fpsimd_to_sve(current);
> +	if (test_and_set_thread_flag(TIF_SVE))
> +		WARN_ON(1); /* SVE access shouldn't have trapped */
> +
> +	task_fpsimd_load();
> +}

When this function is entered, do we expect TIF_SVE to always be
cleared? It's worth adding a comment on the expected conditions. If
that's the case, task_fpsimd_save() would only save the FPSIMD state
which is fine. However, you subsequently transfer the FPSIMD state to
SVE, set TIF_SVE and restore the full SVE state. If we don't care about
the SVE state here, can we call task_fpsimd_load() *before* setting
TIF_SVE?

I may as well have confused myself with the state bouncing between
FPSIMD and SVE (more reasons to document the data flow better ;)).

-- 
Catalin
