From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 15:07:36 +0000
Subject: [PATCH v2 23/31] arm64: Debugging support
In-Reply-To: <1344966752-16102-24-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-24-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151507.36174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +const struct user_regset_view *task_user_regset_view(struct task_struct *task)
> +{
> +#ifdef CONFIG_AARCH32_EMULATION
> +	if (test_tsk_thread_flag(task, TIF_32BIT))
> +		return &user_aarch32_view;
> +#endif
> +	return &user_aarch64_view;
> +}

Ah, nice. So you support 64 bit debuggers debugging 32 bit processes, right?

>From what I can tell, there is no support for 32 bit processes debugging
64 bit ones. Is that something you plan to add in the future, or do you
consider that out of scope? In either case, a comment would be helpful.

> +long arch_ptrace(struct task_struct *child, long request,
> +		 unsigned long addr, unsigned long data)
> +{
> +	int ret;
> +	unsigned long *datap = (unsigned long __user *)data;
> +
> +	switch (request) {
> +		case PTRACE_GET_THREAD_AREA:
> +			ret = put_user(child->thread.tp_value, datap);
> +			break;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +		case PTRACE_GETHBPREGS:
> +			ret = ptrace_gethbpregs(child, addr, datap);
> +			break;
> +
> +		case PTRACE_SETHBPREGS:
> +			ret = ptrace_sethbpregs(child, addr, datap);
> +			break;
> +#endif
> +
> +		default:
> +			ret = ptrace_request(child, request, addr, data);
> +			break;
> +	}
> +
> +	return ret;
> +}

Is there a reaons why these are not regsets but have their own ptrace
commands? I believe new architectures should generally not add ptrace
commands any more.

	Arnd
