From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 14:50:10 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <48925827.N0Xfqtb3JD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 02:30:42 Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> Add a separate syscall-table for ILP32, which dispatches either to native
> LP64 system call implementation or to compat-syscalls, as appropriate.

The uapi/asm-generic/unistd.h already contains a list of compat syscalls
that should work by default, I think it would be better to use that
list and override only the ones that differ between normal compat
mode and the new mode, e.g. when you require a wrapper or want to
use the native syscall entry.

> +/* We need to make sure the pointer gets copied correctly. */
> +asmlinkage long ilp32_sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u_notification)
> +{
> +	struct sigevent __user *p = NULL;
> +	if (u_notification) {
> +		struct sigevent n;
> +		p = compat_alloc_user_space(sizeof(*p));
> +		if (copy_from_user(&n, u_notification, sizeof(*p)))
> +			return -EFAULT;
> +		if (n.sigev_notify == SIGEV_THREAD)
> +			n.sigev_value.sival_ptr = compat_ptr((uintptr_t)n.sigev_value.sival_ptr);
> +		if (copy_to_user(p, &n, sizeof(*p)))
> +			return -EFAULT;
> +	}
> +	return sys_mq_notify(mqdes, p);
> +}

Could this be avoided by defining sigval_t in a way that is
compatible?

> +/* sigevent contains sigval_t which is now 64bit always
> +   but need special handling due to padding for SIGEV_THREAD.  */
> +#define sys_mq_notify		ilp32_sys_mq_notify
> +
> +/* sigaltstack needs some special handling as the
> +   padding for stack_t might not be non-zero. */
> +long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
> +			   stack_t __user *uoss_ptr)

asmlinkage?

	Arnd
