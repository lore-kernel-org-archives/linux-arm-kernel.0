From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Fri, 15 Jan 2016 13:46:46 +0100
Subject: [PATCH v6 20/21] all: s390: make compat wrappers the generic
 solution
In-Reply-To: <1452792198-10718-21-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <1452792198-10718-21-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160115124646.GD4130@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 08:23:17PM +0300, Yury Norov wrote:
> The problem that makes us to use wrappers is that some compat
> architectures allows user code to access top halves of registers.
> This is not a problem for syscalls that are already handled by compat
> code, or for that who has types of the same size in kernel and
> userspace. In case of lp64/ilp32 the problem is in pointer types, long,
> unsigned long.
> 
> S390 folks already have the solution for it. In this patch,
> it is turned to be general, as arm64/ilp32 needs it too.
> 
> Build-tested on s390.

If you want to make this generic then I think the footprint of the compat
wrapper infrastructure should be as small as possible:

> diff --git a/arch/s390/include/asm/compat_wrapper.h b/arch/s390/include/asm/compat_wrapper.h
> new file mode 100644
> index 0000000..d5a5c36
> --- /dev/null
> +++ b/arch/s390/include/asm/compat_wrapper.h
> @@ -0,0 +1,25 @@
> +#ifndef __ASM_COMPAT_WRAPPER
> +#define __ASM_COMPAT_WRAPPER
> +
> +/*
> + *  Compat system call wrappers.
> + *
> + *    Copyright IBM Corp. 2014
> + */
> +
> +#define __SC_COMPAT_CAST(t, a)						\
> +({									\
> +	long __ReS = a;							\
> +									\
> +	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
> +		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
> +	if (__TYPE_IS_L(t))						\
> +		__ReS = (s32)a;						\
> +	if (__TYPE_IS_UL(t))						\
> +		__ReS = (u32)a;						\
> +	if (__TYPE_IS_PTR(t))						\
> +		__ReS = a & 0x7fffffff;					\
> +	(t)__ReS;							\
> +})
> +
> +#endif /* __ASM_COMPAT_WRAPPER */

This should go to arch/s390/include/asm/compat.h right below Al's
__SC_DELOUSE. (no new header file please)


> diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
> index 437e611..22416a8 100644
> --- a/arch/s390/kernel/compat_linux.c
> +++ b/arch/s390/kernel/compat_linux.c
> @@ -44,6 +44,7 @@
>  #include <linux/binfmts.h>
>  #include <linux/capability.h>
>  #include <linux/compat.h>
> +#include <linux/compat_wrapper.h>
>  #include <linux/vfs.h>
>  #include <linux/ptrace.h>
>  #include <linux/fadvise.h>
> @@ -86,6 +87,11 @@
>  #define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
>  #define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
> 
> +COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long,
> +		mmio_addr, const void __user *, user_buffer, const size_t, length);
> +COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long,
> +		mmio_addr, void __user *, user_buffer, const size_t, length);
> +

I'd really prefer if the existing common SYSCALL_DEFINE macros could be
extended to also generate the compat wrappers, if needed.

This probably means that you need another set of SYSCALL_DEFINE macros,
e.g. something like SYSCALL_COMPAT, which is defined the same like
SYSCALL_DEFINE, except that it also generates the compat_wrapper functions.

Since the list of system calls that need a wrapper is already present in
s390's compat_wrapper.c file it's "only" a matter of writing a script that
converts the required SYSCALL_DEFINEs to SYSYCALL_COMPATs.

> diff --git a/include/linux/compat_wrapper.h b/include/linux/compat_wrapper.h
> new file mode 100644
> index 0000000..6f22732
> --- /dev/null
> +++ b/include/linux/compat_wrapper.h
> @@ -0,0 +1,270 @@
> +#ifndef __COMPAT_WRAPPER
> +#define __COMPAT_WRAPPER
> +
> +#include <asm/compat_wrapper.h>
> +
> +#define COMPAT_SYSCALL_WRAP1(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(1, _##name, __VA_ARGS__)
> +#define COMPAT_SYSCALL_WRAP2(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(2, _##name, __VA_ARGS__)
> +#define COMPAT_SYSCALL_WRAP3(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(3, _##name, __VA_ARGS__)
> +#define COMPAT_SYSCALL_WRAP4(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(4, _##name, __VA_ARGS__)
> +#define COMPAT_SYSCALL_WRAP5(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(5, _##name, __VA_ARGS__)
> +#define COMPAT_SYSCALL_WRAP6(name, ...) \
> +	COMPAT_SYSCALL_WRAPx(6, _##name, __VA_ARGS__)
> +
> +#ifndef __SC_COMPAT_TYPE
> +#define __SC_COMPAT_TYPE(t, a) \
> +	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
> +#endif
> +
> +#ifndef __SC_COMPAT_CAST
> +#define __SC_COMPAT_CAST(t, a)	((t)(long) ((t)(-1) < 0 ? (s32)(a) : (u32)(a)))
> +#endif
> +/*
> + * The COMPAT_SYSCALL_WRAP macro generates system call wrappers to be used by
> + * compat tasks. These wrappers will only be used for system calls where only
> + * the system call arguments need sign or zero extension or zeroing of the upper
> + * 33 bits of pointers.
> + * Note: since the wrapper function will afterwards call a system call which
> + * again performs zero and sign extension for all system call arguments with
> + * a size of less than eight bytes, these compat wrappers only touch those
> + * system call arguments with a size of eight bytes ((unsigned) long and
> + * pointers). Zero and sign extension for e.g. int parameters will be done by
> + * the regular system call wrappers.
> + */
> +#ifndef COMPAT_SYSCALL_WRAPx
> +#define COMPAT_SYSCALL_WRAPx(x, name, ...)						\
> +asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));				\
> +asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))			\
> +		__attribute__((alias(__stringify(compat_SyS##name))));			\
> +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));	\
> +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))		\
> +{											\
> +	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));			\
> +}
> +#endif

All of this should go to include/linux/compat.h

> +asmlinkage long compat_sys_creat(const char __user *pathname, umode_t mode);
> +asmlinkage long compat_sys_link(const char __user *oldname,
> +				const char __user *newname);
> +asmlinkage long compat_sys_chdir(const char __user *filename);
> +asmlinkage long compat_sys_mknod(const char __user *filename, umode_t mode,
> +				unsigned dev);

Are these really needed?

> diff --git a/kernel/compat_wrapper.c b/kernel/compat_wrapper.c
> new file mode 100644
> index 0000000..4a99811
> --- /dev/null
> +++ b/kernel/compat_wrapper.c
> @@ -0,0 +1,167 @@
> +/*
> + *  Compat system call wrappers.
> + *
> + *    Copyright IBM Corp. 2014
> + */
> +
> +#include <linux/syscalls.h>
> +#include <linux/compat.h>
> +#include <linux/compat_wrapper.h>
> +
> +COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
> +COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
> +COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
> +COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
> +COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
> +COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);

With all the above changes this file wouldn't be necessary, which I think
would be good.

Just my thoughts...
