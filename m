From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 21 Dec 2015 17:51:22 +0100 (CET)
Subject: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
In-Reply-To: <20151221104818.GF23092@arm.com>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com> <5671CD5B.9030907@linaro.org>
 <20151221104818.GF23092@arm.com>
Message-ID: <alpine.DEB.2.11.1512211749180.28591@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Dec 2015, Will Deacon wrote:
> +static void send_user_sigtrap(int si_code)
> +{
> +	struct pt_regs *regs = current_pt_regs();
> +	siginfo_t info = {
> +		.si_signo	= SIGTRAP,
> +		.si_errno	= 0,
> +		.si_code	= si_code,
> +		.si_addr	= (void __user *)instruction_pointer(regs),
> +	};
> +
> +	if (WARN_ON(!user_mode(regs)))
> +		return;
> +
> +	preempt_disable();

That doesn't work on RT either. force_sig_info() takes task->sighand->siglock,
which is a 'sleeping' spinlock on RT.

Why would we need to disable preemption here at all? What's the problem of
being preempted or even migrated?

Thanks,

	tglx
