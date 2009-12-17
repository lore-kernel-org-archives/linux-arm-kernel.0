From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 17 Dec 2009 19:32:10 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217175416.9317.66257.stgit@e101986-lin>
References: <20091217175416.9317.66257.stgit@e101986-lin>
Message-ID: <20091217193210.GD362@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leif Lindholm wrote:
> To correctly deal with copy-on-write, it also modifies
> cpu_v7_set_pte_ext to change the mappings to priviliged RO when user RO.

Does this break ptrace writing to RO pages or anything else?
If it doesn't break anything, seems to me it should always be done
like that, not conditional on CONFIG_SWP_EMULATE.

> +static void set_segfault(struct pt_regs *regs)
> +{
> +	siginfo_t info;
> +
> +	info.si_signo = SIGSEGV;
> +	info.si_errno = 0;
> +	info.si_code  = SEGV_ACCERR;
> +	info.si_addr  = (void __user *)regs->ARM_pc;

Ideally it would report the same errors as userspace accesses, as
calculated in do_page_fault() and passed to __do_user_fault(), for the
benefit of programs which distinguish SEGV_MAPERR from SEGV_ACCERR.

> +	printk(KERN_INFO "SWP{B} emulation: access caused memory abort!\n");
> +	arm_notify_die("Illegal memory access", regs, &info, 0, 0);

> +	if (address & 0x3) {
> +		/* SWP to unaligned address not permitted */
> +		printk(KERN_INFO "SWP instruction on unaligned pointer!\n");
> +		return -EFAULT;
> +	}

These printks look like an easy local denial of service.  They should
be rate limited.

-- Jamie
