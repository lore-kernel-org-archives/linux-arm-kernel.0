From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 14:34:04 +0000
Subject: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
In-Reply-To: <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151434.05145.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +#ifdef CONFIG_AARCH32_EMULATION
> +#include <linux/compat.h>
> +
> +#define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
> +
> +extern const compat_ulong_t aarch32_sigret_code[6];
> +
> +int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
> +		       struct pt_regs *regs);
> +int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
> +			  sigset_t *set, struct pt_regs *regs);
> +
> +void compat_setup_restart_syscall(struct pt_regs *regs);
> +#else
> +
> +static inline int compat_setup_frame(int usid, struct k_sigaction *ka,
> +				     sigset_t *set, struct pt_regs *regs)
> +{
> +	BUG();
> +}

What good is the run-time BUG() here? Nothing should be calling these
when CONFIG_COMPAT is disabled, so I think you should just remove
the #ifdef around the declarations, and the entire #else case.


> +asmlinkage int compat_sys_sched_rr_get_interval(compat_pid_t pid,
> +						struct compat_timespec __user *interval)
> +{
> +	struct timespec t;
> +	int ret;
> +	mm_segment_t old_fs = get_fs();
> +
> +	set_fs(KERNEL_DS);
> +	ret = sys_sched_rr_get_interval(pid, (struct timespec __user *)&t);
> +	set_fs(old_fs);
> +	if (put_compat_timespec(&t, interval))
> +		return -EFAULT;
> +	return ret;
> +}
> +
> +asmlinkage int compat_sys_sendfile(int out_fd, int in_fd,
> +				   compat_off_t __user *offset, s32 count)
> +{
> +	mm_segment_t old_fs = get_fs();
> +	int ret;
> +	off_t of;
> +
> +	if (offset && get_user(of, offset))
> +		return -EFAULT;
> +
> +	set_fs(KERNEL_DS);
> +	ret = sys_sendfile(out_fd, in_fd, offset ? (off_t __user *)&of : NULL,
> +			   count);
> +	set_fs(old_fs);
> +
> +	if (offset && put_user(of, offset))
> +		return -EFAULT;
> +	return ret;
> +}

I guess it's time to move these two into common code. They look like they should
be shared across most architectures that have compat support.

> +asmlinkage int compat_sys_personality(compat_ulong_t personality)
> +{
> +	int ret;
> +
> +	if (personality(current->personality) == PER_LINUX32 &&
> +		personality == PER_LINUX)
> +		personality = PER_LINUX32;
> +	ret = sys_personality(personality);
> +	if (ret == PER_LINUX32)
> +		ret = PER_LINUX;
> +	return ret;
> +}

Where did you get this from?

You should not need compat_sys_personality, just call the native function.

	Arnd
